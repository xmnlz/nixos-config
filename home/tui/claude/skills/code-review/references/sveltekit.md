# SvelteKit review guide

Companion to [svelte.md](svelte.md), which covers component-level runes and templates. This file covers the framework:
routing, load functions, form actions, remote functions, hooks, page options, and the server/client boundary.
Distilled from the [official SvelteKit docs](https://svelte.dev/docs/kit) into review checks — there is no upstream
skill for this half.

Load both files when a diff touches components *and* `+page.server`/`hooks.server`/`+server` files.

The recurring theme: **the server is long-lived and shared between users; the client is not.** Most serious SvelteKit
bugs are a violation of that one fact, and most of the 🔴s below are instances of it.

## Shared server state — check this first

🔴 **Mutable state at module scope in any server-side module** (`+page.server.js`, `+layout.server.js`, `+server.js`, `hooks.server.js`, anything in `$lib/server`).

```js
/// +page.server.js
let user; // NEVER DO THIS

export function load() { return { user }; }

export const actions = {
	default: async ({ request }) => {
		const data = await request.formData();
		user = { name: data.get('name'), embarrassingSecret: data.get('secret') };
	}
};
```

The server is shared by every visitor. Alice submits, Bob loads the page, Bob sees Alice's secret. It also evaporates on restart. Authenticate via cookies and persist to a database.

Applies to caches, "current tenant" variables, memoised request-scoped values — anything module-level that a request *writes* to. Module-level immutable config is fine.

🔴 **Side effects in `load`.** `load` must be pure. Writing to a store or global so a component can read it later is the same leak:

```js
import { user } from '$lib/user';

export async function load({ fetch }) {
	const response = await fetch('/api/user');
	user.set(await response.json()); // NEVER DO THIS
}
```

Return the data instead and pass it down (or read `page.data`). Worth flagging even in a CSR-only app — it makes the data flow much harder to follow.

🟠 **Cross-request state shared through hand-rolled context.** App state works because the context is attached to the component tree per render. Anything custom must follow the same lifecycle.

## Load functions

### Universal vs server

`+page.js` / `+layout.js` export **universal** loads (server during SSR, then browser). `+page.server.js` / `+layout.server.js` export **server** loads (server only).

🔴 **Database access, private env vars, or secrets in a universal `load`.** It runs in the browser. Move it to `+page.server.js`.

🟠 **Server `load` returning something devalue can't serialize.** Server loads must return JSON-plus (`BigInt`, `Date`, `Map`, `Set`, `RegExp`, cyclical refs). Class instances and component constructors need a universal load or a `transport` hook.

🟠 **The wrong kind for the job.** Server load: direct DB/filesystem access, private credentials. Universal load: fetching a public external API (the browser hits it directly instead of round-tripping through your server), or returning something unserializable.

🟡 When a route has both, the server load runs first and its return value arrives as the universal load's `data` property — not directly as the page's `data`. Flag code that assumes otherwise.

### Correctness

🟠 **Bare `fetch` instead of the `fetch` from the load event.** The provided one forwards cookies and auth headers on the server, accepts relative URLs, and lets SSR responses be inlined and replayed during hydration rather than refetched.

🟠 **Sequential awaits that create a waterfall.** Separate loads already run in parallel; an `await` chain inside one serialises them. On the server, prefer one query with a join over "fetch user, then fetch their items".

🟠 **`await parent()` called when the parent's data isn't used.** It blocks a load that could have run in parallel.

🟠 **Slow non-critical data awaited instead of streamed.** A server load may return promises in its object; they stream in after navigation.

🟠 **Invalidation wrong in either direction.** Data that must refetch on a change needs `depends()` + `invalidate()`, or a real URL/param dependency. Conversely, reading `url.searchParams` or `params` creates a dependency you may not want — `untrack` exists for that.

🟠 **`cookies.set()` without an explicit `path`.** SvelteKit requires it, and the wrong path silently scopes the cookie to the current route.

🟠 **`setHeaders` used to cache a response containing user-specific data**, or called twice for the same header.

## Authentication — the SvelteKit-specific trap

🔴 **Auth guard only in `+layout.server.js`.** Two documented behaviours make this unsafe:

1. Layout `load` functions **do not rerun on every request** — notably not during client-side navigation between child routes.
2. Layout and page loads **run concurrently** unless `await parent()` is called. If the layout load throws, the page load still runs; the client just doesn't receive the layout's data.

So a child page's `load` can do its protected work before, or regardless of, the layout's guard.

Acceptable strategies:

- Guard in `hooks.server.js` `handle` — runs before any load, covers whole route subtrees. Best default.
- Guard directly in each `+page.server.js` `load` — route-specific and explicit.
- Guard in `+layout.server.js` **only if** every child calls `await parent()` before anything protected. Usually the least performant option; flag it unless children genuinely depend on the parent's data.

🔴 **`+server.js` endpoint with no auth check.** API routes are public URLs and inherit nothing from page guards.

🔴 **Authorisation derived from client-supplied data** rather than from `locals` populated by a verified session in `handle`.

🟠 **Ownership not checked on a resource identified by a route param.** `params.id` is user input; authentication is not authorisation.

📚 `getRequestEvent` lets shared server helpers (a `requireLogin()` guard, say) reach the current request without threading `event` through every call. Suggest it when guards are being passed around by hand.

## Server-only modules and environment variables

SvelteKit enforces most of this at build time — but know what the enforcement is, because reviews mostly see it worked *around*.

🔴 **A secret moved into `$env/static/public` or `$env/dynamic/public` to "fix" an import error.** The public modules are client-visible by design. The correct fix is moving the consumer to the server.

🔴 **A `$lib/server` module or `.server.js` file re-exported through a client-reachable module.** The import *chain* is what's unsafe, not which export is used — `+page.svelte` → `utils.js` → `$lib/server/secrets.js` is rejected even if only `add()` is imported. Note that illegal-import detection is **disabled under test** (`process.env.TEST === 'true'`), so a test suite will not catch it.

🟠 **A type-only import from a server module written as a value import.** Should be `import type`.

🟡 New server-only code not placed in `$lib/server/` or named `*.server.ts` — the two mechanisms that make the protection automatic.

## Form actions

🔴 **Unvalidated `formData()`.** Every field is user-supplied and typed `string | File | null`. Parse with a schema before use.

🔴 **No auth or ownership check inside the action.** Actions are public POST endpoints; the UI that renders the form is irrelevant.

🟠 **Validation failures thrown as errors instead of returned with `fail(status, data)`.** `fail` repopulates the form; `error()` replaces the page.

🟠 **Submitted values not returned on failure**, forcing a full retype — and conversely 🔴 **passwords or card numbers echoed back** in the `fail` payload.

🟠 **`use:enhance` customised without preserving what it replaced** — applying the result, resetting the form, invalidating data. If a callback is supplied, check `applyAction` / `invalidateAll` are still handled.

🟠 **A mutation implemented as a GET** — via a `load`, or a form with `method="GET"`. Anything with side effects is POST.

🟡 Multiple actions on a route without named actions, or a `?/name` reference that has drifted from its export.

## Remote functions (2.27+, experimental)

`.remote.js` / `.remote.ts` exports — `query`, `form`, `command`, `prerender` — compile to `fetch` wrappers hitting a generated HTTP endpoint.

🔴 **A `query` or `command` with no auth check.** These are **public HTTP endpoints**. Calling them like ordinary functions from a component makes it easy to forget that anyone can hit the generated URL with any arguments.

🔴 **Arguments used without schema validation.** Same reason.

🟠 **Adoption without the flags enabled** — needs `kit.experimental.remoteFunctions` and `compilerOptions.experimental.async` in `svelte.config.js`.

🟠 **`query` on a fully-prerendered page.** Queries can't run when `export const prerender = true` applies to the page or a parent layout; `prerender` remote functions are the static counterpart.

🟠 **Sensitive form fields not prefixed with `_`.** A leading underscore (`_password`) keeps the value from being sent back on a non-progressively-enhanced validation failure.

🟡 A remote file placed in `src/lib/server` — not allowed; anywhere else under `src` is fine.

🔵 Flag the experimental status itself when these appear in production code — the API is explicitly subject to change without notice.

## Hooks

🟠 **`handle` doing per-request work that isn't request-scoped**, or writing to module state (see the first section).

🟠 **`locals` populated without verifying the session** — everything downstream trusts `locals`.

🔴 **`handleError` returning the raw error to the client.** Unexpected errors are stripped to `{ "message": "Internal Error" }` precisely because they may carry secrets; a custom `handleError` that returns `err.message` undoes that.

🟠 **`handleError` not reporting anywhere** — no Sentry, no structured log. Unexpected errors then vanish silently.

🟠 **`handleFetch` rewriting URLs or forwarding credentials to an external host.** Forwarding cookies to a third party is 🔴.

🟠 **`reroute` doing async or expensive work** — it runs on every navigation.

## Errors

🟠 **`error(status, message)` carrying internal detail.** Expected errors *are* shown to the user — that's their purpose. Stack traces, SQL text, and upstream messages don't belong in one.

🟠 **A genuine 404 returned as a 200 with empty data**, or a real failure surfaced as an expected error — both distort monitoring.

🟡 No `+error.svelte` for a route subtree with meaningfully different error states.

## Page options

🟠 **`export const ssr = false`** on a page needing SEO or fast first paint — it becomes an SPA route with a built-in waterfall (empty page → JS → data → render).

🟠 **`export const csr = false`** on a page containing interactive components; they will not hydrate.

🟠 **`export const prerender = true`** on a route reading cookies, `locals`, session, or any per-user data. Prerendering happens at build time, so it bakes one view or fails outright. Also flag it on routes with actions or non-GET handlers.

🟠 **A prerendered dynamic route without `entries`** — the pages are never generated.

🟡 `trailingSlash` changed globally — check for link/redirect churn and duplicate-URL SEO.

## Component state across navigations

🟠 **Values computed once from `data` instead of derived.** SvelteKit *reuses* layout and page components across navigations, so top-level `const` never recomputes:

```svelte
<script>
	let { data } = $props();

	// BUGGY — keeps the first post's value after navigating to another post
	const wordCount = data.content.split(' ').length;

	// correct
	let wordCount = $derived(data.content.split(' ').length);
</script>
```

Same trap for `onMount` / `onDestroy`, which don't rerun — `afterNavigate` / `beforeNavigate` are the equivalents. When a component genuinely must remount, `{#key page.url.pathname}` is the escape hatch.

🟠 **State that should survive reload or affect SSR kept in memory** — table filters, sort order, pagination, active tab. These belong in URL search params: readable in `load` via `url`, in components via `page.url.searchParams`.

🔵 **Ephemeral DOM state lost on back-navigation** — an unsubmitted comment, an accordion position. `export const snapshot = { capture, restore }` persists it to `sessionStorage`. Keep captured values small; they're retained for the whole session.

🟠 **Context value set as a plain value rather than a function.** `setContext('user', () => data.user)` preserves reactivity across the boundary; passing `data.user` snapshots it.

📚 SSR caveat: updating context state from a deeper component during SSR won't affect an already-rendered parent, though it will on the client. Prefer passing state *down* to avoid hydration flashes.

🟡 **Deprecated `$app/stores` imports in new code** — `$app/state` is the runes-era replacement (`page` rather than `$page`).

## Performance

🟠 **Universal `load` chaining API calls** (fetch user → fetch their items → fetch each item's detail). Every hop is a browser round trip, and it's worst for users far from your backend. Move to a server load, or collapse into one query.

🟠 **Heavy component statically imported** where a dynamic `import(...)` behind a condition would keep it out of the page bundle.

🟠 **Preloading removed** from `<body data-sveltekit-preload-data>` without a stated reason.

🟡 Fonts not preloaded via the `preload` filter in `handle` — SvelteKit preloads JS and CSS automatically but deliberately not fonts.

🟡 `<img>` where `@sveltejs/enhanced-img` is already a dependency.

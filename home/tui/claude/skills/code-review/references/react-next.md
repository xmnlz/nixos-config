# React 19 / Next.js review guide

## Server vs client boundary

🔴 **Secret reaching the client.** Any value read in a `'use client'` file, passed as a prop from a server component into a client component, or interpolated into rendered markup is public. Service-role keys, API secrets, and internal URLs must stay server-side. Check every new env var: is it `NEXT_PUBLIC_`-prefixed, and should it be?

🟠 **`'use client'` added higher than necessary.** Marking a layout or page as a client component pulls its entire subtree into the bundle. The fix is usually to push the directive down to the one interactive leaf and pass server-rendered children through.

🟠 **Server-only module imported into a client component.** DB clients, secret config, Node built-ins. Reach for `server-only` as a guard.

🟠 **Non-serialisable prop crossing the boundary** — class instances, `Date` in some setups, functions other than Server Actions.

🟡 **Whole objects passed to a client component when two fields are used.** More payload in the RSC stream and more surface to keep in sync.

## Server Actions

🔴 **No authentication/authorisation check inside the action.** A Server Action is a public POST endpoint. Any user can call it with any arguments. Checks done in the UI that renders the button do not apply.

🔴 **Unvalidated input.** Arguments arrive from the network. Parse with a schema before use, even for a hidden form field.

🟠 **IDs taken from arguments and used without an ownership check.** `deleteDocument(id)` must verify the caller owns `id`. This is the most common IDOR in modern React apps.

🟠 **Missing revalidation.** A mutation with no `revalidatePath`/`revalidateTag` or query invalidation leaves stale data on screen.

🟠 **Raw error objects returned to the client.** Return a code, not the exception.

## Hooks

🔴 **Conditional hook call** — inside `if`, loop, early return, or after a conditional `return`. Breaks hook ordering.

🟠 **`useEffect` doing something that isn't synchronisation with an external system.** Derived state, data transforms, and event responses do not belong in effects. Signals:
- Effect that only calls `setState` from other state → compute during render instead.
- Effect that runs on a user action → put it in the handler.
- Effect fetching data → use the query library; effect-fetching has no dedup, cache, or race protection.

🟠 **Missing cleanup.** Subscription, listener, interval, observer, or in-flight fetch with no teardown leaks and can set state after unmount. Under StrictMode the double-invoke will surface it.

🟠 **Dependency array lying.** Suppressing the lint rule to "fix" an infinite loop hides a stale closure. Fix the actual cause: unstable object/function identity, or state that should be a ref.

🟠 **Object/array/function literal in a dependency array** — new identity every render, effect runs every render.

🟠 **Stale closure over state in an async callback.** After an `await`, `count` is the value from the render that started the call. Use the functional updater.

🟡 **`useMemo`/`useCallback` on cheap work** with no referential-identity requirement — cost without benefit.

## Rendering

🟠 **`key` from array index on a reorderable/filterable list.** Causes state to attach to the wrong row. Stable `key` on static lists is fine.

🟠 **Component defined inside another component's body.** New type each render → subtree unmounts and remounts, losing state and focus.

🔴 **`dangerouslySetInnerHTML` with anything not sanitised server-side.** Markdown, user bios, CMS rich text — all XSS vectors.

🟠 **State duplicating props or derivable values.** `useState(props.value)` only reads the initial value; later prop changes are ignored, and the two drift.

🟠 **Uncontrolled → controlled switch.** `value={x}` where `x` starts `undefined` warns and loses input.

## Data fetching (TanStack Query)

🟠 **Query key missing a variable the query depends on.** Different inputs share a cache entry and serve each other's data. Every argument used in the fetch belongs in the key.

🟠 **Manual `setQueryData` writing a shape that doesn't match what the query returns.** The optimistic entry is later replaced by a differently-shaped refetch, causing a flash or a crash. Type the updater with the query's own output type.

🟠 **Optimistic update with no rollback** on error.

🟠 **Mutation that changes server state without invalidating or patching every affected key.** List, detail, and count views typically all need touching.

🟠 **`enabled` missing on a query whose parameters can be undefined** — fires a request with `undefined` in the URL.

🟡 **`refetchInterval` on data that doesn't change** — needless load.

## Next.js specifics

🟠 **`await` on `params`/`searchParams` missed** where the version makes them async.

🟠 **Dynamic route segment used in a query without validation** — it's user input.

🟠 **Fetch cache semantics not considered.** A `fetch` that must be fresh but inherits static caching serves stale data indefinitely; one that could be cached but isn't hits the origin every render.

🟠 **`redirect()` inside `try/catch`.** It works by throwing; the catch swallows it.

🟡 **`<img>` instead of the framework image component** for anything above the fold.

## Accessibility (only where the diff introduces interaction)

🟠 Interactive behaviour on a `div` with no role, `tabIndex`, or keyboard handler.
🟠 Icon-only button with no accessible name.
🟠 Form input with no associated label.
🟡 Colour as the only signal for state.

# Svelte 5 review guide

Derived from the official [`svelte-core-bestpractices`](https://svelte.dev/docs/ai/skills) skill
([source](https://github.com/sveltejs/ai-tools/tree/main/tools/skills/svelte-core-bestpractices)), reframed as
review checks. Covers core Svelte 5 runes-mode.

For load functions, form actions, hooks, page options, and the server/client boundary, see
[sveltekit.md](sveltekit.md) — load both when a diff touches components *and* `+page.server` / `hooks.server` files.

## Runes

### `$state`

🟡 **`$state` on a variable nothing reacts to.** Only use it for variables that drive an `$effect`, a `$derived`, or a template expression. Everything else is a normal variable — a rune here is overhead plus a false signal to the reader.

🟠 **`$state({...})` / `$state([...])` on a large object that is only ever reassigned.** Objects and arrays are made *deeply* reactive by proxying, which costs on every access. If the value is replaced wholesale rather than mutated — API responses are the classic case — `$state.raw` is correct and materially cheaper.

🟠 **Proxied state where identity matters.** Because `$state` objects are proxies, `===` against the original object fails, and passing them to external libraries (canvas, D3, Web APIs, `structuredClone`) can misbehave. Use `$state.raw`, or unwrap with `$state.snapshot` at the boundary.

### `$derived`

🟠 **`$effect` used to compute a value from state.** This is the single most common Svelte 5 review finding.

```js
// do this
let square = $derived(num * num);

// don't do this
let square;
$effect(() => { square = num * num; });
```

The effect version runs a tick later, can flash a stale value, and adds a mutable binding.

🟠 **A function passed to `$derived`.** `$derived` takes an *expression*, not a function — `$derived(() => num * num)` derives a function, not a number. For anything needing statements, use `$derived.by(() => { ... })`.

📚 Deriveds are *writable* — you can assign to one, and it re-evaluates when its expression changes. A local override is legitimate; don't flag it as a mistake.

📚 A derived object or array is returned as-is and is **not** deeply reactive. If mutation of the result needs to be tracked, `$state` inside `$derived.by` is the (rare) escape hatch.

### `$effect`

**Effects are an escape hatch and should mostly be avoided.** For each `$effect` in the diff, ask what it's for and whether the intended tool exists:

| The effect is… | Use instead |
|---|---|
| computing a value from state | `$derived` / `$derived.by` |
| syncing to an external library (D3, a map, a chart) | `{@attach ...}` |
| responding to a user interaction | the event handler directly, or a function binding |
| logging for debugging | `$inspect` / `$inspect.trace` |
| observing something outside Svelte | `createSubscriber` from `svelte/reactivity` |

🟠 **State updated inside an effect.** Causes extra render passes, and often an infinite loop. Almost always means a `$derived` was wanted.

🟠 **Effect body wrapped in `if (browser) { ... }`** (or a `typeof window` guard). Effects never run on the server — the guard is dead code and signals the author misunderstands when effects fire.

🟠 **Effect with no cleanup** for a subscription, listener, timer, or observer it created. Return a teardown function.

🟠 **Dependencies read after an `await`** inside an effect are not tracked — only synchronously-read state becomes a dependency. An effect that "doesn't re-run" usually has this shape.

### `$props`

🟠 **A value computed from a prop at initialisation instead of derived.**

```js
let { type } = $props();

// do this
let color = $derived(type === 'danger' ? 'red' : 'green');

// don't do this — `color` never updates when `type` changes
let color = type === 'danger' ? 'red' : 'green';
```

Treat every prop as though it will change. This bug is invisible until the parent re-renders with a new value.

### `$inspect.trace`

📚 Not a finding — a tool for the review itself. When something re-runs more than it should, `$inspect.trace(label)` as the first line of an `$effect` or `$derived.by` (or any function they call) reports which dependency triggered the update. Suggest it when a reactivity question can't be settled by reading.

🟡 `$inspect` / `$inspect.trace` left in committed code.

## Events

🟠 **Legacy `on:click={...}` directive syntax.** In runes mode any attribute starting with `on` is a listener: `onclick={...}`. Shorthand (`{onclick}`) and spreads (`{...props}`) work too.

🟠 **`onMount` or `$effect` used to attach `window` / `document` listeners.** Use the special elements — they handle cleanup and SSR for you:

```svelte
<svelte:window onkeydown={...} />
<svelte:document onvisibilitychange={...} />
```

## Templates

### Each blocks

🟠 **Unkeyed `{#each}` over a list that reorders, filters, or has items removed.** Keys let Svelte insert/remove surgically instead of updating the DOM of existing items — without them, component state and DOM state attach to the wrong row.

🔴 **Index used as the key.** The key *must* uniquely identify the object. An index key is worse than no key: it silently asserts identity that doesn't hold.

🟠 **Destructuring the item when the body mutates it** — e.g. `bind:value={item.count}` won't work against a destructured copy.

### Snippets

🟠 **`<slot>`, `$$slots`, or `<svelte:fragment>` in new code.** Use `{#snippet ...}` + `{@render ...}`; snippets can also be passed to components as props.

```svelte
{#snippet greeting(name)}
	<p>hello {name}!</p>
{/snippet}

{@render greeting('world')}
```

📚 Snippets declared at the top level of a component can be referenced from `<script>`. One that doesn't reference component state is also available in `<script module>` and can be exported for other components — worth suggesting when the same markup is duplicated across files.

## Styling

🟡 **A JS value plumbed into CSS through a class name or inline `style` string** when the `style:` directive would set a custom property:

```svelte
<div style:--columns={columns}>...</div>
```

then `var(--columns)` inside the component's `<style>`.

🟠 **`:global` used to style a child component you control.** Component CSS is scoped; the preferred cross-component channel is a CSS custom property:

```svelte
<!-- Parent.svelte -->
<Child --color="red" />

<!-- Child.svelte -->
<h1>Hello</h1>
<style>
	h1 { color: var(--color); }
</style>
```

`:global` is the correct fallback only when the child is out of your control (a library component). Flag it when the child is in the same repo.

## State sharing and SSR

🔴 **Mutable state declared at module scope in an SSR app.** The module is shared across requests on the server, so one user's state leaks into another's render. This is a data-leak bug, not a style issue. (In SvelteKit this is the single highest-value check — see [sveltekit.md](sveltekit.md).)

Prefer **context**: it scopes state to the part of the tree that needs it and eliminates the leak.

🟡 **`setContext` / `getContext` where `createContext` is available** — `createContext` carries type safety.

🟠 **Stores (`writable`/`readable`) used to share reactivity between components in new code.** A class with `$state` fields is the modern replacement.

## Async

📚 On Svelte 5.36+, `await` expressions and `hydratable` let promises be used directly in components. Both require `experimental.async` in `svelte.config.js`.

🟠 A diff that uses await expressions **without** the flag enabled, or that adopts them in a codebase pinned below 5.36. Also worth a 🔵 note that these are explicitly not yet stable — reasonable to question in production code.

## Legacy features in new code

Each of these is 🟠 when introduced by the diff (🟡 when it's pre-existing code the change merely touched):

| Legacy | Modern |
|---|---|
| implicit reactivity (`let count = 0; count += 1`) | `$state` |
| `$:` assignments and statements | `$derived` (or `$effect`, only when nothing better fits) |
| `export let`, `$$props`, `$$restProps` | `$props` |
| `on:click={...}` | `onclick={...}` |
| `<slot>`, `$$slots`, `<svelte:fragment>` | `{#snippet ...}` + `{@render ...}` |
| `<svelte:component this={X}>` | `<X>` directly |
| `<svelte:self>` | `import Self from './ThisComponent.svelte'` |
| stores for cross-component reactivity | classes with `$state` fields |
| `use:action` | `{@attach ...}` |
| `class:` directive | clsx-style arrays/objects in `class` |

🟠 **Runes and legacy syntax mixed in one component.** A file is in runes mode or it isn't; a half-migrated component behaves surprisingly and is a migration trap for the next editor.

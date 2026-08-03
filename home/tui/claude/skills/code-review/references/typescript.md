# TypeScript review guide

## Type safety

🔴 **`any` in a public signature.** It disables checking for every caller. `unknown` + narrowing is almost always the right replacement. `any` in a local, in a test, or behind a well-typed façade is 🟡.

🟠 **Type assertions (`as`) that aren't provably true.** `as` is the author claiming something the compiler can't verify. Each one needs a reason. `as unknown as T` is a 🔴 unless it's bridging a genuinely broken third-party type, with a comment saying so.

🟠 **Non-null assertion `!` on values that can legitimately be absent.** `map.get(k)!`, `arr[0]!`, `document.querySelector(...)!` — each is a runtime crash waiting for the empty case.

🟠 **`noUncheckedIndexedAccess` defeated.** If the project enables it, indexing returns `T | undefined`. Code that immediately `!`s it away has opted back out of the protection the flag exists for.

🟡 **Return types omitted on exported functions.** Inference is fine internally, but an exported function's type should be stated so an unrelated edit can't silently change the public contract.

## Modelling

🟠 **Optional fields used to model mutually exclusive states.** `{ status: string; error?: string; data?: T }` allows `status: 'ok'` with an `error`. Prefer a discriminated union:

```ts
type Result<T> = { status: 'ok'; data: T } | { status: 'error'; error: string };
```

Look for this whenever you see two or more `?:` fields that are always set or unset together.

🟠 **Stringly-typed domain values.** `userId: string`, `role: string`, `currency: string`. Branded types or unions (`'admin' | 'member'`) make wrong-argument bugs impossible. Passing an `orderId` where a `userId` belongs typechecks fine when both are `string` — this is a real, common production bug.

🟡 **Booleans that will become three states.** `isLoading: boolean` next to `isError: boolean` is the union above in disguise.

🔵 **Wide types where narrow ones exist.** `Record<string, unknown>` for a known shape, `string` for a known enum, `number` for something that must be a positive integer.

## Narrowing and control flow

🔴 **Exhaustiveness not enforced on unions.** A `switch` over a discriminated union without a `default` that fails to compile on a new variant means adding a variant silently skips handling. Enforce with:

```ts
default: {
  const _exhaustive: never = value;
  throw new Error(`unhandled: ${String(_exhaustive)}`);
}
```

🟠 **Truthiness checks on values where `0` or `''` is valid.** `if (!count)` treats zero as missing. `if (count === undefined)` is what was meant.

🟠 **`==` / `!=` other than the `== null` idiom.** Everything else should be `===`.

## Async

🔴 **Floating promises.** An unawaited async call whose rejection nobody handles becomes an unhandled rejection and, on some runtimes, kills the process. If it's fire-and-forget on purpose, it needs an explicit `void` plus a `.catch`.

🔴 **`await` inside a loop over independent work.** Serialises N round-trips that could be one `Promise.all`. See performance guide.

🟠 **`Promise.all` where one failure must not abort the rest** — use `Promise.allSettled`.

🟠 **`async` function with no `await`.** Usually means an `await` was dropped during editing; check the return value isn't a bare promise being treated as a value.

🟠 **`try/catch` around an `await` that also wraps non-async code.** The catch now swallows errors from code it wasn't meant to cover.

🟠 **No timeout / cancellation on network calls.** A hung request holds a connection forever. Look for `AbortSignal` on `fetch`.

## Immutability and shared state

🟠 **Mutating a parameter.** `function f(opts) { opts.x = 1 }` surprises every caller. Especially bad for arrays: `.sort()`, `.reverse()`, `.splice()` mutate in place — use `.toSorted()` / `.toReversed()` or copy first.

🟠 **Module-level mutable state.** In a serverless/worker runtime this is shared across requests within an isolate and leaks data between users. 🔴 if it holds anything request-scoped (auth, tenant, user id).

🟡 **Shallow copy presented as a deep one.** `{ ...obj }` still shares nested objects.

## Errors

🔴 **`catch {}` or `catch (e) { /* ignore */ }`.** Silent failure. If ignoring is genuinely right, say why in a comment.

🟠 **Throwing non-`Error` values.** Loses the stack trace.

🟠 **Catch-and-rethrow that drops the cause.** `throw new Error('failed')` inside a catch discards the original. Use `{ cause: e }`.

🟠 **Errors typed `unknown` and then `as`-cast to a specific shape** without a type guard.

## Module hygiene

🟡 **`export` on something used only in its own file.** It widens the public surface and hides dead code from unused-export detectors.

🟡 **Value import where `import type` was meant.** Can drag runtime code into a bundle that only needed a type.

🟠 **Deep relative imports (`../../../`) crossing a package boundary** instead of the package's public entry point.

🟠 **Barrel file (`index.ts`) re-exporting a whole subtree** in a bundle-sensitive app — it defeats tree-shaking and creates import cycles.

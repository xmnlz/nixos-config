# Effect-TS review guide

## The error channel

🔴 **`unknown` or `Error` in the error channel.** The point of Effect is that failures are typed. Every failure should be a tagged error the caller can discriminate on.

```ts
class UserNotFoundError extends Data.TaggedError('UserNotFoundError')<{ userId: string }> {}
```

🔴 **`throw` inside an Effect generator.** It becomes a defect, not a failure — it bypasses the typed error channel and every `catchTag` above it. Use `yield* new SomeError(...)` or `Effect.fail`.

🔴 **`Effect.tryPromise` / `Effect.try` without a `catch` that normalises the error.** Without it, `unknown` leaks into the error channel.

🟠 **`Effect.catchAll` used where a specific tag was meant.** It swallows unrelated failures — including ones added later — and converts a typed union into a single opaque case. Prefer `Effect.catchTag` / `Effect.catchTags`.

🟠 **`Effect.orDie` / `Effect.die` on a recoverable condition.** Turning "row not found" into a defect means the caller can't handle it and it surfaces as a 500.

🟠 **`Effect.mapError` collapsing several distinct failures into one generic error** before the caller had a chance to distinguish them. Map at the boundary, not in the middle.

🟠 **Catching defects in business logic.** Defects are bugs; they belong at the outermost boundary where they can be logged and turned into a generic 500.

## Services, layers, dependencies

🔴 **Layer built per request** for something that should be constructed once (DB pool, SDK client, runtime). Check whether the change constructs a runtime or layer inside a handler.

🟠 **Raw SDK used directly in business logic** instead of through an Effect service wrapper. Third-party promise APIs (Stripe, Supabase, storage, analytics) should be wrapped once, with tagged errors and a span, then injected.

🟠 **Dependency reached for via a global import instead of the context.** Defeats testability — the whole point of `Context.Tag`.

🟠 **Circular layer dependency.** A depends on B depends on A. Often only manifests as a confusing runtime error; call it out at review time.

🟠 **Missing `Layer.scoped` / finalizer** for a resource that needs cleanup.

🟡 **Layer composition duplicated** in several places instead of one composed application layer.

## Running effects

🔴 **`Effect.runPromise` / `runSync` in a request handler** when the project has a runtime helper. Each `runPromise` builds and tears down dependencies, losing pooling and tracing.

🟠 **`Effect.runSync` on an effect that can be async** — throws at runtime.

## Concurrency and resources

🟠 **Sequential `yield*` over independent effects.** Use `Effect.all([...], { concurrency: 'unbounded' })` or a bounded number.

🔴 **`concurrency: 'unbounded'` over a user-controlled collection.** An array of 10,000 IDs becomes 10,000 concurrent DB calls. Bound it.

🟠 **`Effect.forEach` inside a loop over rows** — the N+1 pattern in Effect clothing. Batch the query instead.

🟠 **`acquireRelease` missing for something that must be undone on failure** — a write to an external system that doesn't participate in the DB transaction needs a compensating action.

🟠 **`Effect.scoped` missing** where finalizers were registered — they never run.

🟠 **No timeout on an outbound call.** `Effect.timeout` / `Effect.retry` with a schedule; retrying without a backoff schedule is 🟠 on its own.

🟠 **Retry on a non-idempotent operation.** Retrying a payment or an email send duplicates it.

## Schema

🟠 **Decoding untrusted input with a "known shape" decoder.** Reserve the trusting decoder for data that genuinely came from your own DB; use the unknown-input decoder for anything from the network.

🟠 **Whole struct decoded from `unknown` when only one field is untrusted.** Decode the one field, merge it into a normalised object, then construct the entity. Blanket `fromUnknown` hides which part was actually untrusted.

🟠 **Validation duplicated in two schemas** that can drift. Define it once and adapt (`omit`, `pick`, `partial`) at the edges.

🟡 **`Schema.Any` / `Schema.Unknown`** as an escape hatch in a domain type.

## Observability

🟠 **New service method or handler with no span.** Named spans are how these systems get debugged in production; a silent path is invisible.

🟠 **Span name that doesn't match the function it wraps** — makes traces lie.

🟠 **Logging a user-facing validation failure at error level.** Noise that buries real errors. Log expected failures at debug/info; reserve error for defects and internal failures.

🔴 **Logging tokens, passwords, full request bodies, or PII.**

## Style

🟡 Namespace imports (`import * as Effect from 'effect/Effect'`) mixed with named imports from the same module in one file — pick the project's convention.

🟡 Deeply nested `pipe` where a generator would read linearly, or vice versa. Only worth a comment when it genuinely obscures the logic.

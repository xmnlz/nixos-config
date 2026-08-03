# Performance review guide

Flag performance only where the cost scales with something real — user count, row count, list length, request rate. A 2× slowdown on a once-per-deploy path is not a finding.

## Database

🔴 **N+1 query.** A query inside a loop over rows, or a `map`/`forEach` that awaits a per-item fetch. Fix with a batched `IN` query, a join, or a dataloader. This is the single most common serious performance defect.

Detection: any `await` or `yield*` textually inside a `for`/`map`/`forEach` whose collection came from a previous query.

🔴 **Unbounded query.** `SELECT` with no `LIMIT` on a table that grows — fine at 100 rows, fatal at 10 million. Every list endpoint needs pagination, and pagination needs a stable sort key.

🟠 **New query filtering/sorting on an unindexed column.** Check whether a migration adds the index. Also check composite index column order matches the query.

🟠 **`OFFSET`-based pagination on a large table** — cost grows linearly with offset. Prefer keyset/cursor pagination.

🟠 **`SELECT *` / selecting whole rows** when a few columns are used, especially with large text/JSON columns.

🟠 **Count query on every request** where an approximate or cached count would do.

🟠 **Work inside a transaction that doesn't need to be there** — HTTP calls, LLM calls, file uploads. Long transactions hold locks and connections.

🟠 **Missing transaction where two writes must be atomic**, leaving inconsistent state on partial failure. (Correctness, but usually surfaces as a performance/retry problem.)

🟠 **Read-modify-write race** — read a counter, add one, write it back. Two concurrent requests lose an update. Use an atomic increment or a conditional update.

## Async and concurrency

🔴 **Serial awaits on independent operations.** `await a(); await b();` where neither depends on the other doubles latency. `Promise.all`.

🔴 **Unbounded parallelism over a user-controlled collection.** 10,000 IDs → 10,000 concurrent connections → pool exhaustion and a self-inflicted DoS. Bound the concurrency.

🟠 **No timeout on an outbound call.** One slow upstream ties up capacity across the fleet.

🟠 **Retry without exponential backoff and jitter** — synchronised retries amplify an outage.

🟠 **Retry on a non-idempotent operation** — duplicate charges, duplicate emails.

## Algorithms and memory

🟠 **Nested loop over two collections that both scale** — O(n·m). A `Map` lookup makes it O(n+m). Worth flagging when either side comes from user data or a query.

🟠 **`array.includes`/`find` inside a loop** — same problem, less visible.

🟠 **Repeated work in a loop that is loop-invariant** — regex compilation, date formatter construction, config parsing, schema construction.

🟠 **Whole dataset loaded into memory** to compute something the database could compute, or that could stream. Serverless/worker runtimes have hard memory limits — this is 🔴 there.

🟠 **Unbounded in-memory cache/Map** keyed by user or request data — grows until OOM.

🟠 **Full re-parse/re-serialise of a large JSON payload** on a hot path.

## Caching

🟠 **New expensive computation with no caching** on a hot path — and conversely, a cache added where the computation was cheap (cache invalidation is a real cost).

🟠 **Cache key missing a dimension** the result depends on — user, tenant, locale, permission scope. Serving one tenant's cached data to another is a 🔴 security finding, not a performance one.

🟠 **Cache with no TTL or no invalidation on write** — permanently stale.

🟠 **Caching a personalised response at the CDN/edge layer.**

## Frontend

🟠 **Large dependency added** for a small job (date library for one format call, lodash for one helper, chart library on a page with no chart). Check whether it's tree-shakeable and whether it lands in the initial bundle.

🟠 **Heavy component not lazily loaded** — editor, chart, PDF viewer, emoji picker. These belong behind a dynamic import.

🟠 **Expensive work in render** — sorting/filtering a large list, `JSON.parse`, date formatting per row.

🟠 **New context provider holding a frequently-changing value near the app root** — re-renders every consumer.

🟠 **Unstable prop identity into a memoised child** — new object/array/function literal per render defeats the memo entirely.

🟠 **Long list rendered without virtualisation** where length is user-controlled.

🟠 **Waterfall requests** — a fetch whose input comes from a previous fetch that could have run in parallel or been resolved server-side.

🟡 **Unoptimised images**, missing dimensions (layout shift), missing `loading="lazy"` below the fold.

## Before flagging

State the scaling factor. "This is O(n²) where n is the number of rows returned, which reaches ~5,000 for large accounts" is actionable. "This could be faster" is not.

# Quality, reuse, and dead code

This is the guide for "can this be simpler, smaller, or deleted entirely" — the highest-value review output after correctness, and the one automated tooling is worst at.

## 1. The reuse audit

Run this on **every new function, constant, type, and component** in the diff. Most duplication is written by people who didn't know the helper existed.

```bash
# by name and near-names
rg -n "formatDuration|durationToString|toDuration" --type ts

# by the distinctive body of the logic
rg -n "Math.floor\(.*\/ 60" --type ts

# by the constant's value
rg -n "1024 \* 1024" --type ts
```

Check, in order:

1. **The same directory.** Sibling files are where near-duplicates hide.
2. **The nearest shared module** — `utils/`, `lib/`, `shared/`, `components/ui/`.
3. **Shared packages** — a monorepo `packages/utils`, `packages/types`, `packages/ui`.
4. **The platform.** `Object.groupBy`, `Array.prototype.at`, `toSorted`, `structuredClone`, `Intl.*`, `URL`, `AbortSignal.timeout` replace a lot of hand-written helpers.
5. **Existing dependencies.** A library already in the manifest may do it.

Report as: 🔵/🟠 `path:line` — "`formatBytes` here duplicates `packages/utils/src/formatters.ts:12`. Import that instead; it also handles the zero case, which this version doesn't."

**Then check the inverse:** does this change make an *existing* helper redundant? Two functions doing the same thing is worse than one, whichever came first.

## 2. Dead code the change created

A change is not finished when the new path works — it's finished when the old path is gone.

| Removed / changed | Now check for |
|---|---|
| A call site | Is the callee still called anywhere? |
| The last consumer of a component | Component, its stories, its tests, its styles |
| A conditional branch | Constants, types, and helpers only that branch used |
| A feature flag's second value | Everything behind the dead value |
| A field from a type | Every producer of that field; DB column; migration |
| A route | Links to it, translation keys, sitemap entries, tests |
| A prop | Callers still passing it (silently ignored) |
| An env var | Config schema, deployment config, `.env.example`, docs |

```bash
# candidate is dead if this returns only its own definition
rg -n "\bthingName\b" --type ts

# string-keyed references the compiler will never catch
rg -n "thing-name|'thingName'" -g '!node_modules'
```

Also flag:

🟠 **Unreferenced export.** Exported but imported nowhere — either make it local or delete it. Exported-and-unused is invisible to most tooling and accumulates forever.

🟠 **Parameter no longer read** by the function body, still passed by every caller.

🟠 **Commented-out code.** Git remembers it. Delete.

🟠 **`TODO`/`FIXME` added by this change** with no owner, ticket, or date.

🟡 **Translation keys, fixtures, or test helpers** orphaned by the change.

If the project has an unused-code detector (knip, ts-prune, depcheck), run it and compare against the base branch so you attribute only the new findings.

## 3. Simplification

Concrete, common wins. Each is 🔵 unless it also hides a bug.

**Collapse nested conditionals with guard clauses.** Three levels of `if` nesting almost always inverts into early returns.

**Replace an if/else-if chain over one value** with a lookup object or a `switch` — especially when each branch returns.

**Delete defensive checks the types already guarantee.** `if (typeof x === 'string')` on a `string` parameter is noise; if it's *not* guaranteed, the type is wrong and that's the real finding.

**Merge passes over the same collection.** `.filter().map().filter()` over a large array, or three separate loops that could be one.

**Drop the intermediate variable that's used once** and named worse than the expression.

**Replace a hand-rolled loop with the standard method** — `some`, `every`, `find`, `flatMap`, `Object.groupBy`.

**Collapse a wrapper that adds nothing** — a function that only forwards its arguments, a component that only renders one child, an abstraction with exactly one implementation and no prospect of a second.

**Question new abstraction introduced for a single use.** Premature indirection costs more than the duplication it prevents. Two occurrences is a coincidence; three is a pattern.

## 4. Recurring anti-patterns

🟠 **Parameter sprawl.** More than ~4 positional parameters, or two adjacent booleans — call sites become unreadable and argument-swap bugs typecheck. Take an options object.

🟠 **Boolean parameter that selects behaviour.** `render(true)` means nothing at the call site. Two functions, or a named union.

🟠 **Leaky abstraction.** A "repository" that returns driver-specific rows; a "service" whose caller must know the HTTP status codes; a hook that returns raw query internals.

🟠 **Mixed levels of abstraction in one function.** High-level orchestration interleaved with byte-shuffling. Extract the low-level part.

🟠 **Doing two things.** A function that both computes and persists, or both validates and mutates, can't be tested or reused for either.

🟠 **Magic number or string used more than once**, or used once with non-obvious meaning. Name it.

🟠 **Copy-pasted block with one value changed** — the classic three-near-identical-branches shape.

🟠 **No-op update.** Writing a value equal to the current one, or an "update" whose payload is empty — usually a symptom of a lost condition.

🟠 **Time-of-check/time-of-use.** Checking a quota, permission, or existence and acting on it later without atomicity. Under concurrency both requests pass the check.

🟠 **Comment describing what the code does** rather than why. If the code needs the "what", rename things instead. Comments that have gone stale relative to the code they describe are 🟠 — they actively mislead.

🟡 **Inconsistent with the neighbours.** Different naming, file layout, or error-handling shape than the sibling files. Consistency is a real cost saving; deviation needs a reason.

## 5. Altitude check

Finally, step back from the diff and ask:

- Is this solving the problem, or working around a defect one level down? A `try/catch` around a function that shouldn't throw, a `setTimeout` to dodge a race, a null check compensating for a caller that shouldn't pass null — fix the cause.
- Is the complexity here proportional to the problem? Configuration, generics, and indirection added "for later" usually never pay off.
- If you deleted the newest 20% of this change, would anything be lost?

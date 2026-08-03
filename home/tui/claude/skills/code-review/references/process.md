# Review process in depth

## Getting the right diff

| Situation | Command |
|---|---|
| Current branch vs main | `git diff main...HEAD` (three dots — excludes main's own commits) |
| Uncommitted work | `git diff` and `git diff --staged` |
| A GitHub PR | `gh pr diff <n>` / `gh pr view <n> --json title,body,files` |
| Just the file list | `git diff --stat main...HEAD` |
| A single commit | `git show <sha>` |

Always start from `--stat`. The shape of the change (2 files × 400 lines vs 40 files × 10 lines) determines how you read it.

## Triaging by size

- **< 100 lines** — read every line, plus every caller of every changed export.
- **100–400 lines** — read every line, sample callers for the riskiest exports.
- **> 400 lines** — do not read top-to-bottom. Group files by subsystem, review the highest-risk subsystem completely, sample the rest, and state in the summary which parts got shallow coverage. Also flag the size itself: 🟠 if it mixes unrelated concerns that could have shipped separately.
- **Generated files, lockfiles, snapshots** — skip the content, check only that they're consistent with the source change (e.g. lockfile changed but no `package.json` change is suspicious).

## Reading order within a change

Read in dependency order, not alphabetical order:

1. Types / schemas / interfaces — these define the contract everything else obeys.
2. Data layer — queries, repositories, migrations.
3. Business logic.
4. Transport / handlers / routers.
5. UI.
6. Tests.
7. Config, CI, infra.

Reading types first means that by the time you reach the UI you already know what shapes are legal, and illegal ones jump out.

## Blast-radius check

For every exported symbol whose signature, semantics, or nullability changed:

```bash
rg -n "\bsymbolName\b" --type ts
```

Then ask, per call site: does it still compile *and* still mean the same thing? Type checkers catch the first, not the second. A field that changed from "always present" to "present unless archived" compiles fine everywhere and is wrong in half of them.

For deleted or renamed things, also grep string references: dynamic imports, route strings, translation keys, feature flags, env var names, SQL column names.

## Migration and data-shape changes

These deserve their own pass because they cannot be rolled back cheaply:

- Is the migration backwards-compatible with the currently-deployed code? (Deploys are not atomic.)
- Adding a `NOT NULL` column without a default breaks inserts from old code.
- Dropping/renaming a column requires a two-phase deploy — flag single-phase drops as 🔴.
- Index added for the new query? Index left behind for a removed query?
- Backfill: does it lock the table, and is it batched?

## Tests

Judge tests on whether they'd catch a regression, not on coverage percentage:

- Does each new test fail if you mentally revert the corresponding production line? If not, it tests nothing.
- Are edge cases covered — empty collection, boundary value, failure path, concurrent call?
- Are assertions specific? `expect(result).toBeTruthy()` on an object is close to no assertion.
- Is the test coupled to implementation detail (mocking internals, asserting call order) in a way that will break on any refactor? That's 🟠 — it makes future changes expensive.
- Missing test for a bug fix is 🟠: the bug can silently return.

## What to verify by running

Prefer evidence over inference. Typical checks, cheapest first:

```bash
# type check, lint, dead code, tests — adapt to the repo's actual scripts
<pkg-manager> run lint
<pkg-manager> run check-types
<pkg-manager> run knip        # or equivalent unused-code detector
<pkg-manager> test
```

If a command fails for reasons unrelated to the diff (pre-existing breakage), say so explicitly rather than attributing it to the author.

## Writing the summary

Template:

```md
## Summary
<what the change does, in one or two sentences, in your own words — this proves you understood it>
<verdict sentence>

## Findings

### 🔴 blocking
- `path/to/file.ts:42` — <defect>. <failure scenario>. <fix>.

### 🟠 important
- ...

### 🟡 nit / 🔵 suggestion
- ...

## 🌟 Worth calling out
- ...

## Coverage
Reviewed: <areas>. Not reviewed: <areas and why>. Commands run: <list, with results>.

**Decision:** Approve / Comment / Request changes
```

Restating the change in your own words at the top is not filler — if you cannot do it, you are not ready to review it.

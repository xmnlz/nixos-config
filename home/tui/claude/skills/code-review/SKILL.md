---
name: code-review
description: Systematic code review for TypeScript / React / Effect-TS code — correctness, architecture, security, performance, and quality, with severity-labelled findings. Use when reviewing a pull request, a branch, a diff, or staged/uncommitted changes; when asked to "review this", "check my changes", "look over this PR", "find problems in what I wrote"; or when establishing review standards. If a project-specific review skill matches the repo being reviewed, prefer that one.
allowed-tools: Read, Grep, Glob, Bash, WebFetch
---

# Code Review

Review is knowledge sharing, not gatekeeping. The output is a prioritised, actionable list of findings — each tied to a file and line, each something the author can act on without asking a follow-up question.

## Core rules

1. **Never report a finding you have not verified in the code.** Read the surrounding context before claiming a bug. A plausible-sounding defect that doesn't reproduce wastes more of the author's time than saying nothing.
2. **Every finding needs a failure scenario.** "This could be cleaner" is not a finding. "If `items` is empty, line 42 throws because `items[0].id` is unguarded" is.
3. **Don't review what tooling already reviews.** Formatting, import order, lint rules, simple typos — the linter owns those. Run it instead of commenting on it.
4. **Read the neighbourhood, not just the diff.** Most real findings live at the seam between new code and code that already existed: a helper that already does this, a caller that now passes a dead argument, an export nothing imports anymore.
5. **Praise is a finding too.** If a change made something meaningfully better, say so and say why.

## Severity labels

Use exactly these. Order findings most-severe first.

| Label | Meaning |
|---|---|
| 🔴 `blocking` | Must be fixed before merge — correctness, security, data loss, breaking API change |
| 🟠 `important` | Should be fixed — real defect or design problem, may block depending on context |
| 🟡 `nit` | Minor, non-blocking. Style or preference the linter doesn't cover |
| 🔵 `suggestion` | Optional improvement worth considering — simpler, faster, or more reusable |
| 📚 `learning` | Educational note, no action required |
| 🌟 `praise` | Explicitly good work |

If more than ~20% of your findings are 🔴, recheck them — you are probably over-escalating.

## Review process

Run these phases in order. Full detail in [references/process.md](references/process.md).

### Phase 1 — Scope and context

- Get the diff: `git diff main...HEAD`, `git diff --staged`, or `gh pr diff <n>`.
- Read the PR/commit description and any linked issue. What is this *supposed* to do?
- Check size. Over ~400 changed lines, review in passes by subsystem rather than top-to-bottom, and say so in the summary.
- Check CI/build/test status before reading — a failing build tells you where to look.
- Identify which layers are touched (UI, API, data, infra). That selects your guides below.

### Phase 2 — Design pass (read, don't nitpick)

Before any line-level comment, answer:

- Does the approach fit the problem, or is it fighting the existing architecture?
- Is the change in the right place — right module, right layer, right ownership boundary?
- **Does this already exist?** Grep for the function name, the string constant, the shape of the logic. Duplicated helpers are the single most common avoidable finding.
- What is the blast radius? Search for callers of every changed signature.
- Are the tests testing behaviour that could actually break, or just restating the implementation?

### Phase 3 — Line-by-line pass

For each changed hunk, in this order:

1. **Correctness** — edge cases, empty/null/undefined, off-by-one, early returns, unhandled branches, async ordering, race conditions.
2. **Error handling** — every failure path either handled or deliberately propagated; no swallowed errors; no `catch {}`.
3. **Security** — untrusted input reaching a query/render/exec, authz checks on every mutation, secrets and PII in logs. See [references/security.md](references/security.md).
4. **Performance** — N+1s, work inside loops that belongs outside, unbounded fetches, re-render churn. See [references/performance.md](references/performance.md).
5. **Reuse and dead code** — existing helper that should have been used; code the change just made unreachable. See [references/code-quality.md](references/code-quality.md).
6. **Naming and clarity** — does the name say what it does, and is it still true after this change?

### Phase 4 — Verify

Before writing the summary, run what you can: type check, lint, tests, dead-code check. A finding confirmed by a failing command outranks ten findings from reading.

### Phase 5 — Summarise

- One-paragraph verdict: what the change does and whether it is sound.
- Findings, most severe first, each as `file:line` + label + failure scenario + concrete fix.
- Explicit decision: **Approve** / **Comment** / **Request changes**.
- What you did *not* cover (files skipped, tests not run) — silence reads as coverage.

## How to phrase findings

Ask about intent, state facts about behaviour.

```md
❌ "This is wrong."
✅ "If `items` is empty this throws at line 42 — `items[0]` is unchecked. Guard, or use `.at(0)`."

❌ "Why didn't you use the repository pattern?"
✅ "This bypasses `userRepository.getById` and queries the table directly. Deliberate? Going through the repo keeps the error mapping consistent."

❌ "Rename this."
✅ "[nit] `uc` → `userCount`. Not blocking."
```

Never rewrite someone's code to your taste and present it as a defect. If two approaches are both fine, say so and move on.

## Topic guides

Load only what the diff touches.

| Topic | Guide |
|---|---|
| Review workflow in depth, diff triage, large PRs, migrations, tests | [references/process.md](references/process.md) |
| TypeScript — type safety, narrowing, async, immutability | [references/typescript.md](references/typescript.md) |
| React 19 / Next.js — hooks, RSC, Server Actions, TanStack Query | [references/react-next.md](references/react-next.md) |
| Effect-TS — services, layers, typed errors, schema, concurrency | [references/effect-ts.md](references/effect-ts.md) |
| Security — injection, authz, SSRF, secrets, XSS | [references/security.md](references/security.md) |
| Performance — N+1, complexity, caching, bundle, re-renders | [references/performance.md](references/performance.md) |
| Quality — reuse audit, dead code, anti-patterns, simplification | [references/code-quality.md](references/code-quality.md) |

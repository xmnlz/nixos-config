---
name: preview
description: Build a throwaway UI preview I can click through and pick from, fast. Several design variants side by side, every state, matching the real app. Use when I ask for a preview, a mock, a prototype, variants, options to pick from, or "show me how it would look", before anything is built in the real app.
---

# preview

A preview exists to help me make one design decision. It is thrown away once I
have picked.

## Before building

1. **Name the decision** in one line: what am I picking between? Everything
   on the page serves that question. Nothing else goes on it.
2. **Screenshot the real screen** the change lands in, with the browser skill,
   in light and dark. That screenshot is what the preview has to match.
3. **Find the real parts:** the app's components, its theme CSS (tokens,
   fonts, radius) and its icons. Copy them, do not redraw them.

## Pick the mode

| Mode | When | How |
| --- | --- | --- |
| **Quick** | copy, order, layout, a flow | one HTML file, Tailwind from its browser build, the app's theme variables pasted in |
| **Lab** | it has to look exactly like the app | a Vite + React + Tailwind project with the app's components copied in, built with `vite-plugin-singlefile` into one `index.html` |

Start in Quick unless the decision is about how it looks in detail. A lab
lives in `~/projects/<task>-lab/` and can be reused for the next round.

## Build

- **One agent per variant, in parallel.** Each gets the decision, the
  screenshot, the real parts, and its own idea to build. Name the variants A,
  B, C.
- **One page holds them all:** tabs or side by side, with switches for every
  state the screen has. Always language (each the app ships), light and dark.
  Then whichever apply: empty, loading, error, long content, a narrow width.
- Each variant says in one line what it is betting on.
- Files go in `/tmp/preview-<task>/`, unless a vault note asks for them in its
  assets.

## Check, then show

- **Compare with the screenshot** at the same width, in a browser. If it does
  not match the real app, fix it before I see it.
- Click every switch once. The console must be empty.
- **Open it** as soon as it passes. Report one line per variant.

## After I pick

Write my pick and why into the effort it belongs to, the same turn. Changes I
ask for go into the same page, so the history of the round stays in one place.

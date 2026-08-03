# Security review guide

Review for security on every diff that touches: an HTTP handler, a Server Action, a database query, a file upload/download, an auth flow, a template that renders user text, or anything that spends money or sends mail.

## Authorisation — the highest-yield check

Most real vulnerabilities in application code are missing authorisation, not exotic injection.

🔴 **Object accessed by an ID from the request with no ownership check.** (IDOR.) `getDocument(input.id)` must also assert the caller may read *that* document. Authentication ("who are you") is not authorisation ("may you touch this").

🔴 **Permission checked in the UI only.** Hiding a button hides nothing — the endpoint is still callable.

🔴 **Authorisation check present but not enforced.** Computing `hasPermission` and never branching on it, or branching only on the happy path.

🔴 **Tenant/org scope missing from a query.** In a multi-tenant system, every query on tenant-owned data needs the tenant predicate. One missing `WHERE org_id = ?` is a cross-customer data leak.

🔴 **Privilege derived from client-supplied data.** `role` taken from the request body, tenant taken from a header the client controls.

🟠 **New endpoint using the public/unauthenticated base** where siblings use the protected one. Compare against the adjacent handlers.

🟠 **Authorisation on the write path but not the corresponding read path** (or vice versa).

## Injection

🔴 **SQL built by string concatenation or template literal with user input.** Parameterise. If a dynamic identifier (table/column/direction) is genuinely required, validate it against an allowlist — identifiers cannot be parameterised.

🔴 **`LIKE`/`ILIKE` pattern from user input without escaping `%` and `_`.** At minimum a DoS via wildcard scans.

🔴 **Shell command built from user input** (`exec`, `spawn` with `shell: true`). Use argument arrays, never a shell string.

🔴 **Dynamic `eval`, `new Function`, or dynamic `import()` of a user-controlled path.**

🟠 **NoSQL query taking a raw object from the request** — allows operator injection (`{ $gt: '' }`). Validate to primitives first.

🟠 **User input in a redirect target, `Location` header, or `window.location`** — open redirect. Allowlist the destination.

## XSS

🔴 **`dangerouslySetInnerHTML` / `v-html` / `innerHTML` with user or CMS content** not sanitised on the server with a real sanitiser.

🔴 **Markdown rendered with raw HTML enabled** and no sanitisation step.

🟠 **User-controlled URL in `href`/`src`** without a scheme check — `javascript:` and `data:` are executable.

🟠 **User data interpolated into an inline `<script>` or a JSON blob in HTML** — needs proper escaping, not `JSON.stringify` alone.

## SSRF and outbound requests

🔴 **`fetch` to a user-supplied URL.** Reaches cloud metadata endpoints and internal services. Requires a scheme + host allowlist, and DNS-rebinding awareness if it's a general "import from URL" feature.

🟠 **Webhook/callback URL accepted without validation.**

🟠 **Redirects followed automatically on a user-supplied URL** — the allowlist check must apply after each hop.

## Secrets and data exposure

🔴 **Secret hardcoded** — key, token, password, connection string. Even in a test file, even "temporarily".

🔴 **Server secret exposed to the client** via a public-prefixed env var, a client-side import, or a prop.

🔴 **Secrets, tokens, or PII in logs**, including whole request/response bodies and error objects that embed them.

🟠 **Internal detail in a client-facing error** — stack trace, SQL text, file path, upstream error message.

🟠 **Error message that distinguishes "no such user" from "wrong password"** — user enumeration. Same for password-reset and invite flows.

🟠 **Response object built by spreading a DB row** — ships every column, including ones added later (`password_hash`, `stripe_customer_id`, internal flags). Select fields explicitly.

## Authentication and sessions

🔴 **Session/JWT trusted without verification**, or verified without checking expiry, issuer, and audience.

🔴 **`alg: none` or algorithm taken from the token header.**

🟠 **Token or session id in a URL** — leaks via referrer, logs, and history.

🟠 **Cookie missing `HttpOnly` / `Secure` / `SameSite`** for a session cookie.

🟠 **Session not rotated on privilege change** (login, role change) — session fixation.

🟠 **Password compared with `===` or hashed with a fast hash.** Use a memory-hard KDF and a constant-time compare for tokens.

🟠 **State-changing endpoint reachable cross-origin without CSRF protection** (relevant for cookie-authenticated non-JSON endpoints).

## Uploads, files, and rate limits

🔴 **Path built from a user-supplied filename** — traversal. Generate the storage key server-side.

🟠 **File type trusted from the client-supplied MIME type or extension.** Check content.

🟠 **No size limit** on upload or on a request body.

🟠 **Signed URL with an excessive TTL, or scoped to a bucket rather than an object.**

🟠 **Expensive, unauthenticated, or spendable endpoint with no rate limit** — LLM calls, email/SMS, PDF generation, sign-up, password reset, invite.

## Dependencies and config

🟠 New dependency: is it maintained, widely used, and is it actually needed for what it does here? A transitive supply-chain risk for a 10-line utility is a bad trade.

🟠 Lockfile changed with no corresponding manifest change, or a dependency pinned to a range that allows a major bump.

🟠 CORS widened to `*` alongside credentials.

🟠 A permissions/CSP directive loosened — ask why, and whether it can be scoped.

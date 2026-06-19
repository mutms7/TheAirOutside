# Defects (code-phase findings)

Likely BUGS surfaced while extracting requirements from code (P1.5) — a route with no auth, a fail-open
check, a missing isolation filter, code that contradicts a passing test. These are NOT requirements
(encoding them would canonize the bug). Triage each: fix the code (then co-update the record), or open a
tracked issue. Verify every finding against the actual code before listing it here.

| # | Area | File | Finding | Why it looks wrong | Recommendation | Status |
|---|------|------|---------|--------------------|----------------|--------|

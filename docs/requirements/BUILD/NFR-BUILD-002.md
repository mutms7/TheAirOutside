---
id: NFR-BUILD-002
type: NFR
area: BUILD
provenance: doc
status: unratified
verification: manual
tests: []
source: ["vercel.json", "build.sh"]
why: The Vercel deploy path is how players access the game publicly; a misconfigured SPA rewrite causes 404 on direct URL access.
---
The Vercel deployment (bash build.sh) produces a working SPA with: a catch-all rewrite routing all paths to index.html, a 1-year cache header on /_framework/ assets, and no-cache on index.html.

Verification: Manual — after a Vercel deploy, navigate directly to a non-root path (e.g. /play) and confirm 200 with the game loaded, not a 404.

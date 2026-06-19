---
id: FR-BUILD-003
type: FR
area: BUILD
provenance: doc
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Web/**"]
why: The web publish target must be a fully self-contained static folder so it can be dropped on Vercel, Cloudflare Pages, or itch.io without a server.
---
`dotnet publish src/VisualNovel.Web -c Release -o publish` exits with code 0 and produces publish/wwwroot/index.html.

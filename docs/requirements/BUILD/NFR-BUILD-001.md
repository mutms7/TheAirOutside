---
id: NFR-BUILD-001
type: NFR
area: BUILD
provenance: doc
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/wwwroot/**"]
why: Zero runtime JS dependencies is an architectural constraint; importing an npm package would break the no-bundle, static-file deploy model.
---
No node_modules directory exists under src/; no package.json with a non-empty "dependencies" field exists under src/.

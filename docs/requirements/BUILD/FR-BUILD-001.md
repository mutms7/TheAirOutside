---
id: FR-BUILD-001
type: FR
area: BUILD
provenance: code
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.InkBuild/Program.cs", "ink/story.ink"]
why: The Ink compiler must run cleanly as a precondition for any gameplay; a compile failure is a blocking build error, not a runtime degradation.
---
Running `dotnet run --project src/VisualNovel.InkBuild` exits with code 0 and writes a valid JSON file to src/VisualNovel.Shared/wwwroot/story.json.

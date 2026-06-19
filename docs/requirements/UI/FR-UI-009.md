---
id: FR-UI-009
type: FR
area: UI
provenance: doc
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/wwwroot/js/interaction.js"]
why: Fullscreen must be togglable via keyboard so players can go borderless without touching the mouse.
---
Fullscreen mode is toggled by pressing F or F11, and by clicking the fullscreen icon in the TopBar; in the web app this calls the DOM Fullscreen API, in the desktop app it sends a web-message via window.visualNovelHost.

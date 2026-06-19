# Reconciliation Ledger

Human-reviewable record of cross-source conflicts found during reconciliation (P2). Conflicts are NOT
auto-applied. Fill in **Decision** (Accept|Reject|Edit|Defer), **Edited_Statement**, and **Ratified**
(Y|N), then run `cvs apply-ledger` (P6). Fewer than ~25 conflicts → keep it here as this markdown table;
more → use a CSV with the SAME columns at `docs/cvs/reconciliation-ledger.csv` (apply-ledger reads either).

Columns are the canonical Appendix B set; `cvs apply-ledger` auto-applies only the mechanical subset
(Edit/Accept-with-Edited_Statement rewrites the record's statement; Ratified=Y flips status) and lists the
rest (fix-code / fix-doc / create-new) as manual follow-up.

| ID | Area | Sources | Statement_A | Statement_B | Conflict_Type | Conflict_Detail | Recommendation | Rationale | Confidence | Decision | Edited_Statement | Ratified |
|----|------|---------|-------------|-------------|---------------|-----------------|----------------|-----------|------------|----------|------------------|----------|
| FR-CLIMAX-004 | CLIMAX | code vs doc | 8s ease forwards, opacity 0.55 (CSS + CLAUDE.md) | "slow ~1.5s fade-in" (mechanics.md §Impl note 6) | stale-doc | mechanics.md was written in Phase 1 design-only; implementation settled on 8s in Phase 7. CLAUDE.md and CSS both confirm 8s. | Accept 8s record; mechanics.md §note 6 is stale. | Code and CLAUDE.md are in agreement; doc predates the implementation. | H | Accept | — | Y |
| FR-CLIMAX-005 | CLIMAX | doc (unbuilt) | — (no code) | "pre-pause silence ~3s, music stops before climax div" (mechanics.md §Impl note 1) | missing | Transition into IsClimaxPause is immediate; no 3s pre-silence or music stop implemented. | Create FR-CLIMAX-005 as tracked debt in gap baseline. | Intentional deferral; address in Phase 8 with audio wiring. | H | Accept (create-new applied) | — | N |
| NFR-NARR-001 | NARR | code vs requirement | Em-dash in ink/scenes/11-night-hallway.ink line 85 (choice label) | NFR-NARR-001: no em-dashes in player-visible prose | conflict | Phase 6 conversion missed the em-dash in `[Walk to the janitor — say something.]`. | Fix prose — replace em-dash with semicolon. | Clear Phase 6 regression; semicolon preserves the two-part phrasing cleanly. | H | Accept (fix applied) | `[Walk to the janitor; say something.]` | Y |
| NFR-AUDIO-002 | AUDIO | doc (unbuilt) | audio.js has no IsClimaxPause check; scene 13 mood plays normally | "ambient/diegetic only; no score during pause" (mechanics.md §Impl note 2) | missing | MusicService calls SetSceneMoodAsync(13) on normal scene change with no silence for the climax pause specifically. | Keep as unbuilt debt; address in Phase 8. | Audio not yet wired; deferring all audio feature work to Phase 8. | H | Defer | — | N |
| FR-NARR-005 | NARR | coverage gap | Requirement exists; no test bound | — | missing | First-person Wren-verb check has no automated test. | Leave in gap baseline; no test needed at this time. | Low risk of regression given active authoring discipline; can add test if/when violations appear. | H | Defer | — | N |

Conflict_Type: missing | conflict | weaken | vague | stale-doc | code-vs-doc. Confidence: H|M|L.

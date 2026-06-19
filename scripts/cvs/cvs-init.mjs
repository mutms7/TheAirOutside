#!/usr/bin/env node
// cvs-init — scaffold the CVS kit into the current repo. Idempotent: never overwrites an existing
// file (reports [skip]); only creates what's missing and appends the .gitignore negation once.
import { writeFileSync, readFileSync, existsSync, mkdirSync } from 'node:fs';
import { join, dirname, basename } from 'node:path';
import { fileURLToPath } from 'node:url';
import { execFileSync } from 'node:child_process';

const ROOT = process.cwd();
const KIT_DIR = dirname(fileURLToPath(import.meta.url));
const created = [], skipped = [];
function put(rel, content) {
  const abs = join(ROOT, rel);
  if (existsSync(abs)) { skipped.push(rel); return; }
  mkdirSync(join(abs, '..'), { recursive: true });
  writeFileSync(abs, content);
  created.push(rel);
}

// ── Stack presets (`cvs init --preset <name>`) ────────────────────────────────
// A preset pre-fills the stack-specific config — `testSources` globs (with brace alternation,
// which the indexer's globToRe supports) and the coverage `policy`. The rest of the config is
// identical across presets. `default` keeps the TODO placeholders for an unknown stack; `dotnet`
// and `js-react` give a real starting point so a JS/React repo (or a .NET one) is usable without
// hand-authoring the globs. Override anything in .traceability.config.json afterwards.
const PRESETS = {
  default: {
    label: 'generic placeholders (edit testSources for your stack)',
    testSources: [
      { glob: 'TODO/**/*.ext', kind: 'unit', requireTagged: false },
      { glob: 'TODO/**/*.spec.ts', kind: 'playwright', requireTagged: true },
    ],
    policy: {
      FR: { requires: 'playwright|integration|unit' },
      BIZ: { requires: 'unit' },
      NFR: { requires: 'any|manual' },
    },
  },
  dotnet: {
    label: '.NET — xUnit/MSTest/NUnit unit + Playwright e2e',
    testSources: [
      { glob: 'tests/**/*.cs', kind: 'unit', requireTagged: false },
      { glob: 'PlaywrightTests/tests/**/*.ts', kind: 'playwright', requireTagged: true },
    ],
    policy: {
      FR: { requires: 'playwright|integration|unit' },
      BIZ: { requires: 'unit' },
      NFR: { requires: 'any|manual' },
    },
  },
  'js-react': {
    label: 'JS/React — Vitest/Jest unit + Playwright e2e + Storybook stories',
    testSources: [
      // Vitest/Jest unit + component tests. Brace alternation covers JS and TS / React (.jsx/.tsx).
      { glob: 'src/**/*.{test,spec}.{js,jsx,ts,tsx}', kind: 'unit', requireTagged: false },
      // Playwright e2e specs (tag each with its requirement ID — requireTagged).
      { glob: 'e2e/**/*.{spec,test}.{js,ts}', kind: 'playwright', requireTagged: true },
      // Storybook stories as a proof source out of the box (kind: storybook; allowed by the FR/NFR
      // policy below). Coverage comes from the record's `tests:` binding, so requireTagged:false.
      { glob: 'src/**/*.stories.{js,jsx,ts,tsx}', kind: 'storybook', requireTagged: false },
    ],
    policy: {
      FR: { requires: 'playwright|integration|unit|storybook' },
      BIZ: { requires: 'unit' },
      NFR: { requires: 'any|manual' },
    },
  },
};

const PRESET_NAME = (() => {
  const i = process.argv.indexOf('--preset');
  const name = i >= 0 ? (process.argv[i + 1] || '').toLowerCase() : 'default';
  if (!PRESETS[name]) {
    console.error(`cvs init: unknown --preset "${name}". Known presets: ${Object.keys(PRESETS).join(', ')}.`);
    process.exit(2);
  }
  return name;
})();
const PRESET = PRESETS[PRESET_NAME];

// Area segment `[A-Z][A-Z0-9]*` allows digits (A11Y, OAUTH2) — matching the cvs-repo areas-glossary
// key shape. `-` is the ID field delimiter, so an area code can't contain a hyphen (use one token,
// e.g. RUNTIMEINTERFACE). Override `idPattern` below for a different scheme.
const CONFIG = JSON.stringify({
  requirementSources: ['docs/requirements/**/*.md'],
  idPattern: '(FR|BIZ|NFR)-[A-Z][A-Z0-9]*-\\d+',
  enforceGlobalIdUniqueness: true,
  enforceAreaPrefixMatchesPath: true,
  testSources: PRESET.testSources,
  policy: PRESET.policy,
  manualMarker: 'Verification: Manual',
  infraMarker: 'Verification: Infra',
  ignoreRangeHeaders: true,
  baseline: 'docs/traceability-baseline.json',
  untaggedTestBaseline: 'docs/untagged-test-baseline.json',
  index: { json: 'docs/requirements-index.json', traceability: 'docs/TRACEABILITY.md' },
  affected: { runCmd: '', sourceGlobs: [] },
}, null, 2) + '\n';

const CONSTITUTION = `# Requirements Constitution

This repository is maintained toward a strict Computable Verifiable State (CVS). During bootstrap,
\`docs/traceability-baseline.json\` (accepted gaps) and \`docs/untagged-test-baseline.json\` may exist
as shrink-only transition scaffolding; strict CVS requires both empty.

Invariants enforced by CI (\`cvs index --check\`) on every PR and the default branch:
1. Every requirement record has a stable ID and is bound to a test (via \`tests:\`) OR marked \`Verification: Manual\`.
2. Every requirement is covered per \`.traceability.config.json\` policy (its \`tests:\` binding resolves to a
   real test of the required kind), unless baselined. A non-empty binding that resolves to nothing fails.
3. Every UI/integration test cites its requirement ID(s) (untagged ones are listed in the untagged
   baseline, shrink-only). Unit tests are exempt — coverage comes from the record's \`tests:\` binding.
4. No orphans (a test cites a non-existent ID).
5. Both baselines may only SHRINK; strict CVS requires them empty. Growing either needs a
   \`constitution-change\` PR.
6. IDs use the org-standard FR / BIZ / NFR taxonomy; globally unique; area prefix matches the path.
7. The README carries a valid \`cvs-repo\` block (slug/name/description + areas glossary) — the CVS hub's
   single source of repo identity. A missing README, missing block, missing required field, or invalid
   slug is a \`REPO-META\` hard-fail (\`cvs init\` scaffolds the block; replace its placeholders).

Advisory — NOT gated, by design: a record may carry an optional \`source:\` field listing the source
files/globs it implements. \`cvs index --affected\` maps changed files -> requirements (via \`source:\`) ->
their bound \`tests:\` and reports blind spots (changed source under no requirement) and reverse-drift
(a requirement whose source changed but whose bound tests did not). These inform a local / pre-push gate
but DO NOT block merge, and \`source:\` is fully backward-compatible (records without it are unaffected; an
unresolved glob is an advisory only). Promoting \`--affected\` or reverse-drift to a hard CI gate is itself
a \`constitution-change\` PR.

Governance: area CODEOWNERS ratify (\`unratified -> ratified\`); amendments need a \`constitution-change\`
PR approved by <NAME/ROLE>. Ratification is tracked but NOT gated. The requirement records are the
source of truth; tests verify them — when a test and a ratified requirement disagree, the requirement
wins and the test/code is fixed.
`;

// The sample is Verification: Manual so a freshly-initialized repo passes the gate immediately
// (an automated record with an empty tests: binding would be an instant uncovered gap). Replace it.
const SAMPLE = `---
id: NFR-SAMPLE-001
type: NFR
area: SAMPLE
provenance: human
status: unratified
verification: manual
tests: []
source: []
why: Optional rationale — why this requirement exists (advisory, never gated).
---

Replace this sample. One atomic, falsifiable statement per record; statement prose lives in the body.

Verification: Manual — this placeholder is verified by hand (delete it once you add real records).
`;

const WORKFLOW = `name: Requirement traceability
on:
  pull_request:
  push:
    branches: [main, master]
jobs:
  traceability:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: '20' }
      # Runs the vendored indexer (scripts/cvs/, written by \`cvs init\`) at the repo root —
      # zero deps, no network. If you publish the kit instead, swap for \`npx cvs-kit@<version> index --check\`.
      - run: node scripts/cvs/reqindex.mjs --check
`;

// LF pin (R10): the indexer parses frontmatter line-by-line and compares the generated index byte-for-byte.
// On a Windows / core.autocrlf=true checkout a CRLF working tree would break both (every frontmatter key
// fails to parse → "No requirements found"; committed-CRLF vs generated-LF → false STALE-INDEX). reqindex
// is also CRLF-tolerant on read, but pinning these paths to LF keeps a local run identical to CI.
const GITATTRIBUTES = `# CVS: keep requirement records, the generated index, baselines, config, and the kit scripts as LF so
# the indexer behaves identically on Windows checkouts and in (Linux) CI. See cvs-kit reqindex.mjs.
docs/requirements/** text eol=lf
docs/cvs/** text eol=lf
docs/TRACEABILITY.md text eol=lf
docs/requirements-index.json text eol=lf
docs/traceability-baseline.json text eol=lf
docs/untagged-test-baseline.json text eol=lf
.traceability.config.json text eol=lf
scripts/cvs/*.mjs text eol=lf
`;

const GITIGNORE_NEGATION = `
# CVS requirement records are the source of truth — never ignore them, even when an area
# directory name (e.g. RELEASE/) collides with a build-output pattern like [Rr]elease/.
!docs/requirements/
!docs/requirements/*/
!docs/requirements/**
`;

// Working-artifacts home — lives OUTSIDE docs/requirements/** so the indexer never parses these as
// records. The reconciliation ledger (P2 conflicts) and the defects list (P1.5 likely-bugs) live here.
const LEDGER = `# Reconciliation Ledger

Human-reviewable record of cross-source conflicts found during reconciliation (P2). Conflicts are NOT
auto-applied. Fill in **Decision** (Accept|Reject|Edit|Defer), **Edited_Statement**, and **Ratified**
(Y|N), then run \`cvs apply-ledger\` (P6). Fewer than ~25 conflicts → keep it here as this markdown table;
more → use a CSV with the SAME columns at \`docs/cvs/reconciliation-ledger.csv\` (apply-ledger reads either).

Columns are the canonical Appendix B set; \`cvs apply-ledger\` auto-applies only the mechanical subset
(Edit/Accept-with-Edited_Statement rewrites the record's statement; Ratified=Y flips status) and lists the
rest (fix-code / fix-doc / create-new) as manual follow-up.

| ID | Area | Sources | Statement_A | Statement_B | Conflict_Type | Conflict_Detail | Recommendation | Rationale | Confidence | Decision | Edited_Statement | Ratified |
|----|------|---------|-------------|-------------|---------------|-----------------|----------------|-----------|------------|----------|------------------|----------|

Conflict_Type: missing | conflict | weaken | vague | stale-doc | code-vs-doc. Confidence: H|M|L.
`;
const DEFECTS = `# Defects (code-phase findings)

Likely BUGS surfaced while extracting requirements from code (P1.5) — a route with no auth, a fail-open
check, a missing isolation filter, code that contradicts a passing test. These are NOT requirements
(encoding them would canonize the bug). Triage each: fix the code (then co-update the record), or open a
tracked issue. Verify every finding against the actual code before listing it here.

| # | Area | File | Finding | Why it looks wrong | Recommendation | Status |
|---|------|------|---------|--------------------|----------------|--------|
`;

put('.traceability.config.json', CONFIG);
put('docs/REQUIREMENTS_CONSTITUTION.md', CONSTITUTION);
put('docs/requirements/SAMPLE/NFR-SAMPLE-001.md', SAMPLE);
put('docs/cvs/RECONCILIATION-LEDGER.md', LEDGER);
put('docs/cvs/DEFECTS.md', DEFECTS);
put('.github/workflows/traceability.yml', WORKFLOW);

// Vendor the kit scripts into the consumer so CI (and local runs) work offline — no npx / registry.
for (const f of ['reqindex.mjs', 'cvs.mjs', 'ratify.mjs', 'migrate-requirements-to-records.mjs', 'apply-ledger.mjs']) {
  try { put(`scripts/cvs/${f}`, readFileSync(join(KIT_DIR, f), 'utf8')); }
  catch { /* script not present in this kit checkout — skip */ }
}

// Append the gitignore negation once.
const giPath = join(ROOT, '.gitignore');
const gi = existsSync(giPath) ? readFileSync(giPath, 'utf8') : '';
if (!gi.includes('!docs/requirements/**')) {
  writeFileSync(giPath, gi + GITIGNORE_NEGATION);
  created.push('.gitignore (negation appended)');
} else skipped.push('.gitignore (negation already present)');

// Append the gitattributes LF pin once (R10). .gitattributes commonly exists, so append rather than skip.
const gaPath = join(ROOT, '.gitattributes');
const ga = existsSync(gaPath) ? readFileSync(gaPath, 'utf8') : '';
if (!ga.includes('docs/requirements/** text eol=lf')) {
  writeFileSync(gaPath, ga && !ga.endsWith('\n') ? ga + '\n' + GITATTRIBUTES : ga + GITATTRIBUTES);
  created.push(existsSync(gaPath) && ga ? '.gitattributes (LF pin appended)' : '.gitattributes');
} else skipped.push('.gitattributes (LF pin already present)');

// Scaffold the README `cvs-repo` metadata block. It's REQUIRED: the gate (validateRepoMeta in
// reqindex.mjs) hard-fails without it, and the CVS hub (Alexander) fails sync with "README is
// missing or has no valid cvs-repo block". Scaffolding it here means a freshly-initialized repo
// is gate-green and syncable from day one, instead of looking done while silently missing the one
// thing the hub needs. Placeholder values are valid (so the gate passes); replace them in P0.
// Idempotent: create the README if absent, else append the block once.
const repoDirName = basename(ROOT);
const defaultSlug = repoDirName.toLowerCase().replace(/[^a-z0-9-]+/g, '-').replace(/^-+|-+$/g, '') || 'my-repo';
const README_BLOCK = `
<!-- cvs-repo: CVS hub (Alexander) repo metadata. Edit the values; keep the fence. -->
\`\`\`cvs-repo
slug: ${defaultSlug}
name: ${repoDirName}
description: TODO — one-line description of this repo (required)
aliases: []
owners: []
areas:
  SAMPLE: Replace with a real area — one "KEY: description" line per subsystem
\`\`\`
`;
const readmePath = join(ROOT, 'README.md');
if (!existsSync(readmePath)) {
  writeFileSync(readmePath, `# ${repoDirName}\n${README_BLOCK}`);
  created.push('README.md (with cvs-repo block)');
} else {
  const existing = readFileSync(readmePath, 'utf8');
  if (!/```cvs-repo[ \t]*\n/.test(existing.replace(/\r\n/g, '\n'))) {
    writeFileSync(readmePath, existing + '\n' + README_BLOCK);
    created.push('README.md (cvs-repo block appended)');
  } else skipped.push('README.md (cvs-repo block already present)');
}

console.log(`cvs-init (preset: ${PRESET_NAME} — ${PRESET.label}):`);
for (const c of created) console.log(`  [create] ${c}`);
for (const s of skipped) console.log(`  [skip]   ${s}`);

// Generate the initial index so a freshly-initialized repo is `--check`-green immediately
// (otherwise the first CI run fails with STALE-INDEX until someone runs the indexer by hand).
if (existsSync(join(ROOT, 'scripts/cvs/reqindex.mjs'))) {
  try {
    execFileSync('node', ['scripts/cvs/reqindex.mjs'], { cwd: ROOT, stdio: 'inherit' });
    console.log('  [index]  generated docs/TRACEABILITY.md + docs/requirements-index.json');
  } catch { console.log('  [index]  skipped — run `node scripts/cvs/reqindex.mjs` once and commit the result'); }
}

console.log(`
Next:
  1. Edit the README \`cvs-repo\` block (slug/name/description/areas) — placeholder values pass the gate
     but the CVS hub syncs them verbatim, so set the real ones before registering the repo.
  2. Edit .traceability.config.json testSources globs for your stack (and declRegex if exotic).
     Tip: \`cvs init --preset js-react\` (Vitest/Jest + Playwright + Storybook) or \`--preset dotnet\`
     pre-fills these; globs support brace alternation, e.g. src/**/*.{test,spec}.{js,jsx,ts,tsx}.
  3. Bootstrap requirements with the prompts in this kit's prompts.md (P0-P6), or migrate a legacy
     table:  node scripts/cvs/cvs.mjs migrate
  4. Tag tests + bind records, then regenerate/gate:
       node scripts/cvs/reqindex.mjs            (regenerate the index — commit the result)
       node scripts/cvs/reqindex.mjs --check    (the CI gate)
  5. Add 'node scripts/cvs/reqindex.mjs --check' as a required status check on your default branch.`);

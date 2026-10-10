# Commercial Font Builder

A reusable agent skill for developing an installable, commercially deliverable desktop font from a design brief, starting with glyph design rather than existing font assets.

The default workflow targets a modern rounded Latin font with letters, digits, and punctuation, compiled as TTF/OTF and validated on Windows. It covers design specification, representative glyphs, editable source management, compilation, font-table QA, Windows installation visibility, and commercial-delivery readiness.

## What It Covers

- Font design brief and glyph-system rules
- Modern rounded sans-serif metrics and representative glyphs
- Latin letters, digits, punctuation, `.notdef`, and space coverage
- Editable source formats such as UFO or FontForge projects
- TTF/OTF metadata and naming-table requirements
- Automated and visual QA
- Windows Font Viewer, font-library, Word/WPS visibility checks
- Diagnosis of naming, cache, installation-scope, and missing-glyph issues
- Commercial package structure, license status, versioning, and handoff documentation

## Repository Layout

```text
commercial-font-builder/
├── SKILL.md
├── README.md
├── LICENSE
├── references/
│   ├── design-brief-template.md
│   └── windows-validation.md
└── .gitignore
```

## Use

Place this folder in the skills directory supported by your agent environment, or reference `SKILL.md` directly when configuring an agent skill. The skill does not include a font binary and does not grant commercial rights to any generated font.

A typical project created while following the skill should keep source and generated files separate:

```text
font-project/
├── source/
├── build/
├── specimens/
├── reports/
└── packaging/
```

## Requirements

The workflow can use a font editor or compiler such as FontForge, UFO/FontTools, or another professional font tool. Automated checks may use FontTools, FontBakery, OTS Sanitizer, or equivalent tools. Windows is required for the final Windows installation and application-visibility acceptance test.

The skill does not silently install or uninstall fonts. Installation scope must be explicit, and user approval is required before changing system state.

## Commercial and Legal Boundary

A font that compiles or installs is not automatically commercially licensed. Confirm glyph ownership, contributor agreements, third-party asset licenses, family-name conflicts, trademark considerations, embedding permissions, and the final EULA before selling or redistributing a font.

Until those checks are complete, mark the license as pending or unverified rather than claiming commercial clearance.

## Included References

- `references/design-brief-template.md`: project brief, metrics, style system, coverage, and release gates.
- `references/windows-validation.md`: Windows installation scope, read-only inspection, application refresh, and troubleshooting.

## License

This skill repository is released under the MIT License. See `LICENSE`. The license for any font created by following the workflow is a separate project decision and must be documented in that font's delivery package.

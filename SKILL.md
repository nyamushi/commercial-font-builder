---
name: commercial-font-builder
description: Build an installable, commercially deliverable desktop font from a design brief, starting with glyph design rather than existing font assets. Use this skill whenever the user asks to design a font, create a TTF or OTF, make a custom typeface, package a font for commercial use, fix a font that does not appear in Word or the Windows font library, or validate font installation. The default project is a modern rounded Latin font with letters, digits, and punctuation validated on Windows, but adapt the character set and platform checks when the user specifies otherwise.
compatibility: Requires a font editor or compiler such as FontForge or a UFO/FontTools workflow, Python with fontTools for automated checks, and Windows or a Windows test machine for installation verification. Do not assume that a generated file has commercial rights.
---

# Commercial Font Builder

Use this workflow to turn a font idea into a maintainable, installable desktop font. Treat design, engineering, licensing, and installation as separate deliverables. A font that compiles is not automatically a finished typeface, and a font that installs is not automatically licensed for commercial use.

## Default project profile

Unless the user overrides it, use these defaults:

- Style: modern rounded sans serif.
- Platform: Windows desktop.
- Initial coverage: uppercase A-Z, lowercase a-z, digits 0-9, ASCII punctuation, space, and a small Western-European extension only when it can be designed consistently.
- Deliverables: editable source, installable TTF or OTF, QA report, specimen sheet, character coverage list, Windows install/uninstall instructions, and a license/credits placeholder.
- Development order: design a small representative set first, get approval, then expand the rest of the character set.

Do not claim that a complete Chinese font, a complete Unicode font, or legal commercial clearance exists unless the user has supplied the corresponding work and rights.

## Phase 0: Confirm the project contract

Before drawing glyphs, collect or write a short design brief. Ask only the questions that affect implementation; use the defaults above for everything else.

Record:

1. Typeface purpose: brand, UI, display, editorial, packaging, or general text.
2. Intended reading size and medium: screen, print, logo, poster, or mixed use.
3. Tone and references: friendly, geometric, neutral, playful, compact, wide, or other terms.
4. Character coverage and release size.
5. Required weights and styles. Start with one regular style unless the user explicitly needs a family.
6. Font name, foundry/author name, version, copyright line, and license intent.
7. Whether the user owns or will create every glyph. Flag third-party material for a licensing decision.
8. Target software and Windows versions to test.

Save the brief as `design-brief.md`. Use `references/design-brief-template.md` when a structured template is helpful.

## Phase 1: Establish the glyph system

Design the system before drawing every character. For the modern rounded default, define:

- em size, baseline, x-height, cap height, ascender, descender, and overshoot;
- stroke or monoline behavior, terminal shape, corner radius, and aperture behavior;
- sidebearings, spacing rhythm, kerning policy, and punctuation alignment;
- width policy for capitals, lowercase, digits, and symbols;
- contrast policy. A rounded sans can still have optical variation, but do not introduce accidental contrast;
- how curves join, where extrema are placed, and how joins behave at small sizes;
- hinting or rasterization expectations for Windows text rendering.

Create a small specimen before expanding the set. For the default Latin project, start with `H O n o a e`, `0 1 2 8`, and representative punctuation such as `. , : ; - ( ) / &`. These glyphs expose cap height, x-height, roundness, stems, joins, counters, numerals, and spacing. Add a short specimen string such as `Hamburgefontsiv 0123456789` plus punctuation.

Do not proceed to mass production when the representative set has inconsistent stem weight, mismatched curve tension, unstable counters, or visibly uneven spacing. Revise the rules and record the decision in `design-brief.md`.

## Phase 2: Create editable source data

Use an editable font source format rather than drawing directly into a final binary. Prefer one of these workflows, chosen by the tools available in the workspace:

- UFO plus FontTools for a scriptable, portable source;
- FontForge project for a GUI-oriented workflow;
- another professional source format only when it can export a valid TTF or OTF and preserve naming and metrics.

Keep source, generated binaries, specimens, and reports in separate directories. A typical project layout is:

```text
font-project/
  source/       editable glyphs and font project
  build/        generated TTF/OTF/WOFF2 files
  specimens/    proof sheets and test strings
  reports/      QA and coverage reports
  packaging/    README, license, install and uninstall instructions
```

Use stable glyph names and Unicode assignments. Keep the source under version control when possible. Never overwrite the only source copy with an exported binary.

## Phase 3: Expand and space the initial character set

For each glyph:

1. Draw or construct the outline using the established primitives.
2. Check closed contours, correct winding direction, sensible extrema, and no accidental duplicate points.
3. Assign Unicode code points only when the glyph meaning is correct.
4. Set sidebearings using a repeatable spacing method, then apply optical corrections.
5. Add kerning only for visible collisions; do not use kerning to hide incorrect sidebearings.
6. Compare glyphs in words and in isolation at intended sizes.

For the default release, include at least:

- `A-Z`, `a-z`, `0-9`;
- space and common ASCII punctuation: `! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \\ ] ^ _ { | } ~`;
- symbols needed by the stated use case;
- a deliberate `.notdef` glyph and a sensible space glyph.

If a requested character is not designed, leave it out of the release coverage rather than mapping an unrelated shape to its code point. Report missing characters explicitly.

## Phase 4: Compile and name the font

Export TTF or OTF using the selected font tool. Prefer one primary desktop format for the first release and generate the other only after the primary file passes QA. Generate WOFF2 only when web delivery is requested.

Set and review at least:

- family name;
- subfamily/style name;
- full name and PostScript name;
- version string;
- unique identifier;
- copyright and trademark fields;
- manufacturer or designer field when appropriate;
- license description and license URL when available;
- OS/2 weight, width, selection flags, and embedding permissions;
- Unicode ranges and code page ranges that match actual coverage.

Use a unique family name so the font does not collide with an existing installed family. Keep the family name stable across revisions; increment the version for released changes. Do not use a name that implies affiliation with an unrelated type foundry or brand.

## Phase 5: Run automated and visual QA

Run automated checks before installation. Use FontTools, FontForge validation, OTS Sanitizer, FontBakery, or the equivalent tools available in the environment. At minimum check:

- the file opens and parses;
- `cmap` maps intended characters and does not contain accidental duplicates;
- required naming records exist and agree;
- glyph outlines are closed, valid, and free of obvious self-intersections;
- advance widths and vertical metrics are finite and plausible;
- `.notdef` and space exist;
- no requested glyph is silently empty;
- font tables are internally consistent;
- the binary is not rejected by OTS Sanitizer when that tool is available.

Produce `reports/qa-report.md` with tool versions, commands, pass/fail results, warnings, known limitations, and the exact build file tested. A warning is not a pass. Classify each issue as blocking, release-warning, or accepted limitation.

Perform visual QA at several sizes and contexts:

- uppercase, lowercase, mixed words, numerals, punctuation, and symbols;
- isolated glyphs and realistic words;
- normal, bold-looking, small, and large display sizes;
- Windows text rendering, including anti-aliasing differences;
- side-by-side comparisons of representative glyphs and repeated shapes.

Create a specimen page or PDF/PNG when the available tools support it. Do not use a specimen image as a substitute for checking the actual font binary.

## Phase 6: Verify Windows installation and application visibility

Installation is a separate acceptance test. Use a disposable test copy of the final font and record the exact filename and version.

1. Confirm the font file opens in Windows Font Viewer.
2. Install for the current user first unless the user explicitly requires all-users installation.
3. Confirm that the family and style appear in Windows Settings or the Fonts control panel.
4. Confirm that Windows can enumerate the family and style using a native font listing method or a small test program.
5. Close and reopen the target text application so it refreshes its font list.
6. Type a test string covering letters, digits, punctuation, and every claimed extension character.
7. Check that the application shows the intended family name, not a fallback or duplicate entry.
8. Record whether the font is visible in Word, WPS, LibreOffice, or another named application. Do not generalize from one application to all applications.
9. If the font does not appear, check naming records, duplicate installed versions, per-user versus all-users installation, application caching, and whether the application filters unsupported fonts.
10. Uninstall the test copy and verify that the expected family entry disappears after applications refresh.

Use `references/windows-validation.md` for the PowerShell and registry-safe inspection examples. Installation scripts must be explicit about scope and should not silently modify system-wide font locations. Ask for confirmation before executing an install or uninstall action.

## Phase 7: Package a commercial deliverable

Package only files that have passed QA, and include:

- `build/<family>-<style>.ttf` or `.otf`;
- editable source or a clearly documented source handoff;
- `reports/qa-report.md`;
- `reports/coverage.txt` or an equivalent character list;
- `specimens/` test sheet;
- `packaging/README.md`;
- `packaging/install-windows.ps1` and `packaging/uninstall-windows.ps1` when scripts are requested;
- `packaging/LICENSE.txt` or a clearly marked license template;
- version and change notes.

The README must state the supported character set, tested Windows/application versions, known limitations, installation scope, and license status. Label a placeholder license as a placeholder. Do not call a font “commercially cleared” merely because it was generated locally.

## Required response format

When applying this skill, report progress and deliverables in this order:

1. **Brief**: design choices, coverage, target platform, and unresolved decisions.
2. **Source**: editable source location and how to continue editing it.
3. **Build**: generated font files, names, versions, and formats.
4. **QA**: checks run, results, warnings, and known limitations.
5. **Windows verification**: installation scope, font enumeration result, applications tested, and refresh/restart steps.
6. **Commercial readiness**: ownership/licensing status and anything that still needs legal or human review.
7. **Next iteration**: the smallest concrete next step, such as adding a weight, expanding coverage, or correcting a QA issue.

If a dependency, Windows machine, or human visual review is unavailable, say exactly which acceptance test could not be completed instead of claiming success.

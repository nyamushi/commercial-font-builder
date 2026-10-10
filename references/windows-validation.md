# Windows Font Validation

Use this checklist after building a font. Commands are inspection examples; installation and removal are user-approved actions.

## File and viewer check

- Open the final TTF/OTF in Windows Font Viewer.
- Confirm the displayed family name, style, version, and glyph preview.
- Confirm that the file is the exact build artifact named in the QA report.

## Installation scope

Prefer current-user installation for development and QA. All-users installation can require elevation and affects other users.

For a current-user install, use Windows Explorer's **Install** or **Install for all users** action deliberately. If an automation script is provided, it must state the chosen scope and stop on errors. Never silently copy an untrusted file into a system font directory.

A PowerShell inspection example for the per-user fonts directory:

```powershell
$fontPath = Join-Path $env:LOCALAPPDATA 'Microsoft\Windows\Fonts'
Get-ChildItem -LiteralPath $fontPath -Filter '*.ttf' -ErrorAction SilentlyContinue
Get-ChildItem -LiteralPath $fontPath -Filter '*.otf' -ErrorAction SilentlyContinue
```

The registry is not a complete substitute for application visibility. Use it only as a diagnostic signal, and do not edit it directly to install a font.

```powershell
$userFontsKey = 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts'
Get-ItemProperty -Path $userFontsKey -ErrorAction SilentlyContinue
```

## Acceptance checks

Record each check with pass/fail and the exact date or test session identifier:

1. Windows Font Viewer opens the file.
2. The current-user Fonts folder contains the installed artifact or Windows reports it as installed.
3. The Windows font list shows the intended family and style.
4. The target application was closed and reopened after installation.
5. The target application lists the intended family and style once.
6. A test string renders letters, digits, punctuation, and every claimed extension character.
7. A document saved with the font reopens without substitution on the test machine.
8. Removing the test font and refreshing the application removes the family from the list.

## If the font is missing

Check these causes in order:

- the application was open during installation and has not refreshed its font list;
- a previous build with the same family name is installed;
- the family/subfamily/name records disagree;
- the file is corrupted or rejected by the application;
- the user installed a file with a different style name than expected;
- the application is using a separate font cache or sandbox;
- the font is installed for a different Windows user;
- the requested glyph is missing and the application is showing fallback glyphs.

After changing naming tables or replacing a build, uninstall the old test copy, use a new versioned build, reinstall, and retest. Record the result rather than relying on visual memory.

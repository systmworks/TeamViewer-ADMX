<p align="center"><a href="https://buymeacoffee.com/systmworks"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" height="45" alt="Buy me a coffee"></a></p>

> I have spent many, many hours creating and testing this ADMX. If it helps you please consider buying me a Coffee :)

# TeamViewer Host ADMX — v1.0

**Version:** 1.0
**Date:** 2026-04-10
**Target:** TeamViewer Host 15.x / 16.x (Windows x64 and x86 on 64-bit OS)

## Files

| File | Description | Policies |
|------|-------------|----------|
| `TeamViewer.admx` | Policy definition (Computer Configuration) | 62 policies (31 x64 + 31 x86) across 7 categories each |
| `en-US\TeamViewer.adml` | English (US) display strings and presentations | Shared strings + 34 presentation elements (17 per arch) |

## Policy count by category

| Category | Policies | Type |
|----------|----------|------|
| Security | 5 | 3 toggles, 2 dropdowns |
| Update Control | 2 | 2 dropdowns |
| Access Control (Incoming) | 8 | 1 toggle, 5 dropdowns (3-option), 1 dropdown (5-option), 1 toggle |
| Access Control (Outgoing) | 4 | 1 toggle, 1 dropdown (5-option), 2 dropdowns (3-option) |
| Network & Proxy | 6 | 3 toggles, 1 dropdown, 2 text boxes |
| Logging | 3 | 3 toggles |
| Features | 3 | 3 toggles |
| **Total** | **31** | |

## Installation

1. Copy `TeamViewer.admx` to `C:\Windows\PolicyDefinitions\` (or the domain Central Store `\\domain\SYSVOL\domain\Policies\PolicyDefinitions\`)
2. Copy `en-US\TeamViewer.adml` to `C:\Windows\PolicyDefinitions\en-US\` (or the Central Store equivalent)
3. Open `gpedit.msc` or the Group Policy Management Console
4. Navigate to: **Computer Configuration > Administrative Templates > TeamViewer**
5. Choose **TeamViewer (x64)** for 64-bit installs or **TeamViewer (x86)** for 32-bit installs on 64-bit Windows

## Registry paths

| Subcategory | Registry key | Scope |
|-------------|-------------|-------|
| TeamViewer (x64) | `HKLM\SOFTWARE\TeamViewer` (+ `\AccessControl`) | 64-bit TeamViewer on 64-bit Windows |
| TeamViewer (x86) | `HKLM\SOFTWARE\WOW6432Node\TeamViewer` (+ `\AccessControl`) | 32-bit TeamViewer on 64-bit Windows |

Both architectures are covered in a single ADMX template. Configure the subcategory matching the TeamViewer architecture installed on your endpoints.

## Changes from previous version

First release — no prior version.

## Known issues

- **Allowlist/blocklist values** (`Whitelist`, `Blacklist`) are `REG_MULTI_SZ` and cannot be managed via ADMX. Use TeamViewer Management Console or `.reg` file import.
- **Encrypted values** (passwords, license keys) use AES-128 binary format and are excluded from this template.
- TeamViewer does **not** officially support GPO-based registry management; these settings are derived from vendor deployment docs and community-confirmed references. Test in a pilot group before broad deployment.
- This template covers both **64-bit** (`SOFTWARE\TeamViewer`) and **32-bit** (`SOFTWARE\WOW6432Node\TeamViewer`) installs via separate subcategories.

## Documentation

See `Documentation/TeamViewer_Registry_Reference.md` for the complete key-by-key reference with vendor source URLs, allowed values, defaults, and risk notes.

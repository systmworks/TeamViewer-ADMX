<p align="left"><a href="https://github.com/systmworks/TeamViewer-ADMX">&lt;- Back to Main</a></p>

<p align="center"><a href="https://buymeacoffee.com/systmworks"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" height="45" alt="Buy me a coffee"></a></p>

> I have spent many, many hours creating and testing this ADMX. If it helps you please consider buying me a Coffee :)

# TeamViewer Host ADMX - Install Guide

**Revision:** 1.2  
**Target:** TeamViewer Host 15.x / 16.x (Windows x64 and x86 on 64-bit OS)

## Files

| ![File](https://img.shields.io/badge/File-316dca?style=flat-square) | ![Description](https://img.shields.io/badge/Description-316dca?style=flat-square) | ![Policies](https://img.shields.io/badge/Policies-316dca?style=flat-square) |
|------|-------------|----------|
| `TeamViewer.admx` | Policy definition (Computer Configuration) | 120 policies (60 x64 + 60 x86) across 9 categories each |
| `en-US\TeamViewer.adml` | English (US) display strings and presentations | ASCII-only (Intune-ready) |

## Policy count by category

| ![Category](https://img.shields.io/badge/Category-316dca?style=flat-square) | ![Policies](https://img.shields.io/badge/Policies-316dca?style=flat-square) | ![Type](https://img.shields.io/badge/Type-316dca?style=flat-square) |
|----------|----------|------|
| Access Control (Incoming) | 17 | 1 toggle, 15 dropdowns (3-option), 1 dropdown (5-option) |
| Access Control (Outgoing) | 4 | 1 toggle, 1 dropdown (5-option), 2 dropdowns (3-option) |
| Features | 5 | 5 toggles |
| Logging | 3 | 3 toggles |
| Network & Proxy | 10 | 8 toggles, 1 dropdown, 2 text boxes |
| Security | 9 | 5 toggles, 2 dropdowns (3-option), 1 dropdown (4-option) |
| Session Recording | 2 | 2 toggles |
| Update Control | 6 | 3 toggles, 2 dropdowns, 1 text box |
| Wake-on-LAN | 4 | 1 toggle, 1 dropdown (3-option), 1 text box, 1 decimal |
| **Total** | **60** | |

## Installation

1. Copy `TeamViewer.admx` to `C:\Windows\PolicyDefinitions\` (or the domain Central Store)
2. Copy `en-US\TeamViewer.adml` to `C:\Windows\PolicyDefinitions\en-US\`
3. Open GPMC or `gpedit.msc`
4. Navigate to: **Computer Configuration > Administrative Templates > TeamViewer**
5. Choose **TeamViewer (x64)** or **TeamViewer (x86)** matching the installed architecture

## Registry paths

| ![Subcategory](https://img.shields.io/badge/Subcategory-316dca?style=flat-square) | ![Registry key](https://img.shields.io/badge/Registry%20key-316dca?style=flat-square) | ![Scope](https://img.shields.io/badge/Scope-316dca?style=flat-square) |
|-------------|-------------|-------|
| TeamViewer (x64) | `HKLM\SOFTWARE\TeamViewer` (+ `\AccessControl`) | 64-bit TeamViewer on 64-bit Windows |
| TeamViewer (x86) | `HKLM\SOFTWARE\WOW6432Node\TeamViewer` (+ `\AccessControl`) | 32-bit TeamViewer on 64-bit Windows |

## Documentation

- [Registry Reference](../Documentation/TeamViewer_Registry_Reference.md)
- [Changelog](../Documentation/changelog.md)
- [Network Ports and Connectivity](../Documentation/Network_Ports_and_Connectivity.md)

---

**Sharing & responsibility** — Built for the community, shared with good intentions. Use at your own risk. The author accepts no responsibility for any outcomes resulting from the use of these files. Always verify registry paths and values, and test in a safe environment first. If you find an issue or have a suggestion, contributions are welcome.

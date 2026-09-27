<p align="center"><a href="https://buymeacoffee.com/systmworks"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" height="45" alt="Buy me a coffee"></a></p>

> I have spent many, many hours creating and testing this ADMX. If it helps you please consider buying me a Coffee :)

> [!TIP]
> **Coming soon: ADMX Pro.** Ready-to-import Intune & GPO profiles (Security Hardened · STIG-aligned · No Nags & Upsells),
> re-tested against every vendor release, plus an email alert when a vendor changes or breaks a setting.
> **[Join the waitlist →](https://tally.so/r/7RGrVR)** (free, no spam, one email when it launches)

# TeamViewer Host - Custom ADMX Template

| ![Quick Links](https://img.shields.io/badge/Quick%20Links-316dca?style=flat-square) | ![Description](https://img.shields.io/badge/Description-316dca?style=flat-square) |
|---|---|
| [ADMX install guide](ADMX/readme.md) | Copy paths, registry keys, and policy counts for the live template |
| [Registry Reference](Documentation/TeamViewer_Registry_Reference.md) | Full key reference with vendor sources, values, defaults and risk notes |
| [Changelog](Documentation/changelog.md) | Version history for the ADMX template |
| [Network Ports and Connectivity](Documentation/Network_Ports_and_Connectivity.md) | Outbound port order, AVD/Azure troubleshooting, diagnostic script |
| [Screenshots](Documentation/screenshots.md) | GPO Editor screenshots showing the template in action |

Custom Group Policy Administrative Template for TeamViewer Host enterprise deployment.

TeamViewer does **not** provide an official ADMX template ([community request 2021](https://community.teamviewer.com/English/discussion/112033/gpo-admx-for-teamviewer), [2025](https://community.teamviewer.com/English/discussion/140776/teamviewer-admx-templates)). This template maps vendor-documented and community-confirmed registry values to standard Windows Group Policy settings.

## Quick start

1. Copy `ADMX/TeamViewer.admx` to your Central Store or local `PolicyDefinitions` folder
2. Copy `ADMX/en-US/TeamViewer.adml` to the `en-US` subfolder
3. Open Group Policy Editor - policies appear under **Computer Configuration > Administrative Templates > TeamViewer**, with separate subcategories for **TeamViewer (x64)** and **TeamViewer (x86)**

## Policy categories (60 settings, duplicated for x64 and x86)

| ![Category](https://img.shields.io/badge/Category-316dca?style=flat-square) | ![Settings](https://img.shields.io/badge/Settings-316dca?style=flat-square) | ![Description](https://img.shields.io/badge/Description-316dca?style=flat-square) |
|----------|----------|-------------|
| **Access Control (Incoming)** | 17 | Server-side access mode + granular permissions |
| **Access Control (Outgoing)** | 4 | Client-side outgoing connection controls |
| **Features** | 5 | Login screen access, chat, allowlist enforcement, online status, meeting allowlist |
| **Logging** | 3 | Master logging toggle, incoming/outgoing connection logging |
| **Network & Proxy** | 10 | Direct LAN, LAN-only mode, proxy config, UPnP, custom router, always online, UDP, inbound DirectIn |
| **Security** | 9 | Admin rights, password strength, Windows logon auth, incoming connections, remote shutdown, black screen, local input, TFA, scam protection |
| **Session Recording** | 2 | Auto-record enforcement, prevent stop/pause |
| **Update Control** | 6 | Auto-update mode, check interval, update channel, version pinning, preview/insider builds |
| **Wake-on-LAN** | 4 | WoL mode, public address, port, neighbor update |

## What is NOT included (and why)

- **Passwords / license keys** - stored as AES-128 encrypted binary; cannot be set via plain-text GPO
- **Credential-related settings** - proxy username/password and options password hash excluded for security reasons
- **Allowlist / blocklist entries** - `REG_MULTI_SZ` values not practical in ADMX; manage via TeamViewer Console or `.reg` import
- **Per-user settings** - this template targets `HKLM` (machine-wide); per-user `HKCU` settings are not in scope

The ADMX provides two subcategories - **TeamViewer (x64)** targeting `SOFTWARE\TeamViewer` and **TeamViewer (x86)** targeting `SOFTWARE\WOW6432Node\TeamViewer` - so both 64-bit and 32-bit TeamViewer installs on x64 Windows 10/11 are covered from a single template.

## Important notes

- TeamViewer's **officially supported** configuration method is their cloud-based Management Console. This ADMX is a **supplementary** tool for environments that require GPO-based standardization.
- **Test in a pilot group** before broad deployment - registry behavior may change across TeamViewer versions.
- All registry keys are documented with vendor source URLs in [Documentation/TeamViewer_Registry_Reference.md](Documentation/TeamViewer_Registry_Reference.md).
- For AVD/network port troubleshooting, see [Network Ports and Connectivity](Documentation/Network_Ports_and_Connectivity.md) and run [`Helper_Scripts/Test-TeamViewerConnectivity.ps1`](Helper_Scripts/Test-TeamViewerConnectivity.ps1) on a session host (read-only).

## License

CC BY-SA 4.0 - Free to use and redistribute, including commercially, with attribution; ShareAlike applies to adaptations you distribute. See [LICENSE.md](LICENSE.md).

Created by Darren Milne.

---

**Sharing & responsibility** — Built for the community, shared with good intentions. Use at your own risk. The author accepts no responsibility for any outcomes resulting from the use of these files. Always verify registry paths and values, and test in a safe environment first. If you find an issue or have a suggestion, contributions are welcome.

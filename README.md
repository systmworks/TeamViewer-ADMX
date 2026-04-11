<p align="center"><a href="https://buymeacoffee.com/systmworks"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" height="45" alt="Buy me a coffee"></a></p>

> I have spent many, many hours creating and testing this ADMX. If it helps you please consider buying me a Coffee :)

# TeamViewer Host — Custom ADMX Template

| Quick Links | |
|---|---|
| [Registry Reference](Documentation/TeamViewer_Registry_Reference.md) | Full key reference with vendor sources, values, defaults and risk notes |
| [Screenshots](screenshots.md) | GPO Editor screenshots showing the template in action |

Custom Group Policy Administrative Template for TeamViewer Host enterprise deployment.

TeamViewer does **not** provide an official ADMX template ([community request 2021](https://community.teamviewer.com/English/discussion/112033/gpo-admx-for-teamviewer), [2025](https://community.teamviewer.com/English/discussion/140776/teamviewer-admx-templates)). This template maps vendor-documented and community-confirmed registry values to standard Windows Group Policy settings.

## Quick start

1. Copy `v1.0/TeamViewer.admx` to your Central Store or local `PolicyDefinitions` folder
2. Copy `v1.0/en-US/TeamViewer.adml` to the `en-US` subfolder
3. Open Group Policy Editor — policies appear under **Computer Configuration > Administrative Templates > TeamViewer**, with separate subcategories for **TeamViewer (x64)** and **TeamViewer (x86)**

## Contents

```
TeamViewer_ADMX/
├── README.md                          (this file)
├── Documentation/
│   └── TeamViewer_Registry_Reference.md   (full key reference with vendor sources)
└── v1.0/
    ├── README.md                      (version notes, install guide, known issues)
    ├── TeamViewer.admx                (62 policies: 31 x64 + 31 x86, 7 categories each)
    └── en-US/
        └── TeamViewer.adml            (English display strings)
```

## Policy categories (31 settings, duplicated for x64 and x86)

| Category | Description |
|----------|-------------|
| **Security** | Admin rights requirement, password strength, Windows logon auth, incoming connections, remote shutdown |
| **Update Control** | Auto-update mode, check interval |
| **Access Control (Incoming)** | Server-side access mode + granular permissions (view, control, file transfer, VPN, printing, remote input) |
| **Access Control (Outgoing)** | Client-side outgoing connection controls |
| **Network & Proxy** | Direct LAN, LAN-only mode, proxy config, UPnP, custom router |
| **Logging** | Master logging toggle, incoming/outgoing connection logging |
| **Features** | Login screen access, chat, allowlist enforcement |

## What is NOT included (and why)

- **Passwords / license keys** — stored as AES-128 encrypted binary; cannot be set via plain-text GPO
- **Allowlist / blocklist entries** — `REG_MULTI_SZ` values not practical in ADMX; manage via TeamViewer Console or `.reg` import
- **Per-user settings** — this template targets `HKLM` (machine-wide); per-user `HKCU` settings are not in scope

The ADMX provides two subcategories — **TeamViewer (x64)** targeting `SOFTWARE\TeamViewer` and **TeamViewer (x86)** targeting `SOFTWARE\WOW6432Node\TeamViewer` — so both 64-bit and 32-bit TeamViewer installs on x64 Windows 10/11 are covered from a single template.

## Important notes

- TeamViewer's **officially supported** configuration method is their cloud-based Management Console. This ADMX is a **supplementary** tool for environments that require GPO-based standardization.
- **Test in a pilot group** before broad deployment — registry behavior may change across TeamViewer versions.
- All registry keys are documented with vendor source URLs in `Documentation/TeamViewer_Registry_Reference.md`.

## License

CC BY-SA 4.0 — Free to use and redistribute, including commercially, with attribution; ShareAlike applies to adaptations you distribute.

Created by Darren Milne.

<p align="center"><a href="https://buymeacoffee.com/systmworks"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" height="45" alt="Buy me a coffee"></a></p>

> I have spent many, many hours creating and testing this ADMX. If it helps you please consider buying me a Coffee :)

# TeamViewer Host — Registry Key Reference for ADMX

Version: 1.0
Date: 2026-04-10
Validated against: TeamViewer Host 15.x / 16.x (Windows)

## Overview

TeamViewer does **not** provide official ADMX templates. Configuration management is intended to be done via the TeamViewer Management Console (cloud-based policy) or MSI deployment parameters. However, TeamViewer reads many settings from the Windows registry, and these are widely used by enterprise admins for GPO-based configuration.

This reference documents the registry values included in the custom ADMX template. Each entry is traceable to TeamViewer's official documentation, community-confirmed deployment guides, or the vendor's support knowledge base.

## Registry Paths

| Path | Scope | Notes |
|------|-------|-------|
| `HKLM\SOFTWARE\TeamViewer` | Machine (64-bit TeamViewer on 64-bit OS) | Primary path for modern installs |
| `HKLM\SOFTWARE\WOW6432Node\TeamViewer` | Machine (32-bit TeamViewer on 64-bit OS) | WOW64 redirection for legacy 32-bit installs |
| `HKLM\SOFTWARE\TeamViewer\AccessControl` | Machine | Granular access control (server-side / incoming) |

The ADMX template includes two subcategories — **TeamViewer (x64)** targeting `SOFTWARE\TeamViewer` and **TeamViewer (x86)** targeting `SOFTWARE\WOW6432Node\TeamViewer` — so both 64-bit and 32-bit TeamViewer installs on x64 Windows are covered from a single template.

## Sources

| ID | Source | URL |
|----|--------|-----|
| S1 | TeamViewer Mass Deployment Guide | https://www.teamviewer.com/en-us/global/support/knowledge-base/teamviewer-remote/deployment/mass-deployment-user-guide/deploy-teamviewer-host-or-full-client-9-10/ |
| S2 | TeamViewer Policy Settings Reference | https://teamviewer.com/en-us/global/support/knowledge-base/teamviewer-remote/devices/policy-settings |
| S3 | TeamViewer GPO Deployment KB | https://www.teamviewer.com/en-us/global/support/knowledge-base/teamviewer-classic/deployment/deploy-teamviewer-via-gpo/ |
| S4 | TeamViewer Export Settings for Deployment | https://www.teamviewer.com/en-mea/global/support/knowledge-base/teamviewer-classic/deployment/export-settings-for-host-deployment/ |
| S5 | Community Registry Reference Thread | https://community.teamviewer.com/English/discussion/16466/windows-teamviewer-registry-keys-and-values |
| S6 | ADMX Request Thread (2021) | https://community.teamviewer.com/English/discussion/112033/gpo-admx-for-teamviewer |
| S7 | ADMX Request Thread (2025) | https://community.teamviewer.com/English/discussion/140776/teamviewer-admx-templates |

---

## Category: Security

| Display Name | Value Name | Values | Default | Source |
|-------------|------------|--------|---------|--------|
| Require Admin Rights for Changes | `Security_Adminrights` | 0 = No admin required, 1 = Require admin | 0 | S2, S5 |
| Random Password Strength | `Security_PasswordStrength` | 1 = 4 chars (weak), 2 = 6 chars, 3 = 8 chars, 4 = 10 chars (very secure) | 3 | S2, S5 |
| Windows Logon Authentication | `Security_WinLogin` | 0 = Not allowed, 1 = Administrators only, 2 = All users | 0 | S2, S5 |
| Accept Incoming Connections | `Security_AcceptIncoming` | 0 = Reject, 1 = Accept | 1 | S2, S5 |
| Prevent Remote Shutdown | `Security_Disableshutdown` | 0 = Allow remote shutdown, 1 = Prevent remote shutdown | 0 | S5 |

## Category: Update Control

| Display Name | Value Name | Values | Default | Source |
|-------------|------------|--------|---------|--------|
| Auto-Update Mode | `AutoUpdateMode` | 0 = Disabled, 1 = Security updates only, 2 = Same major version, 3 = All updates | 3 | S1, S2 |
| Update Check Interval | `UpdateCheckInterval` | 0 = Never, 1 = Daily, 2 = Weekly, 3 = Monthly | 2 | S1, S5 |

## Category: Access Control (Server-Side — Incoming Connections)

Where the ADMX policy name differs from the registry value name, the ADMX file is authoritative.

| Display Name | Value Name | Values | Default | Source |
|-------------|------------|--------|---------|--------|
| Incoming Access Control Mode | `AC_Server_AccessControlType` | 0 = Full access, 1 = Confirm all, 2 = View only, 3 = Custom, 4 = Deny | 0 | S5 |
| Allow Partner to View Desktop | `AC_Server_Custom_AllowPartnerViewDesktop` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 1 | S5 |
| Allow Remote Control | `AC_Server_Custom_RemoteControlAccess` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 1 | S5 |
| Allow File Transfer (Incoming) | `AC_Server_Custom_FileTransferAccess` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 1 | S5 |
| Allow VPN Connections | `AC_Server_Custom_AllowVPN` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 1 | S5 |
| Disable Remote Input | `AC_Server_Custom_DisableRemoteImput` | 0 = Allow remote input, 1 = Disable remote input | 0 | S5 |
| Allow Printing to Remote Printers | `AC_Server_Custom_AllowToPrintOnRemotePrinters` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 0 | S5 |
| Allow Printing to Local Printers | `AC_Server_Custom_AllowToPrintOnMyPrinters` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 0 | S5 |

## Category: Access Control (Client-Side — Outgoing Connections)

Where the ADMX policy name differs from the registry value name, the ADMX file is authoritative.

| Display Name | Value Name | Values | Default | Source |
|-------------|------------|--------|---------|--------|
| Allow Outgoing Connections | `AC_AllowOutgoingConnections` | 0 = Deny outgoing, 1 = Allow outgoing | 1 | S5 |
| Outgoing Access Control Mode | `AC_Client_AccessControlType` | 0 = Full access, 1 = Confirm all, 2 = View only, 3 = Custom, 4 = Deny | 0 | S5 |
| Allow File Transfer (Outgoing) | `AC_Client_Custom_FileTransferAccess` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 1 | S5 |
| Allow Remote Control (Outgoing) | `AC_Client_Custom_RemoteControlAccess` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 1 | S5 |

## Category: Network and Proxy

| Display Name | Value Name | Values | Default | Source |
|-------------|------------|--------|---------|--------|
| Enable Direct LAN Connections | `General_DirectLAN` | 0 = Disabled, 1 = Enabled | 0 | S5 |
| Restrict to LAN Only | `LanOnly` | 0 = Allow internet connections, 1 = LAN only | 0 | S5 |
| Proxy Mode | `Proxy_Type` | 0 = No proxy, 1 = Auto-detect, 2 = Manual | 0 | S5 |
| Proxy Server Address | `Proxy_IP` | Server address (e.g. proxy.example.com:8080) | (empty) | S5 |
| Enable UPnP | `UPNP` | 0 = Disabled, 1 = Enabled | 1 | S5 |
| Custom Router Address | `CustomRouter` | Router address for custom routing | (empty) | S5 |

## Category: Logging

| Display Name | Value Name | Values | Default | Source |
|-------------|------------|--------|---------|--------|
| Enable Logging | `Logging` | 0 = Disabled, 1 = Enabled | 1 | S5 |
| Log Incoming Connections | `LogIncomingConnections` | 0 = Disabled, 1 = Enabled | 1 | S5 |
| Log Outgoing Connections | `LogOutgoingConnections` | 0 = Disabled, 1 = Enabled | 1 | S5 |

## Category: Features

| Display Name | Value Name | Values | Default | Source |
|-------------|------------|--------|---------|--------|
| Full Access on Windows Login Screen | `ACFullAccessOnLoginScreen` | 0 = Disabled, 1 = Enabled | 1 | S5 |
| Allow Chat to This Machine | `ChatToThisMachine` | 0 = Disabled, 1 = Enabled | 1 | S5 |
| Enforce Allowlist Mode | `UseWhitelist` | 0 = Disabled, 1 = Enforce allowlist | 0 | S5 |

---

## Values NOT Included in ADMX (and why)

| Value Name | Type | Reason for Exclusion |
|------------|------|---------------------|
| `SecurityPasswordAES` | REG_BINARY | AES-encrypted; cannot be set as plain text via GPO |
| `OptionsPasswordAES` | REG_BINARY | AES-encrypted |
| `PermanentPassword` | REG_BINARY | AES-encrypted |
| `ServerPasswordAES` | REG_BINARY | AES-encrypted |
| `ProxyPasswordAES` | REG_BINARY | AES-encrypted |
| `LicenseKeyAES` | REG_BINARY | AES-encrypted |
| `Whitelist` | REG_MULTI_SZ | Multi-string; manage via TeamViewer console or .reg import |
| `Blacklist` | REG_MULTI_SZ | Multi-string; manage via TeamViewer console or .reg import |
| `WhitelistBuddy` / `BlacklistBuddy` | REG_MULTI_SZ | Multi-string |
| `WhitelistCompany` / `BlacklistCompany` | REG_MULTI_SZ | Multi-string |
| `*BuddyAccountID` / `*CompanyID` | REG_BINARY | Encrypted account identifiers |
| `Wol_Neighbors` | REG_MULTI_SZ | Multi-string |

These values require either AES-encrypted binary data or multi-string types that are not practical to manage via ADMX policies. Use TeamViewer's Management Console, MSI `SETTINGSFILE=` parameter, or `IMPORTREGFILE=1` for these settings.

## Risk Notes

| Setting | Risk |
|---------|------|
| `LanOnly = 1` | Completely blocks internet-based remote support; only use if all support staff are on-premises |
| `Security_AcceptIncoming = 0` | Disables all incoming connections; effectively prevents remote support |
| `AC_Server_AccessControlType = 4` | Denies all incoming access; overrides granular custom permissions |
| `UseWhitelist = 1` | Without a populated Whitelist (REG_MULTI_SZ, not in ADMX), all connections will be blocked |
| `AutoUpdateMode = 0` | Disables all updates; must be paired with a separate patching strategy |

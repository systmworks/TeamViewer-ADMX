<p align="left"><a href="https://github.com/systmworks/TeamViewer-ADMX">&lt;- Back to Main</a></p>

<p align="center"><a href="https://buymeacoffee.com/systmworks"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" height="45" alt="Buy me a coffee"></a></p>

> I have spent many, many hours creating and testing this ADMX. If it helps you please consider buying me a Coffee :)

# TeamViewer Host — Registry Key Reference for ADMX

Version: 1.2
Date: 2026-07-31
Validated against: TeamViewer Host 15.x / 16.x (Windows)

## Overview

TeamViewer does **not** provide official ADMX templates. Configuration management is intended to be done via the TeamViewer Management Console (cloud-based policy) or MSI deployment parameters. However, TeamViewer reads many settings from the Windows registry, and these are widely used by enterprise admins for GPO-based configuration.

This reference documents the registry values included in the custom ADMX template. Each entry is traceable to TeamViewer's official documentation, community-confirmed deployment guides, or the vendor's support knowledge base.

## Registry Paths

| ![Path](https://img.shields.io/badge/Path-316dca?style=flat-square) | ![Scope](https://img.shields.io/badge/Scope-316dca?style=flat-square) | ![Notes](https://img.shields.io/badge/Notes-316dca?style=flat-square) |
|------|-------|-------|
| `HKLM\SOFTWARE\TeamViewer` | Machine (64-bit TeamViewer on 64-bit OS) | Primary path for modern installs |
| `HKLM\SOFTWARE\WOW6432Node\TeamViewer` | Machine (32-bit TeamViewer on 64-bit OS) | WOW64 redirection for legacy 32-bit installs |
| `HKLM\SOFTWARE\TeamViewer\AccessControl` | Machine | Granular access control (server-side / incoming) |

The ADMX template includes two subcategories — **TeamViewer (x64)** targeting `SOFTWARE\TeamViewer` and **TeamViewer (x86)** targeting `SOFTWARE\WOW6432Node\TeamViewer` — so both 64-bit and 32-bit TeamViewer installs on x64 Windows are covered from a single template.

## Sources

| ![ID](https://img.shields.io/badge/ID-316dca?style=flat-square) | ![Source](https://img.shields.io/badge/Source-316dca?style=flat-square) | ![URL](https://img.shields.io/badge/URL-316dca?style=flat-square) |
|----|--------|-----|
| S1 | TeamViewer Mass Deployment Guide | https://www.teamviewer.com/en-us/global/support/knowledge-base/teamviewer-remote/deployment/mass-deployment-user-guide/deploy-teamviewer-host-or-full-client-9-10/ |
| S2 | TeamViewer Policy Settings Reference | https://teamviewer.com/en-us/global/support/knowledge-base/teamviewer-remote/devices/policy-settings |
| S3 | TeamViewer GPO Deployment KB | https://www.teamviewer.com/en-us/global/support/knowledge-base/teamviewer-classic/deployment/deploy-teamviewer-via-gpo/ |
| S4 | TeamViewer Export Settings for Deployment | https://www.teamviewer.com/en-mea/global/support/knowledge-base/teamviewer-classic/deployment/export-settings-for-host-deployment/ |
| S5 | Community Registry Reference Thread | https://community.teamviewer.com/English/discussion/16466/windows-teamviewer-registry-keys-and-values |
| S6 | ADMX Request Thread (2021) | https://community.teamviewer.com/English/discussion/112033/gpo-admx-for-teamviewer |
| S7 | ADMX Request Thread (2025) | https://community.teamviewer.com/English/discussion/140776/teamviewer-admx-templates |
| S8 | Community DirectIn / ListenHttp references | https://serverfault.com/questions/11202/disable-teamviewer-from-stealing-port-80 |

---

## Category: Access Control (Server-Side — Incoming Connections)

Where the ADMX policy name differs from the registry value name, the ADMX file is authoritative.

| ![Display Name](https://img.shields.io/badge/Display%20Name-316dca?style=flat-square) | ![Value Name](https://img.shields.io/badge/Value%20Name-316dca?style=flat-square) | ![Values](https://img.shields.io/badge/Values-316dca?style=flat-square) | ![Default](https://img.shields.io/badge/Default-316dca?style=flat-square) | ![Source](https://img.shields.io/badge/Source-316dca?style=flat-square) |
|-------------|------------|--------|---------|--------|
| Allow Control of Remote TeamViewer | `AC_Server_Custom_ControlRemoteTV` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 0 | S2, S4 |
| Allow Download from File Box | `AC_Server_Custom_AllowMeToDownloadFromFileBox` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 0 | S2, S4 |
| Allow File Transfer (Incoming) | `AC_Server_Custom_FileTransferAccess` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 1 | S5 |
| Allow In-Session Chat | `AC_Server_Custom_AllowInSessionChat` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 0 | S2, S4 |
| Allow Manage Virtual Monitors | `AC_Server_Custom_AllowManageVirtualMonitors` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 0 | S2, S4 |
| Allow Partner to View Desktop | `AC_Server_Custom_AllowPartnerViewDesktop` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 1 | S5 |
| Allow Port Forwarding | `AC_Server_Custom_AllowPortForwarding` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 0 | S2, S4 |
| Allow Printing to Local Printers | `AC_Server_Custom_AllowToPrintOnMyPrinters` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 0 | S5 |
| Allow Printing to Remote Printers | `AC_Server_Custom_AllowToPrintOnRemotePrinters` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 0 | S5 |
| Allow Remote Control | `AC_Server_Custom_RemoteControlAccess` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 1 | S5 |
| Allow Remote Script Execution | `AC_Server_Custom_AllowExecuteScripts` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 0 | S2, S4 |
| Allow Remote Terminal | `AC_Server_Custom_AllowRemoteTerminal` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 0 | S2, S4 |
| Allow Session Insights Logging | `AC_Server_Custom_AllowSessionInsightsLogging` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 1 | S2, S4 |
| Allow Upload to File Box | `AC_Server_Custom_AllowMeToUploadToFileBox` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 0 | S2, S4 |
| Allow VPN Connections | `AC_Server_Custom_AllowVPN` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 1 | S5 |
| Disable Remote Input | `AC_Server_Custom_DisableRemoteImput` | 0 = Allow remote input, 1 = Disable remote input | 0 | S5 |
| Incoming Access Control Mode | `AC_Server_AccessControlType` | 0 = Full access, 1 = Confirm all, 2 = View only, 3 = Custom, 4 = Deny | 0 | S5 |

## Category: Access Control (Client-Side — Outgoing Connections)

Where the ADMX policy name differs from the registry value name, the ADMX file is authoritative.

| ![Display Name](https://img.shields.io/badge/Display%20Name-316dca?style=flat-square) | ![Value Name](https://img.shields.io/badge/Value%20Name-316dca?style=flat-square) | ![Values](https://img.shields.io/badge/Values-316dca?style=flat-square) | ![Default](https://img.shields.io/badge/Default-316dca?style=flat-square) | ![Source](https://img.shields.io/badge/Source-316dca?style=flat-square) |
|-------------|------------|--------|---------|--------|
| Allow File Transfer (Outgoing) | `AC_Client_Custom_FileTransferAccess` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 1 | S5 |
| Allow Outgoing Connections | `AC_AllowOutgoingConnections` | 0 = Deny outgoing, 1 = Allow outgoing | 1 | S5 |
| Allow Remote Control (Outgoing) | `AC_Client_Custom_RemoteControlAccess` | 0 = Denied, 1 = Allowed, 2 = After confirmation | 1 | S5 |
| Outgoing Access Control Mode | `AC_Client_AccessControlType` | 0 = Full access, 1 = Confirm all, 2 = View only, 3 = Custom, 4 = Deny | 0 | S5 |

## Category: Features

| ![Display Name](https://img.shields.io/badge/Display%20Name-316dca?style=flat-square) | ![Value Name](https://img.shields.io/badge/Value%20Name-316dca?style=flat-square) | ![Values](https://img.shields.io/badge/Values-316dca?style=flat-square) | ![Default](https://img.shields.io/badge/Default-316dca?style=flat-square) | ![Source](https://img.shields.io/badge/Source-316dca?style=flat-square) |
|-------------|------------|--------|---------|--------|
| Allow Chat to This Machine | `ChatToThisMachine` | 0 = Disabled, 1 = Enabled | 1 | S5 |
| Apply Allowlist to Meetings | `Apply_Blacklist_Or_Whitelist_On_Meeting` | 0 = Disabled, 1 = Enabled | 0 | S4 |
| Enforce Allowlist Mode | `UseWhitelist` | 0 = Disabled, 1 = Enforce allowlist | 0 | S5 |
| Full Access on Windows Login Screen | `ACFullAccessOnLoginScreen` | 0 = Disabled, 1 = Enabled | 1 | S5 |
| Hide Online Status | `HideOnlineStateOfTV` | 0 = Show, 1 = Hide | 0 | S2 |

## Category: Logging

| ![Display Name](https://img.shields.io/badge/Display%20Name-316dca?style=flat-square) | ![Value Name](https://img.shields.io/badge/Value%20Name-316dca?style=flat-square) | ![Values](https://img.shields.io/badge/Values-316dca?style=flat-square) | ![Default](https://img.shields.io/badge/Default-316dca?style=flat-square) | ![Source](https://img.shields.io/badge/Source-316dca?style=flat-square) |
|-------------|------------|--------|---------|--------|
| Enable Logging | `Logging` | 0 = Disabled, 1 = Enabled | 1 | S5 |
| Log Incoming Connections | `LogIncomingConnections` | 0 = Disabled, 1 = Enabled | 1 | S5 |
| Log Outgoing Connections | `LogOutgoingConnections` | 0 = Disabled, 1 = Enabled | 1 | S5 |

## Category: Network and Proxy

| ![Display Name](https://img.shields.io/badge/Display%20Name-316dca?style=flat-square) | ![Value Name](https://img.shields.io/badge/Value%20Name-316dca?style=flat-square) | ![Values](https://img.shields.io/badge/Values-316dca?style=flat-square) | ![Default](https://img.shields.io/badge/Default-316dca?style=flat-square) | ![Source](https://img.shields.io/badge/Source-316dca?style=flat-square) |
|-------------|------------|--------|---------|--------|
| Always Online | `Always_Online` | 0 = Disabled, 1 = Enabled | 0 | S4 |
| Custom Router Address | `CustomRouter` | Router address for custom routing | (empty) | S5 |
| Enable Direct LAN Connections | `General_DirectLAN` | 0 = Disabled, 1 = Enabled | 0 | S5 |
| Enable UPnP | `UPNP` | 0 = Disabled, 1 = Enabled | 1 | S5 |
| Proxy Mode | `Proxy_Type` | 0 = No proxy, 1 = Auto-detect, 2 = Manual | 0 | S5 |
| Proxy Server Address | `Proxy_IP` | Server address (e.g. proxy.example.com:8080) | (empty) | S5 |
| Restrict to LAN Only | `LanOnly` | 0 = Allow internet connections, 1 = LAN only | 0 | S5 |
| Use UDP | `useUDP` | 0 = Disabled, 1 = Enabled | 1 | S2 |
| Don't Use Incoming Port 80 | `ListenHttp` | 0 = Do not listen on port 80, 1 = May listen on port 80 | 0 | S8 (community; inbound DirectIn only) |
| Activate DirectIn Listener | `Security_ActivateDirectIn` | 0 = DirectIn inactive, 1 = Activate DirectIn | 0 | S8 (community; inbound DirectIn only) |

## Category: Security

| ![Display Name](https://img.shields.io/badge/Display%20Name-316dca?style=flat-square) | ![Value Name](https://img.shields.io/badge/Value%20Name-316dca?style=flat-square) | ![Values](https://img.shields.io/badge/Values-316dca?style=flat-square) | ![Default](https://img.shields.io/badge/Default-316dca?style=flat-square) | ![Source](https://img.shields.io/badge/Source-316dca?style=flat-square) |
|-------------|------------|--------|---------|--------|
| Accept Incoming Connections | `Security_AcceptIncoming` | 0 = Reject, 1 = Accept | 1 | S2, S5 |
| Black Screen for Incoming Connections | `Local_BlackScreen` | 0 = Disabled, 1 = Enabled | 0 | S2 |
| Disable Local Input During Connection | `Local_DisableInput` | 0 = Disabled, 1 = Enabled | 0 | S2 |
| Prevent Remote Shutdown | `Security_Disableshutdown` | 0 = Allow remote shutdown, 1 = Prevent remote shutdown | 0 | S5 |
| Prevent TFA for Connections | `DisableTFAForConnections` | 0 = Allow TFA, 1 = Prevent TFA | 0 | S2 |
| Random Password Strength | `Security_PasswordStrength` | 1 = 4 chars (weak), 2 = 6 chars, 3 = 8 chars, 4 = 10 chars (very secure) | 3 | S2, S5 |
| Require Admin Rights for Changes | `Security_Adminrights` | 0 = No admin required, 1 = Require admin | 0 | S2, S5 |
| Scam Protection Warning | `ShowScamProtection` | 0 = Off, 1 = On, 2 = Enhanced | 2 | S2, S4 |
| Windows Logon Authentication | `Security_WinLogin` | 0 = Not allowed, 1 = Administrators only, 2 = All users | 0 | S2, S5 |

## Category: Session Recording

| ![Display Name](https://img.shields.io/badge/Display%20Name-316dca?style=flat-square) | ![Value Name](https://img.shields.io/badge/Value%20Name-316dca?style=flat-square) | ![Values](https://img.shields.io/badge/Values-316dca?style=flat-square) | ![Default](https://img.shields.io/badge/Default-316dca?style=flat-square) | ![Source](https://img.shields.io/badge/Source-316dca?style=flat-square) |
|-------------|------------|--------|---------|--------|
| Disable Stopping/Pausing Recordings | `DeactivateSessionRecordingPauseStop` | 0 = Allow stop/pause, 1 = Prevent stop/pause | 0 | S2 |
| Enforce Auto-Record Outgoing Sessions | `AutorecordRemoteControlEnforced` | 0 = Disabled, 1 = Enabled | 0 | S2 |

## Category: Update Control

| ![Display Name](https://img.shields.io/badge/Display%20Name-316dca?style=flat-square) | ![Value Name](https://img.shields.io/badge/Value%20Name-316dca?style=flat-square) | ![Values](https://img.shields.io/badge/Values-316dca?style=flat-square) | ![Default](https://img.shields.io/badge/Default-316dca?style=flat-square) | ![Source](https://img.shields.io/badge/Source-316dca?style=flat-square) |
|-------------|------------|--------|---------|--------|
| Auto-Update Mode | `AutoUpdateMode` | 0 = Disabled, 1 = Security updates only, 2 = Same major version, 3 = All updates | 3 | S1, S2 |
| Preview Version Flag | `IsPreviewVersion` | 0 = No, 1 = Yes | 0 | S4 |
| Receive Insider Builds | `ReceiveInsiderBuild` | 0 = Disabled, 1 = Enabled | 0 | S2 |
| Update Channel | `UpdateChannel` | 0 = Stable, 1 = Preview | 0 | S2, S4 |
| Update Check Interval | `UpdateCheckInterval` | 0 = Never, 1 = Daily, 2 = Weekly, 3 = Monthly | 2 | S1, S5 |
| Update to Specific Version | `UpdateExpectedVersion` | Version string (e.g. 15.58.4) | (empty) | S2 |

## Category: Wake-on-LAN

| ![Display Name](https://img.shields.io/badge/Display%20Name-316dca?style=flat-square) | ![Value Name](https://img.shields.io/badge/Value%20Name-316dca?style=flat-square) | ![Values](https://img.shields.io/badge/Values-316dca?style=flat-square) | ![Default](https://img.shields.io/badge/Default-316dca?style=flat-square) | ![Source](https://img.shields.io/badge/Source-316dca?style=flat-square) |
|-------------|------------|--------|---------|--------|
| Force WoL Neighbor Update | `Wol_ForceUpdate` | 0 = Disabled, 1 = Enabled | 1 | S4 |
| Wake-on-LAN Mode | `Wol_Mode` | 0 = Disabled, 1 = Public address, 2 = TeamViewer IDs in network | 0 | S2, S4 |
| Wake-on-LAN Port | `Wol_Port` | Port number (0–65535) | 0 | S4 |
| Wake-on-LAN Public Address | `Wol_IP` | IP address or hostname | (empty) | S4 |

---

## Values NOT Included in ADMX (and why)

| ![Value Name](https://img.shields.io/badge/Value%20Name-316dca?style=flat-square) | ![Type](https://img.shields.io/badge/Type-316dca?style=flat-square) | ![Reason for Exclusion](https://img.shields.io/badge/Reason%20for%20Exclusion-316dca?style=flat-square) |
|------------|------|---------------------|
| `SecurityPasswordAES` | REG_BINARY | AES-encrypted; cannot be set as plain text via GPO |
| `OptionsPasswordAES` | REG_BINARY | AES-encrypted |
| `OptionsPasswordHash` | REG_SZ | Credential hash; excluded for security reasons |
| `PermanentPassword` | REG_BINARY | AES-encrypted |
| `ServerPasswordAES` | REG_BINARY | AES-encrypted |
| `ProxyPasswordAES` | REG_BINARY | AES-encrypted |
| `ProxyUsername` | REG_SZ | Credential data; excluded for security reasons |
| `ProxyPassword` | REG_SZ | Credential data; excluded for security reasons |
| `LicenseKeyAES` | REG_BINARY | AES-encrypted |
| `Whitelist` | REG_MULTI_SZ | Multi-string; manage via TeamViewer console or .reg import |
| `Blacklist` | REG_MULTI_SZ | Multi-string; manage via TeamViewer console or .reg import |
| `WhitelistBuddy` / `BlacklistBuddy` | REG_MULTI_SZ | Multi-string |
| `WhitelistCompany` / `BlacklistCompany` | REG_MULTI_SZ | Multi-string |
| `*BuddyAccountID` / `*CompanyID` | REG_BINARY | Encrypted account identifiers |
| `Wol_Neighbors` | REG_MULTI_SZ | Multi-string |

These values require either AES-encrypted binary data, credential information, or multi-string types that are not practical to manage via ADMX policies. Use TeamViewer's Management Console, MSI `SETTINGSFILE=` parameter, or `IMPORTREGFILE=1` for these settings.

## Risk Notes

| ![Setting](https://img.shields.io/badge/Setting-316dca?style=flat-square) | ![Risk](https://img.shields.io/badge/Risk-316dca?style=flat-square) |
|---------|------|
| `LanOnly = 1` | Completely blocks internet-based remote support; only use if all support staff are on-premises |
| `Security_AcceptIncoming = 0` | Disables all incoming connections; effectively prevents remote support |
| `AC_Server_AccessControlType = 4` | Denies all incoming access; overrides granular custom permissions |
| `UseWhitelist = 1` | Without a populated Whitelist (REG_MULTI_SZ, not in ADMX), all connections will be blocked |
| `AutoUpdateMode = 0` | Disables all updates; must be paired with a separate patching strategy |
| `AC_Server_Custom_AllowExecuteScripts = 1` | Allows remote script execution; significant security risk if granted to untrusted partners |
| `AC_Server_Custom_AllowRemoteTerminal = 1` | Allows direct command-line access; only enable for trusted connections |
| `AC_Server_Custom_AllowPortForwarding = 1` | Allows network port forwarding through the TeamViewer tunnel; potential lateral movement risk |
| `DisableTFAForConnections = 1` | Prevents users from enabling two-factor authentication for connections; weakens security posture |
| `ListenHttp = 0` (via GPO Enabled) | Disables incoming port 80 listener only; does not change outbound port fallback order |
| `Security_ActivateDirectIn = 1` | Enables inbound DirectIn; does not change outbound port selection |

---

**Sharing & responsibility** — Built for the community, shared with good intentions. Use at your own risk. The author accepts no responsibility for any outcomes resulting from the use of these files. Always verify registry paths and values, and test in a safe environment first. If you find an issue or have a suggestion, contributions are welcome.

<p align="left"><a href="https://github.com/systmworks/TeamViewer-ADMX">&lt;- Back to Main</a></p>

<p align="center"><a href="https://buymeacoffee.com/systmworks"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" height="45" alt="Buy me a coffee"></a></p>

> I have spent many, many hours creating and testing this ADMX. If it helps you please consider buying me a Coffee :)

# Changelog

Registry **setting** changes are recorded in the **Registry settings** table (Add / Delete / Modify per policy value). Public **template**, **documentation**, and **repository** changes are listed separately in **Template and documentation**. Each release adds a new dated section at the top (newest first).

Table columns (registry): **Change type** · **Category** · **Friendly name** · **Value name** · **Change**. Table columns (template and documentation): **Change type** · **Item** · **Change**.

---

## 1.2 — 2026-07-31

**Summary:** 2 new inbound DirectIn registry settings (60 unique per architecture, 120 policies with x64/x86 duplication). ASCII-only ADML fixes Intune ingestion in v1.1. New network troubleshooting documentation and connectivity diagnostic script. Repository layout: live ADMX at `ADMX/`, docs at `Documentation/`, helpers at `Helper_Scripts/`.

### Registry settings

| ![Change type](https://img.shields.io/badge/Change%20type-316dca?style=flat-square) | ![Category](https://img.shields.io/badge/Category-316dca?style=flat-square) | ![Friendly name](https://img.shields.io/badge/Friendly%20name-316dca?style=flat-square) | ![Value name](https://img.shields.io/badge/Value%20name-316dca?style=flat-square) | ![Change](https://img.shields.io/badge/Change-316dca?style=flat-square) |
|-------------|----------|---------------|------------|--------|
| Add | Network and Proxy | Don't Use Incoming Port 80 | `ListenHttp` | Inbound DirectIn only; Enabled writes 0 (do not listen on port 80) |
| Add | Network and Proxy | Activate DirectIn Listener | `Security_ActivateDirectIn` | Inbound DirectIn only; enables DirectIn listener |

### Template and documentation

| ![Change type](https://img.shields.io/badge/Change%20type-316dca?style=flat-square) | ![Item](https://img.shields.io/badge/Item-316dca?style=flat-square) | ![Change](https://img.shields.io/badge/Change-316dca?style=flat-square) |
|-------------|------|--------|
| Modify | ADML encoding | ASCII-only display strings (fixes Intune ingestion blocker in v1.1) |
| Modify | Repository layout | Live template at `ADMX/`; documentation at `Documentation/`; consumer scripts at `Helper_Scripts/` |
| Add | [Network Ports and Connectivity](Network_Ports_and_Connectivity.md) | Outbound port order (5938 → 443 → 80), AVD/Azure troubleshooting, proxy/WPAD notes |
| Add | [Test-TeamViewerConnectivity.ps1](../Helper_Scripts/Test-TeamViewerConnectivity.ps1) | Read-only connectivity diagnostic for session hosts |
| Modify | [Screenshots](screenshots.md) | GPO Editor screenshots for the template categories |

---

## 1.1 — 2026-04-11

**Summary:** 27 new registry settings (58 unique per architecture, 116 policies with x64/x86 duplication).

| ![Change type](https://img.shields.io/badge/Change%20type-316dca?style=flat-square) | ![Category](https://img.shields.io/badge/Category-316dca?style=flat-square) | ![Friendly name](https://img.shields.io/badge/Friendly%20name-316dca?style=flat-square) | ![Value name](https://img.shields.io/badge/Value%20name-316dca?style=flat-square) | ![Change](https://img.shields.io/badge/Change-316dca?style=flat-square) |
|-------------|----------|---------------|------------|--------|
| Add | Access Control (Incoming) | Allow Control of Remote TeamViewer | `AC_Server_Custom_ControlRemoteTV` | Granular deny/allow/confirm for controlling remote TeamViewer |
| Add | Access Control (Incoming) | Allow Download from File Box | `AC_Server_Custom_AllowMeToDownloadFromFileBox` | File Box download permission |
| Add | Access Control (Incoming) | Allow In-Session Chat | `AC_Server_Custom_AllowInSessionChat` | In-session chat permission |
| Add | Access Control (Incoming) | Allow Manage Virtual Monitors | `AC_Server_Custom_AllowManageVirtualMonitors` | Virtual monitor management permission |
| Add | Access Control (Incoming) | Allow Port Forwarding | `AC_Server_Custom_AllowPortForwarding` | Port forwarding permission |
| Add | Access Control (Incoming) | Allow Remote Script Execution | `AC_Server_Custom_AllowExecuteScripts` | Script execution permission |
| Add | Access Control (Incoming) | Allow Remote Terminal | `AC_Server_Custom_AllowRemoteTerminal` | Remote terminal permission |
| Add | Access Control (Incoming) | Allow Session Insights Logging | `AC_Server_Custom_AllowSessionInsightsLogging` | Session insights logging permission |
| Add | Access Control (Incoming) | Allow Upload to File Box | `AC_Server_Custom_AllowMeToUploadToFileBox` | File Box upload permission |
| Add | Features | Apply Allowlist to Meetings | `Apply_Blacklist_Or_Whitelist_On_Meeting` | Apply allow/block lists to meetings |
| Add | Features | Hide Online Status | `HideOnlineStateOfTV` | Hide TeamViewer online presence |
| Add | Network and Proxy | Always Online | `Always_Online` | Keep device always reachable |
| Add | Network and Proxy | Use UDP | `useUDP` | Toggle UDP for connections |
| Add | Security | Black Screen for Incoming Connections | `Local_BlackScreen` | Black local screen during remote session |
| Add | Security | Disable Local Input During Connection | `Local_DisableInput` | Block local keyboard/mouse during session |
| Add | Security | Prevent TFA for Connections | `DisableTFAForConnections` | Block users enabling TFA for connections |
| Add | Security | Scam Protection Warning | `ShowScamProtection` | Off / On / Enhanced scam warnings |
| Add | Session Recording | Disable Stopping/Pausing Recordings | `DeactivateSessionRecordingPauseStop` | Prevent pausing or stopping recordings |
| Add | Session Recording | Enforce Auto-Record Outgoing Sessions | `AutorecordRemoteControlEnforced` | Force auto-record on outgoing sessions |
| Add | Update Control | Preview Version Flag | `IsPreviewVersion` | Mark install as preview channel |
| Add | Update Control | Receive Insider Builds | `ReceiveInsiderBuild` | Insider/preview build channel |
| Add | Update Control | Update Channel | `UpdateChannel` | Stable vs Preview updates |
| Add | Update Control | Update to Specific Version | `UpdateExpectedVersion` | Pin to explicit version string (REG_SZ) |
| Add | Wake-on-LAN | Force WoL Neighbor Update | `Wol_ForceUpdate` | Force refresh of WoL neighbor list |
| Add | Wake-on-LAN | Wake-on-LAN Mode | `Wol_Mode` | Off / public address / TV IDs in network |
| Add | Wake-on-LAN | Wake-on-LAN Port | `Wol_Port` | WoL UDP port (0–65535) |
| Add | Wake-on-LAN | Wake-on-LAN Public Address | `Wol_IP` | Public IP or hostname for WoL |

---

## 1.0 — 2026-04-10

**Summary:** Initial public release — 31 registry settings per architecture (62 policies with x64/x86 duplication).

| ![Change type](https://img.shields.io/badge/Change%20type-316dca?style=flat-square) | ![Category](https://img.shields.io/badge/Category-316dca?style=flat-square) | ![Friendly name](https://img.shields.io/badge/Friendly%20name-316dca?style=flat-square) | ![Value name](https://img.shields.io/badge/Value%20name-316dca?style=flat-square) | ![Change](https://img.shields.io/badge/Change-316dca?style=flat-square) |
|-------------|----------|---------------|------------|--------|
| Add | Access Control (Incoming) | Allow File Transfer (Incoming) | `AC_Server_Custom_FileTransferAccess` | Initial release |
| Add | Access Control (Incoming) | Allow Partner to View Desktop | `AC_Server_Custom_AllowPartnerViewDesktop` | Initial release |
| Add | Access Control (Incoming) | Allow Printing to Local Printers | `AC_Server_Custom_AllowToPrintOnMyPrinters` | Initial release |
| Add | Access Control (Incoming) | Allow Printing to Remote Printers | `AC_Server_Custom_AllowToPrintOnRemotePrinters` | Initial release |
| Add | Access Control (Incoming) | Allow Remote Control | `AC_Server_Custom_RemoteControlAccess` | Initial release |
| Add | Access Control (Incoming) | Allow VPN Connections | `AC_Server_Custom_AllowVPN` | Initial release |
| Add | Access Control (Incoming) | Disable Remote Input | `AC_Server_Custom_DisableRemoteImput` | Initial release |
| Add | Access Control (Incoming) | Incoming Access Control Mode | `AC_Server_AccessControlType` | Initial release |
| Add | Access Control (Outgoing) | Allow File Transfer (Outgoing) | `AC_Client_Custom_FileTransferAccess` | Initial release |
| Add | Access Control (Outgoing) | Allow Outgoing Connections | `AC_AllowOutgoingConnections` | Initial release |
| Add | Access Control (Outgoing) | Allow Remote Control (Outgoing) | `AC_Client_Custom_RemoteControlAccess` | Initial release |
| Add | Access Control (Outgoing) | Outgoing Access Control Mode | `AC_Client_AccessControlType` | Initial release |
| Add | Features | Allow Chat to This Machine | `ChatToThisMachine` | Initial release |
| Add | Features | Enforce Allowlist Mode | `UseWhitelist` | Initial release |
| Add | Features | Full Access on Windows Login Screen | `ACFullAccessOnLoginScreen` | Initial release |
| Add | Logging | Enable Logging | `Logging` | Initial release |
| Add | Logging | Log Incoming Connections | `LogIncomingConnections` | Initial release |
| Add | Logging | Log Outgoing Connections | `LogOutgoingConnections` | Initial release |
| Add | Network and Proxy | Custom Router Address | `CustomRouter` | Initial release |
| Add | Network and Proxy | Enable Direct LAN Connections | `General_DirectLAN` | Initial release |
| Add | Network and Proxy | Enable UPnP | `UPNP` | Initial release |
| Add | Network and Proxy | Proxy Mode | `Proxy_Type` | Initial release |
| Add | Network and Proxy | Proxy Server Address | `Proxy_IP` | Initial release |
| Add | Network and Proxy | Restrict to LAN Only | `LanOnly` | Initial release |
| Add | Security | Accept Incoming Connections | `Security_AcceptIncoming` | Initial release |
| Add | Security | Prevent Remote Shutdown | `Security_Disableshutdown` | Initial release |
| Add | Security | Random Password Strength | `Security_PasswordStrength` | Initial release |
| Add | Security | Require Admin Rights for Changes | `Security_Adminrights` | Initial release |
| Add | Security | Windows Logon Authentication | `Security_WinLogin` | Initial release |
| Add | Update Control | Auto-Update Mode | `AutoUpdateMode` | Initial release |
| Add | Update Control | Update Check Interval | `UpdateCheckInterval` | Initial release |

---

**Sharing & responsibility** — Built for the community, shared with good intentions. Use at your own risk. The author accepts no responsibility for any outcomes resulting from the use of these files. Always verify registry paths and values, and test in a safe environment first. If you find an issue or have a suggestion, contributions are welcome.

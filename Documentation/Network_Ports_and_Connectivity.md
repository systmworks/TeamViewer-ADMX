<p align="left"><a href="https://github.com/systmworks/TeamViewer-ADMX">&lt;- Back to Main</a></p>

<p align="center"><a href="https://buymeacoffee.com/systmworks"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" height="45" alt="Buy me a coffee"></a></p>

> I have spent many, many hours creating and testing this ADMX. If it helps you please consider buying me a Coffee :)

# TeamViewer Network Ports and Connectivity

**Version:** 1.2  
**Date:** 2026-07-31  
**Audience:** Enterprise admins deploying TeamViewer Host (especially Azure Virtual Desktop)

This guide explains TeamViewer outbound port behaviour, why endpoints may fall back to port 80, and how to troubleshoot in AVD/Azure environments. It complements the [Registry Reference](TeamViewer_Registry_Reference.md) and the read-only diagnostic script [`Helper_Scripts/Test-TeamViewerConnectivity.ps1`](../Helper_Scripts/Test-TeamViewerConnectivity.ps1).

---

## Outbound port preference (hardcoded)

TeamViewer establishes **outbound** connections in this order ([vendor KB](https://www.teamviewer.com/en-us/global/support/knowledge-base/teamviewer-remote/troubleshooting/ports-used-by-teamviewer/)):

| ![Order](https://img.shields.io/badge/Order-316dca?style=flat-square) | ![Port](https://img.shields.io/badge/Port-316dca?style=flat-square) | ![Protocol](https://img.shields.io/badge/Protocol-316dca?style=flat-square) | ![Role](https://img.shields.io/badge/Role-316dca?style=flat-square) |
|-------|------|----------|------|
| 1 | 5938 | TCP and UDP | Primary - best performance |
| 2 | 443 | TCP | Fallback if 5938 blocked; also updates and Management Console |
| 3 | 80 | TCP | Last resort - slower, less reliable, no auto-reconnect |

**There is no TeamViewer registry value or ADMX policy that changes this order.** Port preference is implemented in the client binary.

---

## What the ADMX *does* cover (network category)

| ![Policy](https://img.shields.io/badge/Policy-316dca?style=flat-square) | ![Value name](https://img.shields.io/badge/Value%20name-316dca?style=flat-square) | ![Affects](https://img.shields.io/badge/Affects-316dca?style=flat-square) |
|--------|------------|----------|
| Proxy Mode | `Proxy_Type` | 0 = No proxy, 1 = Auto-detect, 2 = Manual |
| Proxy Server Address | `Proxy_IP` | Manual proxy host:port |
| Use UDP | `useUDP` | UDP vs TCP-only for sessions |
| Restrict to LAN Only | `LanOnly` | Blocks all internet connections |
| Enable UPnP | `UPNP` | Router port mapping (local) |
| Enable Direct LAN | `General_DirectLAN` | LAN peer connections |
| Custom Router | `CustomRouter` | On-premises router address |
| Always Online | `Always_Online` | Stay reachable without logged-on user |
| Don't Use Incoming Port 80 | `ListenHttp` | **Inbound** DirectIn listener only (v1.2) |
| Activate DirectIn Listener | `Security_ActivateDirectIn` | **Inbound** DirectIn only (v1.2) |

`ListenHttp` and `Security_ActivateDirectIn` do **not** control outbound fallback. They govern whether TeamViewer listens for incoming DirectIn on local ports.

---

## Why AVD hosts may use port 80 even when 5938 and 443 are "open"

### 1. Azure Firewall application rules do not cover port 5938

TeamViewer on port 5938 uses its **own protocol**, not HTTP/HTTPS. An Azure Firewall **Application rule** for `*.teamviewer.com` typically inspects HTTP/S traffic only and will **not** permit raw TCP/UDP 5938.

**Fix:** Add an Azure Firewall **Network rule** (or NSG outbound rule) allowing TCP and UDP **5938** and TCP **443** to `*.teamviewer.com`. Enable DNS proxy if filtering by FQDN.

### 2. TLS inspection breaks port 443

If a proxy or firewall performs TLS break-and-inspect on 443, TeamViewer's non-browser protocol fails negotiation and the client falls back to port 80.

**Fix:** Bypass inspection for TeamViewer destination domains on 443, or allow direct outbound 5938.

### 3. Proxy auto-detect (common in enterprise/AVD)

When `Proxy_Type` is **Not Configured**, TeamViewer defaults to behaviour that can **auto-detect** system/WPAD proxy settings. Proxied traffic often appears on ports **80** or **8080**.

**Fix (test):** Deploy ADMX policy **Proxy Mode = No proxy (0)** and retest. Run [`Helper_Scripts/Test-TeamViewerConnectivity.ps1`](../Helper_Scripts/Test-TeamViewerConnectivity.ps1) to inspect WinHTTP and WPAD state.

### 4. UDP 5938 blocked while TCP appears open

TeamViewer prefers **UDP** 5938 for performance. Some firewalls allow TCP probes but block UDP.

**Fix:** Allow outbound **UDP 5938** explicitly alongside TCP 5938.

---

## Remediation checklist (ordered by likelihood)

1. Run `.\Helper_Scripts\Test-TeamViewerConnectivity.ps1` on an affected AVD session host.
2. Confirm Azure Firewall has **network** (not just application) rules for TCP/UDP 5938 and TCP 443 to TeamViewer domains.
3. Set **Proxy Mode = No proxy (0)** via GPO and retest (rules out WPAD/proxy path).
4. Verify UDP 5938 is allowed outbound on session host NSGs and Azure Firewall.
5. Check for TLS inspection on 443; add bypass for TeamViewer if present.
6. Review TeamViewer log for "proxy", "router", "5938", "443", "80" (script parses recent lines).
7. Do **not** expect `ListenHttp` or DirectIn settings to change outbound port selection.

---

## Diagnostic script

From the repository root (after cloning [TeamViewer-ADMX](https://github.com/systmworks/TeamViewer-ADMX)):

```powershell
.\Helper_Scripts\Test-TeamViewerConnectivity.ps1
```

Optional: `-SkipPortTests` if outbound probes are blocked by local policy; `-TeamViewerLogPath` for a custom log location.

The script is **read-only** - safe on production session hosts.

---

## Related documentation

- [TeamViewer Registry Reference](TeamViewer_Registry_Reference.md) - all ADMX value names and sources
- [Changelog](changelog.md) - v1.2 adds `ListenHttp` and `Security_ActivateDirectIn`
- Internal design review: maintainer workspace only (not published)

---

**Sharing & responsibility** — Built for the community, shared with good intentions. Use at your own risk. The author accepts no responsibility for any outcomes resulting from the use of these files. Always verify registry paths and values, and test in a safe environment first. If you find an issue or have a suggestion, contributions are welcome.

---
title: NMAPSCAN
section: 1
header: User Commands
date: May 2026
author: Mark Pitman <mark.pitman@gmail.com>
---

# NAME

nmapscan - comprehensive nmap reconnaissance scan against a single target

# SYNOPSIS

**nmapscan** [-h] [-o output_dir] [-u] \<target\>

# DESCRIPTION

**nmapscan** runs a six-phase nmap reconnaissance campaign against an IP
address, hostname, or CIDR subnet and writes each phase to a timestamped file
in the output directory.

Phases:

1. **Host discovery** — ICMP echo/timestamp/netmask probes plus TCP SYN/ACK and UDP pings with traceroute.
2. **Full TCP port scan** — all 65535 ports at high speed to enumerate every open TCP port.
3. **Service/version and OS detection** — version intensity 9, OS fingerprinting with guess mode, and the default NSE script set on all open ports.
4. **UDP scan** — top 200 common UDP ports (requires root; skipped otherwise or with **-u**).
5. **NSE script battery** — `default`, `auth`, `discovery`, `vuln`, `malware`, and `safe` script categories against open TCP ports.
6. **Traceroute and timing probe** — low-noise `-T2` pass with traceroute to map the network path and gather additional service detail.

A summary of open services is printed to stdout when all phases complete.

# OPTIONS

**-o** output_dir

: Directory where result files are written.
  Default: `./nmapscan-results`.

**-u**

: Skip the UDP scan even when running as root.

**-h**

: Show usage help and exit.

# ARGUMENTS

**target**

: IP address, hostname, or CIDR subnet (e.g. `192.168.1.0/24`) to scan.
  Exactly one target is required.

# OUTPUT FILES

Each phase writes a plain-text nmap report named:

```
<output_dir>/<target>_<YYYYMMDD_HHMMSS>_<NN>_<phase>.txt
```

| File | Contents |
|------|----------|
| `*_01_discovery.txt`  | Host discovery results |
| `*_02_tcp_full.txt`   | Full TCP port scan |
| `*_03_services.txt`   | Service, version, and OS detection |
| `*_04_udp.txt`        | UDP scan (when run) |
| `*_05_scripts.txt`    | NSE script output |
| `*_06_traceroute.txt` | Traceroute and timing probe |

# EXAMPLES

```bash
nmapscan 192.168.1.1
nmapscan 192.168.1.0/24
nmapscan -o /tmp/scans 10.0.0.0/16
nmapscan -u scanme.nmap.org
sudo nmapscan 10.10.0.1
```

# EXIT STATUS

**0**

: All phases completed successfully.

**1**

: Invalid arguments, missing **nmap** dependency, or scan failure.

# NOTES

Root privileges (or `sudo`) are required for the UDP scan phase and for raw-socket
OS fingerprinting. Without root, both are skipped automatically.

Aggressive NSE categories such as `exploit`, `brute`, and `intrusive` are
intentionally omitted to avoid unintended service disruption. Add
`--script exploit,brute` manually if intrusive testing is desired.

Only scan hosts you own or have explicit written permission to test.

# SEE ALSO

**nmap**(1)

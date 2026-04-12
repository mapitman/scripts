---
title: SELFCERT
section: 1
header: User Commands
date: March 2026
author: Mark Pitman <mark.pitman@gmail.com>
---

# NAME

selfcert - generate a local CA and a leaf certificate bundle with OpenSSL

# SYNOPSIS

**selfcert** [-h] [-d domain] [-o org] [-y days] [-O output_dir] [-p pfx_password] [-s san_list]

# DESCRIPTION

**selfcert** creates a small local certificate authority and a leaf certificate
for a target domain. It writes a CA key and certificate, a serial file, the leaf
private key and CSR, the signed leaf certificate, and a PKCS#12 bundle.

The requested domain is always included in the certificate Subject Alternative
Name list. Additional SAN entries can be supplied with **-s**.

# OPTIONS

**-d** domain

: Domain name for the leaf certificate and output filenames.
  Default: `localhost`.

**-o** org

: Organization and Common Name for the generated CA certificate.
  Default: `localhost-ca`.

**-y** days

: Validity period, in days, for both the CA and the leaf certificate.
  Default: `365`.

**-O** output_dir

: Directory where generated files should be written.
  Default: current directory.

**-p** pfx_password

: Password to use when exporting the PKCS#12 bundle. If omitted, OpenSSL prompts
  interactively.

**-s** san_list

: Comma-separated list of additional DNS subjectAltName entries.
  The primary domain from **-d** is always included.

**-h**

: Show usage help and exit.

# OUTPUT FILES

The script writes the following files into the selected output directory:

- `ca.key`
- `ca.crt`
- `ca.srl`
- `<domain>.key`
- `<domain>.csr`
- `<domain>.crt`
- `<domain>.pfx`

# EXAMPLES

```bash
selfcert
selfcert -d example.local -O certs
selfcert -d example.local -s www.example.local,api.example.local
selfcert -d example.local -o example-ca -y 825 -O certs
selfcert -d example.local -p secret123
```

# EXIT STATUS

**0**

: Success.

**1**

: Invalid arguments, missing dependencies, or an OpenSSL failure occurred.

# SEE ALSO

**openssl**(1)
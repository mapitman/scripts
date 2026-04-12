---
title: STRIP-EXT
section: 1
header: User Commands
date: March 2026
author: Mark Pitman <mark.pitman@gmail.com>
---

# NAME

strip-ext - remove the final filename extension from matching files

# SYNOPSIS

**strip-ext** [-n] [-h] pattern ...

# DESCRIPTION

**strip-ext** renames each matching file by removing only its last filename
extension.

For example, `archive.tar.gz` becomes `archive.tar`, not `archive`.

Existing destination paths are never overwritten. Files without an extension are
skipped.

# OPTIONS

**-n**

: Dry run. Print what would be renamed without making any changes.

**-h**

: Show usage help and exit.

# EXAMPLES

```bash
strip-ext '*.sh'
strip-ext -n '*.tar.gz'
strip-ext report.txt archive.tar.gz
```

# EXIT STATUS

**0**

: Success.

**1**

: No files matched, invalid usage, or another error occurred.

# NOTES

Only the last extension segment is removed.

# SEE ALSO

**mv**(1)
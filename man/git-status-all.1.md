---
title: GIT-STATUS-ALL
section: 1
header: User Commands
date: June 2026
author: Mark Pitman <mark.pitman@gmail.com>
---

# NAME

git-status-all - check the status of all Git repositories under a directory

# SYNOPSIS

**git-status-all** [-f] [-h] [*dir*]

# DESCRIPTION

**git-status-all** scans the specified directory recursively for directories containing a `.git` folder, and checks each one for uncommitted changes or unpushed commits.

Only repositories that have uncommitted changes or unpushed commits are output by default. If all scanned repositories are clean, a summary message to that effect is shown.

# OPTIONS

**-f**

: Fetch from remotes before checking for unpushed commits. This provides an up-to-date view of the remote branches, but requires network connectivity.

**-h**

: Show usage help and exit.

# EXAMPLES

Check the status of repositories in the current directory:

```bash
git-status-all
```

Check the status of repositories under `~/src`, fetching remote updates first:

```bash
git-status-all -f ~/src
```

# EXIT STATUS

**0**

: Success.

**1**

: Invalid usage, missing directory, or another error occurred.

# SEE ALSO

**git-status**(1), **git-log**(1), **git-fetch**(1)

---
title: GIT-CLONE-ALL
section: 1
header: User Commands
date: June 2026
author: Mark Pitman <mark.pitman@gmail.com>
---

# NAME

git-clone-all - recursively clone all git repositories from a GitHub or GitLab user or organization

# SYNOPSIS

**git-clone-all** [-n] [-a] [-d *dir*] [-h] *org-or-user-path*

# DESCRIPTION

**git-clone-all** retrieves the list of all repositories belonging to the specified user, organization, or group from GitHub or GitLab, and clones them locally.

By default, the script creates directories that replicate the user or organization structure (e.g., `mapitman/scripts` for GitHub, or `group/subgroup/project` for GitLab) under the destination directory.

For each repository, the script attempts to clone using **SSH** first. If the SSH clone fails, it falls back to **HTTPS**.

If the destination directory for a repository already exists, it is skipped.

# INTEGRATION & AUTHENTICATION

The script automatically prioritizes using CLI utilities if they are installed and configured:

**GitHub**

: The script uses the `gh` CLI utility if available. To authenticate or list private repositories, make sure `gh` is logged in (`gh auth login`). If `gh` is not available or is unauthenticated, the script falls back to direct API queries using `curl` and can utilize `GITHUB_TOKEN` or `GH_TOKEN` environment variables.

**GitLab**

: The script uses the `glab` CLI utility (via `glab api`) if available. If `glab` is not available, it falls back to direct API queries using `curl` and can utilize `GITLAB_TOKEN`, `GL_TOKEN`, or `PRIVATE_TOKEN` environment variables.

# OPTIONS

**-d** *dir*

: Specify the base directory where repositories should be cloned. Defaults to the current directory (`.`).

**-a**

: Clone archived repositories as well. By default, archived repositories are skipped.

**-n**

: Dry-run. Print the commands that would be executed without cloning any repositories.

**-h**

: Show usage help and exit.

# EXAMPLES

Clone all repositories under GitHub user `mapitman`:

```bash
git-clone-all github.com/mapitman
```

Clone all repositories under GitLab group `gitlab-org` into a custom source folder, using dry-run first:

```bash
git-clone-all -n -d ~/src gitlab.com/gitlab-org
```

# EXIT STATUS

**0**

: Success.

**1**

: Invalid usage, API error, or another error occurred.

# SEE ALSO

**git-clone**(1), **gh**(1), **glab**(1)

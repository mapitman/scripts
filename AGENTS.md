# Scripts — Project Guidelines

Shell utility scripts installed to `~/.local/bin` so they're on `$PATH` from anywhere.

## Structure

| Directory | Purpose |
|-----------|---------|
| `files/`  | General file/filesystem utilities |
| `qemu/`   | `vmctl` — interactive gum wrapper around quickemu |

## Conventions

- **No file extensions** — scripts are executed directly from `~/.local/bin`; never add `.sh` or similar suffixes
- **Strict error handling** — begin every script with `set -euo pipefail`
- **Argument parsing** — use `getopts` for flags; always support `-h` for usage help
- **Man pages required** — every installed script must have a corresponding Markdown man page under `man/` that is converted to `man(1)` format with `pandoc`
- **Help output should include examples** — usage help should show a few concrete examples, not just option summaries
- **Defensive `mv`/`cp`** — use `--` before filenames to guard against names starting with `-` (e.g., `mv -- "$src" "$dst"`)
- **Dry-run flag** — add `-n` to scripts that move, rename, or delete files
- **Bash** — shebang `#!/usr/bin/env bash` unless the script requires only POSIX sh
- **Use `gum` for interactive workflows** — scripts that require substantial user interaction while running should prefer `gum` for menus, prompts, confirmations, and pagers

## Install And Man Pages

- **Makefile is the source of truth** — every installed script must be listed in `SCRIPTS` in the `Makefile`
- **Install and uninstall stay in sync** — `make install` and `make uninstall` should handle both scripts and their man pages together
- **Man source naming** — each installed command should have a matching manpage source named `man/<command>.1.md`
- **Generated manpages are build artifacts** — the Markdown sources under `man/` are the canonical source, and `pandoc` generates the `man(1)` files
- **User-local install paths** — scripts install to `~/.local/bin`; man pages install under `${XDG_DATA_HOME:-$HOME/.local/share}/man/man1`

## Naming

- **Prefer short command names** — choose concise, extensionless names intended for direct use from `$PATH`
- **Renames must be propagated** — if a script is renamed, update the script path, `Makefile`, manpage source name/title, and any local tooling references

## Interactive UX

- **Prefer built-in `gum` behavior** — avoid custom keybinding logic when `gum` already provides a reasonable interaction model
- **Use `gum choose` for small fixed menus** — action menus with a short list of options should prefer `gum choose`
- **Use `gum filter` for large/searchable lists** — VM pickers, snapshot pickers, or other long lists should prefer `gum filter`
- **Keep navigation consistent** — `Esc` should go back one level; top-level exit should not require a separate `Quit` item unless there is a strong reason
- **Confirm destructive actions** — actions like delete, apply, create, or resize should show a confirmation prompt with enough context for the user to understand what will happen

## QEMU / vmctl script

`qemu/vmctl` is a `gum`-based interactive wrapper around [quickemu](https://github.com/quickemu-project/quickemu). It scans `~/quickemu/` for `*.conf` files and presents menus to manage VMs.

**Actions:** Start · Stop · Connect (SPICE) · Snapshot (Create / Apply / List / Delete)

**Dependencies:** `quickemu` and `gum` are installed via the Linux bootstrap project. The Connect action requires `spicy` (from `spice-client-gtk`) or `remote-viewer` (from `virt-viewer`).

**Port and disk management** is handled entirely by quickemu — the `vmctl` script does not manage ports or disk images directly.

## Pitfalls

- Always shut a VM down before using Snapshot → Apply or Delete — quickemu calls `qemu-img snapshot` directly on the disk
- The Connect action reads `~/quickemu/<name>/<name>.spice` written by quickemu at launch — this file only exists while the VM is running
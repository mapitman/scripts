prefix := env_var_or_default("PREFIX", home_dir() / ".local")
bindir := env_var_or_default("BINDIR", prefix / "bin")
xdg_data_home := env_var_or_default("XDG_DATA_HOME", home_dir() / ".local/share")
mandir := env_var_or_default("MANDIR", xdg_data_home / "man")
man1dir := env_var_or_default("MAN1DIR", mandir / "man1")
pandoc := env_var_or_default("PANDOC", "pandoc")

scripts := "development/git-clone-all general/mktlapse general/nmapscan general/selfcert general/strip-ext qemu/vmctl"
man_sources := "man/git-clone-all.1.md man/mktlapse.1.md man/nmapscan.1.md man/selfcert.1.md man/strip-ext.1.md man/vmctl.1.md"

# Default action: install scripts and man pages
default: install

# Install all scripts and man pages
install: install-scripts install-man

# Install only utility scripts
install-scripts:
    #!/usr/bin/env bash
    set -euo pipefail
    mkdir -p "{{bindir}}"
    for script in {{scripts}}; do
        name=$(basename "$script")
        install -m 0755 "$script" "{{bindir}}/$name"
        echo "Installed $name -> {{bindir}}/$name"
    done

# Install only man pages (builds them if needed)
install-man: man
    #!/usr/bin/env bash
    set -euo pipefail
    mkdir -p "{{man1dir}}"
    for source in {{man_sources}}; do
        name=$(basename "${source%.md}")
        install -m 0644 "build/man/$name" "{{man1dir}}/$name"
        echo "Installed $name -> {{man1dir}}/$name"
    done

# Build all man pages from Markdown sources
man: _check-pandoc
    #!/usr/bin/env bash
    set -euo pipefail
    mkdir -p build/man
    for source in {{man_sources}}; do
        name=$(basename "${source%.md}")
        "{{pandoc}}" --standalone --to man "$source" -o "build/man/$name"
        echo "Built build/man/$name"
    done

# Uninstall all scripts and man pages
uninstall: uninstall-scripts uninstall-man

# Uninstall utility scripts
uninstall-scripts:
    #!/usr/bin/env bash
    set -euo pipefail
    for script in {{scripts}}; do
        name=$(basename "$script")
        rm -f "{{bindir}}/$name"
        echo "Removed {{bindir}}/$name"
    done

# Uninstall man pages
uninstall-man:
    #!/usr/bin/env bash
    set -euo pipefail
    for source in {{man_sources}}; do
        name=$(basename "${source%.md}")
        rm -f "{{man1dir}}/$name"
        echo "Removed {{man1dir}}/$name"
    done

# List all scripts in the repository
list:
    #!/usr/bin/env bash
    set -euo pipefail
    for script in {{scripts}}; do
        echo "$script"
    done

# Clean generated man page build artifacts
clean-man:
    rm -rf build/man

# Verify if pandoc is installed
_check-pandoc:
    @command -v "{{pandoc}}" >/dev/null 2>&1 || { \
        echo "pandoc is required to build man pages" >&2; \
        exit 1; \
    }

SHELL := /usr/bin/env bash

PREFIX ?= $(HOME)/.local
BINDIR ?= $(PREFIX)/bin
XDG_DATA_HOME ?= $(HOME)/.local/share
MANDIR ?= $(XDG_DATA_HOME)/man
MAN1DIR ?= $(MANDIR)/man1
PANDOC ?= pandoc

SCRIPTS := \
	general/mktlapse \
	general/selfcert \
	general/strip-ext \
	qemu/vmctl

MAN_SOURCES := \
	man/mktlapse.1.md \
	man/selfcert.1.md \
	man/strip-ext.1.md \
	man/vmctl.1.md

MAN_PAGES := $(patsubst man/%.md,build/man/%,$(MAN_SOURCES))

.PHONY: install install-scripts install-man uninstall uninstall-man list man clean-man check-pandoc

install: install-scripts install-man

install-scripts:
	@mkdir -p "$(BINDIR)"
	@for script in $(SCRIPTS); do \
		name="$$(basename "$$script")"; \
		install -m 0755 "$$script" "$(BINDIR)/$$name"; \
		echo "Installed $$name -> $(BINDIR)/$$name"; \
	done

install-man: $(MAN_PAGES)
	@mkdir -p "$(MAN1DIR)"
	@for page in $(MAN_PAGES); do \
		name="$$(basename "$$page")"; \
		install -m 0644 "$$page" "$(MAN1DIR)/$$name"; \
		echo "Installed $$name -> $(MAN1DIR)/$$name"; \
	done

uninstall: uninstall-man
	@for script in $(SCRIPTS); do \
		name="$$(basename "$$script")"; \
		rm -f "$(BINDIR)/$$name"; \
		echo "Removed $(BINDIR)/$$name"; \
	done

uninstall-man:
	@for source in $(MAN_SOURCES); do \
		name="$$(basename "$${source%.md}")"; \
		rm -f "$(MAN1DIR)/$$name"; \
		echo "Removed $(MAN1DIR)/$$name"; \
	done

list:
	@printf '%s\n' $(SCRIPTS)

man: $(MAN_PAGES)

clean-man:
	@rm -rf build/man

check-pandoc:
	@command -v "$(PANDOC)" >/dev/null 2>&1 || { \
		echo "pandoc is required to build man pages" >&2; \
		exit 1; \
	}

build/man:
	@mkdir -p "$@"

build/man/%: man/%.md | build/man check-pandoc
	@$(PANDOC) --standalone --to man "$<" -o "$@"

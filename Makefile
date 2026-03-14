.PHONY: help install install-nvim install-tmux clean uninstall check-nvim check-tmux

# Get current directory path
NVIM_REPO := $(shell pwd)
NVIM_CONFIG := $(HOME)/.config/nvim
TMUX_CONFIG := $(HOME)/.tmux.conf

help:
	@echo "╔════════════════════════════════════════╗"
	@echo "║       Nvim & Tmux Setup Makefile       ║"
	@echo "╚════════════════════════════════════════╝"
	@echo ""
	@echo "Available targets:"
	@echo "  make install       - Install nvim and tmux"
	@echo "  make install-nvim  - Install nvim only"
	@echo "  make install-tmux  - Install tmux only"
	@echo "  make uninstall     - Uninstall nvim and tmux configuration"
	@echo "  make clean         - Clean temporary files"
	@echo ""

install: install-nvim install-tmux
	@echo "✅ Setup completed! nvim and tmux configuration installed"

install-nvim: check-nvim
	@echo "📦 Installing nvim configuration..."
	@if [ "$(NVIM_REPO)" = "$(NVIM_CONFIG)" ]; then \
		echo "✅ Already running from $(NVIM_CONFIG), nothing to do"; \
	elif [ -L "$(NVIM_CONFIG)" ]; then \
		echo "⚠️  Removing existing symlink at $(NVIM_CONFIG)"; \
		rm "$(NVIM_CONFIG)"; \
		ln -s "$(NVIM_REPO)" "$(NVIM_CONFIG)"; \
		echo "✅ Symlink updated: $(NVIM_CONFIG) -> $(NVIM_REPO)"; \
	elif [ -d "$(NVIM_CONFIG)" ]; then \
		echo "⚠️  $(NVIM_CONFIG) exists, backed up to $(NVIM_CONFIG).bak"; \
		mv "$(NVIM_CONFIG)" "$(NVIM_CONFIG).bak"; \
		ln -s "$(NVIM_REPO)" "$(NVIM_CONFIG)"; \
		echo "✅ Symlink created: $(NVIM_CONFIG) -> $(NVIM_REPO)"; \
	elif [ -e "$(NVIM_CONFIG)" ]; then \
		echo "⚠️  $(NVIM_CONFIG) is a file, backed up to $(NVIM_CONFIG).bak"; \
		mv "$(NVIM_CONFIG)" "$(NVIM_CONFIG).bak"; \
		ln -s "$(NVIM_REPO)" "$(NVIM_CONFIG)"; \
		echo "✅ Symlink created: $(NVIM_CONFIG) -> $(NVIM_REPO)"; \
	else \
		mkdir -p "$(HOME)/.config"; \
		ln -s "$(NVIM_REPO)" "$(NVIM_CONFIG)"; \
		echo "✅ Symlink created: $(NVIM_CONFIG) -> $(NVIM_REPO)"; \
	fi
	@echo ""

install-tmux: check-tmux
	@echo "📦 Installing tmux configuration..."
	@if [ -L "$(TMUX_CONFIG)" ]; then \
		echo "⚠️  Removing existing symlink at $(TMUX_CONFIG)"; \
		rm "$(TMUX_CONFIG)"; \
	elif [ -e "$(TMUX_CONFIG)" ]; then \
		echo "⚠️  $(TMUX_CONFIG) exists, backed up to $(TMUX_CONFIG).bak"; \
		mv "$(TMUX_CONFIG)" "$(TMUX_CONFIG).bak"; \
	fi
	@ln -s "$(NVIM_REPO)/rcfiles/tmux.conf" "$(TMUX_CONFIG)"
	@echo "✅ Symlink created: $(TMUX_CONFIG) -> $(NVIM_REPO)/rcfiles/tmux.conf"
	@echo ""

check-nvim:
	@if ! command -v nvim > /dev/null 2>&1; then \
		echo "❌ Error: nvim not installed"; \
		echo "Please install neovim first: https://github.com/neovim/neovim"; \
		exit 1; \
	else \
		echo "✅ nvim detected: $$(nvim --version | head -1)"; \
	fi

check-tmux:
	@if ! command -v tmux > /dev/null 2>&1; then \
		echo "❌ Error: tmux not installed"; \
		echo "Install via: brew install tmux  (macOS) or  apt install tmux  (Linux)"; \
		exit 1; \
	else \
		echo "✅ tmux detected: $$(tmux -V)"; \
	fi

uninstall:
	@echo "🗑️  Uninstalling nvim and tmux configuration..."
	@if [ -L "$(NVIM_CONFIG)" ]; then \
		rm "$(NVIM_CONFIG)"; \
		echo "✅ nvim symlink removed"; \
	elif [ -d "$(NVIM_CONFIG)" ]; then \
		echo "⚠️  $(NVIM_CONFIG) is a real directory, not a symlink — skipping to avoid data loss"; \
		echo "   Remove manually if intended: rm -rf $(NVIM_CONFIG)"; \
	fi
	@if [ -L "$(TMUX_CONFIG)" ]; then \
		rm "$(TMUX_CONFIG)"; \
		echo "✅ tmux symlink removed"; \
	elif [ -f "$(TMUX_CONFIG)" ]; then \
		echo "⚠️  $(TMUX_CONFIG) is a real file, not a symlink — skipping to avoid data loss"; \
		echo "   Remove manually if intended: rm $(TMUX_CONFIG)"; \
	fi
	@echo ""

clean:
	@echo "🧹 Cleaning temporary files..."
	@find "$(NVIM_REPO)" -name "*.swp" -delete
	@find "$(NVIM_REPO)" -name "*.swo" -delete
	@find "$(NVIM_REPO)" -name ".DS_Store" -delete
	@echo "✅ Clean completed"
	@echo ""

.DEFAULT_GOAL := help

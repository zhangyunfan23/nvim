.PHONY: help install install-nvim install-tmux clean uninstall

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
	@mkdir -p $(NVIM_CONFIG)
	@if [ -e $(NVIM_CONFIG) ] && [ ! -d $(NVIM_CONFIG) ]; then \
		echo "⚠️  $(NVIM_CONFIG) is a file, backed up to $(NVIM_CONFIG).bak"; \
		mv $(NVIM_CONFIG) $(NVIM_CONFIG).bak; \
	elif [ -d $(NVIM_CONFIG) ]; then \
		echo "⚠️  $(NVIM_CONFIG) exists, backed up to $(NVIM_CONFIG).bak"; \
		mv $(NVIM_CONFIG) $(NVIM_CONFIG).bak; \
	fi
	@cp -r $(NVIM_REPO) $(NVIM_CONFIG)
	@echo "✅ nvim configuration installed to $(NVIM_CONFIG)"
	@echo ""

install-tmux:
	@echo "📦 Installing tmux configuration..."
	@if [ -e $(TMUX_CONFIG) ]; then \
		echo "⚠️  $(TMUX_CONFIG) exists, backed up to $(TMUX_CONFIG).bak"; \
		mv $(TMUX_CONFIG) $(TMUX_CONFIG).bak; \
	fi
	@cp $(NVIM_REPO)/rcfiles/tmux.conf $(TMUX_CONFIG)
	@echo "✅ tmux configuration installed to $(TMUX_CONFIG)"
	@echo ""

check-nvim:
	@if ! command -v nvim &> /dev/null; then \
		echo "❌ Error: nvim not installed"; \
		echo "Please install neovim first: https://github.com/neovim/neovim"; \
		exit 1; \
	else \
		echo "✅ nvim detected"; \
	fi

uninstall:
	@echo "🗑️  Uninstalling nvim and tmux configuration..."
	@if [ -d $(NVIM_CONFIG) ]; then \
		rm -rf $(NVIM_CONFIG); \
		echo "✅ nvim configuration removed"; \
	fi
	@if [ -f $(TMUX_CONFIG) ]; then \
		rm $(TMUX_CONFIG); \
		echo "✅ tmux configuration removed"; \
	fi
	@echo ""

clean:
	@echo "🧹 Cleaning temporary files..."
	@find $(NVIM_REPO) -name "*.swp" -delete
	@find $(NVIM_REPO) -name "*.swo" -delete
	@find $(NVIM_REPO) -name ".DS_Store" -delete
	@echo "✅ Clean completed"
	@echo ""

.DEFAULT_GOAL := help

.PHONY: help install install-nvim install-tmux clean uninstall

# 获取当前目录路径
NVIM_REPO := $(shell pwd)
NVIM_CONFIG := $(HOME)/.config/nvim
TMUX_CONFIG := $(HOME)/.tmux.conf

help:
	@echo "╔════════════════════════════════════════╗"
	@echo "║       Nvim & Tmux Setup Makefile       ║"
	@echo "╚════════════════════════════════════════╝"
	@echo ""
	@echo "Available targets:"
	@echo "  make install       - 一键安装nvim和tmux"
	@echo "  make install-nvim  - 仅安装nvim"
	@echo "  make install-tmux  - 仅安装tmux"
	@echo "  make uninstall     - 卸载nvim和tmux配置"
	@echo "  make clean         - 清理临时文件"
	@echo ""

install: install-nvim install-tmux
	@echo "✅ Setup完成！nvim和tmux配置已安装"

install-nvim: check-nvim
	@echo "📦 正在安装nvim配置..."
	@mkdir -p $(NVIM_CONFIG)
	@if [ -L $(NVIM_CONFIG) ] && [ "$(shell readlink $(NVIM_CONFIG))" = "$(NVIM_REPO)" ]; then \
		echo "✅ nvim配置已经符号链接"; \
	elif [ -e $(NVIM_CONFIG) ]; then \
		echo "⚠️  $(NVIM_CONFIG) 已存在，备份为 $(NVIM_CONFIG).bak"; \
		mv $(NVIM_CONFIG) $(NVIM_CONFIG).bak; \
		ln -s $(NVIM_REPO) $(NVIM_CONFIG); \
		echo "✅ nvim配置已安装"; \
	else \
		ln -s $(NVIM_REPO) $(NVIM_CONFIG); \
		echo "✅ nvim配置已安装"; \
	fi
	@echo ""

install-tmux:
	@echo "📦 正在安装tmux配置..."
	@mkdir -p $(HOME)
	@if [ -L $(TMUX_CONFIG) ] && [ "$(shell readlink $(TMUX_CONFIG))" = "$(NVIM_REPO)/rcfiles/tmux.conf" ]; then \
		echo "✅ tmux配置已经符号链接"; \
	elif [ -e $(TMUX_CONFIG) ]; then \
		echo "⚠️  $(TMUX_CONFIG) 已存在，备份为 $(TMUX_CONFIG).bak"; \
		mv $(TMUX_CONFIG) $(TMUX_CONFIG).bak; \
		ln -s $(NVIM_REPO)/rcfiles/tmux.conf $(TMUX_CONFIG); \
		echo "✅ tmux配置已安装"; \
	else \
		ln -s $(NVIM_REPO)/rcfiles/tmux.conf $(TMUX_CONFIG); \
		echo "✅ tmux配置已安装"; \
	fi
	@echo ""

check-nvim:
	@if ! command -v nvim &> /dev/null; then \
		echo "❌ 错误: nvim未安装"; \
		echo "请先安装neovim: https://github.com/neovim/neovim"; \
		exit 1; \
	else \
		echo "✅ 已检测到nvim"; \
	fi

uninstall:
	@echo "🗑️  卸载nvim和tmux配置..."
	@if [ -L $(NVIM_CONFIG) ]; then \
		rm $(NVIM_CONFIG); \
		echo "✅ 已移除nvim配置链接"; \
	fi
	@if [ -L $(TMUX_CONFIG) ]; then \
		rm $(TMUX_CONFIG); \
		echo "✅ 已移除tmux配置链接"; \
	fi
	@echo ""

clean:
	@echo "🧹 清理临时文件..."
	@find $(NVIM_REPO) -name "*.swp" -delete
	@find $(NVIM_REPO) -name "*.swo" -delete
	@find $(NVIM_REPO) -name ".DS_Store" -delete
	@echo "✅ 清理完成"
	@echo ""

.DEFAULT_GOAL := help

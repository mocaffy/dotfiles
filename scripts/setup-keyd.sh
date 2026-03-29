#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

sudo ln -sf "$DOTFILES_DIR/.config/keyd/default.conf" /etc/keyd/default.conf
sudo systemctl reload-or-restart keyd

#!/usr/bin/env bash
set -e

# ─── Paths ─────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
SOURCE_DIR="/etc/nixos"

# ─── Sudo check ────────────────────────────────────────
if [ "$EUID" -ne 0 ]; then
    echo "🔐 Sudo required. Prompting..."
    exec sudo "$0" "$@"
fi

echo "📁 Backing up /etc/nixos into $REPO_DIR..."

# ─── Copy everything ───────────────────────────────────
rsync -av --delete "$SOURCE_DIR/" "$REPO_DIR/"

# ─── Fix ownership for user ────────────────────────────
chown -R "$SUDO_USER:users" "$REPO_DIR"

# ─── Git commit & push ─────────────────────────────────
cd "$REPO_DIR"
DATE=$(date "+%Y-%m-%d %H:%M")
git add .
git commit -m "🛡 Backup from /etc/nixos — $DATE"
git push

echo "✅ Backup complete and pushed to GitHub!"

#!/usr/bin/env bash
set -euo pipefail

# ─── Auto-sudo ─────────────────────────────────────────
if [[ $EUID -ne 0 ]]; then
    echo "🔐 Sudo required. Re-running as root..."
    exec sudo "$0" "$@"
fi

# ─── Directories ───────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$SCRIPT_DIR"
SOURCE_DIR="/etc/nixos"

# ─── Rsync (mirror files, preserve structure) ─────────
echo "📁 Syncing /etc/nixos → $REPO_DIR"
rsync -av --delete \
    --exclude=".git" \
    --exclude="README.md" \
    --exclude="install.sh" \
    --exclude="backup.sh" \
    "$SOURCE_DIR/" "$REPO_DIR/"

# ─── Fix ownership (for git push) ─────────────────────
chown -R "$SUDO_USER:users" "$REPO_DIR"

# ─── Git commit as original user ──────────────────────
sudo -u "$SUDO_USER" bash <<'EOF'
cd "$REPO_DIR"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M")
git add .
git commit -m "🛡 NixOS backup from /etc/nixos — $TIMESTAMP"
git push
EOF

echo "✅ Backup complete and synced with GitHub!"

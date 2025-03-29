#!/usr/bin/env bash
set -e

# ───────────────
# 🔐 Keep sudo alive
# ───────────────
echo "🧠 Starting NixOS flake bootstrap..."
echo "🔐 Please enter your sudo password:"
sudo -v
while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done 2>/dev/null &

# ───────────────
# ⚙️ Handle flags
# ───────────────
force=0
if [[ "$1" == "--force" ]]; then
    force=1
    echo "⚠️  Force mode enabled: existing /etc/nixos will be overwritten if needed."
fi

# ───────────────
# 🧠 Detect flakes support
# ───────────────
if ! nix show-config | grep -q "experimental-features.*flakes"; then
    echo "[+] Flakes not enabled — injecting into /etc/nixos/configuration.nix..."

    sudo tee -a /etc/nixos/configuration.nix >/dev/null <<'EOF'

# Added by flake bootstrap
{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
EOF

    echo "[+] Rebuilding to enable flakes..."
    sudo nixos-rebuild switch
fi

# ───────────────
# 🌐 Choose install source
# ───────────────
echo
echo "🌐 Choose install source:"
echo "  [1] GitHub (remote flake)"
echo "  [2] Local repository (/etc/nixos)"
read -rp "Enter 1 or 2: " choice

# ───────────────
# 💻 Choose hostname (flake target)
# ───────────────
echo
echo "💻 Choose target system:"
echo "  [1] blade"
echo "  [2] vm"
read -rp "Enter 1 or 2: " host_choice

case "$host_choice" in
1) host="blade" ;;
2) host="vm" ;;
*)
    echo "❌ Invalid choice. Please enter 1 or 2."
    exit 1
    ;;
esac

# ───────────────
# 🚀 Run install
# ───────────────
if [[ "$choice" == "1" ]]; then
    echo "[+] Using remote flake: github:lizardkingdev/nixos-config#$host"
    sudo nixos-rebuild switch --flake github:lizardkingdev/nixos-config#"$host"

else
    if [[ "$force" == "1" ]]; then
        echo "[!] Force mode: removing existing /etc/nixos and re-cloning..."
        sudo rm -rf /etc/nixos
        sudo git clone https://github.com/lizardkingdev/nixos-config /etc/nixos
    elif [ ! -d /etc/nixos/.git ]; then
        echo "[+] /etc/nixos is not a Git repo. Cloning your config..."
        sudo rm -rf /etc/nixos
        sudo git clone https://github.com/lizardkingdev/nixos-config /etc/nixos
    fi

    cd /etc/nixos
    echo "[+] Rebuilding from local flake config..."
    sudo nixos-rebuild switch --flake .#"$host"
fi

# ───────────────
# ✅ Done!
# ───────────────
echo "✅ System is now running your flake config for host '$host'"

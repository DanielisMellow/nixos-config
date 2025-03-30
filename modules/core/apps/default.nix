# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  imports = [
    ./browser.nix
    ./discord.nix
    ./github-cli.nix
    ./media_player.nix
    ./neovim.nix
    ./nordvpn.nix
    ./obsidian.nix
    ./terminal-cli.nix
    ./terminals.nix

  ];
}

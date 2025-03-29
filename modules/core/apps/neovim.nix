{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    vimPlugins.telescope-fzf-native-nvim
    tree-sitter
    imagemagick
    gcc
    gnumake
    pkg-config
    lua
    luarocks
    lua-language-server
    nil
    nixpkgs-fmt
    cargo
    nodejs
    stylua
    shfmt
    fish
    ruff
    isort
    pyright
    python312Packages.jedi-language-server
    pylint
    mypy

  ];
  environment.variables = {
    EDITOR = "nvim";
  };
}

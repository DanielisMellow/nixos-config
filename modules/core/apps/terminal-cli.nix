{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neofetch
    fastfetch
    cowsay
    cmatrix
    btop
    tmux
    viu
    chafa
    tldr
    # tools
    git
    tree
    fzf
    lazygit
    fd
    ripgrep
    unzip
    curl
    ffmpeg
    jq
    yad
    ncdu
    rsync
  ];
}

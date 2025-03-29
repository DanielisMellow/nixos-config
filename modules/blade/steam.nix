# steam.nix
{ config, pkgs, ... }:

{
  ##############################
  # Steam + Gaming Essentials #
  ##############################
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Allow Steam Remote Play
    dedicatedServer.openFirewall = false; # You can toggle this if hosting servers
  };

  ##############################
  # NVIDIA GPU Optimizations  #
  ##############################
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
    nvidiaPersistenced = true;
    open = false; # Optional: use open kernel module if desired
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  ##############################
  # OpenGL + Vulkan Support   #
  ##############################
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ libvdpau vaapiVdpau ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ libvdpau vaapiVdpau ];
  };

  ##############################
  # GameMode & Utilities      #
  ##############################
  environment.systemPackages = with pkgs; [
    gamemode # Boosts game performance
    mangohud # In-game HUD for stats
    protonup-qt # Install/manage Proton-GE
    lutris # For non-Steam games
    wineWowPackages.stable # For running Windows games
    winetricks # For tweaking Wine prefixes
  ];

  # Optional: Enable MangoHud globally (can also be toggled per-game)
  environment.variables = {
    MANGOHUD = "1";
  };
}

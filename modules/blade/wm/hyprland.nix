{ config, pkgs, ... }:

{
  # Enable Hyprland window manager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Environment variables
  environment.sessionVariables = {
    # Fixes invisible cursor with NVIDIA
    WLR_NO_HARDWARE_CURSORS = "1";

    # Required for some Electron/Chromium apps
    NIXOS_OZONE_WL = "1";

    # NVIDIA-specific: ensures correct OpenGL vendor
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  # Enable graphics stack (OpenGL, etc.)
  hardware.graphics.enable = true;

  # NVIDIA driver setup
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;        # Required for Wayland
    powerManagement.enable = true;    # Optional: allows power saving
    open = false;                     # Keep false for RTX 3070 (proprietary driver is better)
    nvidiaSettings = true;            # Enables `nvidia-settings` GUI
  };
}


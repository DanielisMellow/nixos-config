{ pkgs, ... }:
{

  # Use PipeWire instead of PulseAudio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;  # Optional, only if you need JACK
  };

  # For hardware volume keys and mixers
  hardware.pulseaudio.enable = false;

  # Firmware for some sound chips
  hardware.enableAllFirmware = true;




  environment.systemPackages = with pkgs; [
    pamixer
    pavucontrol
  ];
}

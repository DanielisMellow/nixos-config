
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

  # Terminal 
  alacritty
  kitty
  ];
}

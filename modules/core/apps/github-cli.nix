{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gh
  ];


}

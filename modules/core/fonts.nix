
{ config, pkgs, ... }:

{
fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    jetbrains-mono
    font-awesome
	terminus_font
    powerline-fonts

    (nerdfonts.override { fonts = ["Hack" "JetBrainsMono"]; })
 	];

}

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    twemoji-color-font
  ];
  fonts = {
    packages = with pkgs; [
      wqy_zenhei
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "Hack" "JetBrainsMono" "Iosevka" "IosevkaTerm" "NerdFontsSymbolsOnly" "DaddyTimeMono" ]; })
      twemoji-color-font
    ];
  };
}

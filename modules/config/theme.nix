{ config, pkgs, lib, ... }:
{
  options = {
    theme.enable = 
      lib.mkEnableOption "enables theme";
  };
  config = lib.mkIf config.theme.enable {
    environment.systemPackages = with pkgs; [
    bibata-cursors
    gruvbox-gtk-theme
    gruvbox-plus-icons
    ];
  programs.fish.interactiveShellInit = ''
  set fish_greeting
  fastfetch
  '';
  stylix = {
    enable =true;
    base16Scheme = {
      base00 = "#282828";
      base01 = "#3c3836";
      base02 = "#504945";
      base03 = "#665c54";
      base04 = "#928374";
      base05 = "#ebdbb2";
      base06 = "#fbf1c7";
      base07 = "#f9f5d7";
      base08 = "#cc241d";
      base09 = "#d65d0e";
      base0A = "#d79921";
      base0B = "#98971a";
      base0C = "#689d6a";
      base0D = "#458588";
      base0E = "#b16286";
      base0F = "#9d0006";
    };
    # cursor = {
    #   package = pkgs.bibata-cursors;
    #   name = "Bibata-Modern-Classic";
    # };
    # fonts = {
    #   monospace ={
    #     package = JetBrainsMono;
    #     name = "JetBrainsMono Nerd Font Mono";
    #   };
    #   sansSerif = {
    #     package = JetBrainsMono;
    #     name = "JetBrainsMono Nerd Font";
    #   };
    #   serif = {
    #     package = JetBrainsMono;
    #     name = "JetBrainsMono Nerd Font";
    #   };
    # };
    opacity = {
      applications = 1.0;
      desktop = 1.0;
      popups = 1.0;
      terminal = 0.7;
    };
    polarity = "dark";
    targets = {
      grub.enable = false;
      plymouth.enable = false;
      # firefox.profileNames = ["default"];
    };
  };
    distro-grub-themes = {
        enable = true;
        theme = "nixos";
    };
    boot.plymouth = {
      enable = true;
      theme = "deus_ex";
      themePackages = with pkgs; [
          # By default we would install all themes
          (adi1090x-plymouth-themes.override {
          selected_themes = [ "deus_ex" ];
          })
      ];
    };
    fonts = {
      packages = with pkgs; [
        dejavu_fonts
        nerd-fonts.jetbrains-mono
        beedii
        noto-fonts-monochrome-emoji
        vazir-fonts
        shabnam-fonts
      ];
    
      # fontconfig = {
      #   enable = true;
      #   defaultFonts = {
      #     serif = [ "DejaVu Serif" ];
      #     sansSerif = [ "DejaVu Sans" ];
      #     monospace = [ "JetBrains Mono Nerd Font" ];
      #     emoji = [ "Noto Emoji" ];
      #     # emoji = [ "Beedii" "Noto Emoji" ];
      #   };
      # };
      # Enable font discovery for applications
      fontDir.enable = true;
    };
  };
}
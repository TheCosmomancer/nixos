{ config, pkgs, lib, ... }:
{
  options = {
    theme.enable = 
      lib.mkEnableOption "enables theme";
  };
  config = lib.mkIf config.theme.enable {
    environment.systemPackages = with pkgs; [
    bibata-cursors
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    gruvbox-kvantum
    rose-pine-kvantum
    gruvbox-gtk-theme
    gruvbox-plus-icons
    ];
    environment.sessionVariables = {
      QT_STYLE_OVERRIDE = "kvantum";
    };
    boot.loader = {
            systemd-boot.enable = false;
            efi.canTouchEfiVariables = true;
            grub = {
                efiSupport = true;
                enable = true;
                useOSProber = true;
                device = "nodev";
            };
        };
    distro-grub-themes = {
        enable = true;
        theme = "nixos";
    };
    boot = {
            plymouth = {
                enable = true;
                theme = "deus_ex";
                themePackages = with pkgs; [
                    # By default we would install all themes
                    (adi1090x-plymouth-themes.override {
                    selected_themes = [ "deus_ex" ];
                    })
                ];
            };

            # Enable "Silent boot"
            consoleLogLevel = 3;
            initrd.verbose = false;
            kernelParams = [
                "quiet"
                "splash"
                "boot.shell_on_fail"
                "udev.log_priority=3"
                "rd.systemd.show_status=auto"
            ];
            # Hide the OS choice for bootloaders.
            # It's still possible to open the bootloader list by pressing any key
            # It will just not appear on screen unless a key is pressed
            loader.timeout = 5;
        };
      # environment.cosmic.excludePackages = [];
      services.displayManager = {
        cosmic-greeter.enable = true;
      # autoLogin = {
      #   enable = true;
      #   user = "cosmomancer";
      # };
      # sddm = {
      #   enable = true;
      #   wayland.enable = true;
      #   autoNumlock = true;
      #   # autoLogin.relogin = true;
      # };
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
      fontconfig = {
        enable = true;
        defaultFonts = {
          serif = [ "DejaVu Serif" ];
          sansSerif = [ "DejaVu Sans" ];
          monospace = [ "JetBrains Mono Nerd Font" ];
          emoji = [ "Noto Emoji" ];
          # emoji = [ "Beedii" "Noto Emoji" ];
        };
      };
      # Enable font discovery for applications
      fontDir.enable = true;
    };
  };
}
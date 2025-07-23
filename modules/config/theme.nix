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
        theme = "hp-victus";
    };
    boot = {
            plymouth = {
                enable = true;
                theme = "owl";
                themePackages = with pkgs; [
                    # By default we would install all themes
                    (adi1090x-plymouth-themes.override {
                    selected_themes = [ "owl" ];
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
      services.displayManager = {
      autoLogin = {
        enable = true;
        user = "cosmomancer";
      };
      sddm = {
        enable = true;
        package = pkgs.libsForQt5.sddm;
        wayland.enable = true;
        autoNumlock = true;
        autoLogin.relogin = true;
        # sugarCandyNix = {
        #   enable = true;
        #   settings = {
        #     Background = /etc/nixos/media/astronautgarden.png;
        #     ScreenWidth = 1920;
        #     ScreenHeight = 1080;
        #     FormPosition = "left";
        #     MainColor = "white";
        #     AccentColor = "black";
        #     # OverrideLoginButtonTextColor = "";
        #     HeaderText = "";
        #     DateFormat = "dddd, MMMM d, yyyy";
        #   };
        # };
      };
    };
  };
}
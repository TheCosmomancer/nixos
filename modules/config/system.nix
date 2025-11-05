{ config, pkgs, lib, ... }:
{
  options = {
    system.enable = 
      lib.mkEnableOption "enables system";
  };
  config = lib.mkIf config.system.enable {
    networking.networkmanager.enable = true;
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
    services.thermald.enable = true;
    time.timeZone = "Asia/Tehran";
    i18n.defaultLocale = "en_US.UTF-8";
    services.printing.enable = true;
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    environment.systemPackages = with pkgs;[
      bash
    ];
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = false;
      # use the example session manager (no others are packaged yet so this is enabled by default,no need to redefine it in your config for now)
      #media-session.enable = true;
    };
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = ["nix-command" "flakes"];
    boot= {
      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
      ];
      loader = {
            systemd-boot.enable = false;
            efi.canTouchEfiVariables = true;
            timeout = 5;
            grub = {
                efiSupport = true;
                enable = true;
                useOSProber = true;
                device = "nodev";
            };
        };
    };
    programs.nh = {
      enable = true;
      clean= {
        enable = true;
        extraArgs = "--keep 5";
        dates = "weekly";
      };
      flake = "/etc/nixos/";
    };
  };
}
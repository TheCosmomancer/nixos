{ config, pkgs, lib, ... }:
{
  options = {
    sysman.enable = 
      lib.mkEnableOption "enables sysman";
  };
  config = lib.mkIf config.sysman.enable {
    networking.networkmanager.enable = true;
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
    services.thermald.enable = true;
    services.gnome.gnome-keyring.enable = true;
    environment.systemPackages = with pkgs; [
      lm_sensors
      btop
      wireplumber
      libgtop
      networkmanagerapplet
      dart-sass
      wl-clipboard
      brightnessctl
      #bluez
    ];
    time.timeZone = "Asia/Tehran";
    i18n.defaultLocale = "en_US.UTF-8";
    services.printing.enable = true;
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      # use the example session manager (no others are packaged yet so this is enabled by default,no need to redefine it in your config for now)
      #media-session.enable = true;
    };
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = ["nix-command" "flakes"];
  };
}
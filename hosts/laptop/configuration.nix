{ config, pkgs, inputs, ... }:

{
  #nerd-fonts.jetbrains-mono MAKE SURE to manually install
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/default.nix
      inputs.home-manager.nixosModules.default
    ];

  networking.hostName = "laptop";

  # Enable touchpad support
  services.libinput.enable = true;
  lid.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cosmomancer = {
    isNormalUser = true;
    description = "cosmomancer";
    extraGroups = [ "networkmanager" "wheel" "input" ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  users.extraGroups.vboxusers.members = [ "cosmomancer" ];
  security.sudo.extraRules = [
  {
    users = [ "cosmomancer" ];
    commands = [
      {
        command = "ALL";
        options = [ "SETENV" "NOPASSWD" ];
      }
    ];
  }
];


  home-manager = {
    extraSpecialArgs = {inherit inputs; };
    users = {
      "cosmomancer" = import ./home.nix;
    };

  backupFileExtension = "backup";
  };
  #just don't change this and you'll be fine
  system.stateVersion = "24.11";
}

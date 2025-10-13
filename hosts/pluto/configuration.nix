{ config, pkgs, inputs, ... }:

{
  #nerd-fonts.jetbrains-mono MAKE SURE to manually install
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/config/default.nix
      inputs.home-manager.nixosModules.default
    ];

  networking.hostName = "pluto";


  laptop.enable = true;
  nvidia.enable = true;
  theme.enable = true;
  fun.enable = true;
  hypr.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cosmomancer = {
    isNormalUser = true;
    description = "cosmomancer";
    extraGroups = [ "networkmanager" "wheel" "input" ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  security.sudo.extraRules = [{
    users = [ "cosmomancer" ];
    commands = [
      {
        command = "ALL";
        options = [ "SETENV" "NOPASSWD" ];
      }
    ];
    
  }];
  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs; };
    users = {
      "cosmomancer" ={
        home.username = "cosmomancer";
        home.homeDirectory = "/home/cosmomancer";
        nixpkgs.config.allowUnfree = true;
        # Let Home Manager install and manage itself.
        programs.home-manager.enable = true;
        imports = [../../modules/hm];
        #just don't change this and you'll be fine
        home.stateVersion = "24.11";
      };
    };
  };
  #just don't change this and you'll be fine
  system.stateVersion = "24.11";
}
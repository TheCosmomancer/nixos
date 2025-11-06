{ config, pkgs, inputs, ... }:

{
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
    extraGroups = [ "networkmanager" "wheel" "input" "libvirtd"];
    shell = pkgs.fish;
  };
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza --git -F --color-scale --icons --group-directories-first";
      lsa = "eza --git -F -a --color-scale --icons --group-directories-first";
      vibegit = "git add -A && git commit -m \".\" && git push";
      pingg = "ping google.com";
      # mkcd = "command mkdir -p \\$argv[1] && cd \\$argv[1]";
    };
  };
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
        imports = [./home.nix];
        #just don't change this and you'll be fine
        home.stateVersion = "24.11";
      };
    };
  };
  #just don't change this and you'll be fine
  system.stateVersion = "24.11";
}
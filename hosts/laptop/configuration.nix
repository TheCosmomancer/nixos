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
        imports = [
          ../../modules/hm/dotfiles.nix
          ../../modules/hm/firefox.nix
          ../../modules/hm/hypr.nix
          ../../modules/hm/theme.nix
          ../../modules/hm/vsc.nix
          ../../modules/hm/zsh.nix
          #../../modules/hm/
        ];
        #just don't change this and you'll be fine
        home.stateVersion = "24.11";
      };
    };
  };
  #just don't change this and you'll be fine
  system.stateVersion = "24.11";
}

# Home Manager needs a bit of information about you and the paths it should
  # manage.
  # The home.packages option allows you to install Nix packages into your
  # environment.
  # home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  # ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/cosmomancer/etc/profile.d/hm-session-vars.sh
  #
  # home.sessionVariables = {
    # EDITOR = "emacs";
  # };
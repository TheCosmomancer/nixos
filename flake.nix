{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darkmatter-grub-theme = {
      url = gitlab:VandalByte/darkmatter-grub-theme;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darkmatter-grub-theme, ... }@inputs: {
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video
    nixosConfigurations.cosmomancer = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        inputs.home-manager.nixosModules.default
        darkmatter-grub-theme.nixosModule
      ];
    };
  };
}

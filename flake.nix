{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    distro-grub-themes= {
      url = "github:AdisonCavani/distro-grub-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
    url = "github:nix-community/nixvim";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.pluto = nixpkgs.lib.nixosSystem { #laptop
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/pluto/configuration.nix
        inputs.distro-grub-themes.nixosModules.${"x86_64-linux"}.default
        inputs.home-manager.nixosModules.default
        inputs.nixvim.nixosModules.nixvim
      ];
    };
  };
}

{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    sddm-sugar-candy-nix = {
    url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/laptop/configuration.nix
        inputs.distro-grub-themes.nixosModules.${"x86_64-linux"}.default
        inputs.home-manager.nixosModules.default
        inputs.sddm-sugar-candy-nix.nixosModules.default
        {
          nixpkgs.overlays = [
            inputs.hyprpanel.overlay
            inputs.sddm-sugar-candy-nix.overlays.default
            ];
        }
      ];
    };
  };
}

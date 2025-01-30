{
  description = "NixOS config with flake and home-manager";

  outputs = { self, nixpkgs, home-manager, nixos-generators, ... }@inputs:
    let
      username = "nejern";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      # OS
      nixosConfigurations = {
        laptop =
          let
            hostname = "Nejern-laptop";
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs username hostname; };
            modules = [
              ./hosts/laptop/configuration.nix
              ./modules/os
            ];
          };
      };
      # Home
      homeConfigurations = {
        "${username}" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit username inputs; };
          modules = [
            ./users/nejern/home.nix
            ./modules/home
          ];
        };
      };
      # VM
      packages.x86_64-linux = {
        openstack-image = nixos-generators.nixosGenerate {
          system = "x86_64-linux";
          format = "openstack";
          modules = [
            ./hosts/openstack-image/configuration.nix
            ./modules/os
          ];
        };
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    custom-udev-rules = {
      url = "github:MalteT/custom-udev-rules";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

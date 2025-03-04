{
  description = "kriive thinkpad's configuration";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fish-nixpkgs = {
      url = "github:nixos/nixpkgs?ref=fish";
    };

    idapro = {
      url = "git+ssh://git@github.com/kriive/idapro.nix.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      fish-nixpkgs,
      home-manager,
      lanzaboote,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."pwn" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs;
        };

        modules = [ ./hosts/pwn/home.nix ];
      };

      nixosConfigurations = {
        thinkpad = nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = { inherit inputs self; };
          modules = [
            ./modules/common
            ./hosts/thinkpad
            lanzaboote.nixosModules.lanzaboote
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.kriive = import ./hosts/thinkpad/home.nix;
              home-manager.extraSpecialArgs = {
                inherit inputs;
              };
            }
          ];
        };
      };
    };
}

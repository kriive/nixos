{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    microvm = {
      url = "github:microvm-nix/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pwndbg = {
      url = "github:pwndbg/pwndbg";
    };

    go-librespot = {
      url = "github:kriive/go-librespot";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "github:quickshell-mirror/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-mineral = {
      url = "github:cynicsketch/nix-mineral";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    codex = {
      url = "github:sadjow/codex-cli-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    danksearch = {
      url = "github:AvengeMedia/danksearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      go-librespot,
      niri,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      mkSystem =
        modules:
        nixpkgs.lib.nixosSystem {
          inherit system modules;
          specialArgs = { inherit inputs; };
        };
      mkHost =
        hostName: hostPath: homePath:
        mkSystem [
          hostPath
          home-manager.nixosModules.home-manager
          go-librespot.nixosModules.default
          niri.nixosModules.niri
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kriive = homePath;
            home-manager.extraSpecialArgs = {
              inherit inputs hostName;
            };
          }
        ];
    in
    {
      nixosConfigurations = {
        t15 = mkHost "t15" ./hosts/t15 ./hm/hosts/t15;
        t14 = mkHost "t14" ./hosts/t14 ./hm/hosts/t14;
      };
    };
}

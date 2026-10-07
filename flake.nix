{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dank-greeter = {
      url = "github:AvengeMedia/dank-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    danksearch = {
      url = "github:AvengeMedia/danksearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pwntools-src = {
      url = "github:Gallopsled/pwntools/dev";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pwntoolsOverlay = import ./overlays/pwntools.nix { inherit (inputs) pwntools-src; };
      overlays = [ pwntoolsOverlay ];
      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };
      pwnPackages = import ./pkgs/pwn-tools.nix { inherit pkgs; };
      mkHost =
        hostName:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/${hostName}
            home-manager.nixosModules.home-manager
            {
              networking.hostName = hostName;
              nixpkgs.overlays = overlays;
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
              };
            }
          ];
        };
      hosts = {
        t14 = mkHost "t14";
        t15 = mkHost "t15";
      };
      pwnHome = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/pwnbox.nix ];
      };
    in
    {
      homeConfigurations.pwn = pwnHome;
      nixosConfigurations = hosts;
      overlays.default = pwntoolsOverlay;
      formatter.${system} = pkgs.nixfmt-tree;

      packages.${system} = {
        tx02-fonts = pkgs.callPackage ./pkgs/tx02-fonts.nix { };
        t14-kernel = hosts.t14.config.boot.kernelPackages.kernel;
      };

      checks.${system} = import ./checks {
        inherit pkgs;
        src = nixpkgs.lib.fileset.toSource {
          root = ./.;
          fileset = nixpkgs.lib.fileset.unions [
            ./statix.toml
            (nixpkgs.lib.fileset.fileFilter (file: file.hasExt "nix") ./.)
          ];
        };
        pwnActivation = pwnHome.activationPackage;
      };

      devShells.${system} = {
        default = pkgs.mkShell {
          packages = with pkgs; [
            nixfmt
            nil
            statix
            deadnix
            git
          ];
        };

        homelab = pkgs.mkShell {
          packages = with pkgs; [
            kubectl
            kubernetes-helm
            kustomize
            fluxcd
            talosctl
            sops
            age
            jq
            yq
          ];
        };

        pwn = pkgs.mkShell {
          packages = pwnPackages;
        };
      };
    };
}

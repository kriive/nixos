{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    tx02-fonts = {
      url = "path:/home/kriive/.local/share/private-fonts/tx-02";
      flake = false;
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

    multipass = {
      url = "github:kriive/multipass";
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

    pwntools-src = {
      url = "github:Gallopsled/pwntools/dev";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      go-librespot,
      niri,
      multipass,
      pwntools-src,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pwntoolsOverlay = final: prev: {
        pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
          (pyFinal: pyPrev: {
            pwntools = pyPrev.pwntools.overridePythonAttrs (old: {
              version = "dev";

              src = pwntools-src;

              meta = old.meta // {
                changelog = "https://github.com/Gallopsled/pwntools/commits/dev";
              };
            });
          })
        ];
      };
      overlays = [
        pwntoolsOverlay
      ];
      pkgs = import nixpkgs {
        inherit system overlays;
      };
      mkSystem =
        modules:
        nixpkgs.lib.nixosSystem {
          inherit system modules;
          specialArgs = { inherit inputs overlays; };
        };
      pwnPackages = import ./hm/profiles/pwn/packages.nix {
        inherit inputs pkgs;
      };
      mkHost =
        hostName: hostPath:
        mkSystem [
          {
            nixpkgs.overlays = overlays;
          }
          hostPath
          home-manager.nixosModules.home-manager
          go-librespot.nixosModules.default
          niri.nixosModules.niri
          {
            networking.hostName = hostName;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kriive = ./hm/hosts/common;
            home-manager.extraSpecialArgs = {
              inherit inputs hostName;
            };
          }
          multipass.nixosModules.multipass
        ];
    in
    {
      homeConfigurations = {
        pwn = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hm/profiles/pwn ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
      };

      nixosConfigurations = {
        t15 = mkHost "t15" ./hosts/t15/configuration.nix;
        t14 = mkHost "t14" ./hosts/t14/configuration.nix;
      };

      overlays.default = pwntoolsOverlay;

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

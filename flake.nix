{
  description = "Cryolitia's NixOS Flake";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      # "https://mirrors.cernet.edu.cn/nix-channels/store"
      "https://mirrors.bfsu.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
  };

  inputs = {

        # NixOS 官方软件源，这里使用 nixos-unstable 分支
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        # home-manager，用于管理用户配置
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nixos-hardware.url = github:NixOS/nixos-hardware/master;

        nur = {
          url = "github:nix-community/NUR";
          inputs.nixpkgs.follows = "nixpkgs";
        };

        nur-cryolitia = {
          url = "github:Cryolitia/nur-packages";
          inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

        vscode-server.url = "github:nix-community/nixos-vscode-server";

  };

  outputs = inputs@{
      self,
      nixpkgs,
      home-manager,
      nur,
      nur-cryolitia,
      nixos-hardware,
      nix-vscode-extensions,
      vscode-server,
      ...
  }: {
    nixosConfigurations = {
      Cryolitia-nixos = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
            inherit inputs;
        };

        modules = [

          ({
            nixpkgs.overlays = [
              (final: prev: {
                nur-cryolitia = inputs.nur-cryolitia.packages."${prev.system}";
              })
            ];
          })

          ./hosts/laptop
          ./overlays/python3Packages-tpm2-pytss.nix
          ./develop/no-gc

          nixos-hardware.nixosModules.common-hidpi
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc-laptop
          nixos-hardware.nixosModules.common-pc-laptop-ssd

          nur.nixosModules.nur

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = inputs;
            home-manager.users.cryolitia = import ./hosts/laptop/home.nix;

          }
          
        ];
      };
    };

    nixosConfigurations = {
      Cryolitia-surface = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
            inherit inputs;
        };

        modules = [

          ./hosts/surface
          ./overlays/python3Packages-tpm2-pytss.nix
          ./common/distribute.nix

          nur.nixosModules.nur

          nixos-hardware.nixosModules.microsoft-surface-go

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = inputs;
            home-manager.users.cryolitia = import ./hosts/surface/home.nix;
          }
          
        ];
      };
    };

    nixosConfigurations = {
      rpi-nixos = nixpkgs.lib.nixosSystem rec {
        system = "aarch64-linux";
        specialArgs = {
            inherit inputs;
        };

        modules = [

          ./hosts/rpi4
          ./common/distribute.nix

          vscode-server.nixosModules.default
          ({ config, pkgs, ... }: {
            services.vscode-server.enable = true;
          })

          nur.nixosModules.nur

          nixos-hardware.nixosModules.raspberry-pi-4

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = inputs;
            home-manager.users.cryolitia = import ./hosts/rpi4/home.nix;
          }
          
        ];
      };
    };

  };

}

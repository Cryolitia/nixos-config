{
  description = "Cryolitia's NixOS Flake";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://mirrors.cernet.edu.cn/nix-channels/store"
      # "https://mirrors.bfsu.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
    extra-substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://cryolitia.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://anyrun.cachix.org"
      "https://ezkea.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cryolitia.cachix.org-1:/RUeJIs3lEUX4X/oOco/eIcysKZEMxZNjqiMgXVItQ8="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
    ];
  };

  inputs =
    {
      # NixOS 官方软件源，这里使用 nixos-unstable 分支
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      #nixpkgs.url = "github:nixos/nixpkgs/58a1abdbae3217ca6b702f03d3b35125d88a2994";
      #nixpkgs.url = "github:Cryolitia/nixpkgs/13e6ece4709970e8f36f2713366ee9902e6ef137";

      # home-manager，用于管理用户配置
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nixos-hardware.url = "github:NixOS/nixos-hardware/master";
      # nixos-hardware.url = github:Cryolitia/nixos-hardware/gpd;

      nur.url = "github:nix-community/NUR";

      nur-cryolitia = {
        url = "github:Cryolitia/nur-packages";
        inputs = {
          nixpkgs.follows = "nixpkgs";
          rust-overlay.follows = "rust-overlay";
        };
      };

      nix-vscode-extensions = {
        url = "github:nix-community/nix-vscode-extensions";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      vscode-server = {
        url = "github:nix-community/nixos-vscode-server";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      anyrun = {
        url = "github:Kirottu/anyrun";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nixos-generators = {
        url = "github:nix-community/nixos-generators";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      rust-overlay = {
        url = "github:oxalica/rust-overlay";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      aagl = {
        url = "github:ezKEa/aagl-gtk-on-nix";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      jetbrains-plugins.url = "github:Cryolitia/nix-jetbrains-plugins";
    };

  outputs =
    inputs:
    let
      system = "x86_64-linux";
      commonModule = import ./common/module.nix { inherit inputs; };
    in
    builtins.trace "「我书写，则为我命令。我陈述，则为我规定。」"
      {

        nixosConfigurations = {
          cryolitia-gpd-nixos = inputs.nixpkgs.lib.nixosSystem rec {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs;
            };

            modules = commonModule ++ (with inputs; [

              ./hosts/gpd

              nixos-hardware.nixosModules.gpd-win-max-2-2023

              # nixos-hardware.nixosModules.common-gpu-nvidia-nonprime

              nur-cryolitia.nixosModules.gpd-fan-driver

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = false;
                home-manager.backupFileExtension = "backup";
                home-manager.extraSpecialArgs = { inherit inputs; };
                home-manager.users.cryolitia = import ./hosts/gpd/home.nix;
              }
            ]);
          };

          cryolitia-surface = inputs.nixpkgs.lib.nixosSystem rec {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs;
            };

            modules = commonModule ++ (with inputs;[

              ./hosts/surface-go
              ./common/distribute.nix

              nixos-hardware.nixosModules.microsoft-surface-go

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = false;
                home-manager.backupFileExtension = "backup";
                home-manager.extraSpecialArgs = { inherit inputs; };
                home-manager.users.cryolitia = import ./hosts/surface/home.nix;
              }
            ]);
          };

          rpi-nixos = inputs.nixpkgs.lib.nixosSystem rec {
            system = "aarch64-linux";
            specialArgs = {
              inherit inputs;
            };
            modules = (with inputs;[

              ./hosts/rpi4
              # ./common/distribute.nix

              vscode-server.nixosModules.default

              {
                services.vscode-server.enable = true;
              }

              nur.nixosModules.nur

              nixos-hardware.nixosModules.raspberry-pi-4

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = false;
                home-manager.backupFileExtension = "backup";
                home-manager.extraSpecialArgs = { inherit inputs; };
                home-manager.users.cryolitia = import ./hosts/rpi4/home.nix;
              }

            ]);
          };
        };

        packages.x86_64-linux = {
          iso = inputs.nixos-generators.nixosGenerate {
            system = "x86_64-linux";
            modules = commonModule ++ (with inputs;[

              ./hosts/image
              nur-cryolitia.nixosModules.ryzen-smu

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = false;
                home-manager.backupFileExtension = "backup";
                home-manager.extraSpecialArgs = { inherit inputs; };
                home-manager.users.cryolitia = import ./hosts/image/home.nix;
              }
            ]);
            format = "install-iso";
            specialArgs = { inherit inputs; };
          };
        };

        devShells."${system}" = rec {

          pkgs-unfree = import inputs.nixpkgs {
            config = {
              allowUnfree = true;
              cudaSupport = false;
            };
            inherit system;
          };

          pkgs-cuda = import inputs.nixpkgs {
            config = {
              allowUnfree = true;
              cudaSupport = true;
              # https://github.com/SomeoneSerge/nixpkgs-cuda-ci/blob/develop/nix/ci/cuda-updates.nix#L18
              cudaCapabilities = [ "8.6" ];
              cudaEnableForwardCompat = false;
            };
            inherit system;
          };

          pkgs-rust = import inputs.nixpkgs {
            config = {
              allowUnfree = true;
              cudaSupport = false;
            };
            inherit system;
            overlays = [
              (import inputs.rust-overlay)
            ];
          };

          gcc = import ./develop/gcc.nix { pkgs = pkgs-unfree; };

          cuda = import ./develop/cuda.nix { pkgs = pkgs-cuda; };

          rust = import ./develop/rust.nix { pkgs = pkgs-rust; };

          python = import ./develop/python.nix { pkgs = pkgs-unfree; };
        };
      };
}

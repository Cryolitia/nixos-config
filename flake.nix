{
  description = "Cryolitia's NixOS Flake";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      # "https://mirrors.cernet.edu.cn/nix-channels/store"
      "https://mirrors.bfsu.edu.cn/nix-channels/store"
    ];
    extra-substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://cryolitia.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://anyrun.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cryolitia.cachix.org-1:/RUeJIs3lEUX4X/oOco/eIcysKZEMxZNjqiMgXVItQ8="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs =
    {
      # NixOS 官方软件源，这里使用 nixos-unstable 分支
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

      # home-manager，用于管理用户配置
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nixos-hardware.url = github:NixOS/nixos-hardware/master;

      nur.url = "github:nix-community/NUR";

      nur-cryolitia = {
        url = "github:Cryolitia/nur-packages";
        inputs.nixpkgs.follows = "nixpkgs";
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

      wayland = {
        url = "github:nix-community/nixpkgs-wayland";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      hyprland = {
        url = "github:hyprwm/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      hyprland-plugin = {
        url = "github:hyprwm/hyprland-plugins";
        inputs.hyprland.follows = "hyprland";
      };

      nixos-generators = {
        url = "github:nix-community/nixos-generators";
        inputs.nixpkgs.follows = "nixpkgs";
      };

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
          Cryolitia-nixos = inputs.nixpkgs.lib.nixosSystem rec {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs;
            };

            modules = commonModule ++ (with inputs; [

              ./hosts/laptop

              nixos-hardware.nixosModules.common-hidpi
              nixos-hardware.nixosModules.common-cpu-intel
              nixos-hardware.nixosModules.common-pc-laptop
              nixos-hardware.nixosModules.common-pc-laptop-ssd

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = false;
                home-manager.backupFileExtension = "backup";
                home-manager.extraSpecialArgs = { inherit inputs; };
                home-manager.users.cryolitia = import ./hosts/laptop/home.nix;

              }
            ]);
          };
        };

        nixosConfigurations = {
          Cryolitia-surface = inputs.nixpkgs.lib.nixosSystem rec {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs;
            };

            modules = commonModule ++ (with inputs;[

              ./hosts/surface
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
        };

        nixosConfigurations = {
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

              /*home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = false;
                home-manager.backupFileExtension = "backup";
                home-manager.extraSpecialArgs = { inherit inputs; };
                home-manager.users.cryolitia = import ./hosts/surface/home.nix;
              }*/
            ]);
            format = "install-iso";
            specialArgs = { inherit inputs; };
          };
        };

        devShells."${system}" = rec {

          pkgs = import inputs.nixpkgs {
            config = {
              allowUnfree = true;
              cudaSupport = true;
            };
            inherit system;
          };

          gcc = import ./develop/gcc.nix { inherit pkgs; };

          cuda = import ./develop/cuda.nix { inherit pkgs; };

        };
      };

}

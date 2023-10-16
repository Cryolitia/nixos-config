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
      "https://nix-community.cachix.org"
      "https://cryolitia.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://anyrun.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cryolitia.cachix.org-1:/RUeJIs3lEUX4X/oOco/eIcysKZEMxZNjqiMgXVItQ8="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
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

      nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

      vscode-server.url = "github:nix-community/nixos-vscode-server";

      anyrun = {
        url = "github:Kirottu/anyrun";
        inputs.nixpkgs.follows = "nixpkgs";
      };

    };

  outputs =
    inputs@{ self
    , nixpkgs
    , home-manager
    , nur
    , nur-cryolitia
    , nixos-hardware
    , nix-vscode-extensions
    , vscode-server
    , anyrun
    , ...
    }:
    let
      system = "x86_64-linux";
    in
    {
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

            nixos-hardware.nixosModules.common-hidpi
            nixos-hardware.nixosModules.common-cpu-intel
            nixos-hardware.nixosModules.common-pc-laptop
            nixos-hardware.nixosModules.common-pc-laptop-ssd

            nur.nixosModules.nur

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
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

            home-manager.nixosModules.home-manager
            {
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
            # ./common/distribute.nix

            vscode-server.nixosModules.default
            ({ config, pkgs, ... }: {
              services.vscode-server.enable = true;
            })

            nur.nixosModules.nur

            nixos-hardware.nixosModules.raspberry-pi-4

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = inputs;
              home-manager.users.cryolitia = import ./hosts/rpi4/home.nix;
            }

          ];
        };
      };

      devShells."${system}" = {

        gcc =
          let

            pkgs = import nixpkgs {
              config = {
                allowUnfree = true;
              };
              inherit system;
            };

          in
          (pkgs.mkShell {

            buildInputs = with pkgs; [
              jetbrains.clion
              cmake
              opencv
              onnxruntime
              cudaPackages.cudatoolkit
              eigen
              zlib
              asio
              libcpr
            ];

            shellHook = ''
              cd ~
              exec zsh
            '';

          });

        cuda =
          let

            pkgs = import nixpkgs {
              config = {
                allowUnfree = true;
                cudaSupport = true;
              };
              inherit system;
            };

          in
          (pkgs.mkShell {

            buildInputs = (
              (with pkgs.python310Packages; [
                pytorch-bin
                venvShellHook
                numpy
                pillow
                matplotlib
                torchvision-bin
              ]) ++ (with pkgs; [
                python310
                cudaPackages.cudatoolkit
                virtualenv
                jetbrains.pycharm-professional
              ])
            );

            shellHook = ''
              cd ~
              echo "`${pkgs.python310}/bin/python3 --version`"
              virtualenv --no-setuptools venv
              export PATH=$PWD/venv/bin:$PATH
              export PYTHONPATH=venv/lib/python3.10/site-packages/:$PYTHONPATH
              exec zsh
            '';

            postShellHook = ''
              ln -sf PYTHONPATH/* ${pkgs.virtualenv}/lib/python3.10/site-packages
            '';

          });
      };
    };

}

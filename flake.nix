{
  description = "Cryolitia's NixOS Flake";

  nixConfig = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      # "https://mirrors.mirrorz.org/nix-channels/store"
      "https://mirrors.bfsu.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"

      "https://nix-community.cachix.org"
      "https://cryolitia.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://ezkea.cachix.org"
      "https://niri.cachix.org"
      "http://cache.kp920.cryolitia.dn42"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cryolitia.cachix.org-1:/RUeJIs3lEUX4X/oOco/eIcysKZEMxZNjqiMgXVItQ8="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      "kp920.cryolitia.dn42:M68UcYMNX/2yWXFwDb21jAregdcIsF3uIrSmXldX70k="
    ];
  };

  inputs = {
    # NixOS 官方软件源，这里使用 nixos-unstable 分支
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-patched.url = "github:cryolitia/nixpkgs/nixos-unstable";

    # home-manager，用于管理用户配置
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jetbrains-plugins.url = "github:Cryolitia/nix-jetbrains-plugins";

    systems.url = "github:nix-systems/default";

    niri.url = "github:sodiboo/niri-flake";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      commonModule = import ./common/module.nix { inherit inputs; };
      eachSystem = inputs.nixpkgs.lib.genAttrs (import inputs.systems);
    in
    builtins.trace "「我书写，则为我命令。我陈述，则为我规定。」" rec {
      # nixosConfigurations.[name].config.system.build.toplevel
      nixosConfigurations = {
        cryolitia-gpd-nixos = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };

          modules =
            (commonModule (import ./hosts/gpd/home.nix))
            ++ (with inputs; [

              ./hosts/gpd

              nixos-hardware.nixosModules.gpd-win-max-2-2023
              # nixos-hardware.nixosModules.common-gpu-nvidia-nonprime

              nur-cryolitia.nixosModules.gpd-fan-driver
            ]);
        };

        kp920-nixos = inputs.nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules =
            (commonModule (import ./hosts/kp920/home.nix))
            ++ (with inputs; [

              ./hosts/kp920

              vscode-server.nixosModules.default

              { services.vscode-server.enable = true; }
            ]);
        };

        q6a-nixos = inputs.nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = import ./hosts/q6a/module.nix { inherit inputs; };
        };
      };

      packages = eachSystem (
        system:
        let
          pkgs = (import inputs.nixpkgs { inherit system; });
        in
        {
          iso = inputs.nixos-generators.nixosGenerate {
            inherit system;
            modules = (commonModule (import ./hosts/image/home.nix)) ++ (with inputs; [ ./hosts/image ]);
            format = "install-iso";
            specialArgs = {
              inherit inputs;
            };
          };

          q6a-image = inputs.nixos-generators.nixosGenerate {
            system = "aarch64-linux";
            format = "raw-efi";
            specialArgs = {
              inherit inputs;
            };
            modules = import ./hosts/q6a/module.nix { inherit inputs; };
          };

          neovim = inputs.nixvim.legacyPackages."${system}".makeNixvim (import ./common/software/neovim.nix);

          vscode = (
            import ./graphic/software/vscode.nix {
              pkgs = import inputs.nixpkgs {
                config = {
                  allowUnfree = true;
                  cudaSupport = false;
                };
                inherit system;
                overlays = [ inputs.nur-cryolitia.overlays.nur-cryolitia ];
              };
            }
          );

          linux_rpi5 = pkgs.linuxKernel.kernels.linux_rpi4.override {
            rpiVersion = 5;
            argsOverride.defconfig = "bcm2712_defconfig";
          };

          pkgsCross.aarch64-multiplatform.linux_rpi5 =
            (import inputs.nixpkgs {
              inherit system;
              crossSystem = {
                config = "aarch64-unknown-linux-gnu";
              };
            }).linuxKernel.kernels.linux_rpi4.override
              {
                rpiVersion = 5;
                argsOverride.defconfig = "bcm2712_defconfig";
              };

          linux_q6a = import ./hosts/q6a/kernel.nix { inherit pkgs; };
        }
      );

      devShells = eachSystem (
        system:
        let
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
            overlays = [ (import inputs.rust-overlay) ];
          };
        in
        {
          gcc = import ./develop/gcc.nix { pkgs = pkgs-unfree; };

          cuda = import ./develop/cuda.nix { pkgs = pkgs-cuda; };

          rust = import ./develop/rust.nix { pkgs = pkgs-rust; };

          python = import ./develop/python.nix { pkgs = pkgs-unfree; };
        }
      );

      formatter = eachSystem (
        system:
        (import ./common/software/nixfmt.nix {
          pkgs = import inputs.nixpkgs {
            inherit system;
          };
        })
      );

      hydraJobs = {
        # rpi-nixos = nixosConfigurations.rpi-nixos.config.system.build.toplevel;
        kp920 = nixosConfigurations.kp920-nixos.config.system.build.toplevel;
        q6a = packages."aarch64-linux".q6a-image;
      };
    };
}

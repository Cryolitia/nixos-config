{
  description = "Cryolitia's NixOS Flake";

  nixConfig = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://mirrors.cernet.edu.cn/nix-channels/store"
      "https://mirrors.bfsu.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"

      "https://nix-community.cachix.org"
      "https://cryolitia.cachix.org"
      "https://ezkea.cachix.org"
      "https://niri.cachix.org"
      "https://nix-on-droid.cachix.org"
      "http://cache.cryolitia.dn42"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cryolitia.cachix.org-1:/RUeJIs3lEUX4X/oOco/eIcysKZEMxZNjqiMgXVItQ8="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      "kp920.cryolitia.dn42:M68UcYMNX/2yWXFwDb21jAregdcIsF3uIrSmXldX70k="
      "nix-on-droid.cachix.org-1:56snoMJTXmDRC1Ei24CmKoUqvHJ9XCp+nidK7qkMQrU="
    ];
  };

  inputs = {
    # NixOS 官方软件源，这里使用 nixos-unstable 分支
    #nixpkgs.url = "github:nixos/nixpkgs/7766073f61f2fbd09d6309ee4e45f86b16610b3a";
    nixpkgs.url = "github:cryolitia/nixpkgs/nixos-unstable";

    # home-manager，用于管理用户配置
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-hardware-yuntian.url = "github:RadxaYuntian/nixos-hardware/cix-mainline";

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

    niri.url = "github:sodiboo/niri-flake";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-2405";
      inputs.home-manager.follows = "home-manager-2405";
    };

    nixpkgs-2405.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager-2405 = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-2405";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
      commonModule = import ./common/module.nix { inherit inputs; };
      eachSystem = inputs.nixpkgs.lib.genAttrs systems;
      lib = inputs.nixpkgs.lib;
    in
    builtins.trace "「我书写，则为我命令。我陈述，则为我规定。」" rec {
      # nixosConfigurations.[name].config.system.build.toplevel
      nixosConfigurations =
        lib.mapAttrs' (name: value: lib.nameValuePair ("cryolitia-" + name + "-nixos") value)
          {
            gpd-wm2 = inputs.nixpkgs.lib.nixosSystem {
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

            lecoo-minipro = inputs.nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              specialArgs = {
                inherit inputs;
              };

              modules =
                (commonModule (import ./hosts/lecoo/home.nix))
                ++ (with inputs; [
                  ./hosts/lecoo
                ]);
            };

            huawei-kp920 = inputs.nixpkgs.lib.nixosSystem {
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

            radxa-q6a = inputs.nixpkgs.lib.nixosSystem {
              system = "aarch64-linux";
              specialArgs = {
                inherit inputs;
              };
              modules =
                (commonModule (import ./hosts/q6a/home.nix))
                ++ (with inputs; [

                  ./hosts/q6a

                  vscode-server.nixosModules.default

                  { services.vscode-server.enable = true; }
                ]);
            };

            radxa-q8b = inputs.nixpkgs.lib.nixosSystem {
              system = "aarch64-linux";
              specialArgs = {
                inherit inputs;
              };
              modules =
                (commonModule (import ./hosts/q8b/home.nix))
                ++ (with inputs; [

                  ./hosts/q8b

                  vscode-server.nixosModules.default
                ]);
            };

            radxa-o6 = inputs.nixpkgs.lib.nixosSystem {
              system = "aarch64-linux";
              specialArgs = {
                inherit inputs;
              };
              modules =
                (commonModule (import ./hosts/o6/home.nix))
                ++ (with inputs; [

                  ./hosts/o6

                  vscode-server.nixosModules.default

                  { services.vscode-server.enable = true; }

                  inputs.nixos-hardware-yuntian.nixosModules.radxa-orion-o6
                  {
                    boot.initrd.allowMissingModules = true;
                  }

                  nixos-hardware.nixosModules.common-gpu-nvidia
                ]);
            };
          };

      darwinConfigurations."Cryolitia-MacBook-Air" = inputs.nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/darwin
          { nixpkgs.overlays = [ inputs.nur-cryolitia.overlays.nur-cryolitia ]; }
          inputs.home-manager.darwinModules.home-manager
          inputs.nur.modules.darwin.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
            home-manager.users.cryolitia = (import ./hosts/darwin/home.nix);
          }
        ];
        specialArgs = {
          inherit inputs;
        };
      };

      packages =
        lib.recursiveUpdate
          (eachSystem (
            system:
            let
              pkgs = (import inputs.nixpkgs { inherit system; });
            in
            {
              iso =
                (inputs.nixpkgs.lib.nixosSystem {
                  inherit system;
                  modules = (commonModule (import ./hosts/image/home.nix)) ++ ([ ./hosts/image ]);
                  specialArgs = {
                    inherit inputs;
                  };
                }).config.system.build.isoImage;

              neovim = inputs.nixvim.legacyPackages."${system}".makeNixvim (import ./common/software/neovim.nix);

              vscode = (
                import ./graphic/software/vscode.nix {
                  inherit inputs;
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
            }
          ))
          {
            "aarch64-linux" = {
              radxa-q6a-image =
                (inputs.nixpkgs.lib.nixosSystem {
                  system = "aarch64-linux";
                  format = "raw-efi";
                  specialArgs = {
                    inherit inputs;
                  };
                  modules = [
                    "${inputs.nixpkgs}/nixos/modules/profiles/base.nix"
                    "${inputs.nixpkgs}/nixos/modules/profiles/installation-device.nix"
                    ./hosts/q6a/common.nix
                    (
                      { lib, ... }:
                      {
                        hardware.enableAllHardware = lib.mkForce false;
                        boot.supportedFilesystems.zfs = lib.mkForce false;
                        system.nixos.tags = [ "radxa-q6a" ];
                        systemd.tpm2.enable = false;
                        boot.initrd.systemd.tpm2.enable = false;
                      }
                    )
                  ];
                }).config.system.build.images.raw-efi;

              radxa-q8b-image =
                (inputs.nixpkgs.lib.nixosSystem {
                  system = "aarch64-linux";
                  specialArgs = {
                    inherit inputs;
                  };
                  modules = [
                    "${inputs.nixpkgs}/nixos/modules/profiles/base.nix"
                    "${inputs.nixpkgs}/nixos/modules/profiles/installation-device.nix"
                    ./hosts/q8b/common.nix
                    (
                      { lib, ... }:
                      {
                        hardware.enableAllHardware = lib.mkForce false;
                        boot.supportedFilesystems.zfs = lib.mkForce false;
                        system.nixos.tags = [ "radxa-q8b" ];
                        systemd.tpm2.enable = false;
                        boot.initrd.systemd.tpm2.enable = false;
                      }
                    )
                  ];
                }).config.system.build.images.raw-efi;

              radxa-o6-iso =
                (inputs.nixpkgs.lib.nixosSystem {
                  system = "aarch64-linux";
                  specialArgs = {
                    inherit inputs;
                  };
                  modules =
                    (commonModule (import ./hosts/image/home.nix))
                    ++ (with inputs; [
                      ./hosts/image
                      inputs.nixos-hardware-yuntian.nixosModules.orion-o6
                      {
                        boot.initrd.allowMissingModules = true;
                        system.nixos.tags = [ "radxa-o6" ];
                      }
                    ]);
                }).config.system.build.images.iso;

              radxa-linux-qcom = import ./common/radxa-linux-qcom.nix {
                pkgs = (import inputs.nixpkgs { system = "aarch64-linux"; });
              };
            };
          };

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

      nixOnDroidConfigurations.default = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
        modules = [
          ./hosts/nix-on-droid
        ];

        # list of extra special args for Nix-on-Droid modules
        extraSpecialArgs = {
          inherit inputs;
          # rootPath = ./.;
        };

        # set nixpkgs instance, it is recommended to apply `nix-on-droid.overlays.default`
        pkgs = import inputs.nixpkgs-2405 {
          system = "aarch64-linux";

          overlays = [
            inputs.nix-on-droid.overlays.default
            # add other overlays
          ];
        };

        # set path to home-manager flake
        home-manager-path = inputs.home-manager-2405.outPath;
      };

      hydraJobs = {
        # rpi-nixos = nixosConfigurations.rpi-nixos.config.system.build.toplevel;
        huawei-kp920 = nixosConfigurations.cryolitia-huawei-kp920-nixos.config.system.build.toplevel;
        radxa-q6a = nixosConfigurations.cryolitia-radxa-q6a-nixos.config.system.build.toplevel;
        radxa-q8b = nixosConfigurations.cryolitia-radxa-q8b-nixos.config.system.build.toplevel;
        radxa-o6 = nixosConfigurations.cryolitia-radxa-o6-nixos.config.system.build.toplevel;
      };
    };
}

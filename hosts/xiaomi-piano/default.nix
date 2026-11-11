{ inputs, ... }:
{
  imports = [
    inputs.xiaomi-piano.nixosModules.piano
    ../../profiles/level-beta/nixos.nix
    ../../graphic/level-gamma/steam/nixos.nix
  ];

  networking.hostName = "cryolitia-xiaomi-piano-nixos";

  features.desktop = [
    "gnome"
    "niri"
  ];
  features.ime = "fcitx5";

  nixpkgs.overlays = [
    (_final: prev: {
      gamescope = prev.gamescope.overrideAttrs (oldAttrs: {
        patches = (oldAttrs.patches or [ ]) ++ [ ./gamescope-separate-kms.patch ];
      });
      kitty = prev.kitty.overrideAttrs (oldAttrs: {
        # Kitty 0.50.0 already includes upstream Wayland touch input.
        patches = (oldAttrs.patches or [ ]) ++ [ ./kitty-wayland-touch.patch ];
      });
      mangohud = prev.mangohud.overrideAttrs (oldAttrs: {
        buildInputs = (oldAttrs.buildInputs or [ ]) ++ [
          prev.libdrm
          prev.libcap
        ];
        mesonFlags = (oldAttrs.mesonFlags or [ ]) ++ [ "-Dcpp_std=c++20" ];
        patches = (oldAttrs.patches or [ ]) ++ [
          # GPU metrics and C++20 prerequisites for the upstream legacy wrapper.
          (prev.fetchpatch2 {
            name = "mangohud-gpu-prerequisites.patch";
            url = "https://github.com/flightlessmango/MangoHud/compare/v0.8.4...1979a94dac3530ea4ac321ede72ba8f45bf56c03.diff";
            includes = [
              "mangohud-next/server/common/*"
              "mangohud-next/server/metrics/gpu/*"
              "mangohud-next/server/metrics/fdinfo.*"
              "mangohud-next/server/metrics/hwmon.*"
              "mangohud-next/utils/*"
              "src/overlay.cpp"
            ];
            hash = "sha256-aDB8nDsB7PDfqy36ab/wH8hVAEoSvohA7uexaNT0bZU=";
          })
          # Use the shared GPU metrics from MangoHud 0.8.4's fdinfo backend.
          (prev.fetchpatch2 {
            url = "https://github.com/flightlessmango/MangoHud/commit/de07d925b7cb0e17b5443e396147919a24d39103.patch";
            hash = "sha256-nraLhWcTGDomf6tdJhWn4MA/vKPj7+UnodyYLfX33R4=";
          })
          # Battery type/scope discovery and its upstream fixes.
          (prev.fetchpatch2 {
            name = "mangohud-battery-upstream.patch";
            url = "https://github.com/flightlessmango/MangoHud/compare/v0.8.4...0448ce19054a54a15ee2562a74e976e59647cd62.diff";
            includes = [
              "src/battery.cpp"
              "src/battery.h"
              "src/string_utils.h"
            ];
            hash = "sha256-1QySSUxLyC2OXV92/j6sB3peM7jEpnf/Pendy1vR1xI=";
          })
          # MSM power and thermal support required by the devfreq clock patch.
          (prev.fetchpatch2 {
            url = "https://github.com/flightlessmango/MangoHud/commit/eeb646736b239c5eccc8b6cee82467b086ddecb1.patch";
            hash = "sha256-5nr+VLdRzYGCi1MqCPawqpZLHsKR/JJ1ileMBuiwobk=";
          })
          (prev.fetchpatch2 {
            url = "https://github.com/flightlessmango/MangoHud/commit/748823d9fde3488c4b2de2c8a0ea0a892f5577cd.patch";
            hash = "sha256-OQTuaOXcnBiqy1XGSMPiGXey8y4fFcJz+uSgSMujEpk=";
          })
          (prev.fetchpatch2 {
            url = "https://github.com/flightlessmango/MangoHud/commit/eb72a0048f439586700b499b4af9ef097403222b.patch";
            hash = "sha256-qTdIaY296JnONiiIVJ0i80vZPles9NmSaNRKoSzu+J0=";
          })
          # Thermal/devfreq discovery fixes; the load backend is absent here.
          (prev.fetchpatch2 {
            url = "https://github.com/flightlessmango/MangoHud/commit/0448ce19054a54a15ee2562a74e976e59647cd62.patch";
            includes = [ "mangohud-next/server/metrics/gpu/msm/dpu.cpp" ];
            hunks = [
              1
              2
            ];
            hash = "sha256-IzKfmt1/eyAlCm+Nm+JQuHABCb9eIy9uJT2KQGx0Bc4=";
          })
          # Match TSENS hwmon names such as gpuss0_thermal.
          (prev.fetchpatch2 {
            url = "https://github.com/flightlessmango/MangoHud/commit/a36e3ce7df0f77b33bdd92dc83f724e81ae0ac04.patch";
            hash = "sha256-LDFVYT9gMGX8kw/i85V/Cgmo3ybWC/rhHuqu0mWOskg=";
          })
          ./mangohud-piano.patch
        ];
      });
    })
  ];

  # Adreno renders frames; the separate DPU drives the screen. Use its stable
  # platform link because DRM card numbers can change between boots.
  programs.steam.gamescopeSession = {
    args = [ "--mangoapp" ];
    env = {
      GAMESCOPE_PREFER_DRM = "/dev/dri/by-path/platform-ae01000.display-controller-card";
      # Otherwise Gamescope's Steam mode creates a config containing no_display.
      MANGOHUD_CONFIGFILE = "$HOME/.config/MangoHud/MangoHud.conf";
    };
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        installDeviceTree = true;
      };
      efi.canTouchEfiVariables = false;
      timeout = 5;
    };
    initrd.systemd.tpm2.enable = false;
  };
  systemd.tpm2.enable = false;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-partlabel/sunuefi_root";
      fsType = "ext4";
      autoResize = true;
    };
    "/boot" = {
      device = "/dev/disk/by-partlabel/sunuefi_esp";
      fsType = "vfat";
      options = [
        "nosuid"
        "nodev"
        "noexec"
      ];
    };
  };

  # Keep internal UFS volumes out of desktop storage lists.
  services.udev.extraRules = ''
    SUBSYSTEM=="block", DRIVERS=="ufshcd-qcom", ENV{UDISKS_IGNORE}="1"
  '';

  # Compatibility versions for this device's initial installation.
  system.stateVersion = "26.11";
  home-manager.users.cryolitia =
    { lib, ... }:
    {
      home.stateVersion = "26.11";
      programs.kitty.settings.linux_display_server = "wayland";

      dconf.settings."org/gnome/shell/extensions/dash-to-dock".show-mounts-network = lib.mkForce false;
      dconf.settings."org/gnome/shell/extensions/freon".hot-sensors = lib.mkForce [
        "__max__"
        "in0"
      ];
      # Use the keyboard layout with Fcitx5 and Kimpanel.
      dconf.settings."org/gnome/desktop/input-sources".sources = lib.mkForce [
        (lib.hm.gvariant.mkTuple [
          "xkb"
          "cn"
        ])
      ];
    };
}

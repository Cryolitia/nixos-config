{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.dashy = {
    enable = true;
    virtualHost = {
      enableNginx = true;
      domain = "_";
    };
    settings = {
      appConfig = {
        theme = "basic";
        language = "cn";
        layout = "auto";
        iconSize = "large";
        startingView = "default";
        defaultOpeningMethod = "newtab";
        statusCheck = false;
        faviconApi = "allesedv";
        routingMode = "history";
        webSearch.disableWebSearch = true;
        enableFontAwesome = true;
        enableMaterialDesignIcons = true;
        showSplashScreen = true;
        preventWriteToDisk = true;
        preventLocalSave = false;
        disableConfiguration = true;
        allowConfigEdit = true;
      };
      pageInfo = {
        title = "Cryolitia DN42 Nav";
        description = "AS4242420994";
      };
      sections = [
        {
          name = "MAINTAINER";
          icon = "fas fa-info";
          displayData = {
            sortBy = "alphabetical";
            rows = 1;
            cols = 1;
            collapsed = false;
            hideForGuests = false;
          };
          items = [
            {
              title = "GitHub";
              description = "@Cryolitia";
              icon = "si-github";
              url = "https://github.com/Cryolitia";
            }
            {
              title = "Matrix";
              description = "cryolitia:matrix.org";
              icon = "si-matrix";
              url = "https://matrix.to/#/@cryolitia:matrix.org";
            }
            {
              title = "Telegram";
              description = "@Cryolitia";
              icon = "si-telegram";
              url = "https://t.me/cryolitia";
            }
            {
              title = "OpenPGP";
              description = "1C3C 6547 538D 7152 310C 0EEA 84DD 0C01 30A5 4DF7";
              icon = "fas fa-key:";
              url = "https://keyserver.ubuntu.com/pks/lookup?op=vindex&search=0x84dd0c0130a54df7";
            }
          ];
          widgets = [
            {
              type = "github-profile-stats";
              options.username = "cryolitia";
            }
          ];
        }
        {
          name = "Public";
          icon = "mdi-earth";
          displayData = {
            sortBy = "most-used";
            rows = 1;
            cols = 1;
            collapsed = false;
            hideForGuests = false;
          };
          items = lib.mkMerge [
            (lib.optional config.virtualisation.oci-containers.containers.gatus.autoStart {
              title = "Status";
              description = pkgs.gatus.meta.description;
              icon = "hl-gatus";
              url = "//status.cryolitia.dn42";
            })
            (lib.optional config.services.hydra.enable {
              title = "Hydra";
              description = pkgs.hydra.meta.description;
              icon = "hl-nixos";
              url = "//hydra.cryolitia.dn42";
            })
            (lib.optional config.services.hydra.enable {
              title = "Netdata";
              description = pkgs.netdata.meta.description;
              icon = "hl-netdata";
              url = "//netdata.cryolitia.dn42";
            })
            (lib.optional config.services.iperf3.enable {
              title = "iperf3";
              description = pkgs.iperf3.meta.description;
              icon = "mdi-speedometer";
              url = "//guide.cryolitia.dn42/iperf.html";
            })
          ];
        }
        {
          name = "Internal";
          icon = "fas fa-shield";
          displayData = {
            sortBy = "most-used";
            rows = 1;
            cols = 1;
            collapsed = false;
            hideForGuests = false;
          };
          items = lib.mkMerge [
            (lib.optional config.virtualisation.oci-containers.containers.wavelog-main.autoStart {
              title = "Wavelog";
              description = pkgs.wavelog.meta.description;
              icon = "hl-wavelog";
              url = "//wavelog.cryolitia.dn42";
            })
            (lib.optional config.services.openvscode-server.enable {
              title = "OpenVSCode Server";
              description = pkgs.openvscode-server.meta.description;
              icon = "hl-code";
              url = "//code.cryolitia.dn42";
            })
            (lib.optional config.virtualisation.oci-containers.containers.homeassistant.autoStart {
              title = "Home Assistant";
              description = pkgs.home-assistant.meta.description;
              icon = "hl-home-assistant-alt";
              url = "//ha.kp920.internal";
            })
            (lib.optional (builtins.hasAttr "qbittorrent" config.systemd.services) {
              title = "qBittorrent";
              description = pkgs.qbittorrent.meta.description;
              icon = "hl-qbittorrent";
              url = "//qbt.kp920.internal";
            })
            [
              {
                title = "Proxmox VE";
                description = "Proxmox Virtual Environment";
                icon = "si-proxmox";
                url = "https://pve.site-01.cryolitia.dn42";
              }
              {
                title = "Internal Services";
                description = "Printer, NAS, and more...";
                icon = "mdi-nas";
                url = "//guide.kp920.internal/internal.html";
              }
            ]
          ];
        }
        {
          name = "Infra";
          icon = "fas fa-network-wired";
          displayData = {
            sortBy = "most-used";
            rows = 1;
            cols = 1;
            collapsed = false;
            hideForGuests = false;
          };
          items = [
            {
              title = "RB5009UG+S+IN";
              icon = "si-mikrotik";
              url = "//root.cryolitia.dn42";
            }
            {
              title = "ASUS RT-BE88U";
              icon = "si-asus";
              url = "//asus.internal";
            }
            {
              title = "CRS305-1G-4S+IN";
              icon = "si-mikrotik";
              url = "//crs305.internal";
            }
            {
              title = "Icom IC-705";
              icon = "mdi-radio-tower";
              url = "ic-705.internal";
              target = "clipboard";
            }
            {
              title = "AirEngine 5762S-11";
              icon = "si-huawei";
              url = "http://ap.internal";
            }
            {
              title = "Huawei Kunpeng 920";
              icon = "si-huawei";
              url = "kp920.cryolitia.dn42";
              target = "clipboard";
            }
          ];
          widgets = [
            {
              type = "image";
              options.imagePath = "https://raw.githubusercontent.com/Cryolitia/Cryolitia.github.io/refs/heads/main/content/post/gallery/20250731_234121%7E2.JPG";
            }
          ];
        }
      ];
    };
  };

  services.nginx.virtualHosts."${config.services.dashy.virtualHost.domain}" = {
    listenAddresses = [
      "0.0.0.0"
      "[::]"
    ];
    locations."/" = {
      extraConfig = ''
        allow 127.0.0.1;
        allow ::1;
        allow 192.168.0.0/16;
        allow fd00::/7;
        deny all;
      '';
    };
  };
}

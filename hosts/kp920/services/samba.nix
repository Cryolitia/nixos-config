{
  services.samba-wsdd.enable = true;
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        workgroup = "WORKGROUP";
        security = "user";
        "use sendfile" = "yes";
        # "max protocol" = "smb2";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };

      NAS = {
        path = "/mnt/NAS";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0666";
        "directory mask" = "0777";
        "force user" = "cryolitia";
        "valid users" = "cryolitia";
      };

      Movie = {
        path = "/mnt/NAS/Movie";
        browseable = "yes";
        "read only" = "yes";
        "guest ok" = "yes";
        "force user" = "nobody";
      };
    };
  };
}

{ ... }:

{
  services.samba-wsdd.enable = true;
  services.samba = {
    enable = true;
    settings = {
      glogal = {
        workgroup = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
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
    };
  };
}

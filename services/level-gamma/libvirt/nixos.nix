{ pkgs, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
      };
      extraConfig = ''
        unix_sock_group = "libvirtd"
      '';
    };
    spiceUSBRedirection.enable = true;
  };

  users.users.cryolitia.extraGroups = [ "libvirtd" ];

  environment.systemPackages = with pkgs; [ virt-manager ];
}

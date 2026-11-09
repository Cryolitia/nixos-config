{ ... }:
{
  networking.networkmanager.enable = true;

  programs.ssh = {
    kexAlgorithms = [
      "curve25519-sha256@libssh.org"
      "diffie-hellman-group-exchange-sha256"
      "diffie-hellman-group1-sha1"
    ];
    pubkeyAcceptedKeyTypes = [
      "ssh-ed25519"
      "ssh-rsa"
      "ecdsa-sha2-nistp256"
    ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      hinfo = true;
    };
  };
  services.openssh.enable = true;
}

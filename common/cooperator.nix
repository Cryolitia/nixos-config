{ pkgs, ... }:

{
  users.users.ziyao = {
    isNormalUser = true;
    uid = 1023;
    description = "ziyao233";
    shell = pkgs.bashInteractive;
    extraGroups = [
      "wheel"
      "video"
      "networkmanager"
      "docker"
      "input"
      "i2c"
      "plugdev"
    ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFEZ7Jy+zBbNGrypUWx+H6DySweWKJMHGG/+HhhTeXd2"
    ];
  };

  users.users.yukari = {
    isNormalUser = true;
    uid = 1024;
    description = "yukari";
    shell = pkgs.bashInteractive;
    extraGroups = [
      "wheel"
      "video"
      "networkmanager"
      "docker"
      "input"
      "i2c"
      "plugdev"
    ]; # Enable ‘sudo’ for the user.
    hashedPassword = "$y$j9T$EGb7ThXBnx23/EoU2wMO.0$DVdXLz2Kav0R5j6YUr.ndmhVDeZ7e6TLH6VRy2NU/J4";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBIE+fnfiCeMjA74rEV6DCDg/gdgTJBtOKpW/RTYhpmc"
    ];
  };

  users.users.cmiki = {
    isNormalUser = true;
    uid = 1025;
    description = "Noa Virellia";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "video"
      "networkmanager"
      "docker"
      "input"
      "i2c"
      "plugdev"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOOz0CMmkGSXv4H77rmrmvadltAlwAZeVimxGoUAfArs"
    ];
  };

  programs.fish.enable = true;
}

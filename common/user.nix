{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cryolitia = {
    isNormalUser = true;
    description = "Cryolitia";
    extraGroups = [
      "wheel"
      "video"
      "networkmanager"
      "docker"
      "input"
    ]; # Enable ‘sudo’ for the user.
    hashedPassword = "$6$wisKmlN2/bkocZwi$79lkaHiKpkrfBtId5H.R1byVTTzg.vc/YGlr37zS4J4gPMRSveHrLLgY19m3UfPvc9aAnVEAEh3pSShBeh.D61";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCpPphCIKbPWRKuzFxyawgMK/WzAofzLrv2NyVHoJkWG1/dFmJHoWeHXAtbC2oyfYDsLd2vr4xXLpJ6UcxEj4+3FrVRiJ6bR4NYEcMKmJf1tamGvGuYXvv/BZn9leDUsLpm6/8t0HxEXGbRot9ROfSV697l5v3rAVJVmMmjWUhDOQynryU2pwrh0x8o7AY5zhWRIBNcu3FY71eoDncnGer3fMW7EXmM5x3XkEhN6WoEZrV1RHvVZuPzLjHMFyRMvzRxNPcVbaI9vyY2hS3a4LqyAQg4T0rEHjbX27yuBQ8ymt5/B7z5BA1/aiCojiLocfhM3AlSDiIsbEcTugA5qbnz"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUCnYwJzdXqbPO2Y92jSSSCTW+u5oH06meRqx0HR8Hd Cryolitia@gmail.com"
    ];    
  };
}

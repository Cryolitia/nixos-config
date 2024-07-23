{ ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cryolitia = {
    isNormalUser = true;
    uid = 1000;
    description = "Cryolitia";
    extraGroups = [
      "wheel"
      "video"
      "networkmanager"
      "docker"
      "input"
      "i2c"
      "plugdev"
    ]; # Enable ‘sudo’ for the user.
    hashedPassword = "$y$j9T$CzLinqTi.Iyd4DDfAfYME0$IQKBC7wm20lYQWbH0bYnU5U0GB0JdRPZv67Tce3p6N2";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUCnYwJzdXqbPO2Y92jSSSCTW+u5oH06meRqx0HR8Hd Cryolitia@gmail.com"

      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN2mmQ5YQrQyUSYRNvRKTgYiTSdPt3wtCdiY0YBD7+X9 openpgp:0xA2647D3C"
    ];
  };
}

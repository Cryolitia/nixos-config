{ inputs, ... }:
{
  imports = [ inputs.hjem.nixosModules.default ];
  hjem.users.cryolitia = {
    clobberFiles = true;
    files.".config" = {
      type = "directory";
      permissions = "0755";
    };
  };
}

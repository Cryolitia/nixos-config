{ pkgs, ... }:
{
  files = {
    # Keep the user configuration directory as a regular directory.
    ".config/git" = {
      type = "directory";
      permissions = "0755";
    };
    ".config/git/config".source = pkgs.writeText "gitconfig-cryolitia" ''
      [user]
        name = Cryolitia PukNgae
        email = Cryolitia@gmail.com
    '';
  };
}

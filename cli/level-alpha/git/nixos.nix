{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    config.credential.helper = lib.mkIf config.services.gnome.gnome-keyring.enable "libsecret";
  };
  programs.git.config = {
    core.autocrlf = "input";
    gpg.format = "openpgp";
    sendemail = {
      smtpServer = "localhost";
      smtpServerPort = 25;
    };
    pull.ff = "only";
    credential = {
      "https://github.com".helper = [
        ""
        "${pkgs.gh}/bin/gh auth git-credential"
      ];
      "https://gist.github.com".helper = [
        ""
        "${pkgs.gh}/bin/gh auth git-credential"
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    gh
    lazygit
  ];
  hjem.users.cryolitia.imports = [ ./hjem.nix ];
}

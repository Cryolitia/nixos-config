{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    signing.format = "openpgp";
    settings = {
      core.autocrlf = "input";
      sendemail = {
        smtpServer = "localhost";
        smtpServerPort = 25;
      };
      pull.ff = "only";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
}

{ config, ... }:
{

  # Installation images start with a fresh home, so follow the current
  # Home Manager release.
  home.stateVersion = config.home.version.release;

  programs.git.signing = {
    key = "63982609A2647D3C";
  };
}

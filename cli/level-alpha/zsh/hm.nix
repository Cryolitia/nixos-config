{ lib, ... }:

{
  programs.zsh = {
    enable = true;
    initContent = ''
      source ~/.p10k.zsh
    '';
    history = {
      extended = true;
      save = 999999;
      size = 999999;
    };
  };

  home.file.".p10k.zsh".source = lib.mkForce ../../../resources/profile-alpha/zsh/.p10k.simple.zsh;
}

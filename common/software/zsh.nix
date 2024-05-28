{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chroma
    zsh-powerlevel10k
  ];

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [
        "colorize"
        "bgnotify"
        "sudo"
        "virtualenv"
        "zsh-interactive-cd"
      ];
    };
    promptInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      export ZSH_COLORIZE_TOOL=chroma
    '';
    #    shellAliases = {
    #     cp = "cpv";
    #     cat = "ccat";
    #    };
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  programs.fzf = {
    fuzzyCompletion = true;
    keybindings = true;
  };
}

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    chroma
    zsh-powerlevel10k
  ];

  programs.zsh = {
    enable = true;
    histSize = 999999;
    setOptions = [
      "HIST_IGNORE_DUPS"
      "SHARE_HISTORY"
      "HIST_FCNTL_LOCK"
      "EXTENDED_HISTORY"
    ];
    ohMyZsh = {
      enable = true;
      package = pkgs.oh-my-zsh.overrideAttrs (oldAttrs: {
        patches = (oldAttrs.patches or [ ]) ++ [
          (pkgs.fetchpatch {
            url = "https://github.com/Cryolitia-Forks/ohmyzsh/commit/2f0063a7142bd9f47741823cb5a60e0da0d7f40a.patch";
            hash = "sha256-QOHPxHg6bBgbxCOxMXOeT/qDmdlpgig/Mm8qhIugb6w=";
          })
        ];
      });
      plugins = [
        "colorize"
        "bgnotify"
        "sudo"
        "virtualenv"
        "zsh-interactive-cd"
      ];
    };
    interactiveShellInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      export ZSH_COLORIZE_TOOL=chroma
      export bgnotify_threshold=10
      export bgnotify_extraargs=-e
      source ${../../../resources/profile-alpha/zsh/.p10k.zsh}
    '';

    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  programs.fzf = {
    fuzzyCompletion = true;
    keybindings = true;
  };
  hjem.users.cryolitia.imports = [ ./hjem.nix ];
}

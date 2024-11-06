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
      package = pkgs.oh-my-zsh.overrideAttrs (oldAttrs: {
        patches = (oldAttrs.patches or [ ]) ++ [
          (pkgs.fetchpatch {
            url = "https://github.com/Cryolitia/ohmyzsh/commit/1243bd5b829c113fdd293c047168305cbc0aa1f4.patch";
            hash = "sha256-/tMtclOrdKyXkqNmNI0d0sJehCbX/VxJazMkv5swHaI=";
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
}

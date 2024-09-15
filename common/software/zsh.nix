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
      package = pkgs.oh-my-zsh.overrideAttrs(oldAttrs: {
        patches = (oldAttrs.patches or []) ++ [
          (pkgs.fetchpatch {
            url = "https://github.com/Cryolitia/ohmyzsh/commit/8318d3de95d2f2fb77ac70995fddae7cd4d5d23e.patch";
            hash = "sha256-v3SPIZX5ZXmnqtjD6vM+FQUuJp8u71PqO6uYUOrR0Wc=";
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
    promptInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      export ZSH_COLORIZE_TOOL=chroma
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

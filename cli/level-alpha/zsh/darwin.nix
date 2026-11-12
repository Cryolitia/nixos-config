{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableFzfCompletion = true;
    enableFzfGit = true;
    enableFzfHistory = true;
    enableFastSyntaxHighlighting = true;
    histSize = 1000000;
    interactiveShellInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      export SSH_SK_PROVIDER=/usr/lib/ssh-keychain.dylib
    '';
  };
  home-manager.users.cryolitia.imports = [ ./hm.nix ];
}

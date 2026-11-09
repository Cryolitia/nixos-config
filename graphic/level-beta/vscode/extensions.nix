{
  inputs,
  pkgs,
  version,
  ...
}:
let
  extensions = inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system};
  vscode-extensions = pkgs.lib.attrsets.recursiveUpdate extensions (
    extensions.forVSCodeVersion version
  );
in

(with pkgs.vscode-extensions; [
  ms-vscode-remote.remote-ssh
  ms-vscode-remote.remote-ssh-edit
  github.copilot-chat
  eamodio.gitlens
])
++ (with vscode-extensions.vscode-marketplace; [
  ms-ceintl.vscode-language-pack-zh-hans
  jnoortheen.nix-ide
  github.vscode-pull-request-github
  brunnerh.insert-unicode
  davidanson.vscode-markdownlint
  vira.vsc-vira-theme
  pkief.material-icon-theme
  esbenp.prettier-vscode
  medo64.code-point
  s-nlf-fh.glassit
  twxs.cmake
  m4ns0ur.base64
  uctakeoff.vscode-counter
  rust-lang.rust-analyzer
  myriad-dreamin.tinymist
  vue.volar
  github.vscode-github-actions
  editorconfig.editorconfig
  jock.svg
  tomoki1207.pdf
  mrmlnc.vscode-scss
  curlybrackets.markdown-word-count
  ms-vscode.hexeditor
  filipjonckers.adif-syntax-highlighting
  iliazeus.vscode-ansi
  openai.chatgpt
])

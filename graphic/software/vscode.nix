{ vscode-extensions-input, pkgs, ... }:

let
  vscode-extensions =
    pkgs.lib.attrsets.recursiveUpdate vscode-extensions-input.extensions.${pkgs.system}
      (vscode-extensions-input.extensions.${pkgs.system}.forVSCodeVersion pkgs.vscode.version);
in

(pkgs.vscode-with-extensions.override {
  vscode = pkgs.nur-cryolitia.vscode-vtuber.override {
    vscode = pkgs.vscode.override {
      # commandLineArgs = "--disable-gpu";
    };
  };
  vscodeExtensions =
    (with pkgs.vscode-extensions; [
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      github.copilot
      github.copilot-chat
    ])
    ++ (with vscode-extensions.vscode-marketplace; [
      ms-ceintl.vscode-language-pack-zh-hans
      jnoortheen.nix-ide
      github.vscode-pull-request-github
      brunnerh.insert-unicode
      davidanson.vscode-markdownlint
      equinusocio.vsc-material-theme
      # FIXME
      #pungrumpy.vsc-material-theme-icons
      esbenp.prettier-vscode
      medo64.code-point
      s-nlf-fh.glassit
      eamodio.gitlens
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
    ]);
})

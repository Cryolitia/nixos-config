{ pkgs, ... }:
let
  jsonFormat = pkgs.formats.json { };
in
jsonFormat.generate "vscode-user-settings" {
  "editor.fontFamily" = "JetBrainsMono Nerd Font Mono";
  "editor.unicodeHighlight.nonBasicASCII" = false;
  "editor.wordWrap" = "on";
  "files.autoSave" = "afterDelay";
  "git.enableSmartCommit" = true;
  "latex-workshop.latex.autoBuild.run" = "never";
  "latex-workshop.view.pdf.viewer" = "tab";
  "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font Mono";
  "workbench.colorTheme" = "Material Theme Darker High Contrast";
  "workbench.editor.enablePreview" = false;
  "workbench.preferredDarkColorTheme" = "Material Theme High Contrast";
  "workbench.preferredLightColorTheme" = "Material Theme Lighter High Contrast";
  "glassit.alpha" = 220;
  "workbench.iconTheme" = "eq-material-theme-icons";
  "nix.enableLanguageServer" = true;
  "nix.serverPath" = "nixd";
  "nix.serverSettings" = {
    "nixd" = {
      "formatting" = {
        "command" = "nixpkgs-fmt";
      };
    };
  };
  "debug.javascript.autoAttachFilter" = "onlyWithFlag";
  "git.autofetch" = false;
  "latex-workshop.latex.recipe.default" = "latexmk (xelatex)";
  "files.insertFinalNewline" = true;
  "[json]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  "[markdown]" = {
    "editor.defaultFormatter" = "DavidAnson.vscode-markdownlint";
  };
  "[html]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  "editor.unicodeHighlight.allowedLocales" = {
    zh-hans = true;
  };
  "github.copilot.editor.enableAutoCompletions" = true;
  "gitlens.ai.experimental.generateCommitMessage.enabled" = false;

  "[css]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
}

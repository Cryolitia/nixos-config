{ pkgs, inputs, ... }:
let
  common-plugins = [
    "github-copilot"
    "statistic"
    "material-theme-ui-lite"
    "chinese-simplified-language-pack----"
  ];
  addPlugins = (inputs.jetbrains-plugins.import pkgs).addPlugins;
in
{
  androidStudioPackages.beta = addPlugins pkgs.androidStudioPackages.beta common-plugins;
  idea-ultimate = addPlugins pkgs.jetbrains.idea-ultimate (
    common-plugins
    ++ [
      # "nixidea" 
    ]
  );
  pycharm-professional = addPlugins pkgs.jetbrains.pycharm-professional common-plugins;
  rust-rover = addPlugins pkgs.jetbrains.rust-rover [ "github-copilot" ];
  clion = addPlugins pkgs.jetbrains.clion common-plugins;
}

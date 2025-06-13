{ pkgs, config, ... }:

{
  services.kmscon = {
    enable = true;
    fonts = [
      {
        name = "Unifont";
        package = pkgs.unifont;
      }
      {
        name = "JetBrainsMono NFM";
        package = pkgs.nerd-fonts.jetbrains-mono;
      }
    ];
    hwRender = config.services.xserver.enable;
  };
}

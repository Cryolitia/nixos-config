{ ... }:

{
  programs.wpaperd = {
    enable = true;
    settings = {
      default = {
        path = ../../background;
        duration = "30m";
        sorting = "random";
      };
    };
  };
}

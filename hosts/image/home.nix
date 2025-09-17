{ ... }:

{

  imports = [ ../../graphic/home ];

  programs.git.signing = {
    signByDefault = true;
    key = "63982609A2647D3C";
  };
}

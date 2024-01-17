{ pkgs, ... }:

((pkgs.mkShell.override { stdenv = pkgs.llvmPackages.stdenv; }) {

  buildInputs = with pkgs; [
    rustc
    cargo
  ];

  LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";

  shellHook = ''
    exec zsh
  '';

})

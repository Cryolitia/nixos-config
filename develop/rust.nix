{ pkgs, ... }:
let 

  rust = (pkgs.rust-bin.stable.latest.rust.override {
      extensions = ["rust-src"];
    });

in ((pkgs.mkShell.override { stdenv = pkgs.llvmPackages.stdenv; }) {

  buildInputs = [
    rust
  ];

  LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
  RUST_SRC_PATH = "${rust}/lib/rustlib/src/rust";

  shellHook = ''
    rustc --version
    cargo --version
    exec zsh
  '';

})

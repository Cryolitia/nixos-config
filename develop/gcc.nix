{ pkgs, ... }:

let

  cuda = import ../common/software/cuda.nix { inherit pkgs; };
in
(pkgs.mkShell {

  buildInputs = with pkgs; [
    codeblocks
    cmake
    ninja
    gdb
    #opencv
    #onnxruntime
    eigen
    zlib
    asio
    libcpr
    #python310Packages.pybind11
  ]; # ++ cuda.cuda-native-redist;

  shellHook = ''
    cd ~
    exec zsh
  '';
})

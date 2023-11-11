{ pkgs, ... }:

let

  cuda = import ../common/software/cuda.nix { inherit pkgs; };

in
(pkgs.mkShell {

  buildInputs = with pkgs; [
    jetbrains.clion
    cmake
    opencv
    onnxruntime
    eigen
    zlib
    asio
    libcpr
  ] ++ cuda.cuda-native-redist;

  shellHook = ''
    cd ~
    exec zsh
  '';

})

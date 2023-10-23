{ pkgs, ... }:

let

  pkgs = import nixpkgs {
    config = {
      allowUnfree = true;
    };
    inherit system;
  };

  cuda = import ../common/software/cuda.nix { inherit pkgs; };

in
(pkgs.mkShell {

  buildInputs = with pkgs; [
    jetbrains.clion
    cmake
    opencv
    onnxruntime
    cuda.cuda-redist
    cuda.cuda-native-redist
    eigen
    zlib
    asio
    libcpr
  ];

  shellHook = ''
    cd ~
    exec zsh
  '';

});

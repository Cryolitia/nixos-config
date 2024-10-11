{ pkgs, ... }:

let
  cuda = import ../common/software/cuda.nix { inherit pkgs; };
  pythonVersion = "python311";
in
(pkgs.mkShell {
  buildInputs = (
    (with pkgs."${pythonVersion}Packages"; [
      python
      pytorch-bin
      venvShellHook
      numpy
      pillow
      matplotlib
      torchvision-bin
      virtualenv
      # (opencv4.override {
      #   enablePython = true;
      #   pythonPackages = pkgs.python310Packages;
      #   enableGtk2 = true;
      #   enableGtk3 = true;
      # })
      tensorflowWithCuda
      keras
    ])
    ++ (with pkgs; [
      python310
      cuda.cuda-native-redist
    ])
  );

  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];

  shellHook = ''
    echo "`${pkgs."${pythonVersion}Packages".python}/bin/python3 --version`"
    rm -v .venv/bin/python
    virtualenv --no-setuptools .venv
    export PATH=$PWD/.venv/bin:$PATH
    export PYTHONPATH=$PWD/.venv/lib/${pythonVersion}/site-packages/:$PYTHONPATH
    exec zsh
  '';

  postShellHook = ''
    ln -sf PYTHONPATH/* ${pkgs.virtualenv}/lib/${pythonVersion}/site-packages
  '';
})

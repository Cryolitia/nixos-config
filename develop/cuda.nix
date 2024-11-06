{ pkgs, ... }:
let
  cuda = import ../common/software/cuda.nix { inherit pkgs; };

  pythonVersion = "python311";
  venvPythonVersion = "python3.11";

  pythonWithPackages = pkgs."${pythonVersion}Packages".python.withPackages (
    ps: with ps; [
      python
      pytorch-bin
      venvShellHook
      numpy
      pillow
      matplotlib
      torchvision-bin
      virtualenv
      tensorflowWithCuda
      keras
      pandas
      librosa
      scikit-learn
    ]
  );
in
{
  default = (
    pkgs.mkShell {
      buildInputs = [
        pythonWithPackages
        cuda.cuda-native-redist
      ];

      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];

      shellHook = ''
        ${pythonWithPackages}/bin/python3 --version
        export PYTHONHOME=${pythonWithPackages}
        export PATH=${pythonWithPackages}/bin:$PATH

        rm -rf $PWD/env
        ln -sv ${pythonWithPackages} $PWD/env
        exec zsh
      '';
    }
  );
}

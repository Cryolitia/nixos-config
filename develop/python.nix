{ pkgs, ... }:
let
  pythonVersion = "python311";
  venvPythonVersion = "python3.11";

  pythonWithPackages = pkgs."${pythonVersion}Packages".python.withPackages (
    ps: with ps; [
      python
      venvShellHook
      numpy
      pillow
      matplotlib
      virtualenv
    ]
  );
in
{
  default = (
    pkgs.mkShell {
      buildInputs = [
        pythonWithPackages
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

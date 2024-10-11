{ pkgs, ... }:
let
  pythonVersion = "python311";
in
(pkgs.mkShell {
  buildInputs = with pkgs."${pythonVersion}Packages"; [
    python
    venvShellHook
    virtualenv
    networkx
    numpy
    pillow
    matplotlib
    pandas
    scikit-learn
    joblib
    pygobject3
    pyudev
    networkx
    jieba
  ];

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

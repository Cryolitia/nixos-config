{ pkgs, ... }:

(pkgs.mkShell {

  buildInputs = (
    (with pkgs.python310Packages; [
      venvShellHook
      numpy
      pillow
      matplotlib
      virtualenv
      pandas
      scikit-learn
      joblib
      pygobject3
      pyudev
      networkx
      jieba
      #pkuseg
      #wordcloud
    ])
    ++ (with pkgs; [ python310 ])
  );

  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];

  shellHook = ''
    cd ~
    echo "`${pkgs.python310}/bin/python3 --version`"
    rm -v $HOME/venv/bin/python
    virtualenv --no-setuptools venv
    export PATH=$PWD/venv/bin:$PATH
    export PYTHONPATH=venv/lib/python3.10/site-packages/:$PYTHONPATH
    exec zsh
  '';

  postShellHook = ''
    ln -sf PYTHONPATH/* ${pkgs.virtualenv}/lib/python3.10/site-packages
  '';
})

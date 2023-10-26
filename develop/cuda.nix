{ pkgs, ... }:

let

  cuda = import ../common/software/cuda.nix { inherit pkgs; };

in
(pkgs.mkShell {

  buildInputs = (
    (with pkgs.python310Packages; [
      pytorch-bin
      venvShellHook
      numpy
      pillow
      matplotlib
      torchvision-bin
    ]) ++ (with pkgs; [
      python310
      cuda.cuda-native-redist
      virtualenv
      jetbrains.pycharm-professional
    ])
  );

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

{
  description = "A Nix-flake-based CUDA development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self , nixpkgs ,... }: 
  let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = 
    let
      pkgs = import nixpkgs {
        config = {
          allowUnfree = true;
          cudaSupport = true;
        };
        inherit system;
      };
    in (pkgs.mkShell {
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
          cudaPackages.cudatoolkit
          virtualenv
          jetbrains.pycharm-professional
        ]));
      shellHook = ''
        cd ~
        echo "`${pkgs.python310}/bin/python3 --version`"
        virtualenv --no-setuptools venv
        export PATH=$PWD/venv/bin:$PATH
        export PYTHONPATH=venv/lib/python3.10/site-packages/:$PYTHONPATH
        exec zsh
      '';
      postShellHook = ''
        ln -sf PYTHONPATH/* ${pkgs.virtualenv}/lib/python3.10/site-packages
      '';
    });
  };
}
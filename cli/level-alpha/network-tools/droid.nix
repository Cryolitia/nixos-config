{ pkgs, ... }:

{
  environment.packages = (
    with pkgs;
    [
      iperf
      doggo
      mtr
    ]
  );
}

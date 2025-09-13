{ pkgs, ... }:
let
  dn42-cacert = pkgs.callPackage ./dn42-cacert/package.nix { };
in
{
  security.pki.certificateFiles = [
    "${dn42-cacert}/etc/ssl/certs/dn42-ca.crt"
  ];
}

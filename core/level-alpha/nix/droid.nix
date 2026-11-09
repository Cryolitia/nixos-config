{
  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
}

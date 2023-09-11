#! /usr/bin/env bash

sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +1
nix-env --delete-generations +1
sudo nix-collect-garbage -d
nix-collect-garbage -d

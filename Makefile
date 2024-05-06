.PHONY: boot-nom, boot, build-nom, build, build-no-cache

boot-nom:
	sudo nixos-rebuild boot --flake .# --log-format internal-json -v --accept-flake-config |& nom --json

boot:
	sudo nixos-rebuild boot --flake .# -v -L

build-nom:
	nixos-rebuild build --flake .# --log-format internal-json -v --accept-flake-config |& nom --json

build:
	nixos-rebuild build --flake .# -v -L --show-trace

build-no-cache:
	nixos-rebuild build --flake .# -v -L --show-trace --option eval-cache false

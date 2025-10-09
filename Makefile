.PHONY: boot-nom, switch, boot, build-nom, build, build-no-cache, remote, clean, fmt

boot-nom: fmt deadnix
	sudo nixos-rebuild boot --flake .# --log-format internal-json -v --accept-flake-config |& nom --json

switch: fmt
	sudo nixos-rebuild switch --flake .# --log-format internal-json -v --accept-flake-config |& nom --json

boot:
	sudo nixos-rebuild boot --flake .# -v -L

build-nom:
	nixos-rebuild build --flake .# --log-format internal-json -v --accept-flake-config |& nom --json

build:
	nixos-rebuild build --flake .# -v -L --show-trace

build-no-cache:
	nixos-rebuild build --flake .# -v -L --show-trace --option eval-cache false

remote:
	sudo nixos-rebuild boot --flake .# --log-format internal-json -v --accept-flake-config --max-jobs 0 |& nom --json

clean:
	sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +1
	nix-env --delete-generations +1
	sudo nix-collect-garbage -d
	nix-collect-garbage -d

	echo "Current GC root:"
	ls /nix/var/nix/gcroots/auto/ -al

fmt:
	nix fmt -- --tree-root .

deadnix:
	nix run nixpkgs#deadnix . -vL

update:
	nix flake update
	./update.py

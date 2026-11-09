{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot.binfmt = {
    preferStaticEmulators = true;

    # https://github.com/felixonmars/archriscv-packages/blob/7c270ecef6a84edd6031b357b7bd1f6be2d6d838/devtools-riscv64/z-archriscv-qemu-riscv64.conf
    registrations =
      lib.genAttrs
        (lib.intersectLists config.boot.binfmt.emulatedSystems [
          "aarch64-linux"
          "riscv64-linux"
        ])
        (system: {
          wrapInterpreterInShell = false;
          preserveArgvZero = true;
          matchCredentials = true;
          fixBinary = true;
          interpreter = "${pkgs.pkgsStatic.qemu-user}/bin/qemu-${lib.removeSuffix "-linux" system}";
        });
  };
}

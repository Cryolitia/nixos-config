{ ... }: {
    nixpkgs.overlays = [
        (final: prev: {
            python3 = prev.python3.override {
                packageOverrides = _: prev: {
                    # TODO: Remove when fixed in nixpkgs
                    tpm2-pytss = prev.tpm2-pytss.overridePythonAttrs {
                        hardeningDisable = [ "fortify" ];
                    };
                };
            };
        })
    ];
}
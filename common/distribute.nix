{ config, pkgs, ...}:

{
    # nix.settings.max-jobs = 0;
    nix.distributedBuilds = true;
    nix.buildMachines = [
        {
            hostName = "192.168.50.69";
            sshUser = "cryolitia";
            sshKey = "/home/cryolitia/.ssh/id_ed25519";
            systems = [
                "x86_64-linux"
                "aarch64-linux"
            ];
            supportedFeatures = [
                "benchmark"
                "big-parallel"
                "kvm"
            ];
            protocol = "ssh-ng";
        }
    ];
    nix.extraOptions = ''
		builders-use-substitutes = true
	'';
}
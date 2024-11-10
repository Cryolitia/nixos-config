{ ... }:

{
  # nix.settings.max-jobs = 0;
  nix.distributedBuilds = true;
  nix.buildMachines = [
    {
      hostName = "gpd.lan";
      sshUser = "cryolitia";
      sshKey = "/home/cryolitia/.ssh/id_ed25519";
      systems = [
        "x86_64-linux"
      ];
      supportedFeatures = [
        "benchmark"
        "big-parallel"
        "kvm"
      ];
      protocol = "ssh-ng";
      maxJobs = 16;
      speedFactor = 2;
    }
    {
      hostName = "kp920.lan";
      sshUser = "cryolitia";
      sshKey = "/home/cryolitia/.ssh/id_ed25519";
      systems = [
        "aarch64-linux"
      ];
      supportedFeatures = [
        "benchmark"
        "big-parallel"
        "kvm"
      ];
      protocol = "ssh-ng";
      maxJobs = 8;
      speedFactor = 2;
    }
  ];
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';
}

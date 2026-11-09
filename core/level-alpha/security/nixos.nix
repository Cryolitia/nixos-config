{ ... }:
{
  security.sudo.wheelNeedsPassword = false;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel"))
        return polkit.Result.YES;
    });
  '';

  security.pam.loginLimits = [
    {
      domain = "*";
      item = "nofile";
      type = "-";
      # https://github.com/lutris/docs/blob/master/HowToEsync.md
      value = "524288";
    }
  ];
}

{ pkgs, config }:

with config.nur.repos.linyinfeng.rimePackages;
((
  withRimeDeps [
    rime-ice
  ]) ++ (with config.nur.repos; [
  pkgs.rime-data
  linyinfeng.rimePackages.rime-emoji
  xddxdd.rime-moegirl
  xddxdd.rime-zhwiki
  pkgs.nur-cryolitia.rime-latex
  pkgs.nur-cryolitia.rime-project-trans
]
))


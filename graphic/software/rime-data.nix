{ pkgs, ... }:

with pkgs.nur.repos.linyinfeng.rimePackages;
(
  (withRimeDeps [ rime-ice ])
  ++ (with pkgs.nur.repos; [
    pkgs.rime-data
    linyinfeng.rimePackages.rime-emoji
    xddxdd.rime-moegirl
    xddxdd.rime-zhwiki
    pkgs.nur-cryolitia.rime-latex
    pkgs.nur-cryolitia.rime-project-trans
  ])
)

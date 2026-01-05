{ ... }:

{
  services.rsnapshot = {
    enable = true;
    extraConfig = ''
      retain	daily	3
      retain	weekly	4

      link_dest	1	#增量备份，节省空间
      use_lazy_deletes	1	#避免删除旧文件过程中断生成坏备份

      snapshot_root	/mnt/NAS/Data
      backup	/var/lib/data	rpi
    '';

    cronIntervals = {
      daily = "0 4 * * *";
      weekly = "0 5 * * 1";
    };
  };
}

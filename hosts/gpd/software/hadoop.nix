{ config, pkgs, ...}:

{
  services.hadoop = {
    gatewayRole.enable = true;
    coreSite = {
      "fs.defaultFS" = "hdfs://localhost";
      "hadoop.tmp.dir" = "file:/var/lib/hadoop";
    };
    hdfsSite = {
      "dfs.replication" = 1;
      "dfs.namenode.name.dir" = "file:/var/lib/hadoop/dfs/name";
      "dfs.datanode.data.dir" = "file:/var/lib/hadoop/dfs/data";
    };
    hdfs = {
      namenode = {
        enable = true;
        formatOnInit = true;
      };
      datanode.enable = true;
    };
  };
}

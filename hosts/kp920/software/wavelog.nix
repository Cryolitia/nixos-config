{ pkgs, ... }:

{
  virtualisation.oci-containers.containers = {
    wavelog-db = {
      image = "mariadb:11.3";
      environment = {
        MARIADB_RANDOM_ROOT_PASSWORD = "yes";
        MARIADB_DATABASE = "wavelog";
        MARIADB_USER = "wavelog";
        MARIADB_PASSWORD = "wavelog"; # <- Insert a strong password here
      };
      volumes = [
        "/var/lib/data/wavelog/dbdata:/var/lib/mysql"
      ];
    };

    wavelog-main = {
      image = "ghcr.io/wavelog/wavelog:2.0.4";
      dependsOn = [ "wavelog-db" ];
      environment = {
        CI_ENV = "docker";
      };
      ports = [ "8086:80" ];
      volumes = [
        "/var/lib/data/wavelog/config:/var/www/html/application/config/docker"
        "/var/lib/data/wavelog/uploads:/var/www/html/uploads"
        "/var/lib/data/wavelog/userdata:/var/www/html/userdata"
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 8086 ];
}

  #PostgreSQL
  services.postgresql = {
  enable = true;
  package = pkgs.postgresql_15;
  dataDir = "/home/fabio/data/postgresql";
  ensureDatabases = [ "mydatabase" ];
  enableTCPIP = true;
  port = 5432;
  authentication = pkgs.lib.mkOverride 10 ''
    #...
    #type database DBuser origin-address auth-method
    # ipv4
    host  all      all     127.0.0.1/32   trust
    # ipv6
    host all       all     ::1/128        trust
  '';
  };

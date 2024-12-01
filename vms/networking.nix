{...}: let
  # Can be found with `ip link`
  # Could be different for you
  netinterface = "enp2s0";
in {
  systemd.network = {
    networks = {
      "10-lan" = {
        matchConfig.Name = [netinterface "vm-*"];
        networkConfig = {
          Bridge = "br0";
        };
      };
      "10-lan-bridge" = {
        matchConfig.Name = "br0";
        networkConfig = {
          Address = ["192.168.1.200/24" "2001:db8::a/64"];
          Gateway = "192.168.1.1";
          DNS = ["9.9.9.9"];
          IPv6AcceptRA = true;
        };
        linkConfig.RequiredForOnline = "routable";
      };
    };
    netdevs = {
      "br0" = {
        netdevConfig = {
          Name = "br0";
          Kind = "bridge";
        };
      };
    };
  };
  # Now all host connections with be on br0
  # If you lets say want to ssh into the server, the ip would be 192.168.1.200
}

{
  # Enable IP forwarding for router functionality
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = 1;

  networking.interfaces = {
    wan = {
      name = "enp1s0";
      pppoe.enable = true;
      pppoe.username = "digiweb@siro.digiweb.ie";
      pppoe.password = "";
      ipv4.method = "pppoe";
    };
    lan = {
      name = "enp2s0";
      ipv4.method = "static";
      ipv4.addresses = [
        {
          address = "10.0.0.1";
          prefixLength = 16;
        }
      ];
    };
  };

  # VLAN configuration
  networking.vlans.vlan10 = {
    id = 10;
    interface = "vtnet1";
  };

  # NAT configuration
  networking.nat = {
    enable = true;
    enableIPv6 = true;
    externalInterface = "wan";
    internalInterfaces = ["lan" "opt1"];
  };
}

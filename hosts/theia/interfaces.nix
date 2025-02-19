{
  networking.interfaces = {
    wan = {
      pppoe.enable = true;
      pppoe.username = "digiweb@siro.digiweb.ie";
      pppoe.password = "ZGlnaXdlYg==";
      ipv4.method = "pppoe";
    };
    lan = {
      ipv4.method = "static";
      ipv4.addresses = [
        {
          address = "10.0.0.1";
          prefixLength = 16;
        }
      ];
    };
    opt1 = {
      vlan.id = 10;
      # Add configuration for DHCP or static IP on this interface if needed
    };
  };
  networking.vlans.vlan10 = {
    link = "vtnet1";
  };
}

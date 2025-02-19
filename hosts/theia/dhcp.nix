{
  services.dhcpd4.enable = true;
  services.dhcpd4.interfaces = ["lan"];
  services.dhcpd4.options = {
    dhcpdConfigFile = ''
      option domain-name "delaney-house.com";
      option domain-name-servers 192.168.1.2;
      option routers 192.168.1.1;

      subnet 192.168.1.0 netmask 255.255.0.0 {
        range 192.168.1.100 192.168.1.254;
      }

      # # Static mappings
      # host master-bedroom-bulb {
      #   hardware ethernet d0:73:d5:3f:05:ba;
      # }
      # host unifi-16port-switch {
      #   hardware ethernet 68:d7:9a:41:0b:14;
      #   fixed-address 192.168.1.6;
      # }
    '';
  };
}

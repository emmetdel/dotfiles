{
  # Basic firewall configuration
  networking.firewall = {
    enable = true;
    allowPing = true;

    # Allow established connections
    extraCommands = ''
      iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
      iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
    '';

    # Allow DNS, DHCP, HTTP, HTTPS from internal networks
    trustedInterfaces = ["lan" "opt1"];
  };

  # Allow DNS, DHCP, HTTP, HTTPS from internal networks
  networking.firewall.allowedTCPPorts = [53 67 68 80 443];
  networking.firewall.allowedUDPPorts = [53 67 68];
}

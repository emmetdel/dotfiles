{pkgs, ...}: {
  # Blocky DNS server
  services.blocky = {
    enable = true;
    settings = {
      ports = {
        dns = 53;
        http = 4000;
      };
      upstream = {
        default = [
          "https://dns.cloudflare.com/dns-query"
          "https://dns.google/dns-query"
        ];
      };
      blocking = {
        blackLists = {
          ads = [
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
          ];
        };
        clientGroupsBlock = {
          default = ["ads"];
        };
      };
      caching = {
        minTime = "5m";
        maxTime = "30m";
        prefetching = true;
      };
      prometheus = {
        enable = true;
        path = "/metrics";
      };
    };
  };

  # Cloudflare Tunnel
  services.cloudflared = {
    enable = true;
    tunnels = {
      "home-tunnel" = {
        credentialsFile = "/var/lib/cloudflared/tunnel-credentials.json";
        default = "http_status:404";
        ingress = {
          # Add your ingress rules here
          # Example:
          # "subdomain.yourdomain.com" = "http://localhost:8080";
        };
      };
    };
  };

  # UniFi Controller
  services.unifi = {
    enable = true;
    unifiPackage = pkgs.unifi7;
    openFirewall = true;
    # MongoDB is required for UniFi
    mongodbPackage = pkgs.mongodb;
  };

  # Open required ports
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      53 # DNS
      4000 # Blocky HTTP interface
      8080 # UniFi HTTP portal
      8443 # UniFi HTTPS portal
      8880 # UniFi HTTP redirect
      8843 # UniFi HTTPS redirect
      6789 # UniFi mobile speed test
    ];
    allowedUDPPorts = [
      53 # DNS
      3478 # UniFi STUN
      10001 # UniFi device discovery
    ];
  };
}

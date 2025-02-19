{enable ? false}: {
  services.wireguard = {
    enable = enable;
    interfaces = ["wan"];
    peers = [
      {
        publicKey = "XBKFbjn5WXyts2wlKEY+jwfnmukqxxmgbkYDNYcnMhc=";
        allowedIPs = ["10.10.10.2/32"];
      }
    ];
  };
}

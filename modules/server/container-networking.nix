{ prefixLength, ipAddr, ... }:

{
  networking = {
    interfaces.eth0.ipv4.addresses = [
      {
        address = "192.168.179.101";
        inherit prefixLength;
      }
    ];

    defaultGateway = {
      address = "192.168.178.1";
      interface = "eth0";
    };

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };
}

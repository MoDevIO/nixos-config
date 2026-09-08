{
  hostname,
  networkInterface,
  ipAddr,
  prefixLength,
  ...
}:

{
  services.openssh.enable = true;

  networking = {
    networkmanager.enable = true;
    hostName = hostname;

    interfaces.${networkInterface}.ipv4.addresses = [
      {
        address = ipAddr;
        prefixLength = prefixLength;
      }
    ];
  };

  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  networking.nat = {
    enable = true;
    externalInterface = networkInterface;
    internalInterfaces = [ "ve-+" ];
  };
}

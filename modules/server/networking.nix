{
  hostname,
  networkInterface,
  ipAddr,
  prefixLength,
  ...
}:

{
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDQGs63zr5X6vgRhUD6+gOWXYaBsvHDddH/RwnccbkEp momo.tiltis@gmail.com"
  ];

  networking = {
    bridges.br0.interfaces = [ networkInterface ];
    hostName = hostname;

    defaultGateway = {
      address = "192.168.178.1";
      interface = "br0";
    };

    interfaces = {
      br0.ipv4.addresses = [
        {
          address = ipAddr;
          prefixLength = prefixLength;
        }
      ];
    };
  };

  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];
}

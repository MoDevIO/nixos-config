{
  prefixLength,
  ipAddr,
  containerIpAddr,
  ...
}:

{
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDQGs63zr5X6vgRhUD6+gOWXYaBsvHDddH/RwnccbkEp momo.tiltis@gmail.com"
  ];

  networking = {
    interfaces.eth0.ipv4.addresses = [
      {
        address = containerIpAddr;
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

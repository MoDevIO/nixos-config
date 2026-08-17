{ config, pkgs, ... }:

{
  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.age.keyFile = "/home/mo/.config/sops/age/keys.txt";

  sops.secrets.gmail_auth_key = { };

  programs.neomutt = {
    enable = true;
    editor = "nvim";
    vimKeys = true;

  };

  accounts.email.accounts."momo.tiltis@gmail.com" = {
    primary = true;
    address = "momo.tiltis@gmail.com";
    realName = "Mo";
    flavor = "gmail.com";
    userName = "momo.tiltis@gmail.com";
    neomutt.mailboxType = "imap";
    passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.gmail_auth_key.path}";

    folders = {
      inbox = "INBOX";
      drafts = "[Gmail]/Drafts";
      sent = "[Gmail]/Sent Mail";
      trash = "[Gmail]/Bin";
    };

    neomutt.enable = true;
  };
}

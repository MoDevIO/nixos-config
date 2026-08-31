{ config, pkgs, ... }:

{

  sops.secrets.gmail_auth_key = { };

  home.packages = [ pkgs.w3m ];
  programs.neomutt = {
    enable = true;
    editor = "nvim";
    vimKeys = true;

    extraConfig = ''
      set mailcap_path = "~/.config/neomutt/mailcap"
      auto_view text/html
      alternative_order text/plain text/enriched text/html

      bind pager q exit
      bind browser q exit
      bind attach q exit
      bind compose q exit
      bind index q quit
    '';
  };
  xdg.configFile."neomutt/mailcap".text = ''
    text/html; ${pkgs.w3m}/bin/w3m -I %{charset} -T text/html -dump; copiousoutput
  '';

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

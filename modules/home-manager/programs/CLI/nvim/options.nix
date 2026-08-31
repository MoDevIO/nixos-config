{
  programs.nixvim.opts = {
    number = true;
    cursorline = true;
    relativenumber = true;
    statuscolumn = "%=%{v:relnum?v:relnum:v:lnum} %s";

    fillchars = "eob: ";

    tabstop = 2;
    softtabstop = 2;
    shiftwidth = 2;
    expandtab = true;
  };
}

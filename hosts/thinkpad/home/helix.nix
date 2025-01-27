{ ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    languages = {
      language = [{ name = "nix"; formatter = { command = "nixfmt"; }; }];
    };
    settings = {
      theme = "base16_transparent";
      editor = {
        true-color = true;
        color-modes = true;
        idle-timeout = 75;
        indent-guides.render = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        soft-wrap.enable = true;
      };

      keys.normal = {
        g = { a = "code_action"; };
        "0" = "goto_line_start";
        "$" = "goto_line_end";
      };

      keys.select = {
        "0" = "goto_line_start";
        "$" = "goto_line_end";
      };

      keys.insert = { j = { k = "normal_mode"; }; };
    };
  };
}

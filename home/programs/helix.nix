{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "ayu_evolve";
      editor = {
        true-color = true;
        color-modes = true;
        cursorline = true;
        idle-timeout = 75;
        inline-diagnostics.cursor-line = "hint";
        indent-guides.render = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        soft-wrap.enable = true;
        lsp = {
          display-inlay-hints = false;
        };
      };

      keys.normal = {
        g = {
          a = "code_action";
        };
        "0" = "goto_line_start";
        "$" = "goto_line_end";
        "ret" = "goto_word";
        "space" = {
          o = "file_picker_in_current_buffer_directory";
        };
      };

      keys.select = {
        "0" = "goto_line_start";
        "$" = "goto_line_end";
      };

      keys.insert = {
        j = {
          k = "normal_mode";
        };
      };
    };
  };

}

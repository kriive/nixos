{ ... }:

{
  programs.zathura = {
    enable = true;
    options = {
      window-title-basename = "true";
      selection-clipboard = "clipboard";

      notification-error-bg = "#ff5555";
      notification-error-fg = "#a29fa0";
      notification-warning-bg = "#ffb86c";
      notification-warning-fg = "#44475a";
      notification-bg = "#001514";
      notification-fg = "#a29fa0";

      completion-bg = "#001514";
      completion-fg = "#6272a4";
      completion-group-bg = "#001514";
      completion-group-fg = "#6272a4";
      completion-highlight-bg = "#44475a";
      completion-highlight-fg = "#a29fa0";

      index-bg = "#001514";
      index-fg = "#a29fa0";
      index-active-bg = "#44475a";
      index-active-fg = "#a29fa0";

      inputbar-bg = "#001514";
      inputbar-fg = "#a29fa0";
      statusbar-bg = "#001514";
      statusbar-fg = "#a29fa0";

      highlight-color = "#ffb86c";
      highlight-active-color = "#ff79c6";

      default-bg = "#001514";
      default-fg = "#a29fa0";

      render-loading = true;
      render-loading-fg = "#001514";
      render-loading-bg = "#a29fa0";

      recolor-lightcolor = "#001514";
      recolor-darkcolor = "#a29fa0";

      adjust-open = "width";
      recolor = true;
    };
  };
}

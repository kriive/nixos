let
  mkModel = name: context: output: {
    inherit name;
    limit = { inherit context output; };
    modalities = {
      input = [
        "text"
        "image"
        "pdf"
      ];
      output = [ "text" ];
    };
  };
  thinkingVariants = {
    low.thinkingConfig.thinkingBudget = 8192;
    max.thinkingConfig.thinkingBudget = 32768;
  };
in
{
  programs.opencode = {
    enable = true;
    settings = {
      plugin = [ "opencode-antigravity-auth@beta" ];
      provider.google.models = {
        antigravity-gemini-3-pro = mkModel "Gemini 3 Pro (Antigravity)" 1048576 65535 // {
          variants = {
            low.thinkingLevel = "low";
            high.thinkingLevel = "high";
          };
        };
        antigravity-gemini-3-flash = mkModel "Gemini 3 Flash (Antigravity)" 1048576 65536 // {
          variants = {
            minimal.thinkingLevel = "minimal";
            low.thinkingLevel = "low";
            medium.thinkingLevel = "medium";
            high.thinkingLevel = "high";
          };
        };
        antigravity-claude-sonnet-4-5 =
          mkModel "Claude Sonnet 4.5 (no thinking) (Antigravity)" 200000
            64000;
        antigravity-claude-sonnet-4-5-thinking =
          mkModel "Claude Sonnet 4.5 Thinking (Antigravity)" 200000 64000
          // {
            variants = thinkingVariants;
          };
        antigravity-claude-opus-4-5-thinking =
          mkModel "Claude Opus 4.5 Thinking (Antigravity)" 200000 64000
          // {
            variants = thinkingVariants;
          };
        "gemini-2.5-flash" = mkModel "Gemini 2.5 Flash (Gemini CLI)" 1048576 65536;
        "gemini-2.5-pro" = mkModel "Gemini 2.5 Pro (Gemini CLI)" 1048576 65536;
        gemini-3-flash-preview = mkModel "Gemini 3 Flash Preview (Gemini CLI)" 1048576 65536;
        gemini-3-pro-preview = mkModel "Gemini 3 Pro Preview (Gemini CLI)" 1048576 65535;
      };
    };
  };
}

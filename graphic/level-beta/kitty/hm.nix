{
  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font Mono";
    shellIntegration.enableZshIntegration = true;
    themeFile = "Catppuccin-Frappe";
    extraConfig = ''
      background_opacity 0.8
      wayland_titlebar_color background
      map ctrl+c copy_or_interrupt
      map ctrl+v paste_from_clipboard
    '';
  };
}

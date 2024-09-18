{
  programs.waybar = {
    enable = true;
    settings = "${./config.jsonc}";
    style = "${./style.css}";
  };
}

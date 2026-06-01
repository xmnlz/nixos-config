{...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.95;
        dynamic_padding = true;
        padding = {
          x = 4;
          y = 4;
        };
      };
    };
  };
}

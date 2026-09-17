-- Window and layer rules
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/

hl.window_rule({
  -- Ignore maximize requests from apps
  name = "suppress-maximize-events",
  match = { class = ".*" },

  suppress_event = "maximize",
})

hl.window_rule({
  -- Fix some dragging issues with XWayland
  name = "fix-xwayland-drags",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },

  no_focus = true,
})

hl.window_rule({
  name = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move = "20 monitor_h-120",
  float = true,
})

hl.window_rule({
  name = "center-bitwarden",
  match = { class = "^bitwarden$" },

  float = true,
  center = true,
})

hl.window_rule({
  name = "picture-in-picture",
  match = { title = "^[Pp]icture[- ][Ii]n[- ][Pp]icture$" },

  float = true,
  pin = true,
  size = { 480, 270 },
  move = { "monitor_w-488", "monitor_h-278" },
  keep_aspect_ratio = true,
  no_initial_focus = true,
  suppress_event = "activate activatefocus",
})

hl.layer_rule({
  name = "vicinae-blur",
  match = { namespace = "vicinae" },

  blur = true,
  ignore_alpha = 0,
})

hl.layer_rule({
  name = "vicinae-no-animation",
  match = { namespace = "vicinae" },

  no_anim = true,
})

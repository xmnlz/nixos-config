-- Input, devices, gestures
-- https://wiki.hypr.land/Configuring/Basics/Variables/#input

hl.config({
  input = {
    kb_layout = "us,ru",
    kb_options = "grp:alt_shift_toggle",

    follow_mouse = 1,
    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

    touchpad = {
      natural_scroll = false,
    },
  },
})

-- Per-device overrides, names come from `hyprctl devices`.
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
hl.device({
  name = "pixa3854:00-093a:0274-touchpad",
  natural_scroll = true,
})

hl.device({
  name = "logitech-g403-prodigy-gaming-mouse",
  accel_profile = "flat",
  sensitivity = -0.5,
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

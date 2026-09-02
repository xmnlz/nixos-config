-- Autostart
-- https://wiki.hypr.land/Configuring/Basics/Autostart/

local programs = require("config.programs")

hl.on("hyprland.start", function()
  hl.exec_cmd(programs.browser, { workspace = "1 silent" })
  hl.exec_cmd(programs.telegram, { workspace = "2 silent" })
  hl.exec_cmd(programs.terminal, { workspace = "3 silent" })
end)

-- Monitors
-- https://wiki.hypr.land/Configuring/Basics/Monitors/
--
-- The two screens of this machine are pinned by hand. Anything else that gets
-- plugged in is picked up by the hotplug handler at the bottom of this file:
-- it gets its best mode (highest resolution, then highest refresh rate), an
-- auto scale, and a workspace of its own so it doesn't steal 1/2/3.

-- Order matters: `auto-*` positions are resolved against the monitors placed
-- before them.
local STATIC = {
  { output = "eDP-1", mode = "2880x1920@120", position = "auto-right", scale = 2 },
  { output = "DP-3",  mode = "1920x1080@144", position = "auto-left",  scale = 1 },
}

local STATIC_WORKSPACES = {
  { workspace = "1", monitor = "DP-3" },
  { workspace = "2", monitor = "eDP-1" },
  { workspace = "3", monitor = "DP-3" },
}

-- Where a hotplugged monitor lands in the layout.
local DYNAMIC_POSITION = "auto-right"

local staticOutputs = {}
for _, spec in ipairs(STATIC) do
  staticOutputs[spec.output] = true
  hl.monitor(spec)
end

-- Fallback rule, applied to any output without one of its own. The hotplug
-- handler replaces it with something better, but this keeps an unknown monitor
-- usable even if that never runs.
hl.monitor({ output = "", mode = "highres", position = DYNAMIC_POSITION, scale = "auto" })

local staticWorkspaceIDs = {}
for _, rule in ipairs(STATIC_WORKSPACES) do
  staticWorkspaceIDs[tonumber(rule.workspace)] = true
  hl.workspace_rule(rule)
end

---------------------------
---- DYNAMIC  MONITORS ----
---------------------------

-- [output name] = { workspace = id, rule = HL.WorkspaceRule }
local dynamic = {}

-- Highest resolution, ties broken by highest refresh rate.
local function bestMode(monitor)
  local best
  for _, mode in ipairs(monitor.available_modes or {}) do
    local area = mode.width * mode.height
    if not best then
      best = mode
    else
      local bestArea = best.width * best.height
      if area > bestArea or (area == bestArea and mode.refresh_rate > best.refresh_rate) then
        best = mode
      end
    end
  end
  return best
end

-- Lowest workspace ID that is neither pinned to a static monitor nor already
-- in use somewhere.
local function freeWorkspaceID()
  local used = {}
  for id in pairs(staticWorkspaceIDs) do
    used[id] = true
  end
  for _, entry in pairs(dynamic) do
    used[entry.workspace] = true
  end
  for _, ws in ipairs(hl.get_workspaces()) do
    if not ws.special and ws.id > 0 then
      used[ws.id] = true
    end
  end

  local id = 1
  while used[id] do
    id = id + 1
  end
  return id
end

-- Hyprland already put a workspace on the monitor by the time we get here.
-- Keep it if it isn't one of the pinned ones, so the assignment survives a
-- `hyprctl reload` (which wipes every rule and re-runs this file).
local function workspaceFor(monitor)
  local active = monitor.active_workspace
  if active and not active.special and active.id > 0 and not staticWorkspaceIDs[active.id] then
    return active.id
  end
  return freeWorkspaceID()
end

local function configure(monitor)
  if staticOutputs[monitor.name] or dynamic[monitor.name] then
    return
  end

  local mode = bestMode(monitor)
  local modeString = mode and string.format("%dx%d@%.2f", mode.width, mode.height, mode.refresh_rate) or "highres"

  hl.monitor({
    output = monitor.name,
    mode = modeString,
    position = DYNAMIC_POSITION,
    scale = "auto",
  })

  local id = workspaceFor(monitor)

  dynamic[monitor.name] = {
    workspace = id,
    -- `persistent` creates the workspace and pins it here; `default` makes
    -- it the one the monitor lands on.
    rule = hl.workspace_rule({
      workspace = tostring(id),
      monitor = monitor.name,
      default = true,
      persistent = true,
    }),
  }

  hl.notification.create({
    text = string.format("%s: %s -> workspace %d", monitor.name, modeString, id),
    timeout = 4000,
    icon = "ok",
  })
end

local function release(monitor)
  local entry = dynamic[monitor.name]
  if not entry then
    return
  end

  -- Drops the pin, so the workspace stops being persistent and its ID is
  -- free again for the next monitor.
  entry.rule:set_enabled(false)
  dynamic[monitor.name] = nil
end

hl.on("monitor.added", configure)
hl.on("monitor.removed", release)

-- A reload clears every monitor/workspace rule and resets this file's state,
-- so re-apply to whatever is already connected.
hl.on("config.reloaded", function()
  for _, monitor in ipairs(hl.get_monitors()) do
    configure(monitor)
  end
end)

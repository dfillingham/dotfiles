local wezterm = require "wezterm"
local act = wezterm.action

local config = wezterm.config_builder()


config.window_background_opacity = 0.96

config.initial_cols = 120
config.initial_rows = 28

config.font = wezterm.font("Cascadia Mono NF")
config.font_size = 11

config.colors = require("cyberdream")
config.default_cwd = wezterm.home_dir

config.window_close_confirmation = "NeverPrompt"
config.mux_enable_ssh_agent = false

config.keys = {
  {
    key = "c",
    mods = "CTRL",
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ""
      if has_selection then
        window:perform_action(act.CopyTo "ClipboardAndPrimarySelection", pane)
        window:perform_action(act.ClearSelection, pane)
      else
        window:perform_action(act.SendKey { key = "c", mods = "CTRL" }, pane)
      end
    end),
  },

  {
    key = "v",
    mods = "CTRL",
    action = wezterm.action.PasteFrom "Clipboard"
  },
  
  { 
    key = "V",
    mods = "SHIFT|CTRL",
    action = wezterm.action_callback(function(window, pane)
      window:perform_action(wezterm.action.SendKey{ key="v", mods="CTRL" }, pane) end),
  },

  {
    key = "T",
    mods = "SHIFT|CTRL",
    action = wezterm.action.SpawnCommandInNewTab {
      cwd = wezterm.home_dir,
    },
  },
}


return config


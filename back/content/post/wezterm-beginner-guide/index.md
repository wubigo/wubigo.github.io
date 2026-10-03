+++
title = "Wezterm Beginner Guide"
date = 2026-4-03T11:19:58+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["AGENT"]
categories = []

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
+++

# 安装

[wezterm](https://github.com/wezterm/wezterm/releases/download/20240203-110809-5046fc22/WezTerm-20240203-110809-5046fc22-setup.exe)


# 初始化配置文件

`~/.wezterm.lua`


```
local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- Font (install a Nerd Font first)
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14
config.line_height = 1.2

-- Window
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.window_background_opacity = 0.9
config.macos_window_background_blur = 10  -- macOS only

-- Scrollback
config.scrollback_lines = 5000

-- Color scheme (735 built-in options)
config.color_scheme = 'Hardcore'

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 2000 }

config.keys = {
  -- Tabs
  { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
  { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
  { key = '&', mods = 'LEADER', action = act.CloseCurrentTab{ confirm = true } },
  
  -- Panes
  { key = '|', mods = 'LEADER', action = act.SplitHorizontal{ domain = 'CurrentPaneDomain' } },
  { key = '-', mods = 'LEADER', action = act.SplitVertical{ domain = 'CurrentPaneDomain' } },
  { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },
  { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane{ confirm = true } },
  
  -- Vim-style pane navigation
  { key = 'h', mods = 'CTRL', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'CTRL', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'CTRL', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'CTRL', action = act.ActivatePaneDirection 'Right' },
  
  -- Pane resizing
  { key = 'h', mods = 'ALT', action = act.AdjustPaneSize{ 'Left', 5 } },
  { key = 'j', mods = 'ALT', action = act.AdjustPaneSize{ 'Down', 5 } },
  { key = 'k', mods = 'ALT', action = act.AdjustPaneSize{ 'Up', 5 } },
  { key = 'l', mods = 'ALT', action = act.AdjustPaneSize{ 'Right', 5 } },
  
  -- Copy mode
  { key = '[', mods = 'LEADER', action = act.ActivateCopyMode },
  
  -- Workspace keybindings
  { key = 's', mods = 'LEADER', action = act.ShowLauncherArgs{ flags = 'FUZZY|WORKSPACES' } },
  { key = 'a', mods = 'LEADER', action = act.AttachDomain 'unix' },
  { key = 'd', mods = 'LEADER', action = act.DetachDomain{ DomainName = 'unix' } },
}


-- GPU frontend (WebGpu, OpenGL, or Software)
config.front_end = "WebGpu"

-- Reduce animation FPS if GPU issues
config.animation_fps = 60

-- Dim inactive panes
config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.7,
}


wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

config.colors = {
  foreground = "#CBE0F0",
  background = "#011423",
  cursor_bg = "#47FF9C",
  cursor_border = "#47FF9C",
  cursor_fg = "#011423",
  selection_bg = "#033259",
  selection_fg = "#CBE0F0",
  ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073",
           "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
  brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073",
              "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
}
return config



```



# SSH

`~~\.ssh\config`

```
Host aws
    HostName 144.12.56.108
    User ubuntu
    IdentityFile C:\Users\bigo\.ssh\ssh-key-09-10.key
```

```
ssh aws
ubuntu@w1:~$opencode
```
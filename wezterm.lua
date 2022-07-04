local colors = require("lua/rose-pine").colors()
local window_frame = require("lua/rose-pine").window_frame()

local wezterm = require "wezterm"

local launch_menu = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  ssh_cmd = { "powershell.exe" }

  table.insert(
    launch_menu,
    {
      label = "Bash",
      args = { "C:/Program Files/Git/bin/bash.exe", "-li" }
    }
  )

  table.insert(
    launch_menu,
    {
      label = "CMD",
      args = { "cmd.exe" }
    }
  )

  table.insert(
    launch_menu,
    {
      label = "PowerShell Core",
      args = { "pwsh.exe", "-NoLogo" }
    }
  )

  table.insert(
    launch_menu,
    {
      label = "PowerShell",
      args = { "powershell.exe", "-NoLogo" }
    }
  )

  table.insert(launch_menu, {
    label = "PowerShellCore",
    args = { "C:/Program Files/PowerShell/7/pwsh.exe", "-WorkingDirectory", wezterm.home_dir },
    domain = { DomainName = "local" },
  })
end

local mouse_bindings = {
  -- 右键粘贴
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = wezterm.action { PasteFrom = "Clipboard" }
  },
  -- Change the default click behavior so that it only selects
  -- text and doesn't open hyperlinks
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = wezterm.action { CompleteSelection = "PrimarySelection" }
  },
  -- and make CTRL-Click open hyperlinks
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = "OpenLinkAtMouseCursor"
  }
}



local default_prog = { "powershell.exe" }

wezterm.on(
  "update-right-status",
  function(window)
    local date = wezterm.strftime("%Y-%m-%d %H:%M:%S ")
    window:set_right_status(
      wezterm.format(
        {
          { Text = date }
        }
      )
    )
  end
)


return {
  window_decorations                         = "RESIZE",
  native_macos_fullscreen_mode               = true,
  tab_max_width                              = 60,
  enable_scroll_bar                          = true,
  color_scheme                               = "rose-pine",
  window_background_opacity                  = 0.94,
  exit_behavior                              = "Close",
  font_size                                  = 12,
  -- 此处可配置终端字体
  -- font                                       = wezterm.font("Hack"),
  colors                                     = colors,
  window_frame                               = window_frame, -- needed only if using fancy tab
  window_padding                             = { left = 10, right = 10, top = 10, bottom = 10 },
  launch_menu                                = launch_menu,
  enable_tab_bar                             = true,
  show_tab_index_in_tab_bar                  = false,
  adjust_window_size_when_changing_font_size = false,
  mouse_bindings                             = mouse_bindings,
  default_prog                               = default_prog,
  harfbuzz_features                          = { "calt=0", "clig=0", "liga=0" },

}

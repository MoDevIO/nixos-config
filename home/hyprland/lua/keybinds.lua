local terminal = "kitty"
local browser = "firefox"
local file_manager = "nautilus"
local editor = "nvim"

local resize_increment = 20

hl.bind("SUPER + Q", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + B", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + E", hl.dsp.exec_cmd(file_manager))
hl.bind("SUPER + G", hl.dsp.exec_cmd(editor))

hl.bind("SUPER + C", hl.dsp.window.close())
hl.bind("SUPER + M", hl.dsp.exit())
hl.bind("SUPER + F", hl.dsp.window.fullscreen("maximized", "toggle"))
hl.bind("SUPER + V", hl.dsp.window.float({action = "toggle"}))

hl.bind("SUPER + H", hl.dsp.focus({direction = "left"}))
hl.bind("SUPER + J", hl.dsp.focus({direction = "down"}))
hl.bind("SUPER + K", hl.dsp.focus({direction = "up"}))
hl.bind("SUPER + L", hl.dsp.focus({direction = "right"}))

hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({direction = "left"}))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({direction = "down"}))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({direction = "up"}))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({direction = "right"}))

hl.bind("SUPER + CTRL + H",
        hl.dsp.window.resize({x = -resize_increment, y = 0, relative = true}),
        {repeating = true})
hl.bind("SUPER + CTRL + J",
        hl.dsp.window.resize({x = 0, y = resize_increment, relative = true}),
        {repeating = true})
hl.bind("SUPER +CTRL + K",
        hl.dsp.window.resize({x = 0, y = -resize_increment, relative = true}),
        {repeating = true})
hl.bind("SUPER + CTRL + L",
        hl.dsp.window.resize({x = resize_increment, y = 0, relative = true}),
        {repeating = true})

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), {mouse = true})
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), {mouse = true})

hl.bind("XF86AudioRaiseVolume",
        hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
        {locked = true, repeating = true})
hl.bind("XF86AudioLowerVolume",
        hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
        {locked = true, repeating = true})
hl.bind("XF86AudioMute",
        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
        {locked = true, repeating = true})
hl.bind("XF86AudioMicMute",
        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
        {locked = true, repeating = true})
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
        {locked = true, repeating = true})
hl.bind("XF86MonBrightnessDown",
        hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
        {locked = true, repeating = true})


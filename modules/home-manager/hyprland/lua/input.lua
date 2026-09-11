hl.config({
    input = {
        touchpad = {natural_scroll = true},
        kb_layout = "gb,gb",
        kb_variant = ",colemak_dh"
    }
})

hl.gesture({fingers = 3, direction = "horizontal", action = "workspace"})
hl.gesture({fingers = 3, direction = "down", action = "close"})
hl.gesture({fingers = 3, direction = "up", action = "fullscreen"})

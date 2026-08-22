local gkeyboard = {
    G1 = "code:191", -- G1 key on Logitech G-keys
    G2 = "code:192", -- G2 key on Logitech G-keys
    G3 = "code:193", -- G3 key on Logitech G-keys
    G4 = "code:194", -- G4 key on Logitech G-keys
    G5 = "code:195" -- G5 key on Logitech G-keys
}
local gmouse = {
    G1 = "code:196", -- Top mouse button
    G2 = "code:197", -- DPI-Shift button
    G3 = "code:200", -- Front side mouse button
    G4 = "code:199" -- Back side mouse button
}

local gkey_actions = {
    default = {},

    ["firefox"] = {
        G1 = {mods = "ctrl", key = "t"},
        G2 = {mods = "ctrl", key = "w"},
        G3 = {mods = "ctrl+shift", key = "t"},
        G4 = {mods = "ctrl+shift", key = "tab"},
        G5 = {mods = "ctrl", key = "tab"},

        MG3 = {mods = "alt", key = "right"},
        MG4 = {mods = "alt", key = "left"}
    },
    ["org.gnome.Nautilus"] = {
        MG3 = {mods = "alt", key = "right"},
        MG4 = {mods = "alt", key = "left"}
    },
    ["code"] = {
        G1 = {mods = "ctrl", key = "b"},
        G2 = {mods = "ctrl", key = "j"},
        G5 = {mods = "ctrl+alt+shift", key = "p"}
    },
    ["kitty"] = {
        G1 = {mods = "ctrl+shift", key = "t"},
        G2 = {mods = "ctrl+shift", key = "w"}
    }
}

local function custom_gkey_action(gkey)
    return function()
        local window_class = hl.get_active_window().class

        local action = nil
        if gkey_actions[window_class] and gkey_actions[window_class][gkey] then
            action = gkey_actions[window_class][gkey]

        else
            if gkey_actions["default"] and gkey_actions["default"][gkey] then
                action = gkey_actions["default"][gkey]
            end
        end

        if action then

            local mods = action.mods
            local key = action.key

            hl.dispatch(hl.dsp.send_key_state({
                mods = mods,
                key = key,
                state = "down"
            }))
            hl.dispatch(hl.dsp.send_key_state({
                mods = mods,
                key = key,
                state = "up"
            }))

        end
    end
end

for gkey, code in pairs(gkeyboard) do hl.bind(code, custom_gkey_action(gkey)) end
for gkey, code in pairs(gmouse) do hl.bind(code, custom_gkey_action("M" .. gkey)) end

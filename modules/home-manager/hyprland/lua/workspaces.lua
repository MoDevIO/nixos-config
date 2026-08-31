local monitors = hl.get_monitors()

local function apply_workspace_rules(monitor)
    for i = 1, 10 do
        local id = monitor.id * 10 + i

        hl.workspace_rule({
            workspace = tostring(id),
            monitor = monitor.name
        })
    end
end

for index, monitor in ipairs(monitors) do
    apply_workspace_rules(monitor)
end

hl.on("monitor.added", function(monitor)
    apply_workspace_rules(monitor)
end)

for i = 1, 10 do
    local key = i % 10
    local workspaceIndex = i

    hl.bind("SUPER + " .. tostring(key), function()
        local monitor = hl.get_active_monitor()
        local id = monitor.id * 10 + workspaceIndex
        hl.dispatch(hl.dsp.focus({ workspace = id }))
    end)

    hl.bind("SUPER + SHIFT + " .. tostring(key), function()
        local monitor = hl.get_active_monitor()
        local id = monitor.id * 10 + workspaceIndex
        hl.dispatch(hl.dsp.window.move({ workspace = id }))
    end)
end
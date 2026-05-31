hl.bind("CTRL+SUPER+ALT+Slash", hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.lua"), { description = "Edit user keybinds" })

-- Laptop customizations (migrated from conf-based setup)
hl.bind("SUPER + SHIFT + K", hl.dsp.global("quickshell:oskToggle"), { description = "Shell: Toggle on-screen keyboard" })
hl.bind("SUPER + ALT + J", hl.dsp.global("quickshell:barToggle"), { description = "Shell: Toggle bar" })

hl.bind("SUPER + SHIFT + Right", hl.dsp.layout("resizeactive 100 0"), { description = "Window: Increase width" })
hl.bind("SUPER + SHIFT + Left", hl.dsp.layout("resizeactive -100 0"), { description = "Window: Decrease width" })
hl.bind("SUPER + SHIFT + Down", hl.dsp.layout("resizeactive 0 100"), { description = "Window: Increase height" })
hl.bind("SUPER + SHIFT + Up", hl.dsp.layout("resizeactive 0 -100"), { description = "Window: Decrease height" })

for i = 1, 4 do
    local arrowkey = { "Left", "Right", "Up", "Down" }
    local movedir = { "l", "r", "u", "d" }
    hl.bind("SUPER + ALT + " .. arrowkey[i], hl.dsp.window.move({ direction = movedir[i] }),
        { description = "Window: Move " .. arrowkey[i] })
end

hl.bind("SUPER + J", hl.dsp.layout("togglesplit"), { description = "Window: Toggle split" })
hl.bind("SUPER + K", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + H", hl.dsp.layout("swapsplit"), { description = "Window: Swap split" })
hl.bind("SUPER + L", hl.dsp.layout("swapsplit"))

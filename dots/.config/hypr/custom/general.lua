-- User overrides. This file is loaded after the end4 defaults.

hl.monitor({
    output = "DP-1",
    mode = "2560x1440@144",
    position = "0x0",
    scale = 1
})

hl.monitor({
    output = "eDP-1",
    mode = "1920x1200",
    position = "2560x0",
    scale = 1
})

hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 2,
        border_size = 1,
        snap = {
            window_gap = 2,
            monitor_gap = 2
        }
    }
})

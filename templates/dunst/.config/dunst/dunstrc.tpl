[global]
    width = 400
    offset = 5x5
    
    progress_bar_min_width = 380
    progress_bar_max_width = 380
    progress_bar_corner_radius = 2

    padding = 10
    horizontal_padding = 10
    frame_width = 1
    gap_size = 3
    font = "JetBrainsMono Nerd Font"

    enable_recursive_icon_lookup = true
    corner_radius = 2

    background = "${THEME_BASE00}"
    foreground = "${THEME_BASE05}"

[urgency_low]
    background = "${THEME_BASE01}"
    highlight = "${THEME_BASE0B}"
    frame_color = "${THEME_BASE0B}"
    default_icon = "dialog-information"
    format = "<b><span foreground='${THEME_BASE0B}'>%s</span></b>\n%b"

[urgency_normal]
    background = "${THEME_BASE02}"
    highlight = "${THEME_BASE0A}"
    frame_color = "${THEME_BASE0A}"
    default_icon = "dialog-warning"
    format = "<b><span foreground='${THEME_BASE0A}'>%s</span></b>\n%b"

[urgency_critical]
    background = "${THEME_BASE08}"
    highlight = "${THEME_BASE08}"
    frame_color = "${THEME_BASE08}"
    default_icon = "dialog-error"
    format = "<b><span foreground='${THEME_BASE08}'>%s</span></b>\n%b"


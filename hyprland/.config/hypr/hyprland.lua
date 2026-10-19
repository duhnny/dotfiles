-- ################
-- ### MONITORS ###
-- ################

-- See https://wiki.hyprland.org/Configuring/Monitors/
hl.monitor({ output = 'eDP-1', scale = 1 });
hl.monitor({ output = 'HDMI-A-1', scale = 1 });

-- uncomment this to mirror all screens
-- hl.monitor({ output = '', scale = 1, mirror = 'eDP-1' });


-- ###################
-- ### MY PROGRAMS ###
-- ###################

-- See https://wiki.hyprland.org/Configuring/Keywords/

-- Set programs that you use
local terminal = 'ghostty';
local fileManager = 'nautilus';
local menu = 'rofi -show drun -show-icons -sort';
local browser = 'zen-browser';
local lockScreen = 'hyprlock';


-- #################
-- ### AUTOSTART ###
-- #################

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on('hyprland.start', function()
    hl.exec_cmd('swaync'); -- notification daemon
    -- hl.exec_cmd('mpvpaper -o "no-audio --loop" ALL /home/daniel/.local/share/images/frieren-campfire.gif'); -- animated wallpaper
    hl.exec_cmd('hyprpaper'); -- wallpaper
    hl.exec_cmd('waybar'); -- task bar
    hl.exec_cmd('hyprpm reload -n'); -- reload plugins on startup

    -- Start GNOME Keyring daemon and export its variables
    hl.exec_cmd('gnome-keyring-daemon --start --components=secrets,pkcs11,ssh');

    -- Optional: Start a polkit agent if you haven't already (required for authentication prompts)
    hl.exec_cmd('/usr/lib/polkit-kde-authentication-agent-1');

    -- dark mode
    hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"') -- for GTK4 apps
    hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3"') -- for GTK3 apps
end)

-- #############################
-- ### ENVIRONMENT VARIABLES ###
-- #############################

-- See https://wiki.hyprland.org/Configuring/Environment-variables/

hl.env('XCURSOR_THEME', 'bibata-modern-classic-xcursor');
hl.env('XCURSOR_SIZE', '22');
hl.env('HYPRCURSOR_THEME', 'bibata-modern-classic');
hl.env('HYPRCURSOR_SIZE', '22');

-- Core environment variables for Wayland/GNOME compatibility
hl.env('XDG_CURRENT_DESKTOP', 'Hyprland');
hl.env('XDG_SESSION_TYPE', 'wayland');
hl.env('XDG_SESSION_DESKTOP', 'Hyprland');
hl.env('GDK_WAYLAND_DISABLE', 'ext_background_effect_manager_v1'); -- fix blur ghostty

-- for KDE compatibility
hl.env('QT_QPA_PLATFORMTHEME', 'qt6ct');

-- #####################
-- ### LOOK AND FEEL ###
-- #####################

-- Refer to https://wiki.hyprland.org/Configuring/Variables/

hl.config({
    -- https://wiki.hyprland.org/Configuring/Variables/#general
    general = {
        gaps_in = 5,
        gaps_out = 10,

        border_size = 1,

        -- https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        col = {
            active_border = 'rgba(ededed2a)',
            inactive_border = 'rgba(59595909)',
        },

        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,
        hover_icon_on_border = true,
        extend_border_grab_area = 10,

        -- Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false,

        layout = 'dwindle',

        -- do not wrap around windows when moving focus in a direction
        -- where there isn't any more windows
        no_focus_fallback = true,
    },

    -- https://wiki.hyprland.org/Configuring/Variables/#decoration
    decoration = {
        rounding = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = 0.85,

        -- https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
            -- variant = 'acrylic',
            enabled = true,
            size = 6,
            passes = 3,
            ignore_opacity = true,
            xray = false,
            new_optimizations = true,
        },

        shadow = {
            enabled = true,
            range = 10,
            render_power = 3,
            sharp = false,
        },

        dim_inactive = false,
    },

    plugin = {
        hyprbars = {
            -- example config
            bar_height = 30,
            bar_blur = true,
            bar_title_enabled = false,
            -- bar_part_of_the_window = true,

            -- cmd to run on double click of the bar
            on_double_click = 'hyprctl dispatch fullscreen 1',
        },
    },

    animations = {
        enabled = true, -- please :)
    },
});

-- Plugin buttons
hl.plugin.hyprbars.add_button({
    bg_color = 'rgb(ff4040)',
    fg_color = 'rgb(ffffff)',
    size = 15,
    icon = '',
    action = 'hyprctl dispatch \'hl.dsp.window.close()\'',
});

hl.plugin.hyprbars.add_button({
    bg_color = 'rgb(16cc50)',
    fg_color = 'rgb(ffffff)',
    size = 15,
    icon = '',
    action = 'hyprctl dispatch fullscreen',
});

hl.plugin.hyprbars.add_button({
    bg_color = 'rgb(eeee11)',
    fg_color = 'rgb(ffffff)',
    size = 15,
    icon = '',
    action = 'hyprctl dispatch movetoworkspacesilent special:magic',
});

-- Animations

-- curves
hl.curve('easeOutQuint', {
    type = 'bezier',
    points = { { 0.23, 1 }, { 0.32, 1 } },
});
hl.curve('easeInOutCubic', {
    type = 'bezier',
    points = { { 0.65, 0.05 }, {0.36, 1} },
});
hl.curve('linear', {
    type = 'bezier',
    points = { { 0, 0 }, {1, 1} },
});
hl.curve('almostLinear', {
    type = 'bezier',
    points = { { 0.5, 0.5 }, {0.75, 1.0} },
});
hl.curve('quick', {
    type = 'bezier',
    points = { { 0.15, 0 }, {0.1, 1} },
});

-- define animations
-- https://wiki.hyprland.org/Configuring/Variables/#animations
hl.animation({
    leaf = 'global',
    enabled = true,
    speed = 10,
    bezier = 'default',
});
hl.animation({
    leaf = 'border',
    enabled = true,
    speed = 5.39,
    bezier = 'easeOutQuint',
});
hl.animation({
    leaf = 'windows',
    enabled = true,
    speed = 4.79,
    bezier = 'easeOutQuint',
});
hl.animation({
    leaf = 'windowsIn',
    enabled = true,
    speed = 4.1,
    bezier = 'easeOutQuint',
    style = 'popin 87%',
});
hl.animation({
    leaf = 'windowsOut',
    enabled = true,
    speed = 1.49,
    bezier = 'linear',
    style = 'popin 87%',
});
hl.animation({
    leaf = 'fadeIn',
    enabled = true,
    speed = 1.73,
    bezier = 'almostLinear',
});
hl.animation({
    leaf = 'fadeOut',
    enabled = true,
    speed = 1.46,
    bezier = 'almostLinear',
});
hl.animation({
    leaf = 'fade',
    enabled = true,
    speed = 3.03,
    bezier = 'quick',
});
hl.animation({
    leaf = 'layers',
    enabled = true,
    speed = 3.81,
    bezier = 'easeOutQuint',
});
hl.animation({
    leaf = 'layersIn',
    enabled = true,
    speed = 4,
    bezier = 'easeOutQuint',
    style = 'fade',
});
hl.animation({
    leaf = 'layersOut',
    enabled = true,
    speed = 1.5,
    bezier = 'linear',
    style = 'fade',
});
hl.animation({
    leaf = 'fadeLayersIn',
    enabled = true,
    speed = 1.79,
    bezier = 'almostLinear',
});
hl.animation({
    leaf = 'fadeLayersOut',
    enabled = true,
    speed = 1.39,
    bezier = 'almostLinear',
});
hl.animation({
    leaf = 'workspaces',
    enabled = true,
    speed = 1.94,
    bezier = 'almostLinear',
    style = 'fade',
});
hl.animation({
    leaf = 'workspacesIn',
    enabled = true,
    speed = 1.21,
    bezier = 'almostLinear',
    style = 'fade',
});
hl.animation({
    leaf = 'workspacesOut',
    enabled = true,
    speed = 1.94,
    bezier = 'almostLinear',
    style = 'fade',
});


-- See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
hl.config({
    master = {
        new_status = 'master',
    },
});

-- https://wiki.hyprland.org/Configuring/Variables/#misc
hl.config({
    misc = {
        force_default_wallpaper = 1,
    },
});

-- #############
-- ### INPUT ###
-- #############

-- https://wiki.hyprland.org/Configuring/Variables/#input
hl.config({
    input = {
        kb_layout = 'br',
        kb_options = 'caps:swapescape', -- map capslock to esc

        follow_mouse = true,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
        },
    },
});

-- Example per-device config
-- See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
hl.device({
    name = 'usb-optical-mouse-',
    sensitivity = 1.0,
});

hl.device({
    name = 'synaptics-tm3336-004',
    sensitivity = 0.45,
});


-- ###################
-- ### KEYBINDINGS ###
-- ###################

-- See https://wiki.hyprland.org/Configuring/Keywords/
local mainMod = 'SUPER' -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
hl.bind(mainMod .. '+ T',         hl.dsp.exec_cmd(terminal));
hl.bind(mainMod .. '+ B',         hl.dsp.exec_cmd(browser));
hl.bind(mainMod .. '+ W',         hl.dsp.exec_cmd('~/.config/hypr/scripts/toggle_waybar.sh'));
hl.bind(mainMod .. '+ C',         hl.dsp.window.close());
hl.bind(mainMod .. '+ F',         hl.dsp.window.float({ action = 'toggle', }));
hl.bind(mainMod .. '+ SHIFT + F', hl.dsp.window.fullscreen({ action = 'toggle', }));
hl.bind(mainMod .. '+ P',         hl.dsp.window.pin({ action = 'toggle', })); -- dwindle
hl.bind(mainMod .. '+ SHIFT + P', hl.dsp.window.pseudo({ action = 'toggle' })); -- dwindle
hl.bind(mainMod .. '+ Z',         hl.dsp.exec_cmd(lockScreen));
hl.bind(mainMod .. '+ SHIFT + Z', hl.dsp.exec_cmd(lockScreen .. ' & disown && sleep 3s && systemctl suspend'));
hl.bind(mainMod .. '+ M',         hl.dsp.workspace.toggle_special('magic'));
hl.bind(mainMod .. '+ SHIFT + M', hl.dsp.window.move({ workspace = 'special:magic', }));

-- launcher
hl.bind(mainMod .. '+ SPACE',     hl.dsp.exec_cmd(menu));

-- print
hl.bind('PRINT',                  hl.dsp.exec_cmd('hyprshot -m window'));
hl.bind(mainMod .. '+ SHIFT + S', hl.dsp.exec_cmd('hyprshot -m region'));

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. '+ left',      hl.dsp.focus({ direction = 'l', }));
hl.bind(mainMod .. '+ right',     hl.dsp.focus({ direction = 'r', }));
hl.bind(mainMod .. '+ up',        hl.dsp.focus({ direction = 'u', }));
hl.bind(mainMod .. '+ down',      hl.dsp.focus({ direction = 'd', }));

-- Move focus with mainMod + vim keys
hl.bind(mainMod .. '+ h',         hl.dsp.focus({ direction = 'l', }));
hl.bind(mainMod .. '+ l',         hl.dsp.focus({ direction = 'r', }));
hl.bind(mainMod .. '+ k',         hl.dsp.focus({ direction = 'u', }));
hl.bind(mainMod .. '+ j',         hl.dsp.focus({ direction = 'd', }));

-- Move windows
hl.bind(mainMod .. '+ CTRL + left',  hl.dsp.window.move({ direction = 'l', }));
hl.bind(mainMod .. '+ CTRL + right', hl.dsp.window.move({ direction = 'r', }));
hl.bind(mainMod .. '+ CTRL + up',    hl.dsp.window.move({ direction = 'u', }));
hl.bind(mainMod .. '+ CTRL + down',  hl.dsp.window.move({ direction = 'd', }));

-- Move windows with vim keys
hl.bind(mainMod .. '+ CTRL + h', hl.dsp.window.move({ direction = 'l', }));
hl.bind(mainMod .. '+ CTRL + l', hl.dsp.window.move({ direction = 'r', }));
hl.bind(mainMod .. '+ CTRL + k', hl.dsp.window.move({ direction = 'u', }));
hl.bind(mainMod .. '+ CTRL + j', hl.dsp.window.move({ direction = 'd', }));

-- Resize windows
hl.bind(mainMod .. '+ SHIFT + left',  hl.dsp.window.resize({ x = -30, y = 0,   relative = true, }, { repeating = true, }));
hl.bind(mainMod .. '+ SHIFT + right', hl.dsp.window.resize({ x = 30,  y = 0,   relative = true, }, { repeating = true, }));
hl.bind(mainMod .. '+ SHIFT + up',    hl.dsp.window.resize({ x = 0,   y = -30, relative = true, }, { repeating = true, }));
hl.bind(mainMod .. '+ SHIFT + down',  hl.dsp.window.resize({ x = 0,   y = 30,  relative = true, }, { repeating = true, }));

-- Resize windows
hl.bind(mainMod .. '+ SHIFT + h', hl.dsp.window.resize({ x = -30,  y = 0,   relative = true, }, { repeating = true, }));
hl.bind(mainMod .. '+ SHIFT + l', hl.dsp.window.resize({ x = 30,   y = 0,   relative = true, }, { repeating = true, }));
hl.bind(mainMod .. '+ SHIFT + k', hl.dsp.window.resize({ x = 0,    y = -30, relative = true, }, { repeating = true, }));
hl.bind(mainMod .. '+ SHIFT + j', hl.dsp.window.resize({ x = 0,    y = 30,  relative = true, }, { repeating = true, }));

-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. '+ 1', hl.dsp.focus({ workspace = '1',  }));
hl.bind(mainMod .. '+ 2', hl.dsp.focus({ workspace = '2',  }));
hl.bind(mainMod .. '+ 3', hl.dsp.focus({ workspace = '3',  }));
hl.bind(mainMod .. '+ 4', hl.dsp.focus({ workspace = '4',  }));
hl.bind(mainMod .. '+ 5', hl.dsp.focus({ workspace = '5',  }));
hl.bind(mainMod .. '+ 6', hl.dsp.focus({ workspace = '6',  }));
hl.bind(mainMod .. '+ 7', hl.dsp.focus({ workspace = '7',  }));
hl.bind(mainMod .. '+ 8', hl.dsp.focus({ workspace = '8',  }));
hl.bind(mainMod .. '+ 9', hl.dsp.focus({ workspace = '9',  }));
hl.bind(mainMod .. '+ 0', hl.dsp.focus({ workspace = '10', }));

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. '+ SHIFT + 1', hl.dsp.window.move({ workspace = '1',  }));
hl.bind(mainMod .. '+ SHIFT + 2', hl.dsp.window.move({ workspace = '2',  }));
hl.bind(mainMod .. '+ SHIFT + 3', hl.dsp.window.move({ workspace = '3',  }));
hl.bind(mainMod .. '+ SHIFT + 4', hl.dsp.window.move({ workspace = '4',  }));
hl.bind(mainMod .. '+ SHIFT + 5', hl.dsp.window.move({ workspace = '5',  }));
hl.bind(mainMod .. '+ SHIFT + 6', hl.dsp.window.move({ workspace = '6',  }));
hl.bind(mainMod .. '+ SHIFT + 7', hl.dsp.window.move({ workspace = '7',  }));
hl.bind(mainMod .. '+ SHIFT + 8', hl.dsp.window.move({ workspace = '8',  }));
hl.bind(mainMod .. '+ SHIFT + 9', hl.dsp.window.move({ workspace = '9',  }));
hl.bind(mainMod .. '+ SHIFT + 0', hl.dsp.window.move({ workspace = '10', }));

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. '+ mouse_down', hl.dsp.focus({ workspace = 'e+1' }));
hl.bind(mainMod .. '+ mouse_up',   hl.dsp.focus({ workspace = 'e-1' }));

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. '+ mouse:272', hl.dsp.window.drag(),   { mouse = true, });
hl.bind(mainMod .. '+ mouse:273', hl.dsp.window.resize(), {mouse = true, });

-- Laptop multimedia keys for volume and LCD brightness
hl.bind('XF86AudioRaiseVolume',  hl.dsp.exec_cmd('wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+'), { locked = true, });
hl.bind('XF86AudioLowerVolume',  hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'),      { locked = true, });
hl.bind('XF86AudioMute',         hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'),     { locked = true, });
hl.bind('XF86AudioMicMute',      hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle'),   { locked = true, });
hl.bind('XF86MonBrightnessUp',   hl.dsp.exec_cmd('brightnessctl s 10%+'),                           { locked = true, });
hl.bind('XF86MonBrightnessDown', hl.dsp.exec_cmd('brightnessctl s 10%-'),                           { locked = true, });

-- Requires playerctl
hl.bind('XF86AudioNext',  hl.dsp.exec_cmd('playerctl next'),       { locked = true, });
hl.bind('XF86AudioPause', hl.dsp.exec_cmd('playerctl play-pause'), { locked = true, });
hl.bind('XF86AudioPlay',  hl.dsp.exec_cmd('playerctl play-pause'), { locked = true, });
hl.bind('XF86AudioPrev',  hl.dsp.exec_cmd('playerctl previous'),   { locked = true, });

-- ##############################
-- ### WINDOWS AND WORKSPACES ###
-- ##############################

-- See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
-- See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
});

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",

    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
});

-- Make all workspaces floating by default, exept first workspace, and first window in a workspace
hl.window_rule({
    match = {
        workspace = 'r[2-10]'
    },

    float = true,
});
hl.window_rule({
    match = {
        workspace = 'w[0]',
    },

    tile = true,
});

-- Control when bars are enabled
hl.window_rule({
    match = {
        pin = true,
        focus = true,
    },

    ["hyprbars:no_bar"] = true,
});
hl.window_rule({
    match = {
        float = false,
    },

    ["hyprbars:no_bar"] = true,
});

-- Blur rofi
hl.layer_rule({
    match = {
        class = 'rofi',
    },

    blur = true,
});
hl.layer_rule({
    match = {
        class = 'rofi',
    },

    ignore_alpha = 0,
});

-- Do not blur hyprshot
hl.layer_rule({
    match = {
        class = 'hyprshot',
    },

    blur = false,
});

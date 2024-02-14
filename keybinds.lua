local awful = require("awful");
local hotkeys_popup = require("awful.hotkeys_popup");
local gears = require("gears");

local modkey = "Mod4";
local altkey = "Mod1";
local ctrlkey = "Control";
local shiftkey = "Shift";

local awesomeGroup = "awesome";
local launcherGroup = "launcher";
local windowGroup = "window";
local layoutGroup = "layout";
local screenGroup = "screen";
local tagGroup = "tag";
local audioGroup = "audio";
local brightnessGroup = "brightness";
local airplaneModeGroup = "airplane mode";

local terminal = "kitty";

local function openTerminalCommand(command)
    return function() awful.spawn.with_shell(terminal .. " -e " .. command) end;
end

local globalKeybinds = {
    -- Awesome Controls
    { modifiers = { modkey, ctrlkey }, name = "r", action = awesome.restart, meta = { description = "reload awesome", group = awesomeGroup } },
    { modifiers = { modkey, shiftkey }, name = "q", action = awesome.quit, meta = { description = "quit awesome", group = awesomeGroup } },
    { modifiers = { modkey }, name = "s", action = hotkeys_popup.show_help, meta = { description = "show help", group = awesomeGroup } },

    -- Launcher Controls
    { modifiers = { modkey }, name = "Return", action = openTerminalCommand("bash"), meta = { description = "open a terminal", group = launcherGroup } },
    { modifiers = { modkey }, name = "z", action = function() awful.spawn("rofi -show drun") end, meta = { description = "open rofi", group = launcherGroup } },
    { modifiers = { ctrlkey, shiftkey }, name = "Escape", action = openTerminalCommand("htop"), meta = { description = "spawn htop", group = launcherGroup } },
    { name = "Print", action = function() awful.spawn("flameshot gui") end, meta = { description = "open flameshot", group = launcherGroup } },
    { modifiers = { modkey }, name = "p", action = function() awful.spawn("flameshot screen -c") end, meta = { description = "take a screenshot", group = launcherGroup } },
    { modifiers = { modkey, shiftkey }, name = "p", action = function() awful.spawn("flameshot screen -c -p ~/Pictures/Screenshots") end, meta = { description = "save a screenshot", group = launcherGroup } },
    { modifiers = { ctrlkey, shiftkey }, name = "c", action = function() awful.spawn("gpick") end, meta = { description = "open gpick", group = launcherGroup } },
    { modifiers = { ctrlkey, altkey }, name = "Delete", action = awesome.quit, meta = { description = "quit awesome", group = launcherGroup } },
    
    -- Window Controls
    { modifiers = { modkey }, name = "j", action = function() awful.client.focus.byidx(1) end, meta = { description = "focus next by index", group = windowGroup } },
    { modifiers = { modkey }, name = "k", action = function() awful.client.focus.byidx(-1) end, meta = { description = "focus previous by index", group = windowGroup } },
    { modifiers = { modkey, shiftkey }, name = "j", action = function() awful.client.swap.byidx(1) end, meta = { description = "swap with next client by index", group = windowGroup } },
    { modifiers = { modkey, shiftkey }, name = "k", action = function() awful.client.swap.byidx(-1) end, meta = { description = "swap with previous client by index", group = windowGroup } },
    { modifiers = { modkey }, name = "u", action = awful.client.urgent.jumpto, meta = { description = "jump to urgent client", group = windowGroup } },
    { modifiers = { modkey }, name = "Tab", action = function()
        awful.client.focus.history.previous()
        if client.focus then client.focus:raise() end
    end, meta = { description = "go back", group = windowGroup } },

    -- Layout Controls
    { modifiers = { modkey }, name = "l", action = function() awful.tag.incmwfact(0.05) end, meta = { description = "increase master width factor", group = layoutGroup } },
    { modifiers = { modkey }, name = "h", action = function() awful.tag.incmwfact(-0.05) end, meta = { description = "decrease master width factor", group = layoutGroup } },
    { modifiers = { modkey, shiftkey }, name = "h", action = function() awful.tag.incnmaster(1, nil, true) end, meta = { description = "increase the number of master clients", group = layoutGroup } },
    { modifiers = { modkey, shiftkey }, name = "l", action = function() awful.tag.incnmaster(-1, nil, true) end, meta = { description = "decrease the number of master clients", group = layoutGroup } },
    { modifiers = { modkey, ctrlkey }, name = "h", action = function() awful.tag.incncol(1, nil, true) end, meta = { description = "increase the number of columns", group = layoutGroup } },
    { modifiers = { modkey, ctrlkey }, name = "l", action = function() awful.tag.incncol(-1, nil, true) end, meta = { description = "decrease the number of columns", group = layoutGroup } },
    { modifiers = { modkey }, name = "space", action = function() awful.layout.inc(1) end, meta = { description = "select next", group = layoutGroup } },
    { modifiers = { modkey, shiftkey }, name = "space", action = function() awful.layout.inc(-1) end, meta = { description = "select previous", group = layoutGroup } },

    -- Screen Controls
    { modifiers = { modkey }, name = "w", action = function() awful.screen.focus_relative(1) end, meta = { description = "focus the next screen", group = screenGroup } },
    { modifiers = { modkey }, name = "e", action = function() awful.screen.focus_relative(-1) end, meta = { description = "focus the previous screen", group = screenGroup } },
    { modifiers = { modkey, shiftkey }, name = "w", action = function() awful.client.movetoscreen() end, meta = { description = "move client to next screen", group = screenGroup } },
    { modifiers = { modkey, shiftkey }, name = "e", action = function() awful.client.movetoscreen() end, meta = { description = "move client to previous screen", group = screenGroup } },

    -- Tag Controls
    { modifiers = { modkey }, name = "Left", action = awful.tag.viewprev, meta = { description = "view previous", group = tagGroup } },
    { modifiers = { modkey }, name = "Right", action = awful.tag.viewnext, meta = { description = "view next", group = tagGroup } },
    { modifiers = { modkey }, name = "Escape", action = awful.tag.history.restore, meta = { description = "go back", group = tagGroup } },

    -- Audio Controls
    { name = "XF86AudioPlay", action = function() awful.spawn("playerctl play-pause") end, meta = { description = "play/pause", group = audioGroup } },
    { name = "XF86AudioNext", action = function() awful.spawn("playerctl next") end, meta = { description = "next", group = audioGroup } },
    { name = "XF86AudioPrev", action = function() awful.spawn("playerctl previous") end, meta = { description = "previous", group = audioGroup } },
    { name = "XF86AudioMute", action = function() awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") end, meta = { description = "mute", group = audioGroup } },
    { name = "XF86AudioLowerVolume", action = function() awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") end, meta = { description = "lower volume", group = audioGroup } },
    { name = "XF86AudioRaiseVolume", action = function() awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+") end, meta = { description = "raise volume", group = audioGroup } },

    -- Brightness Controls
    { name = "XF86MonBrightnessUp", action = function() awful.spawn("brightnessctl set +5%") end, meta = { description = "raise brightness", group = brightnessGroup } },
    { name = "XF86MonBrightnessDown", action = function() awful.spawn("brightnessctl set 5%-") end, meta = { description = "lower brightness", group = brightnessGroup } },

    -- Airplane Mode Controls
    { name = "XF86WLAN", action = function() awful.spawn("nmcli radio wifi toggle") end, meta = { description = "toggle wifi", group = airplaneModeGroup } },
    { name = "XF86Bluetooth", action = function() awful.spawn("bluetoothctl power toggle") end, meta = { description = "toggle bluetooth", group = airplaneModeGroup } }
}

local function formatKeys(keybinds)
    local formattedKeys = {};
    for _, keybind in ipairs(keybinds) do
        table.insert(formattedKeys, awful.key(
            keybind.modifiers or {},
            keybind.name,
            keybind.action,
            keybind.meta
        ));
    end

    return gears.table.join(table.unpack(formattedKeys));
end

root.keys(formatKeys(globalKeybinds));
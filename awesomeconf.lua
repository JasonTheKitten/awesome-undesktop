local awful = require("awful");
local beautiful = require("beautiful");

local clientKeys = require("keybinds").clientKeybinds;
local clientButtons = require("buttonbinds").clientButtonbinds;

awful.layout.layouts = {
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
};

awful.rules.rules = {
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
            floating = false,
            keys = clientKeys,
            buttons = clientButtons,
        }
    },
    {
        rule_any = {
            name = {
                "Picture in picture"
            }
        },
        properties = {
            floating = true,
            ontop = true,
            sticky = true,
            focusable = false,
            placement = awful.placement.bottom_right,
            width = 800,
            height = 450,
        }
    
    }
};

client.connect_signal("manage", function(c)
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        awful.placement.no_offscreen(c);
    end
end);

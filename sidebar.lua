local awful = require("awful");
local beautiful = require("beautiful");
local wibox = require("wibox");

local batteryWidget = require("component.battery").batteryWidget;
local timeWidget = require("component.time").timeWidget;

local sidebar = {};

sidebar.create = function(s)
    -- Create the sidebar
    local sidebarWibar = awful.wibar({
        position = "right",
        screen = s,
        width = 3,
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal,
        ontop = true,
    });

    -- Add widgets to the sidebar
    sidebarWibar:setup({
        -- Just a red rectangle
        layout = wibox.layout.align.vertical,
        {
            layout = wibox.layout.fixed.vertical,
            {
                widget = wibox.container.background,
                forced_height = 100,
                batteryWidget,
            },
            {
                widget = wibox.container.background,
                forced_height = 10,
            },
            {
                widget = wibox.container.background,
                forced_height = 200,
                timeWidget,
            },
        },
    });
end

return sidebar;
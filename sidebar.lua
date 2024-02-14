local awful = require("awful");
local beautiful = require("beautiful");
local wibox = require("wibox");

local batteryWidget = require("component.battery").batteryWidget;

local sidebar = {};

sidebar.create = function(s)
    -- Create the sidebar
    local sidebarWibar = awful.wibar({
        position = "right",
        screen = s,
        width = 2,
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal,
        ontop = true,
    });

    -- Add widgets to the sidebar
    sidebarWibar:setup({
        -- Just a red rectangle
        layout = wibox.layout.align.vertical,
        {
            widget = wibox.container.background,
            forced_height = 100,
            batteryWidget
        }
    });
end

return sidebar;
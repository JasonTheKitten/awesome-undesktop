local awful = require("awful");
local beautiful = require("beautiful");
local wibox = require("wibox");

local sidebar = {};

sidebar.create = function(s)
    -- Create the sidebar
    local sidebar = awful.wibar({
        position = "right",
        screen = s,
        width = 2,
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal,
        ontop = true,
    });

    -- Add widgets to the sidebar
    sidebar:setup({
        -- Just a red rectangle
        layout = wibox.layout.align.vertical,
        {
            widget = wibox.container.background,
            bg = "#FF0000",
            forced_height = 100,
        }
    });
end

return sidebar;
local wibox = require("wibox");
local gears = require("gears");

local function getBatteryInfo()
    local handle = io.popen("acpi -b");
    if not handle then
        return {
            level = 0,
            charging = false
        };
    end
    local s = handle:read("*a");
    handle:close();
    local percentText = string.match(s, "(%d+)%%");
    local isCharging = string.match(s, "Charging");

    return {
        level = tonumber(percentText),
        charging = isCharging
    };
end

local batteryWidget = {
    fit = function(self, width, height)
        return width, height;
    end,
    draw = function(self, mywibox, cr, width, height)
        local batteryInfo = getBatteryInfo();
        if batteryInfo.charging then
            cr:set_source_rgb(.3, 1, 0);
        elseif batteryInfo.level > 20 then
            cr:set_source_rgb(0, .3, 1);
        else
            cr:set_source_rgb(1, 0, 0);
        end
        cr:rectangle(0, 0, width, height);
        cr:fill();

        cr:set_source_rgb(0, .5, 0);
        local fillHeight = height * (batteryInfo.level / 100);
        cr:rectangle(0, height - fillHeight, width, fillHeight);
        cr:fill();

        cr:set_source_rgb(.75, .75, .75);
        for i = 1, 9 do
            local y = (height / 10) * i;
            cr:move_to(0, y);
            cr:line_to(width, y);
            cr:stroke();
        end

        if not self.timer then
            local this = self;
            self.timer = gears.timer.start_new(5, function()
                this:emit_signal("widget::redraw_needed");
                return true;
            end);
        end
    end,
    layout = wibox.widget.base.make_widget
}

return {
    batteryWidget = batteryWidget
}
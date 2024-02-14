local wibox = require("wibox");
local gears = require("gears");

local function getTimeInfo()
    local time = os.date("*t");
    local hour = time.hour;
    local minute = time.min;
    local isMorning = hour < 12;
    hour = hour % 12;
    return {
        hour = hour,
        minute = minute,
        isMorning = isMorning
    };
end

local function timeToPercent(timeInfo)
    local hour = timeInfo.hour;
    local minute = timeInfo.minute;
    local percent = (hour * 60 + minute) / (12 * 60);
    return percent;
end

local timeWidget = {
    fit = function(self, width, height)
        return width, height;
    end,
    draw = function(self, mywibox, cr, width, height)
        local timeInfo = getTimeInfo();
        local percent = timeToPercent(timeInfo);

        if timeInfo.isMorning then
            cr:set_source_rgb(0, 0, 1);
        else
            cr:set_source_rgb(0, .7, 1);
        end
        cr:rectangle(0, 0, width, height);
        cr:fill();

        if timeInfo.isMorning then
            cr:set_source_rgb(0, 1, 1);
        else
            cr:set_source_rgb(0, .4, 1);
        end
        local fillHeight = height * percent;
        cr:rectangle(0, 0, width, fillHeight);
        cr:fill();

        cr:set_source_rgb(0, 0, 0);
        for i = 1, 11 do
            local y = (height / 12) * i;
            cr:move_to(0, y);
            cr:line_to(width, y);
            cr:stroke();
        end
    end,
    layout = wibox.widget.base.make_widget
};

return {
    timeWidget = timeWidget
};
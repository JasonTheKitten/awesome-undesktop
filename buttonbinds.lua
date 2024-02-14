local awful = require("awful");
local gears = require("gears");

local superkey = "Mod4";

local clientButtonbinds = gears.table.join(
    awful.button({ }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true});
    end),
    awful.button({ superkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true});
        awful.mouse.client.move(c);
    end),
    awful.button({ superkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true});
        awful.mouse.client.resize(c);
    end)
);

return {
    clientButtonbinds = clientButtonbinds
};
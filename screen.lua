local awful = require("awful");
local gears = require("gears");

local sidebar = require("sidebar");

local wallpaper = os.getenv("HOME") .. "/Documents/wallpaper.jpeg";

awful.screen.connect_for_each_screen(function(s)
	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }, s, awful.layout.layouts[1]);
	gears.wallpaper.maximized(wallpaper, s, false);
	sidebar.create(s);
end);

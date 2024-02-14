local beautiful = require("beautiful");
local gears = require("gears");
local naughty = require("naughty");

pcall(require, "luarocks.loader");

do
    local in_error = false;
    awesome.connect_signal("debug::error", function(err)
        if in_error then
            return;
        end
        in_error = true;
        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Error in rc.lua",
            text = tostring(err),
        });
        in_error = false;
    end);

end

-- Initialize the theme
local themeFile = gears.filesystem.get_configuration_dir() .. "default/theme.lua";
beautiful.init(themeFile);

-- Load extra modules
require("awesomeconf");
require("screen");
require("keybinds");
require("autospawn");

local awful = require("awful");

local function spawnOnce(command, args)
    awful.spawn.easy_async_with_shell("pgrep \"" .. command .. "\"", function(stdout)
        if stdout == "" then
            awful.spawn.with_shell(command .. " " .. (args or ""));
        end
    end);
end

spawnOnce("picom", "--vsync");
spawnOnce("gnome-keyring-daemon", "--start");
spawnOnce("ibus-daemon", "--xim");
spawnOnce("vivaldi");
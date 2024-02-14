local awful = require("awful");

local modkey = "Mod4";
local altkey = "Mod1";
local ctrlkey = "Control";
local shiftkey = "Shift";

local awesomeGroup = "awesome";

local globalKeybinds = {
    -- Awesome Controls
    { modifiers = { modkey, ctrlkey }, name = "r", action = awesome.restart, meta = { description = "reload awesome", group = awesomeGroup } },
    { modifiers = { modkey, shiftkey }, name = "q", action = awesome.quit, meta = { description = "quit awesome", group = awesomeGroup } },
}

local function formatKeys(keybinds)
    local formattedKeys = {};
    for _, keybind in ipairs(keybinds) do
        table.insert(formattedKeys, awful.key(
            keybind.modifiers or {},
            keybind.name,
            nil,
            keybind.action,
            keybind.meta
        ));
    end

    return formattedKeys;
end

root.keys(formatKeys(globalKeybinds));
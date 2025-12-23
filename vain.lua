-- main.lua
_G.App = {
    Visuals = {}
}

local BASE = "https://raw.githubusercontent.com/VainV4/VainScript/main/scripts/"

local function Load(file)
    local success, src = pcall(function() return game:HttpGet(BASE .. file) end)
    if not success then
        warn("Failed to fetch:", file)
        return
    end
    
    local fn, err = loadstring(src)
    if not fn then
        warn("Compile error:", file, err)
        return
    end
    
    task.spawn(function()
        local ok, runErr = pcall(fn)
        if not ok then warn("Runtime error in " .. file .. ":", runErr) end
    end)
end

-- LOAD ORDER
Load("visuals.lua") -- Logic first
Load("ui.lua")      -- UI second

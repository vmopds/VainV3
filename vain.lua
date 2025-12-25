-- VainScript Dynamic Loader
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Executor persistence
local function SaveSettings(name, data)
    if writefile then
        writefile(name .. ".json", HttpService:JSONEncode(data))
    end
end

local function LoadSettings(name)
    if isfile and isfile(name .. ".json") then
        return HttpService:JSONDecode(readfile(name .. ".json"))
    end
    return {}
end

-- Categories and modules container
local Categories = {}

-- UI toggle
local uiVisible = true
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        uiVisible = not uiVisible
        print("UI Visible:", uiVisible)
        -- TODO: toggle your actual GUI
    end
end)

-- Save all settings on close
game:BindToClose(function()
    for categoryName, modules in pairs(Categories) do
        for moduleName, module in pairs(modules) do
            SaveSettings(categoryName .. "_" .. moduleName, module.settings)
        end
    end
end)

-- Dynamically load all modules
local function LoadModules()
    local scriptFolder = "scripts"  -- relative path in your repo
    local function LoadFolder(path)
        local folderSuccess, folder = pcall(function()
            return listfiles(path)  -- executor-specific: Xeno/Synapse support
        end)
        if not folderSuccess then return end

        for _, file in pairs(folder) do
            if file:sub(-4) == ".lua" then
                local success, moduleFunc = pcall(function()
                    return loadfile(file)
                end)
                if success and type(moduleFunc) == "function" then
                    local category = file:match("scripts/(.-)/") or "Misc"
                    local moduleName = file:match("scripts/.-/([%w_]+)%.lua$")
                    
                    -- Load saved settings
                    local defaultSettings = moduleFunc.DefaultSettings or {Enabled = true}
                    local savedSettings = LoadSettings(category .. "_" .. moduleName)
                    local settings = {}
                    for k, v in pairs(defaultSettings) do
                        settings[k] = savedSettings[k] ~= nil and savedSettings[k] or v
                    end

                    -- Register category if missing
                    Categories[category] = Categories[category] or {}
                    Categories[category][moduleName] = {
                        name = moduleName,
                        settings = settings,
                        init = moduleFunc
                    }

                    -- Run module
                    moduleFunc(settings)
                end
            elseif file:sub(-1) == "/" then
                -- Recursively load subfolders
                LoadFolder(file)
            end
        end
    end

    LoadFolder(scriptFolder)
end

-- Load everything
LoadModules()
print("VainScript loaded! Categories and modules:")
for cat, mods in pairs(Categories) do
    print("-", cat)
    for modName, _ in pairs(mods) do
        print("   -", modName)
    end
end

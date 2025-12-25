-- =====================================
-- Vain Script Hub (Executor LocalScript)
-- =====================================

-- Services
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- ===============================
-- SETTINGS PERSISTENCE
-- ===============================
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

-- ===============================
-- MODULE REGISTRY (IMPORTANT)
-- ===============================
local ModuleRegistry = {
    Visuals = {
        MetalESP = "https://raw.githubusercontent.com/VainV4/VainScript/main/scripts/Visuals/MetalESP.lua"
    },
    Combat = {},
    Support = {},
    Misc = {}
}

-- ===============================
-- LOAD MODULES
-- ===============================
local Categories = {}

local function LoadModules()
    for category, modules in pairs(ModuleRegistry) do
        Categories[category] = {}

        for moduleName, url in pairs(modules) do
            local success, moduleFunc = pcall(function()
                return loadstring(game:HttpGet(url))
            end)

            if success and type(moduleFunc) == "function" then
                local defaults = moduleFunc.DefaultSettings or { Enabled = true }
                local saved = LoadSettings(category .. "_" .. moduleName)

                local settings = {}
                for k, v in pairs(defaults) do
                    settings[k] = saved[k] ~= nil and saved[k] or v
                end

                Categories[category][moduleName] = {
                    name = moduleName,
                    settings = settings,
                    run = moduleFunc
                }

                task.spawn(function()
                    moduleFunc(settings)
                end)
            else
                warn("Failed to load module:", moduleName)
            end
        end
    end
end

-- ===============================
-- UI TOGGLE (Right Shift)
-- ===============================
local uiVisible = true
UserInputService.InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.RightShift then
        uiVisible = not uiVisible
        if CoreGui:FindFirstChild("VainUI") then
            CoreGui.VainUI.Enabled = uiVisible
        end
    end
end)

-- ===============================
-- CREATE UI
-- ===============================
local function CreateUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "VainUI"
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 800, 0, 500)
    main.Position = UDim2.new(0.5, 0, 0.5, 0)
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    main.BackgroundTransparency = 0.15
    main.BorderSizePixel = 0
    main.Parent = gui

    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 18)

    -- Category panel
    local categoriesFrame = Instance.new("Frame")
    categoriesFrame.Size = UDim2.new(0, 200, 1, 0)
    categoriesFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    categoriesFrame.BorderSizePixel = 0
    categoriesFrame.Parent = main
    Instance.new("UICorner", categoriesFrame).CornerRadius = UDim.new(0, 18)

    local catLayout = Instance.new("UIListLayout", categoriesFrame)
    catLayout.Padding = UDim.new(0, 8)

    -- Modules panel
    local modulesFrame = Instance.new("ScrollingFrame")
    modulesFrame.Position = UDim2.new(0, 220, 0, 10)
    modulesFrame.Size = UDim2.new(1, -230, 1, -20)
    modulesFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    modulesFrame.ScrollBarThickness = 6
    modulesFrame.BackgroundTransparency = 1
    modulesFrame.Parent = main

    local modLayout = Instance.new("UIListLayout", modulesFrame)
    modLayout.Padding = UDim.new(0, 6)

    local function LoadCategory(category)
        modulesFrame:ClearAllChildren()
        modLayout.Parent = modulesFrame

        for _, module in pairs(Categories[category]) do
            local card = Instance.new("Frame")
            card.Size = UDim2.new(1, 0, 0, 40)
            card.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            card.BorderSizePixel = 0
            card.Parent = modulesFrame
            Instance.new("UICorner", card).CornerRadius = UDim.new(0, 12)

            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, -50, 1, 0)
            button.Text = module.name
            button.Font = Enum.Font.SourceSansBold
            button.TextSize = 18
            button.TextColor3 = Color3.new(1, 1, 1)
            button.BackgroundTransparency = 1
            button.Parent = card

            local pill = Instance.new("Frame")
            pill.Size = UDim2.new(0, 18, 0, 18)
            pill.Position = UDim2.new(1, -25, 0.5, -9)
            pill.BackgroundColor3 = module.settings.Enabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
            pill.BorderSizePixel = 0
            pill.Parent = card
            Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)

            button.MouseButton1Click:Connect(function()
                module.settings.Enabled = not module.settings.Enabled
                pill.BackgroundColor3 = module.settings.Enabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
                SaveSettings(category .. "_" .. module.name, module.settings)
            end)
        end
    end

    for category in pairs(Categories) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 40)
        btn.Text = category
        btn.Font = Enum.Font.SourceSansBold
        btn.TextSize = 18
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        btn.BorderSizePixel = 0
        btn.Parent = categoriesFrame
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

        btn.MouseButton1Click:Connect(function()
            LoadCategory(category)
        end)
    end

    -- Auto load first category
    for first in pairs(Categories) do
        LoadCategory(first)
        break
    end
end

-- ===============================
-- AUTO SAVE
-- ===============================
RunService.Heartbeat:Connect(function()
    for cat, mods in pairs(Categories) do
        for name, module in pairs(mods) do
            SaveSettings(cat .. "_" .. name, module.settings)
        end
    end
end)

-- ===============================
-- START
-- ===============================
LoadModules()
CreateUI()
print("[Vain] Loaded successfully")

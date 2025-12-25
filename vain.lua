-- =====================================
-- Vain Script Hub (Stable Base)
-- =====================================

-- Services
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- =====================================
-- SETTINGS STORAGE
-- =====================================
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

-- =====================================
-- MODULE DEFINITIONS (LOCAL, GUARANTEED)
-- =====================================

local Modules = {
    Visuals = {
        MetalESP = {
            DefaultSettings = {
                Enabled = true,
                ShowBeams = true,
                ShowDistance = true
            },

            Run = function(settings)
                task.spawn(function()
                    while task.wait(2) do
                        if settings.Enabled then
                            print("[MetalESP]")
                            print("ShowBeams:", settings.ShowBeams)
                            print("ShowDistance:", settings.ShowDistance)
                        end
                    end
                end)
            end
        }
    },

    Combat = {},
    Support = {},
    Misc = {}
}

-- =====================================
-- BUILD CATEGORIES WITH SAVED SETTINGS
-- =====================================
local Categories = {}

for categoryName, mods in pairs(Modules) do
    Categories[categoryName] = {}

    for moduleName, module in pairs(mods) do
        local saved = LoadSettings(categoryName .. "_" .. moduleName)
        local settings = {}

        for k, v in pairs(module.DefaultSettings) do
            settings[k] = saved[k] ~= nil and saved[k] or v
        end

        Categories[categoryName][moduleName] = {
            name = moduleName,
            settings = settings,
            run = module.Run
        }

        task.spawn(function()
            module.Run(settings)
        end)
    end
end

-- =====================================
-- UI TOGGLE (RIGHT SHIFT)
-- =====================================
local uiVisible = true
UserInputService.InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.RightShift then
        uiVisible = not uiVisible
        if CoreGui:FindFirstChild("VainUI") then
            CoreGui.VainUI.Enabled = uiVisible
        end
    end
end)

-- =====================================
-- CREATE UI
-- =====================================
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
    main.BorderSizePixel = 0
    main.Parent = gui
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

    -- Categories panel
    local catPanel = Instance.new("Frame")
    catPanel.Size = UDim2.new(0, 200, 1, 0)
    catPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    catPanel.BorderSizePixel = 0
    catPanel.Parent = main
    Instance.new("UICorner", catPanel).CornerRadius = UDim.new(0, 16)

    local catLayout = Instance.new("UIListLayout", catPanel)
    catLayout.Padding = UDim.new(0, 8)

    -- Modules panel
    local modPanel = Instance.new("ScrollingFrame")
    modPanel.Position = UDim2.new(0, 210, 0, 10)
    modPanel.Size = UDim2.new(1, -220, 1, -20)
    modPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
    modPanel.ScrollBarThickness = 6
    modPanel.BackgroundTransparency = 1
    modPanel.Parent = main

    local modLayout = Instance.new("UIListLayout", modPanel)
    modLayout.Padding = UDim.new(0, 6)

    local function LoadCategory(category)
        modPanel:ClearAllChildren()
        modLayout.Parent = modPanel

        for _, module in pairs(Categories[category]) do
            local card = Instance.new("Frame")
            card.Size = UDim2.new(1, 0, 0, 40)
            card.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            card.BorderSizePixel = 0
            card.Parent = modPanel
            Instance.new("UICorner", card).CornerRadius = UDim.new(0, 12)

            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -40, 1, 0)
            btn.Text = module.name
            btn.Font = Enum.Font.SourceSansBold
            btn.TextSize = 18
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.BackgroundTransparency = 1
            btn.Parent = card

            local pill = Instance.new("Frame")
            pill.Size = UDim2.new(0, 16, 0, 16)
            pill.Position = UDim2.new(1, -22, 0.5, -8)
            pill.BackgroundColor3 = module.settings.Enabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
            pill.BorderSizePixel = 0
            pill.Parent = card
            Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)

            btn.MouseButton1Click:Connect(function()
                module.settings.Enabled = not module.settings.Enabled
                pill.BackgroundColor3 = module.settings.Enabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
                SaveSettings(category .. "_" .. module.name, module.settings)
            end)
        end
    end

    -- Category buttons
    for category in pairs(Categories) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 40)
        btn.Text = category
        btn.Font = Enum.Font.SourceSansBold
        btn.TextSize = 18
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        btn.BorderSizePixel = 0
        btn.Parent = catPanel
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

        btn.MouseButton1Click:Connect(function()
            LoadCategory(category)
        end)
    end

    -- Auto-load first category
    for first in pairs(Categories) do
        LoadCategory(first)
        break
    end
end

-- =====================================
-- START
-- =====================================
CreateUI()
print("[Vain] UI loaded successfully")

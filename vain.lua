--========================================
-- Vain Script Hub (Executor / Local Only)
--========================================

-- Services
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Config
local BASE_URL = "https://raw.githubusercontent.com/VainV4/VainScript/main/"
local REGISTRY_FILE = "modules.json"

--========================================
-- File Storage (Executor Safe)
--========================================

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

--========================================
-- Load Module Registry
--========================================

local Registry
do
    local success, result = pcall(function()
        return HttpService:JSONDecode(
            game:HttpGet(BASE_URL .. REGISTRY_FILE)
        )
    end)

    if not success then
        warn("[Vain] Failed to load modules.json")
        Registry = {}
    else
        Registry = result
    end
end

--========================================
-- Load Modules
--========================================

local Categories = {}

for categoryName, modules in pairs(Registry) do
    Categories[categoryName] = {}

    for moduleName, path in pairs(modules) do
        local success, moduleTable = pcall(function()
            return loadstring(game:HttpGet(BASE_URL .. path))()
        end)

        if success and type(moduleTable) == "table" then
            local defaults = moduleTable.DefaultSettings or { Enabled = true }
            local saved = LoadSettings(categoryName .. "_" .. moduleName)

            local settings = {}
            for k, v in pairs(defaults) do
                settings[k] = saved[k] ~= nil and saved[k] or v
            end

            Categories[categoryName][moduleName] = {
                Name = moduleName,
                Settings = settings,
                Run = moduleTable.Run
            }

            -- Start module
            if moduleTable.Run then
                task.spawn(function()
                    moduleTable.Run(settings)
                end)
            end
        else
            warn("[Vain] Failed to load module:", moduleName)
        end
    end
end

--========================================
-- UI Toggle (Right Shift)
--========================================

local uiVisible = true

UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.RightShift then
        uiVisible = not uiVisible
        if CoreGui:FindFirstChild("VainUI") then
            CoreGui.VainUI.Enabled = uiVisible
        end
    end
end)

--========================================
-- UI Creation
--========================================

local function CreateUI()
    if CoreGui:FindFirstChild("VainUI") then
        CoreGui.VainUI:Destroy()
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "VainUI"
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    -- Main Window
    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0, 820, 0, 520)
    main.Position = UDim2.new(0.5, 0, 0.5, 0)
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    main.BorderSizePixel = 0
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 18)

    -- Category Panel
    local categoryPanel = Instance.new("Frame", main)
    categoryPanel.Size = UDim2.new(0, 200, 1, 0)
    categoryPanel.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    categoryPanel.BorderSizePixel = 0
    Instance.new("UICorner", categoryPanel).CornerRadius = UDim.new(0, 18)

    local categoryLayout = Instance.new("UIListLayout", categoryPanel)
    categoryLayout.Padding = UDim.new(0, 10)
    categoryLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    -- Module Panel
    local modulePanel = Instance.new("ScrollingFrame", main)
    modulePanel.Position = UDim2.new(0, 210, 0, 14)
    modulePanel.Size = UDim2.new(1, -224, 1, -28)
    modulePanel.CanvasSize = UDim2.new(0, 0, 0, 0)
    modulePanel.ScrollBarImageTransparency = 0.5
    modulePanel.BackgroundTransparency = 1
    modulePanel.BorderSizePixel = 0

    local moduleLayout = Instance.new("UIListLayout", modulePanel)
    moduleLayout.Padding = UDim.new(0, 10)

    moduleLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        modulePanel.CanvasSize = UDim2.new(0, 0, 0, moduleLayout.AbsoluteContentSize.Y + 10)
    end)

    -- Load Category
    local function LoadCategory(categoryName)
        modulePanel:ClearAllChildren()
        moduleLayout.Parent = modulePanel

        for _, module in pairs(Categories[categoryName]) do
            local card = Instance.new("Frame", modulePanel)
            card.Size = UDim2.new(1, 0, 0, 46)
            card.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            card.BorderSizePixel = 0
            Instance.new("UICorner", card).CornerRadius = UDim.new(0, 14)

            local label = Instance.new("TextLabel", card)
            label.Size = UDim2.new(1, -70, 1, 0)
            label.Position = UDim2.new(0, 16, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = module.Name
            label.TextColor3 = Color3.new(1, 1, 1)
            label.Font = Enum.Font.GothamBold
            label.TextSize = 18
            label.TextXAlignment = Enum.TextXAlignment.Left

            local toggle = Instance.new("TextButton", card)
            toggle.Size = UDim2.new(0, 46, 0, 26)
            toggle.Position = UDim2.new(1, -56, 0.5, -13)
            toggle.BackgroundColor3 = module.Settings.Enabled and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(180, 60, 60)
            toggle.Text = module.Settings.Enabled and "ON" or "OFF"
            toggle.TextColor3 = Color3.new(1, 1, 1)
            toggle.Font = Enum.Font.GothamBold
            toggle.TextSize = 12
            Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)

            toggle.MouseButton1Click:Connect(function()
                module.Settings.Enabled = not module.Settings.Enabled
                toggle.Text = module.Settings.Enabled and "ON" or "OFF"
                toggle.BackgroundColor3 = module.Settings.Enabled and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(180, 60, 60)
                SaveSettings(categoryName .. "_" .. module.Name, module.Settings)
            end)
        end
    end

    -- Category Buttons
    for categoryName in pairs(Categories) do
        local btn = Instance.new("TextButton", categoryPanel)
        btn.Size = UDim2.new(1, -20, 0, 44)
        btn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
        btn.BorderSizePixel = 0
        btn.Text = categoryName
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 18
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 14)

        btn.MouseButton1Click:Connect(function()
            LoadCategory(categoryName)
        end)
    end

    -- Load first category by default
    for first in pairs(Categories) do
        LoadCategory(first)
        break
    end
end

CreateUI()

print("[Vain] Hub loaded successfully")

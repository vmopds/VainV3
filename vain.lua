--========================================
-- Vain Script Hub (Executor / Local Only)
--========================================

-- Services
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Config
-- Ensure this URL points to the RAW github content
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
        local success, content = pcall(readfile, name .. ".json")
        if success then
            return HttpService:JSONDecode(content)
        end
    end
    return {}
end

--========================================
-- Load Module Registry with Error Handling
--========================================

local Registry
do
    -- Added ?t=tick() to bypass GitHub's 5-minute cache
    local success, result = pcall(function()
        local url = BASE_URL .. REGISTRY_FILE .. "?t=" .. tick()
        local response = game:HttpGet(url)
        return HttpService:JSONDecode(response)
    end)

    if not success then
        warn("[Vain] Failed to load modules.json: " .. tostring(result))
        -- Fallback to empty table so UI still creates the frames
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
            return loadstring(game:HttpGet(BASE_URL .. path .. "?t=" .. tick()))()
        end)

        if success and type(moduleTable) == "table" then
            local defaults = moduleTable.DefaultSettings or { Enabled = false }
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

            -- Start module if it has a Run function
            if moduleTable.Run then
                task.spawn(function()
                    moduleTable.Run(settings)
                end)
            end
        else
            warn("[Vain] Failed to load module [" .. moduleName .. "]:", moduleTable)
        end
    end
end

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

    -- Category Panel (Side Bar)
    local categoryPanel = Instance.new("Frame", main)
    categoryPanel.Size = UDim2.new(0, 200, 1, 0)
    categoryPanel.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    categoryPanel.BorderSizePixel = 0
    Instance.new("UICorner", categoryPanel).CornerRadius = UDim.new(0, 18)

    local categoryLayout = Instance.new("UIListLayout", categoryPanel)
    categoryLayout.Padding = UDim.new(0, 10)
    categoryLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    categoryLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Module Panel (Right Side Content)
    local modulePanel = Instance.new("ScrollingFrame", main)
    modulePanel.Position = UDim2.new(0, 210, 0, 14)
    modulePanel.Size = UDim2.new(1, -224, 1, -28)
    modulePanel.CanvasSize = UDim2.new(0, 0, 0, 0)
    modulePanel.ScrollBarThickness = 4
    modulePanel.BackgroundTransparency = 1
    modulePanel.BorderSizePixel = 0

    local moduleLayout = Instance.new("UIListLayout", modulePanel)
    moduleLayout.Padding = UDim.new(0, 10)

    moduleLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        modulePanel.CanvasSize = UDim2.new(0, 0, 0, moduleLayout.AbsoluteContentSize.Y + 10)
    end)

    -- Function to Load Category Items
    local function LoadCategory(categoryName)
        -- Clear existing module cards
        for _, child in pairs(modulePanel:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end

        if not Categories[categoryName] then return end

        for _, module in pairs(Categories[categoryName]) do
            local card = Instance.new("Frame", modulePanel)
            card.Size = UDim2.new(1, 0, 0, 50)
            card.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            card.BorderSizePixel = 0
            Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)

            local label = Instance.new("TextLabel", card)
            label.Size = UDim2.new(1, -80, 1, 0)
            label.Position = UDim2.new(0, 15, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = module.Name
            label.TextColor3 = Color3.new(1, 1, 1)
            label.Font = Enum.Font.GothamBold
            label.TextSize = 16
            label.TextXAlignment = Enum.TextXAlignment.Left

            local toggle = Instance.new("TextButton", card)
            toggle.Size = UDim2.new(0, 60, 0, 30)
            toggle.Position = UDim2.new(1, -70, 0.5, -15)
            toggle.BackgroundColor3 = module.Settings.Enabled and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(180, 60, 60)
            toggle.Text = module.Settings.Enabled and "ON" or "OFF"
            toggle.TextColor3 = Color3.new(1, 1, 1)
            toggle.Font = Enum.Font.GothamBold
            toggle.TextSize = 12
            Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 8)

            toggle.MouseButton1Click:Connect(function()
                module.Settings.Enabled = not module.Settings.Enabled
                toggle.Text = module.Settings.Enabled and "ON" or "OFF"
                toggle.BackgroundColor3 = module.Settings.Enabled and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(180, 60, 60)
                SaveSettings(categoryName .. "_" .. module.Name, module.Settings)
                
                -- Re-run the module logic if needed or handle it within the module's own loop
                if module.Run then 
                    task.spawn(module.Run, module.Settings) 
                end
            end)
        end
    end

    -- Create Category Buttons
    local firstCategory = nil
    for categoryName in pairs(Categories) do
        if not firstCategory then firstCategory = categoryName end
        
        local btn = Instance.new("TextButton", categoryPanel)
        btn.Size = UDim2.new(1, -20, 0, 45)
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        btn.Text = categoryName
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

        btn.MouseButton1Click:Connect(function()
            LoadCategory(categoryName)
        end)
    end

    -- Load the first category by default if it exists
    if firstCategory then
        LoadCategory(firstCategory)
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

-- Initialize
CreateUI()
print("[Vain] Hub loaded successfully")

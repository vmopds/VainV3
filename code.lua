-- =========================
-- UI SETUP
-- =========================

local Converted = {
    ["_VainUI"] = Instance.new("ScreenGui"),
    ["_Main"] = Instance.new("Frame"),
    ["_ModuleList"] = Instance.new("Frame"),
    ["_Container"] = Instance.new("Frame"),
    ["_UIListLayout"] = Instance.new("UIListLayout"),
    ["_Modules"] = Instance.new("Folder"),
    ["_Visuals"] = Instance.new("Frame"),
    ["_VisualsButton"] = Instance.new("TextButton"),
    ["_Visuals1"] = Instance.new("Frame"),
    ["_Main1"] = Instance.new("ScrollingFrame"),
    ["_UIListLayout1"] = Instance.new("UIListLayout"),
    ["_MetalESP"] = Instance.new("Frame"),
    ["_Toggle"] = Instance.new("TextButton"),
    ["_ToggleModuleSettings"] = Instance.new("ImageButton"),
    ["_StarESP"] = Instance.new("Frame"),
    ["_Toggle1"] = Instance.new("TextButton"),
    ["_AimAssist"] = Instance.new("Frame"),
    ["_Toggle2"] = Instance.new("TextButton"),
    ["_Settings"] = Instance.new("Frame"),
    ["_Header"] = Instance.new("Frame"),
    ["_name"] = Instance.new("TextLabel")
}

-- Main GUI
local VainUI = Converted["_VainUI"]
VainUI.Name = "VainUI"
VainUI.DisplayOrder = 999999999
VainUI.ResetOnSpawn = false
VainUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
VainUI.Parent = game:GetService("CoreGui")

-- Main Frame
local Main = Converted["_Main"]
Main.Name = "Main"
Main.BackgroundTransparency = 1
Main.Size = UDim2.new(1, 0, 1, 0)
Main.Parent = VainUI

-- ModuleList & Container
local ModuleList = Converted["_ModuleList"]
ModuleList.Size = UDim2.new(0.085, 0, 1, 0)
ModuleList.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
ModuleList.BorderSizePixel = 0
ModuleList.Name = "ModuleList"
ModuleList.Parent = Main

local Container = Converted["_Container"]
Container.Position = UDim2.new(0.0515, 0, 0.0097, 0)
Container.Size = UDim2.new(0.8798, 0, 0.9789, 0)
Container.BackgroundTransparency = 1
Container.Parent = ModuleList

Converted["_UIListLayout"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout"].Parent = Container

-- Modules folder
local Modules = Converted["_Modules"]
Modules.Name = "Modules"
Modules.Parent = Main

-- =========================
-- SERVICES
-- =========================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui") or player:FindFirstChild("PlayerGui")

local blur = Instance.new("BlurEffect", Lighting)
blur.Enabled = false

-- =========================
-- UI REFERENCES
-- =========================
local ModuleVisuals = Modules:WaitForChild("Visuals")
local MetalESPFrame = ModuleVisuals.Main:WaitForChild("MetalESP")
local MetalESPToggleButton = MetalESPFrame.Toggle
local ToggleMetalESPModuleSettingsButton = MetalESPFrame.ToggleModuleSettings

local StarESPFrame = ModuleVisuals.Main:WaitForChild("StarESP")
local StarESPToggleButton = StarESPFrame.Toggle

local AimAssistFrame = ModuleVisuals.Main:WaitForChild("AimAssist")
local AimAssistToggleButton = AimAssistFrame.Toggle

-- =========================
-- SETTINGS
-- =========================
local Settings = {
    METAL_ESP = {ENABLED = false, COLOR = Color3.fromRGB(255,0,0)},
    STAR_ESP = {ENABLED = false},
    AIM_ASSIST = {ENABLED = false},
    keybinds = {}
}

local Beams = {}

-- =========================
-- UTILITY FUNCTIONS
-- =========================

local function getAllPlayers()
    return Players:GetPlayers()
end

local function getNearestPlayer()
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return nil end
    local closestPlayer = nil
    local closestDistance = 35
    local minDistance = 1
    local lookDir = player.Character.HumanoidRootPart.CFrame.LookVector

    for _, otherPlayer in ipairs(getAllPlayers()) do
        if otherPlayer == player or otherPlayer.Team == player.Team then continue end
        local char = otherPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid").Health > 0 then
            local dist = (char.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            local angle = math.deg(math.acos(lookDir:Dot((char.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Unit)))
            if dist < closestDistance and dist > minDistance and angle <= 80 then
                closestDistance = dist
                closestPlayer = otherPlayer
            end
        end
    end

    return closestPlayer
end

local function toggleSetting(setting)
    Settings[setting].ENABLED = not Settings[setting].ENABLED
end

local function toggleBeamType(beamType, visibility)
    if Beams[beamType] then
        for _, beam in ipairs(Beams[beamType]) do
            beam.Enabled = visibility
        end
    end
end

local function createBeam(target, highlight, beamType, color, visibility)
    if not (target.PrimaryPart and player.Character and player.Character.PrimaryPart) then return end

    local attachLoot = Instance.new("Attachment", target.PrimaryPart)
    local attachPlayer = Instance.new("Attachment", player.Character.PrimaryPart)

    local beam = Instance.new("Beam", target.PrimaryPart)
    beam.Attachment0 = attachPlayer
    beam.Attachment1 = attachLoot
    beam.Texture = "http://www.roblox.com/asset/?id=4955566540"
    beam.TextureMode = Enum.TextureMode.Static
    beam.Width0 = 0.2
    beam.Width1 = 0.2
    beam.Segments = 1
    beam.FaceCamera = true
    beam.Enabled = visibility
    beam.Color = color and ColorSequence.new(color) or ColorSequence.new(Color3.fromRGB(255,0,0))

    Beams[beamType] = Beams[beamType] or {}
    table.insert(Beams[beamType], beam)

    if highlight and not target:FindFirstChild("highlightPart") then
        local part = Instance.new("Part", target)
        part.Name = "highlightPart"
        part.Transparency = 0
        part.Anchored = true
        part.CanCollide = false
        part.Position = target.PrimaryPart.Position

        local hl = Instance.new("Highlight", part)
        hl.Enabled = true
        hl.FillTransparency = 0
        hl.FillColor = color or Color3.fromRGB(255,0,0)
        hl.OutlineColor = color or Color3.fromRGB(255,0,0)
    end
end

-- =========================
-- TOGGLES
-- =========================

local function TweenUI(element, length, color)
    TweenService:Create(element, TweenInfo.new(length, Enum.EasingStyle.Linear), {BackgroundColor3=color}):Play()
end

local function OnMetalESPToggleButtonClick()
    toggleSetting("METAL_ESP")
    toggleBeamType("metal-loot", Settings.METAL_ESP.ENABLED)
    TweenUI(MetalESPToggleButton, 0.05, Settings.METAL_ESP.ENABLED and Color3.fromRGB(0,255,0) or Color3.fromRGB(20,20,20))
end

local function OnStarESPToggleButtonClick()
    toggleSetting("STAR_ESP")
    toggleBeamType("star", Settings.STAR_ESP.ENABLED)
    TweenUI(StarESPToggleButton, 0.05, Settings.STAR_ESP.ENABLED and Color3.fromRGB(0,255,0) or Color3.fromRGB(20,20,20))
end

local function OnAimAssistToggleButtonClick()
    toggleSetting("AIM_ASSIST")
    TweenUI(AimAssistToggleButton, 0.05, Settings.AIM_ASSIST.ENABLED and Color3.fromRGB(20,20,20) or Color3.fromRGB(0,255,0))
end

-- =========================
-- AIM ASSIST
-- =========================
local smoothFactor = 0.1
RunService.Heartbeat:Connect(function()
    if Settings.AIM_ASSIST.ENABLED then
        local target = getNearestPlayer()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local cam = Workspace.CurrentCamera
            local newCFrame = CFrame.new(cam.CFrame.Position, target.Character.HumanoidRootPart.Position)
            cam.CFrame = cam.CFrame:Lerp(newCFrame, smoothFactor)
        end
    end
end)

-- =========================
-- METAL ESP
-- =========================
CollectionService:GetInstanceAddedSignal("hidden-metal"):Connect(function(loot)
    createBeam(loot, true, "metal-loot", Settings.METAL_ESP.COLOR, Settings.METAL_ESP.ENABLED)
end)

local function GetMetalLoot()
    for _, loot in ipairs(CollectionService:GetTagged("hidden-metal")) do
        task.wait(0.5)
        createBeam(loot, true, "metal-loot", Settings.METAL_ESP.COLOR, Settings.METAL_ESP.ENABLED)
    end
end

-- =========================
-- STAR ESP
-- =========================
Workspace.ChildAdded:Connect(function(child)
    if child:IsA("Model") and child.Name:find("Star") then
        task.wait(0.1)
        createBeam(child, false, "star", nil, Settings.STAR_ESP.ENABLED)
    end
end)

-- =========================
-- INPUT
-- =========================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        VainUI.Enabled = not VainUI.Enabled
        blur.Enabled = VainUI.Enabled
    elseif input.KeyCode == Enum.KeyCode.Q then
        OnAimAssistToggleButtonClick()
    end
end)

-- =========================
-- CONNECTIONS
-- =========================
AimAssistToggleButton.MouseButton1Click:Connect(OnAimAssistToggleButtonClick)
MetalESPToggleButton.MouseButton1Click:Connect(OnMetalESPToggleButtonClick)
StarESPToggleButton.MouseButton1Click:Connect(OnStarESPToggleButtonClick)

player.CharacterAdded:Connect(function()
    task.wait(1)
    GetMetalLoot()
end)

-- Initialize existing loot
GetMetalLoot()

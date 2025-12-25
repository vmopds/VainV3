-- UI SETUP --

-- Instances:

local Converted = {
	["VainUI"] = Instance.new("ScreenGui");
	["MainFrame"] = Instance.new("Frame");
	["ModuleListFrame"] = Instance.new("Frame");
	["ModuleContainer"] = Instance.new("Frame");
	["ModuleContainerLayout"] = Instance.new("UIListLayout");
	["ModuleListVisuals"] = Instance.new("Frame");
	["ModuleListVisualsCorner"] = Instance.new("UICorner");
	["VisualsButton"] = Instance.new("TextButton");
	["ModuleListCorner"] = Instance.new("UICorner");
	["ModulesFolder"] = Instance.new("Folder");
	["VisualsFrame"] = Instance.new("Frame");
	["VisualsScrollingFrame"] = Instance.new("ScrollingFrame");
	["VisualsLayout"] = Instance.new("UIListLayout");
	["MetalESPFrame"] = Instance.new("Frame");
	["MetalESPCorner"] = Instance.new("UICorner");
	["MetalESPButton"] = Instance.new("TextButton");
	["MetalESPButtonCorner"] = Instance.new("UICorner");
	["MetalESPSettingsFrame"] = Instance.new("Frame");
	["MetalESPSettingsButton"] = Instance.new("ImageButton");
	["StarESPFrame"] = Instance.new("Frame");
	["StarESPCorner"] = Instance.new("UICorner");
	["StarESPButton"] = Instance.new("TextButton");
	["StarESPButtonCorner"] = Instance.new("UICorner");
	["AimAssistFrame"] = Instance.new("Frame");
	["AimAssistCorner"] = Instance.new("UICorner");
	["AimAssistButton"] = Instance.new("TextButton");
	["AimAssistButtonCorner"] = Instance.new("UICorner");
	["VisualsFrameCorner"] = Instance.new("UICorner");
	["HeaderFrame"] = Instance.new("Frame");
	["HeaderCorner"] = Instance.new("UICorner");
	["HeaderLabel"] = Instance.new("TextLabel");
	["HeaderLayout"] = Instance.new("UIListLayout");
	["HeaderName"] = Instance.new("TextLabel");
}

-- Properties:

Converted["VainUI"].DisplayOrder = 999999999
Converted["VainUI"].ResetOnSpawn = false
Converted["VainUI"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Converted["VainUI"].Name = "VainUI"
Converted["VainUI"].Parent = game:GetService("CoreGui")

Converted["MainFrame"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["MainFrame"].BackgroundTransparency = 1
Converted["MainFrame"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["MainFrame"].BorderSizePixel = 0
Converted["MainFrame"].Size = UDim2.new(1, 0, 1, 0)
Converted["MainFrame"].Name = "Main"
Converted["MainFrame"].Parent = Converted["VainUI"]

Converted["ModuleListFrame"].BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Converted["ModuleListFrame"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["ModuleListFrame"].BorderSizePixel = 0
Converted["ModuleListFrame"].Size = UDim2.new(0.085, 0, 1, 0)
Converted["ModuleListFrame"].Name = "ModuleList"
Converted["ModuleListFrame"].Parent = Converted["MainFrame"]

Converted["ModuleContainer"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["ModuleContainer"].BackgroundTransparency = 1
Converted["ModuleContainer"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["ModuleContainer"].BorderSizePixel = 0
Converted["ModuleContainer"].Position = UDim2.new(0.0515, 0, 0.0097, 0)
Converted["ModuleContainer"].Size = UDim2.new(0.8797, 0, 0.9789, 0)
Converted["ModuleContainer"].Name = "Container"
Converted["ModuleContainer"].Parent = Converted["ModuleListFrame"]

Converted["ModuleContainerLayout"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["ModuleContainerLayout"].Parent = Converted["ModuleContainer"]

Converted["ModuleListVisuals"].BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Converted["ModuleListVisuals"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["ModuleListVisuals"].BorderSizePixel = 0
Converted["ModuleListVisuals"].Position = UDim2.new(0.4639, 0, 0.0177, 0)
Converted["ModuleListVisuals"].Size = UDim2.new(1, 0, 0.05, 0)
Converted["ModuleListVisuals"].Name = "Visuals"
Converted["ModuleListVisuals"].Parent = Converted["ModuleContainer"]

Converted["ModuleListVisualsCorner"].Parent = Converted["ModuleListVisuals"]

Converted["VisualsButton"].Font = Enum.Font.Arial
Converted["VisualsButton"].Text = "VISUALS"
Converted["VisualsButton"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["VisualsButton"].TextSize = 14
Converted["VisualsButton"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["VisualsButton"].BackgroundTransparency = 1
Converted["VisualsButton"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["VisualsButton"].BorderSizePixel = 0
Converted["VisualsButton"].Size = UDim2.new(1, 0, 1, 0)
Converted["VisualsButton"].Name = "VisualsButton"
Converted["VisualsButton"].Parent = Converted["ModuleListVisuals"]

Converted["ModuleListCorner"].Parent = Converted["ModuleListFrame"]

Converted["ModulesFolder"].Name = "Modules"
Converted["ModulesFolder"].Parent = Converted["MainFrame"]

Converted["VisualsFrame"].BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Converted["VisualsFrame"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["VisualsFrame"].BorderSizePixel = 0
Converted["VisualsFrame"].Position = UDim2.new(0.1294, 0, 0.0420, 0)
Converted["VisualsFrame"].Size = UDim2.new(0.1, 0, 0.916, 0)
Converted["VisualsFrame"].Name = "Visuals"
Converted["VisualsFrame"].Parent = Converted["ModulesFolder"]

Converted["VisualsScrollingFrame"].AutomaticCanvasSize = Enum.AutomaticSize.Y
Converted["VisualsScrollingFrame"].CanvasSize = UDim2.new(0, 0, 0, 0)
Converted["VisualsScrollingFrame"].ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
Converted["VisualsScrollingFrame"].ScrollBarImageTransparency = 1
Converted["VisualsScrollingFrame"].Active = true
Converted["VisualsScrollingFrame"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["VisualsScrollingFrame"].BackgroundTransparency = 1
Converted["VisualsScrollingFrame"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["VisualsScrollingFrame"].BorderSizePixel = 0
Converted["VisualsScrollingFrame"].Position = UDim2.new(0.0588, 0, 0.0847, 0)
Converted["VisualsScrollingFrame"].Size = UDim2.new(0.8784, 0, 0.8940, 0)
Converted["VisualsScrollingFrame"].Name = "Main"
Converted["VisualsScrollingFrame"].Parent = Converted["VisualsFrame"]

Converted["VisualsLayout"].Padding = UDim.new(0, 5)
Converted["VisualsLayout"].HorizontalAlignment = Enum.HorizontalAlignment.Center
Converted["VisualsLayout"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["VisualsLayout"].Parent = Converted["VisualsScrollingFrame"]

Converted["MetalESPFrame"].AutomaticSize = Enum.AutomaticSize.Y
Converted["MetalESPFrame"].BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Converted["MetalESPFrame"].BackgroundTransparency = 1
Converted["MetalESPFrame"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["MetalESPFrame"].BorderSizePixel = 0
Converted["MetalESPFrame"].LayoutOrder = 1
Converted["MetalESPFrame"].Size = UDim2.new(0.9, 0, 0.04, 0)
Converted["MetalESPFrame"].Name = "MetalESP"
Converted["MetalESPFrame"].Parent = Converted["VisualsScrollingFrame"]

Converted["MetalESPCorner"].Parent = Converted["MetalESPFrame"]

Converted["MetalESPButton"].Font = Enum.Font.Arial
Converted["MetalESPButton"].Text = "Metal ESP"
Converted["MetalESPButton"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["MetalESPButton"].TextSize = 14
Converted["MetalESPButton"].BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Converted["MetalESPButton"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["MetalESPButton"].BorderSizePixel = 0
Converted["MetalESPButton"].Size = UDim2.new(0.8, 0, 1, 0)
Converted["MetalESPButton"].Name = "Toggle"
Converted["MetalESPButton"].Parent = Converted["MetalESPFrame"]

Converted["MetalESPButtonCorner"].Parent = Converted["MetalESPButton"]

Converted["MetalESPSettingsFrame"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["MetalESPSettingsFrame"].BackgroundTransparency = 0.5
Converted["MetalESPSettingsFrame"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["MetalESPSettingsFrame"].BorderSizePixel = 0
Converted["MetalESPSettingsFrame"].Position = UDim2.new(0, 0, 1, 0)
Converted["MetalESPSettingsFrame"].Size = UDim2.new(1, 0, 1, 0)
Converted["MetalESPSettingsFrame"].Visible = false
Converted["MetalESPSettingsFrame"].Name = "Settings"
Converted["MetalESPSettingsFrame"].Parent = Converted["MetalESPFrame"]

Converted["MetalESPSettingsButton"].Image = "http://www.roblox.com/asset/?id=138007024966757"
Converted["MetalESPSettingsButton"].ScaleType = Enum.ScaleType.Fit
Converted["MetalESPSettingsButton"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["MetalESPSettingsButton"].BackgroundTransparency = 1
Converted["MetalESPSettingsButton"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["MetalESPSettingsButton"].BorderSizePixel = 0
Converted["MetalESPSettingsButton"].Position = UDim2.new(0.8, 0, 0, 0)
Converted["MetalESPSettingsButton"].Size = UDim2.new(0.2, 0, 1, 0)
Converted["MetalESPSettingsButton"].Name = "ToggleModuleSettings"
Converted["MetalESPSettingsButton"].Parent = Converted["MetalESPFrame"]

-- StarESPFrame
Converted["StarESPFrame"].BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Converted["StarESPFrame"].BackgroundTransparency = 1
Converted["StarESPFrame"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["StarESPFrame"].BorderSizePixel = 0
Converted["StarESPFrame"].LayoutOrder = 3
Converted["StarESPFrame"].Size = UDim2.new(0.9, 0, 0.04, 0)
Converted["StarESPFrame"].Name = "StarESP"
Converted["StarESPFrame"].Parent = Converted["VisualsScrollingFrame"]

Converted["StarESPCorner"].Parent = Converted["StarESPFrame"]

Converted["StarESPButton"].Font = Enum.Font.Arial
Converted["StarESPButton"].Text = "Star ESP"
Converted["StarESPButton"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["StarESPButton"].TextSize = 14
Converted["StarESPButton"].BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Converted["StarESPButton"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["StarESPButton"].BorderSizePixel = 0
Converted["StarESPButton"].Size = UDim2.new(1, 0, 1, 0)
Converted["StarESPButton"].Name = "Toggle"
Converted["StarESPButton"].Parent = Converted["StarESPFrame"]

Converted["StarESPButtonCorner"].Parent = Converted["StarESPButton"]

-- AimAssistFrame
Converted["AimAssistFrame"].BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Converted["AimAssistFrame"].BackgroundTransparency = 1
Converted["AimAssistFrame"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["AimAssistFrame"].BorderSizePixel = 0
Converted["AimAssistFrame"].LayoutOrder = 3
Converted["AimAssistFrame"].Size = UDim2.new(0.9, 0, 0.04, 0)
Converted["AimAssistFrame"].Name = "AimAssist"
Converted["AimAssistFrame"].Parent = Converted["VisualsScrollingFrame"]

Converted["AimAssistCorner"].Parent = Converted["AimAssistFrame"]

Converted["AimAssistButton"].Font = Enum.Font.Arial
Converted["AimAssistButton"].Text = "AimAssist"
Converted["AimAssistButton"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["AimAssistButton"].TextSize = 14
Converted["AimAssistButton"].BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Converted["AimAssistButton"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["AimAssistButton"].BorderSizePixel = 0
Converted["AimAssistButton"].Size = UDim2.new(1, 0, 1, 0)
Converted["AimAssistButton"].Name = "Toggle"
Converted["AimAssistButton"].Parent = Converted["AimAssistFrame"]

Converted["AimAssistButtonCorner"].Parent = Converted["AimAssistButton"]

-- VisualsFrame Corner
Converted["VisualsFrameCorner"].Parent = Converted["VisualsFrame"]

-- Header
Converted["HeaderFrame"].BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Converted["HeaderFrame"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["HeaderFrame"].BorderSizePixel = 0
Converted["HeaderFrame"].Size = UDim2.new(1.0, 0, 0.0584, 0)
Converted["HeaderFrame"].Name = "Header"
Converted["HeaderFrame"].Parent = Converted["VisualsFrame"]

Converted["HeaderCorner"].Parent = Converted["HeaderFrame"]

Converted["HeaderLabel"].Font = Enum.Font.SourceSans
Converted["HeaderLabel"].Text = ""
Converted["HeaderLabel"].TextColor3 = Color3.fromRGB(0, 0, 0)
Converted["HeaderLabel"].TextSize = 14
Converted["HeaderLabel"].BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Converted["HeaderLabel"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["HeaderLabel"].BorderSizePixel = 0
Converted["HeaderLabel"].LayoutOrder = 3
Converted["HeaderLabel"].Size = UDim2.new(1, 0, 0.1, 0)
Converted["HeaderLabel"].Name = "nn"
Converted["HeaderLabel"].Parent = Converted["HeaderFrame"]

Converted["HeaderLayout"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["HeaderLayout"].Parent = Converted["HeaderFrame"]

Converted["HeaderName"].Font = Enum.Font.SourceSans
Converted["HeaderName"].Text = "VISUALS"
Converted["HeaderName"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["HeaderName"].TextSize = 14
Converted["HeaderName"].BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Converted["HeaderName"].BackgroundTransparency = 1
Converted["HeaderName"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["HeaderName"].BorderSizePixel = 0
Converted["HeaderName"].LayoutOrder = 1
Converted["HeaderName"].Size = UDim2.new(1, 0, 0.9, 0)
Converted["HeaderName"].Name = "name"
Converted["HeaderName"].Parent = Converted["HeaderFrame"]


-- VARIABLES --

local CollectionService = game:GetService("CollectionService")
local TeamService = game:GetService("Teams")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Workspace = game.Workspace
local RunService = game:GetService("RunService")

local camera = workspace.CurrentCamera
local smoothFactor = 0.1


-- UI VARIABLES --

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui") or player:FindFirstChild("PlayerGui")
local MainGUI = Converted["VainUI"]
MainGUI.Enabled = false

local Main = MainGUI:WaitForChild("Main")

local Modules = Main:WaitForChild("Modules")

local ModuleVisuals = Modules:WaitForChild("Visuals")

local MetalESPFrame = ModuleVisuals:WaitForChild("Main"):WaitForChild("MetalESP")
local MetalESPToggleButton = MetalESPFrame:WaitForChild("Toggle")
local ToggleMetalESPModuleSettingsButton = MetalESPFrame:WaitForChild("ToggleModuleSettings")

local StarESPFrame = ModuleVisuals:WaitForChild("Main"):WaitForChild("StarESP")
local StarESPToggleButton = StarESPFrame:WaitForChild("Toggle")

local AimAssistFrame =  ModuleVisuals:WaitForChild("Main"):WaitForChild("AimAssist")
local AimAssistToggleButton = AimAssistFrame:WaitForChild("Toggle")

local ModuleList = Main:WaitForChild("ModuleList")
local Container = ModuleList:WaitForChild("Container")
local ModuleListVisuals = Container:WaitForChild("Visuals")
local VisualsButton = ModuleListVisuals:WaitForChild("VisualsButton")

local blur = Instance.new("BlurEffect", Lighting)
blur.Enabled = false


--// MODULE SETTING UI

-- SHOW DISTANCE TOGGLE FOR METAL ESP
local ShowDistanceMetalFrame = Instance.new("Frame")
ShowDistanceMetalFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ShowDistanceMetalFrame.BackgroundTransparency = 0
ShowDistanceMetalFrame.BorderSizePixel = 0
ShowDistanceMetalFrame.Size = UDim2.new(1, 0, 0, 30)
ShowDistanceMetalFrame.LayoutOrder = 2
ShowDistanceMetalFrame.Name = "ShowDistance"
ShowDistanceMetalFrame.Parent = MetalESPFrame.Settings

local ShowDistanceMetalButton = Instance.new("TextButton")
ShowDistanceMetalButton.Font = Enum.Font.Arial
ShowDistanceMetalButton.Text = "Show Distance"
ShowDistanceMetalButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowDistanceMetalButton.TextSize = 14
ShowDistanceMetalButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ShowDistanceMetalButton.BorderSizePixel = 0
ShowDistanceMetalButton.Size = UDim2.new(1, 0, 1, 0)
ShowDistanceMetalButton.Parent = ShowDistanceMetalFrame

local ShowDistanceMetalUICorner = Instance.new("UICorner")
ShowDistanceMetalUICorner.CornerRadius = UDim.new(0, 6)
ShowDistanceMetalUICorner.Parent = ShowDistanceMetalButton





--// STAR ESP MODULE \\--

-- STAR ESP SETTINGS FRAME
local StarESPSettings = Instance.new("Frame")
StarESPSettings.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
StarESPSettings.BackgroundTransparency = 0.5
StarESPSettings.BorderSizePixel = 0
StarESPSettings.Position = UDim2.new(0, 0, 1, 0)
StarESPSettings.Size = UDim2.new(1, 0, 1, 0)
StarESPSettings.Visible = false
StarESPSettings.Name = "Settings"
StarESPSettings.Parent = StarESPFrame

-- Add UICorner for style
local StarESPSettingsCorner = Instance.new("UICorner")
StarESPSettingsCorner.Parent = StarESPSettings

local ShowDistanceStarFrame = Instance.new("Frame")
ShowDistanceStarFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ShowDistanceStarFrame.BackgroundTransparency = 0
ShowDistanceStarFrame.BorderSizePixel = 0
ShowDistanceStarFrame.Size = UDim2.new(1, 0, 0, 30)
ShowDistanceStarFrame.LayoutOrder = 2
ShowDistanceStarFrame.Name = "ShowDistance"
ShowDistanceStarFrame.Parent = StarESPFrame.Settings

local ShowDistanceStarButton = Instance.new("TextButton")
ShowDistanceStarButton.Font = Enum.Font.Arial
ShowDistanceStarButton.Text = "Show Distance"
ShowDistanceStarButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowDistanceStarButton.TextSize = 14
ShowDistanceStarButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ShowDistanceStarButton.BorderSizePixel = 0
ShowDistanceStarButton.Size = UDim2.new(1, 0, 1, 0)
ShowDistanceStarButton.Parent = ShowDistanceStarFrame

local ShowDistanceStarUICorner = Instance.new("UICorner")
ShowDistanceStarUICorner.CornerRadius = UDim.new(0, 6)
ShowDistanceStarUICorner.Parent = ShowDistanceStarButton



--// NOTIFICATIONS

local NotificationFolder = Instance.new("Folder")
NotificationFolder.Name = "Notifications"
NotificationFolder.Parent = MainGUI

local notifications = {} -- Stores active notifications
local spacing = 10 -- space between notifications
local notificationWidth = 300
local notificationHeight = 60
local displayTime = 5 -- default time in seconds

-- SETTINGS --

Settings = {

	METAL_ESP = {
		ENABLED = false,
		COLOR = Color3.fromRGB(255,0,0),
		SHOW_DISTANCE = false,
	},

	STAR_ESP = {
		ENABLED = false,
		COLOR = Color3.fromRGB(255,0,0),
		SHOW_DISTANCE = false,
	},

	keybinds = {

	},

	AIM_ASSIST = {
		ENABLED = false,
	},

}

-- FUNCTIONS --

local function TweenUI(element, length, color)

	local goal = {}
	goal.BackgroundColor3 = color

	local tweenInfo = TweenInfo.new(length, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)

	local tween = TweenService:Create(element, tweenInfo, goal)
	tween:Play()
end

local function createNotification(text, duration)
	duration = duration or displayTime

	-- Create main frame
	local notifFrame = Instance.new("Frame")
	notifFrame.Size = UDim2.new(0, notificationWidth, 0, notificationHeight)
	notifFrame.Position = UDim2.new(1, -notificationWidth - 20, 1, -notificationHeight - 20) -- start at bottom-right
	notifFrame.AnchorPoint = Vector2.new(0, 1)
	notifFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	notifFrame.BorderSizePixel = 0
	notifFrame.ZIndex = 1000
	notifFrame.Parent = NotificationFolder

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = notifFrame

	-- Text
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -10, 1, -20)
	label.Position = UDim2.new(0, 5, 0, 5)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextWrapped = true
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextYAlignment = Enum.TextYAlignment.Top
	label.Font = Enum.Font.SourceSans
	label.TextSize = 14
	label.Parent = notifFrame

	-- Timer bar
	local timerBar = Instance.new("Frame")
	timerBar.Size = UDim2.new(1, 0, 0, 5)
	timerBar.Position = UDim2.new(0, 0, 1, -5)
	timerBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	timerBar.BorderSizePixel = 0
	timerBar.Parent = notifFrame

	local timerTween = TweenService:Create(timerBar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 0, 5)})
	timerTween:Play()

	-- Stack notifications
	table.insert(notifications, notifFrame)
	local function updatePositions()
		for i, frame in ipairs(notifications) do
			local goalPos = UDim2.new(1, -notificationWidth - 20, 1, -(notificationHeight + spacing) * i)
			TweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {Position = goalPos}):Play()
		end
	end
	updatePositions()

	-- Remove function
	local function removeNotification()
		local index
		for i, f in ipairs(notifications) do
			if f == notifFrame then index = i break end
		end
		if index then
			table.remove(notifications, index)
		end
		notifFrame:Destroy()
		updatePositions()
	end

	-- Auto remove after duration
	task.delay(duration, removeNotification)

	-- Remove on click
	notifFrame.MouseButton1Click:Connect(removeNotification)
end

local function getAllPlayers()
	return Players:GetPlayers()
end

local function getNearestPlayer()
	local closestPlayer = nil
	local minDistance = 1
	local closestDistance = 35
	local playerLookDirection
	if player and player.Character then
		playerLookDirection = player.Character.HumanoidRootPart.CFrame.LookVector 
	end

	for _, currentPlayer in pairs(game.Players:GetPlayers()) do
		if currentPlayer == player or currentPlayer.Team == player.Team then continue end
		if currentPlayer.Character and currentPlayer.Character:FindFirstChild("HumanoidRootPart") then
			if currentPlayer.Character:FindFirstChild("Humanoid").Health > 0 then
				local distance = (currentPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
				local toPlayerDirection = (currentPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).unit

				local angle = math.acos(playerLookDirection:Dot(toPlayerDirection))

				angle = math.deg(angle)

				if distance < closestDistance and distance > minDistance and angle <= 80 then
					closestDistance = distance
					closestPlayer = currentPlayer
				end
			end
		end
	end

	return closestPlayer
end

local function toggleMetalESP()
	Settings.METAL_ESP.ENABLED = not Settings.METAL_ESP.ENABLED
end

local function toggleStarESP()
	Settings.STAR_ESP.ENABLED = not Settings.STAR_ESP.ENABLED
end

-- ESP STORAGE
local Beams = {}
local Highlights = {}

-- Store ESP by type
local ESPTypes = {
	["metal-loot"] = {},
	["star"] = {},
	-- add more types here
}

-- Create ESP (Beam + Highlight) for a specific type
local function createESP(target, typeName, color, visibility)
	if not target.PrimaryPart or not player.Character or not player.Character.PrimaryPart then return end

	-- Remove existing ESP if present
	if Beams[target] then Beams[target]:Destroy() Beams[target] = nil end
	if Highlights[target] then Highlights[target]:Destroy() Highlights[target] = nil end

	-- Attachments
	local attachTarget = Instance.new("Attachment")
	attachTarget.Parent = target.PrimaryPart

	local attachPlayer = Instance.new("Attachment")
	attachPlayer.Parent = player.Character.PrimaryPart

	-- Beam
	local beam = Instance.new("Beam")
	beam.Attachment0 = attachPlayer
	beam.Attachment1 = attachTarget
	beam.Width0 = 0.2
	beam.Width1 = 0.2
	beam.FaceCamera = true
	beam.Color = ColorSequence.new(color)
	beam.Texture = "http://www.roblox.com/asset/?id=4955566540"
	beam.Parent = target.PrimaryPart
	beam.Enabled = visibility

	-- Highlight
	local insert = nil

	if target.Name == "VitalityStar" or target.Name == "CritStar" then
		insert = target:FindFirstChild("neon_mesh")
	else
		local part = Instance.new("Part", target)
		part.Name = "highlightPart"
		part.Transparency = 0
		part.CanCollide = false
		part.Anchored = true

		if target:IsA("Model") then
			part.Position = target.PrimaryPart.Position
		else
			part.Position = target.Position
		end

		insert = part
	end

	local highlight = Instance.new("Highlight")
	highlight.Adornee = insert
	highlight.FillColor = color
	highlight.OutlineColor = color
	highlight.FillTransparency = 0
	highlight.OutlineTransparency = 0
	highlight.Enabled = visibility
	highlight.Parent = insert

	-- Store references
	Beams[target] = beam
	Highlights[target] = highlight
	if not ESPTypes[typeName] then ESPTypes[typeName] = {} end
	table.insert(ESPTypes[typeName], target)

	-- Cleanup if target removed
	target.AncestryChanged:Connect(function(_, parent)
		if not parent then
			if Beams[target] then Beams[target]:Destroy() Beams[target] = nil end
			if Highlights[target] then Highlights[target]:Destroy() Highlights[target] = nil end
			for i, v in ipairs(ESPTypes[typeName]) do
				if v == target then table.remove(ESPTypes[typeName], i) break end
			end
		end
	end)
end

-- Toggle visibility of an entire ESP type
local function toggleESPType(typeName, visibility)
	if ESPTypes[typeName] then
		for _, target in ipairs(ESPTypes[typeName]) do
			if Beams[target] then Beams[target].Enabled = visibility end
			if Highlights[target] then 
				Highlights[target].Enabled = visibility 
				Highlights[target].Parent.Transparency = visibility and 0 or 1
			end
		end
	end
end

local function toggleShowDistance(typeName, button)
	local settingTable = Settings[typeName]
	if not settingTable then return end

	settingTable.SHOW_DISTANCE = not settingTable.SHOW_DISTANCE

	local color = settingTable.SHOW_DISTANCE and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(20, 20, 20)
	TweenUI(button, 0.05, color)
end

-- Connect buttons
ShowDistanceMetalButton.MouseButton1Click:Connect(function()
	toggleShowDistance("METAL_ESP", ShowDistanceMetalButton)
end)

-- Similarly for Star ESP:
ShowDistanceStarButton.MouseButton1Click:Connect(function()
	toggleShowDistance("STAR_ESP", ShowDistanceStarButton)
end)


--// METAL ESP

local function UpdateMetalLoot()
	for _, loot in ipairs(CollectionService:GetTagged("hidden-metal")) do
		createESP(loot, "metal-loot", Color3.fromRGB(255,0,0), Settings.METAL_ESP.ENABLED)
	end
end

CollectionService:GetInstanceAddedSignal("hidden-metal"):Connect(function(loot)
	createESP(loot, "metal-loot", Color3.fromRGB(255,0,0), Settings.METAL_ESP.ENABLED)
end)

--// STAR ESP

local function UpdateStars()
	for _, star in ipairs(workspace:GetChildren()) do
		if star.Name:find("Star") then
			createESP(star, "star", Color3.fromRGB(0,255,0), Settings.STAR_ESP.ENABLED)
		end
	end
end

workspace.ChildAdded:Connect(function(child)
	if child.Name:find("Star") then
		task.wait(0.1)
		createESP(child, "star", Color3.fromRGB(0,255,0), Settings.STAR_ESP.ENABLED)
	end
end)

-- Module Toggle Functions


local function toggleAimAssist()
	if Settings.AIM_ASSIST.ENABLED then
		Settings.AIM_ASSIST.ENABLED = false
		TweenUI(AimAssistToggleButton, .05, Color3.fromRGB(0, 255, 0))
	else
		Settings.AIM_ASSIST.ENABLED = true
		TweenUI(AimAssistToggleButton, .05, Color3.fromRGB(20, 20, 20))
	end
end

local function OnMetalESPToggleButtonClick()
	toggleMetalESP()
	if Settings.METAL_ESP.ENABLED == true then
		toggleESPType("metal-loot", true)
		TweenUI(MetalESPToggleButton, .05, Color3.fromRGB(0, 255, 0))
	else
		toggleESPType("metal-loot", false)
		TweenUI(MetalESPToggleButton, .05, Color3.fromRGB(20, 20, 20))
	end
	createNotification("Successfully " .. (Settings.METAL_ESP.ENABLED and "enabled" or "disabled") .. " Metal ESP", 3)
end

local function OnStarESPToggleButtonClick()
	toggleStarESP()

	if Settings.STAR_ESP.ENABLED == true then
		toggleESPType("star", true)
		TweenUI(StarESPToggleButton, .05, Color3.fromRGB(0, 255, 0))
	else
		toggleESPType("star", false)
		TweenUI(StarESPToggleButton, .05, Color3.fromRGB(20, 20, 20))
	end

	createNotification("Successfully " .. (Settings.STAR_ESP.ENABLED and "enabled" or "disabled") .. " Star ESP", 3)
end

local function OnAimAssistToggleButtonClick()
	toggleAimAssist()
end



local function OnModuleButtonPressed(button)

	local Settings = button.Parent:FindFirstChild("Settings") or button.Parent:WaitForChild("Settings")
	if Settings.Visible == true then
		Settings.Visible = false
	else
		Settings.Visible = true
	end

end

local children = {MetalESPFrame, StarESPFrame, AimAssistFrame}

local function InitializeAllModuleSettingsButtons()	
	for i, v in children do
		for i, button in pairs(v:GetChildren()) do
			if button.Name == "ToggleModuleSettings" then
				button.MouseButton1Click:Connect(function()
					OnModuleButtonPressed(button)
				end)
			end
		end
	end

end

ShowDistanceStarButton.MouseButton1Click:Connect(function()
	Settings.STAR_ESP.SHOW_DISTANCE = not Settings.STAR_ESP.SHOW_DISTANCE
	local color = Settings.STAR_ESP.SHOW_DISTANCE and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(20, 20, 20)
	TweenUI(ShowDistanceStarButton, 0.05, color)
end)


local distanceTexts = {}

local function updateESPDistances()
	for typeName, espList in pairs(ESPTypes) do
		local showDistance = Settings[typeName] and Settings[typeName].SHOW_DISTANCE
		for _, target in ipairs(espList) do
			if showDistance and target.PrimaryPart and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				local dist = (target.PrimaryPart.Position - player.Character.HumanoidRootPart.Position).Magnitude

				if not distanceTexts[target] then
					local textLabel = Instance.new("BillboardGui")
					textLabel.Size = UDim2.new(0, 100, 0, 30)
					textLabel.Adornee = target.PrimaryPart
					textLabel.AlwaysOnTop = true
					textLabel.Parent = target

					local label = Instance.new("TextLabel")
					label.BackgroundTransparency = 1
					label.Size = UDim2.new(1, 0, 1, 0)
					label.TextColor3 = Color3.fromRGB(255, 255, 255)
					label.TextScaled = true
					label.TextStrokeTransparency = 0
					label.Font = Enum.Font.Arial
					label.Parent = textLabel

					distanceTexts[target] = label
				end
				distanceTexts[target].Text = string.format("%.1f studs", dist)
			elseif distanceTexts[target] then
				distanceTexts[target]:Destroy()
				distanceTexts[target] = nil
			end
		end
	end
end

RunService.Heartbeat:Connect(function()
	updateESPDistances()
	if Settings.AIM_ASSIST.ENABLED then
		local nearestPlayer = getNearestPlayer()
		if nearestPlayer and nearestPlayer.Character and nearestPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local targetPosition = nearestPlayer.Character.HumanoidRootPart.Position

			-- Smoothly transition to the target
			local newCFrame = CFrame.new(camera.CFrame.Position, targetPosition)
			camera.CFrame = camera.CFrame:Lerp(newCFrame, smoothFactor) 
		end
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		if MainGUI.Enabled == false then
			MainGUI.Enabled = true
			blur.Enabled = true
		else
			MainGUI.Enabled = false
			blur.Enabled = false
		end
	end
	if input.KeyCode == Enum.KeyCode.Q  then
		toggleAimAssist()
	end
end)

player.CharacterAdded:Connect(function()
	task.wait(1)
	UpdateStars()
	UpdateMetalLoot()
end)

InitializeAllModuleSettingsButtons()
UpdateStars()
UpdateMetalLoot()


AimAssistToggleButton.MouseButton1Click:Connect(OnAimAssistToggleButtonClick)
MetalESPToggleButton.MouseButton1Click:Connect(OnMetalESPToggleButtonClick)
StarESPToggleButton.MouseButton1Click:Connect(OnStarESPToggleButtonClick)

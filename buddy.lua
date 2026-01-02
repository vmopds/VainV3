--// Modern Vain UI Framework (Logic-Integrated)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local IsInteractingWithSlider = false 

local ModuleKeybinds = {} 
local BeamGroups = {}
local GroupStates = {}
local UIKeybind = Enum.KeyCode.RightShift

--------------------------------------------------
-- UTILS
--------------------------------------------------
local function Tween(obj, info, props)
	local t = TweenService:Create(obj, info, props)
	t:Play()
	return t
end

local TweenFast = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TweenSlow = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- ... [MakeDraggable Function remains the same] ...
local function MakeDraggable(frame, dragHandle)
	dragHandle = dragHandle or frame
	local dragging, dragStart, startPos
	dragHandle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and not IsInteractingWithSlider then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			Tween(frame, TweenInfo.new(0.1), {
				Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			})
		end
	end)
end

--------------------------------------------------
-- CORE SETUP
--------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VainUI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Size = UDim2.fromScale(0.5, 0.55)
Main.Position = UDim2.fromScale(0.25, 0.22)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Main.Active = true
MakeDraggable(Main)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)


-- TOOLTIPS

local TooltipFrame = Instance.new("Frame")
TooltipFrame.Name = "VainTooltip"
TooltipFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TooltipFrame.BorderSizePixel = 0
TooltipFrame.Visible = false
TooltipFrame.ZIndex = 10000 -- Extremely high ZIndex
TooltipFrame.Parent = ScreenGui -- Ensure ScreenGui.IgnoreGuiInset is true or false consistently
Instance.new("UICorner", TooltipFrame).CornerRadius = UDim.new(0, 5)

local TooltipStroke = Instance.new("UIStroke", TooltipFrame)
TooltipStroke.Color = Color3.fromRGB(60, 60, 60)
TooltipStroke.Thickness = 1.2

local TooltipLabel = Instance.new("TextLabel")
TooltipLabel.Name = "Label"
TooltipLabel.Size = UDim2.new(1, -14, 1, -14) -- Padding
TooltipLabel.Position = UDim2.fromOffset(7, 7)
TooltipLabel.BackgroundTransparency = 1
TooltipLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TooltipLabel.Font = Enum.Font.GothamMedium
TooltipLabel.TextSize = 12
TooltipLabel.TextXAlignment = Enum.TextXAlignment.Left
TooltipLabel.TextYAlignment = Enum.TextYAlignment.Top
TooltipLabel.TextWrapped = true
TooltipLabel.ZIndex = 10001
TooltipLabel.Parent = TooltipFrame

RunService.RenderStepped:Connect(function()
	if TooltipFrame.Visible then
		local MousePos = UserInputService:GetMouseLocation()
		local Inset = GuiService:GetGuiInset()
		-- Subtracting the Inset.Y fixes the "Way off the cursor" issue (TopBar height)
		TooltipFrame.Position = UDim2.fromOffset(MousePos.X + 15, MousePos.Y - Inset.Y + 15)
	end
end)

local function ShowTooltip(desc)
	if desc and desc ~= "" then
		TooltipLabel.Text = desc
		local tSize = game:GetService("TextService"):GetTextSize(desc, 12, Enum.Font.GothamMedium, Vector2.new(220, 500))
		TooltipFrame.Size = UDim2.fromOffset(tSize.X + 20, tSize.Y + 20)

		-- Smooth Fade In
		TooltipFrame.BackgroundTransparency = 1
		TooltipLabel.TextTransparency = 1
		TooltipStroke.Transparency = 1
		TooltipFrame.Visible = true

		Tween(TooltipFrame, TweenFast, {BackgroundTransparency = 0})
		Tween(TooltipLabel, TweenFast, {TextTransparency = 0})
		Tween(TooltipStroke, TweenFast, {Transparency = 0})
	else
		TooltipFrame.Visible = false
	end
end

local function HideTooltip()
	TooltipFrame.Visible = false
end

----------------------------------------

local UI = {Categories = {}} 

-- Keybind Listener
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == UIKeybind then Main.Visible = not Main.Visible end
	if ModuleKeybinds[input.KeyCode] then ModuleKeybinds[input.KeyCode]() end
end)

-- Sidebar/Content Setup
local CategoryBar = Instance.new("Frame")
CategoryBar.Size = UDim2.fromScale(0.25, 1)
CategoryBar.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
CategoryBar.Parent = Main
Instance.new("UICorner", CategoryBar).CornerRadius = UDim.new(0, 12)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 60)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "VAIN"
TitleLabel.TextColor3 = Color3.fromRGB(0, 120, 255)
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.TextSize = 20
TitleLabel.Parent = CategoryBar

local CategoryList = Instance.new("Frame")
CategoryList.Size = UDim2.new(1, 0, 1, -70)
CategoryList.Position = UDim2.fromOffset(0, 70)
CategoryList.BackgroundTransparency = 1
CategoryList.Parent = CategoryBar
local CatLayout = Instance.new("UIListLayout", CategoryList)
CatLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
CatLayout.Padding = UDim.new(0, 8)

local ContentBackground = Instance.new("Frame")
ContentBackground.Position = UDim2.fromScale(0.25, 0)
ContentBackground.Size = UDim2.fromScale(0.75, 1)
ContentBackground.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
ContentBackground.Parent = Main
Instance.new("UICorner", ContentBackground).CornerRadius = UDim.new(0, 12)

--------------------------------------------------
-- UI BUILDER functions
--------------------------------------------------
function UI:CreateCategory(name)
	local Category = {Button = nil, Page = nil}

	local Button = Instance.new("TextButton")
	Button.Size = UDim2.new(0.85, 0, 0, 38)
	Button.Text = name
	Button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Button.TextColor3 = Color3.fromRGB(120, 120, 120)
	Button.Font = Enum.Font.GothamBold
	Button.TextSize = 13
	Button.Parent = CategoryList
	Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)

	local Page = Instance.new("ScrollingFrame")
	Page.Size = UDim2.fromScale(1, 1)
	Page.BackgroundTransparency = 1
	Page.ScrollBarThickness = 0
	Page.Visible = false
	Page.Parent = ContentBackground
	local PageLayout = Instance.new("UIListLayout", Page)
	PageLayout.Padding = UDim.new(0, 10)
	PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	Instance.new("UIPadding", Page).PaddingTop = UDim.new(0, 20)

	Category.Button = Button
	Category.Page = Page
	table.insert(UI.Categories, Category)

	Button.MouseButton1Click:Connect(function()
		for _, cat in pairs(UI.Categories) do
			cat.Page.Visible = false
			Tween(cat.Button, TweenFast, {BackgroundColor3 = Color3.fromRGB(25, 25, 25), TextColor3 = Color3.fromRGB(120, 120, 120)})
		end
		Page.Visible = true
		Button.TextXAlignment = Enum.TextXAlignment.Center
		Tween(Button, TweenFast, {BackgroundColor3 = Color3.fromRGB(40, 40, 40), TextColor3 = Color3.fromRGB(255, 255, 255)})
	end)

	function Category:CreateToggle(text, desc, mainCallback)
		local ModuleData = {Enabled = false} 
		local Opened = false
		local CurrentKey = nil

		local Container = Instance.new("Frame")
		Container.Size = UDim2.new(0.94, 0, 0, 48)
		Container.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		Container.ClipsDescendants = true
		Container.Parent = Page
		Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 8)

		local ToggleBtn = Instance.new("TextButton")
		ToggleBtn.Size = UDim2.new(1, 0, 0, 48)
		ToggleBtn.Text = text
		ToggleBtn.BackgroundTransparency = 1
		ToggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
		ToggleBtn.Font = Enum.Font.GothamMedium
		ToggleBtn.TextSize = 14
		ToggleBtn.Parent = Container
		ToggleBtn.MouseEnter:Connect(function() ShowTooltip(desc) end)
		ToggleBtn.MouseLeave:Connect(HideTooltip)

		local Arrow = Instance.new("TextButton")
		Arrow.Size = UDim2.new(0, 40, 0, 48)
		Arrow.Position = UDim2.new(1, -45, 0, 0)
		Arrow.BackgroundTransparency = 1
		Arrow.Text = ">"
		Arrow.TextColor3 = Color3.fromRGB(150, 150, 150)
		Arrow.Font = Enum.Font.GothamBold
		Arrow.TextSize = 16
		Arrow.Parent = Container

		local SettingsFrame = Instance.new("Frame")
		SettingsFrame.Position = UDim2.new(0, 0, 0, 48)
		SettingsFrame.Size = UDim2.new(1, 0, 0, 0)
		SettingsFrame.BackgroundTransparency = 1
		SettingsFrame.Parent = Container
		local SetLayout = Instance.new("UIListLayout", SettingsFrame)
		SetLayout.Padding = UDim.new(0, 8)
		SetLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

		local function ToggleAction()
			ModuleData.Enabled = not ModuleData.Enabled
			Tween(Container, TweenFast, {BackgroundColor3 = ModuleData.Enabled and Color3.fromRGB(60, 100, 255) or Color3.fromRGB(30, 30, 30)})
			Tween(ToggleBtn, TweenFast, {TextColor3 = ModuleData.Enabled and Color3.new(1,1,1) or Color3.fromRGB(200, 200, 200)})
			mainCallback(ModuleData.Enabled, ModuleData)
		end

		ToggleBtn.MouseButton1Click:Connect(ToggleAction)

		local function UpdateSize()
			local targetHeight = Opened and (48 + SetLayout.AbsoluteContentSize.Y + 15) or 48
			Tween(Container, TweenSlow, {Size = UDim2.new(0.94, 0, 0, targetHeight)})
		end

		Arrow.MouseButton1Click:Connect(function()
			Opened = not Opened
			UpdateSize()
			Tween(Arrow, TweenFast, {Rotation = Opened and 90 or 0})
		end)

		local Settings = {}

		function Settings:CreateKeybind(defaultKey)
			local Holder = Instance.new("Frame")
			Holder.Size = UDim2.new(0.9, 0, 0, 36)
			Holder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Holder.Parent = SettingsFrame
			Instance.new("UICorner", Holder)

			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(1, -100, 1, 0)
			Label.Position = UDim2.new(0, 12, 0, 0)
			Label.BackgroundTransparency = 1
			Label.Text = "Keybind:"
			Label.TextColor3 = Color3.fromRGB(160, 160, 160)
			Label.Font = Enum.Font.Gotham
			Label.TextSize = 12
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Parent = Holder

			local BindButton = Instance.new("TextButton")
			BindButton.Size = UDim2.new(0, 75, 0, 24)
			BindButton.Position = UDim2.new(1, -83, 0.5, -12)
			BindButton.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
			BindButton.Text = defaultKey and defaultKey.Name or "NONE"
			BindButton.TextColor3 = Color3.new(1, 1, 1)
			BindButton.Font = Enum.Font.GothamMedium
			BindButton.TextSize = 11
			BindButton.Parent = Holder
			Instance.new("UICorner", BindButton).CornerRadius = UDim.new(0, 4)

			local function SetBind(key)
				if CurrentKey then ModuleKeybinds[CurrentKey] = nil end
				CurrentKey = key
				if key then ModuleKeybinds[key] = ToggleAction BindButton.Text = key.Name else BindButton.Text = "NONE" end
			end

			if defaultKey then SetBind(defaultKey) end

			BindButton.MouseButton1Click:Connect(function()
				BindButton.Text = "..."
				local conn; conn = UserInputService.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Keyboard then SetBind(input.KeyCode) conn:Disconnect() end
				end)
			end)
			UpdateSize()
		end

		function Settings:CreateSubToggle(sText, sDesc, default, sCallback)
			ModuleData[sText] = default or false
			local Holder = Instance.new("Frame")
			Holder.Size = UDim2.new(0.9, 0, 0, 36)
			Holder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Holder.Parent = SettingsFrame
			Holder.MouseEnter:Connect(function() ShowTooltip(sDesc) end)
			Holder.MouseLeave:Connect(HideTooltip)
			Instance.new("UICorner", Holder)

			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(1, -100, 1, 0)
			Label.Position = UDim2.new(0, 12, 0, 0)
			Label.BackgroundTransparency = 1
			Label.Text = sText
			Label.TextColor3 = Color3.fromRGB(160, 160, 160)
			Label.Font = Enum.Font.Gotham
			Label.TextSize = 12
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Parent = Holder

			local CheckBox = Instance.new("TextButton")
			CheckBox.Size = UDim2.new(0, 24, 0, 24)
			CheckBox.Position = UDim2.new(1, -32, 0.5, -12)
			CheckBox.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
			CheckBox.Text = ""
			CheckBox.Parent = Holder
			Instance.new("UICorner", CheckBox).CornerRadius = UDim.new(0, 4)

			local Inner = Instance.new("Frame")
			Inner.Size = UDim2.fromScale(0.6, 0.6)
			Inner.Position = UDim2.fromScale(0.2, 0.2)
			Inner.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
			Inner.BackgroundTransparency = ModuleData[sText] and 0 or 1
			Inner.Parent = CheckBox
			Instance.new("UICorner", Inner).CornerRadius = UDim.new(0, 2)

			-- Inside function Settings:CreateSubToggle
			CheckBox.MouseButton1Click:Connect(function()
				ModuleData[sText] = not ModuleData[sText]
				Tween(Inner, TweenFast, {BackgroundTransparency = ModuleData[sText] and 0 or 1})

				-- REMOVED the "if ModuleData.Enabled" check so it always updates the logic
				if sCallback then
					sCallback(ModuleData[sText])
				end
			end)
			UpdateSize()
		end

		function Settings:CreateSubSlider(sText, sDesc, min, max, default, sCallback)
			ModuleData[sText] = default
			local Holder = Instance.new("Frame")
			Holder.Size = UDim2.new(0.9, 0, 0, 44)
			Holder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Holder.Parent = SettingsFrame
			Holder.MouseEnter:Connect(function() ShowTooltip(sDesc) end)
			Holder.MouseLeave:Connect(HideTooltip)
			Instance.new("UICorner", Holder)

			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(1, -20, 0, 20)
			Label.Position = UDim2.new(0, 12, 0, 4)
			Label.BackgroundTransparency = 1
			Label.Text = sText .. ": " .. default
			Label.TextColor3 = Color3.fromRGB(160, 160, 160)
			Label.Font = Enum.Font.Gotham
			Label.TextSize = 11
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Parent = Holder

			local Bar = Instance.new("Frame")
			Bar.Size = UDim2.new(1, -24, 0, 4)
			Bar.Position = UDim2.new(0, 12, 0, 30)
			Bar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
			Bar.Parent = Holder
			Instance.new("UICorner", Bar)

			local Fill = Instance.new("Frame")
			Fill.Size = UDim2.fromScale((default - min) / (max - min), 1)
			Fill.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
			Fill.Parent = Bar
			Instance.new("UICorner", Fill)

			Bar.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					IsInteractingWithSlider = true
					local MoveConn; MoveConn = UserInputService.InputChanged:Connect(function(inp)
						if inp.UserInputType == Enum.UserInputType.MouseMovement then
							local Scale = math.clamp((inp.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
							local NewVal = math.floor(min + (max - min) * Scale)
							Label.Text = sText .. ": " .. NewVal
							Fill.Size = UDim2.fromScale(Scale, 1)
							ModuleData[sText] = NewVal

							-- LOGIC CHECK
							if ModuleData.Enabled and sCallback then
								sCallback(NewVal)
							end
						end
					end)
					UserInputService.InputEnded:Wait()
					MoveConn:Disconnect()
					IsInteractingWithSlider = false
				end
			end)
			UpdateSize()
		end

		return Settings
	end

	return Category
end


--------------------------------------------------
-- GAME UTILITY MODULES
--------------------------------------------------

local RunService = game:GetService("RunService")

local function CreateBeamBetween(target, color, categoryName)
	local actualPart = nil
	if target:IsA("BasePart") then
		actualPart = target
	elseif target:IsA("Model") then
		actualPart = target.PrimaryPart or target:FindFirstChildWhichIsA("BasePart")
	end

	if not actualPart then return end

	local Character = Player.Character or Player.CharacterAdded:Wait()
	local Root = Character:WaitForChild("HumanoidRootPart", 5)

	if GroupStates[categoryName] == nil then 
		GroupStates[categoryName] = {Master = false, Highlights = true, Beams = true, Labels = true} 
	end
	local state = GroupStates[categoryName]

	--------------------------------------------------
	-- PROXY & VISUALS
	--------------------------------------------------
	local highlightParent = target
	if CollectionService:HasTag(target, "hidden-metal") then
		highlightParent = Instance.new("Part")
		highlightParent.Name = "VainESP_Proxy"
		highlightParent.Transparency = (state.Master and state.Highlights) and 0 or 1 
		highlightParent.CanCollide = false
		highlightParent.Anchored = true
		highlightParent.CFrame = actualPart.CFrame
		highlightParent.Parent = target
	end

	local highlight = Instance.new("Highlight")
	highlight.FillColor = color
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Enabled = state.Master and state.Highlights
	highlight.Parent = highlightParent

	--------------------------------------------------
	-- DISTANCE LABEL (New)
	--------------------------------------------------
	local bGui = Instance.new("BillboardGui")
	bGui.Name = "VainDistanceLabel"
	bGui.Adornee = highlightParent
	bGui.Size = UDim2.fromOffset(100, 50)
	bGui.AlwaysOnTop = true
	-- Lifts the label 3 studs above the part
	bGui.StudsOffset = Vector3.new(0, 3, 0) 
	bGui.Enabled = state.Master and state.Labels
	bGui.Parent = highlightParent

	local dLabel = Instance.new("TextLabel")
	dLabel.Size = UDim2.fromScale(1, 1)
	dLabel.BackgroundTransparency = 1
	dLabel.TextColor3 = Color3.new(1, 1, 1)
	dLabel.TextStrokeTransparency = 0
	dLabel.Font = Enum.Font.GothamBold
	dLabel.TextSize = 12
	dLabel.Text = "0m"
	dLabel.Parent = bGui

	--------------------------------------------------
	-- BEAMS
	--------------------------------------------------
	local a0 = Instance.new("Attachment", Root)
	local a1 = Instance.new("Attachment", highlightParent)
	local beam = Instance.new("Beam")
	beam.Attachment0 = a0
	beam.Attachment1 = a1
	beam.Color = ColorSequence.new(color)
	beam.Width0, beam.Width1 = 0.4, 0.4
	beam.Enabled = state.Master and state.Beams
	beam.Parent = a0 

	-- Storage
	if not BeamGroups[categoryName] then BeamGroups[categoryName] = {} end
	table.insert(BeamGroups[categoryName], {beam = beam, highlight = highlight, proxy = highlightParent, label = bGui, targetPart = actualPart})

	-- Cleanup
	target.AncestryChanged:Connect(function(_, p)
		if not p then 
			a0:Destroy() 
			if highlightParent ~= target then highlightParent:Destroy() end
		end
	end)
end

local function ToggleBeamGroup(categoryName, stateValue, mode)
	if not GroupStates[categoryName] then 
		GroupStates[categoryName] = {
			Master = false, 
			Highlights = true, 
			Beams = true, 
			Labels = true, 
			MaxDistance = 500, 
			AutoCollect = false,
			CollectRadius = 10
		} 
	end

	GroupStates[categoryName][mode] = stateValue
	local s = GroupStates[categoryName]

	if BeamGroups[categoryName] then
		for _, data in pairs(BeamGroups[categoryName]) do
			pcall(function()
				-- Visibility logic now factors in distance (handled in RenderStepped)
				-- But we still toggle the "Master" Enabled states here
				data.highlight.Enabled = (s.Master and s.Highlights)
				data.beam.Enabled = (s.Master and s.Beams)
				data.label.Enabled = (s.Master and s.Labels)
				if data.proxy ~= data.targetPart then
					data.proxy.Transparency = (s.Master and s.Highlights) and 0 or 1
				end
			end)
		end
	end
end

local function RefreshBeams()
	-- Clear old tables if necessary
	for _, group in pairs(BeamGroups) do
		for _, beam in pairs(group) do beam.Attachment0:Destroy() end
	end
	BeamGroups = {}

	-- Re-run your spawners
	for _, bee in pairs(workspace.Bees:GetChildren()) do
		CreateBeamBetween(bee, Color3.new(1,1,0), "Bee")
	end
end

local function GetMetalLoot()
	local loot_table = {}
	for _, loot in ipairs(CollectionService:GetTagged("hidden-metal")) do
		table.insert(loot_table, loot)
		--createBeam(loot, true, "metal-loot", Settings.METAL_ESP.COLOR, Settings.METAL_ESP.ENABLED)
	end
	return loot_table
end


--------------------------------------------------
-- CODE LOGIC
--------------------------------------------------

local Visuals = UI:CreateCategory("Visuals")


-- METAL ESP

local MetalESP = Visuals:CreateToggle("Metal ESP", "Shows hidden metal loot on the map.", function(isActive)
	ToggleBeamGroup("Metal", isActive, "Master")
end)

MetalESP:CreateKeybind(Enum.KeyCode.B)

MetalESP:CreateSubToggle("Auto Collect", "Automatically picks up metal when you walk near it.", false, function(val)
	ToggleBeamGroup("Metal", val, "AutoCollect")
end)

MetalESP:CreateSubSlider(
	"Collect Radius", 
	"How close you must be to automatically pick up loot.", 
	5,   -- Min
	10,  -- Max
	10,  -- Default
	function(val)
		ToggleBeamGroup("Metal", val, "CollectRadius")
	end
)

MetalESP:CreateSubToggle("Highlight Loot", "Shows a glowing box around the loot.", true, function(val)
	ToggleBeamGroup("Metal", val, "Highlights")
end)

MetalESP:CreateSubToggle("Show Beams", "Draws a line from your body to the loot.", true, function(val)
	ToggleBeamGroup("Metal", val, "Beams")
end)

MetalESP:CreateSubToggle("Show Distance", "Displays how many studs away the loot is.", true, function(val)
	ToggleBeamGroup("Metal", val, "Labels")
end)

MetalESP:CreateSubSlider("Max Distance", "Hides ESP if the ore is further than this distance.", 50, 2000, 500, function(val)
	ToggleBeamGroup("Metal", val, "MaxDistance")
end)

for _, metal in ipairs(CollectionService:GetTagged("hidden-metal")) do
	print(metal)
	CreateBeamBetween(metal, Color3.fromRGB(180, 0, 3), "Metal")
end

CollectionService:GetInstanceAddedSignal("hidden-metal"):Connect(function(newMetal)
	print(newMetal)
	CreateBeamBetween(newMetal, Color3.fromRGB(180, 0, 3), "Metal")
end)

--------------------------------------------------
-- INITIALIZATION & RESPOND HANDLING
--------------------------------------------------

local processedIds = {}
local NetManaged = ReplicatedStorage:WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged")
local collectRemote = NetManaged:WaitForChild("CollectCollectableEntity")

-- Tool Visibility Helper
local function setMetalDetectorVisibility(char, visible)
	local transparency = visible and 0 or 1
	local detector = char:FindFirstChild("metal_detector")
	if detector then
		for _, part in ipairs(detector:GetChildren()) do
			if part:IsA("BasePart") then
				part.Transparency = transparency
			end
		end
	end
end

-- Digging Logic (Animation + Shovel Visual)
local function playDigSequence(char)
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	local animator = humanoid and (humanoid:FindFirstChildOfClass("Animator") or humanoid)
	if not animator then return end

	local anim = Instance.new("Animation")
	anim.AnimationId = "rbxassetid://9378575104"

	local track = animator:LoadAnimation(anim)
	track.Priority = Enum.AnimationPriority.Action 
	track:Play()

	setMetalDetectorVisibility(char, false)

	-- Shovel Visual Effect
	local shovelSource = ReplicatedStorage.Assets.Effects:FindFirstChild("Shovel")
	local shovelClone
	if shovelSource then
		shovelClone = shovelSource:Clone()
		shovelClone.Parent = char
		local hand = char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm")

		if hand then
			local weld = Instance.new("WeldConstraint")
			shovelClone:PivotTo(hand.CFrame)
			weld.Part0 = shovelClone.PrimaryPart or shovelClone:FindFirstChildOfClass("BasePart")
			weld.Part1 = hand
			weld.Parent = shovelClone
		end
	end

	local function cleanup()
		setMetalDetectorVisibility(char, true)
		if shovelClone then shovelClone:Destroy() end
	end

	track.Stopped:Connect(cleanup)
	task.delay(1.5, cleanup) -- Fail-safe
end

task.spawn(function()
	while task.wait(0.3) do
		local s = GroupStates["Metal"]
		if s and s.Master and s.AutoCollect then
			local char = Player.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			if not root or not hum then continue end

			local currentRadius = s.CollectRadius or 6

			for _, loot in ipairs(CollectionService:GetTagged("hidden-metal")) do
				local id = loot:GetAttribute("Id")

				if id and not processedIds[id] then
					local dist = (root.Position - loot:GetPivot().Position).Magnitude

					if dist < currentRadius then
						processedIds[id] = true

						-- Synchronized Action
						hum:Move(Vector3.new(0, 0, 0)) -- Stop character
						pcall(function() playDigSequence(char) end)

						task.wait(0.2) -- Brief sync delay
						collectRemote:FireServer({ id = id })
					end
				end
			end
		end
	end
end)

RunService.RenderStepped:Connect(function()
	local char = Player.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	for cat, group in pairs(BeamGroups) do
		local s = GroupStates[cat]
		if s and s.Master then
			for _, data in pairs(group) do
				pcall(function()
					local dist = (root.Position - data.targetPart.Position).Magnitude
					local isWithinRange = dist <= (s.MaxDistance or 500)

					-- Update Label (Look for TextLabel inside BillboardGui)
					local labelObj = data.label:FindFirstChildWhichIsA("TextLabel")
					if labelObj then
						labelObj.Text = string.format("%d studs", dist)
					end

					-- Master Visibility Logic
					data.highlight.Enabled = s.Highlights and isWithinRange
					data.beam.Enabled = s.Beams and isWithinRange
					data.label.Enabled = s.Labels and isWithinRange

					if data.proxy ~= data.targetPart then
						data.proxy.Transparency = (s.Highlights and isWithinRange) and 0 or 1
					end
				end)
			end
		end
	end
end)

Player.CharacterAdded:Connect(function()
	processedIds = {}
	
	for _, group in pairs(BeamGroups) do
		for _, data in pairs(group) do
			pcall(function()
				if data.beam and data.beam:IsA("Beam") then
					if data.beam.Attachment0 then data.beam.Attachment0:Destroy() end
					data.beam:Destroy()
				end
				if data.highlight then data.highlight:Destroy() end
				if data.label then data.label:Destroy() end
				if data.proxy and data.proxy.Name == "VainESP_Proxy" then data.proxy:Destroy() end
			end)
		end
	end
	BeamGroups = {}

	-- 3. Re-scan
	for _, metal in ipairs(CollectionService:GetTagged("hidden-metal")) do
		CreateBeamBetween(metal, Color3.fromRGB(180, 0, 3), "Metal")
	end
end)

-- Set default page
if UI.Categories[1] then
	UI.Categories[1].Page.Visible = true
	UI.Categories[1].Button.TextXAlignment = Enum.TextXAlignment.Center
	Tween(UI.Categories[1].Button, TweenFast, {BackgroundColor3 = Color3.fromRGB(40, 40, 40), TextColor3 = Color3.fromRGB(255, 255, 255)})
end

-- visuals.lua
-- FINAL, STABLE ESP SYSTEM

local Visuals = {}
_G.Vain.Visuals = Visuals

local Config = _G.Vain.Config

--// SERVICES
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")

local player = Players.LocalPlayer

--// STATE
local Active = {
	metal = {},
	tree = {},
	bee = {},
	star = {}
}

--// UTILS
local function isPart(obj)
	return obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation")
end

local function clearCategory(category)
	for _, data in pairs(Active[category]) do
		for _, inst in pairs(data) do
			if typeof(inst) == "Instance" then
				inst:Destroy()
			end
		end
	end
	Active[category] = {}
end

--// CREATE ESP
local function createESP(target, category, color)
	if Active[category][target] then return end
	if not isPart(target) and not target:IsA("Model") then return end
	if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end

	local adornee = target
	if target:IsA("Model") then
		adornee = target.PrimaryPart
		if not adornee then return end
	end

	-- Highlight
	local h = Instance.new("Highlight")
	h.Adornee = adornee
	h.FillColor = color
	h.OutlineColor = Color3.new(1,1,1)
	h.FillTransparency = 0.55
	h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	h.Parent = workspace

	-- Beam
	local a0 = Instance.new("Attachment", player.Character.HumanoidRootPart)
	local a1 = Instance.new("Attachment", adornee)

	local beam = Instance.new("Beam")
	beam.Attachment0 = a0
	beam.Attachment1 = a1
	beam.Width0 = 0.15
	beam.Width1 = 0.15
	beam.FaceCamera = true
	beam.Color = ColorSequence.new(color)
	beam.Parent = workspace

	Active[category][target] = {
		Highlight = h,
		Beam = beam,
		A0 = a0,
		A1 = a1
	}
end

--// REFRESH CATEGORY
function Visuals.Refresh(category)
	local settings = Config.Settings[string.upper(category) .. "_ESP"]
	if not settings or not settings.ENABLED then return end

	if category == "metal" then
		for _, obj in ipairs(CollectionService:GetTagged("hidden-metal")) do
			createESP(obj, "metal", settings.COLOR)
		end

	elseif category == "tree" then
		for _, obj in ipairs(CollectionService:GetTagged("treeOrb")) do
			createESP(obj, "tree", settings.COLOR)
		end

	elseif category == "bee" then
		for _, obj in ipairs(CollectionService:GetTagged("bee")) do
			if obj.Name ~= "TamedBee" then
				createESP(obj, "bee", settings.COLOR)
			end
		end

	elseif category == "star" then
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("Model") and obj.Name:lower():find("star") then
				local color = settings.COLOR
				local n = obj.Name:lower()
				if n:find("green") then color = Color3.fromRGB(80,255,80) end
				if n:find("yellow") then color = Color3.fromRGB(255,230,50) end
				createESP(obj, "star", color)
			end
		end
	end
end

--// TOGGLE
function Visuals.Toggle(category, state)
	local settings = Config.Settings[string.upper(category) .. "_ESP"]
	if not settings then return end

	settings.ENABLED = state

	if not state then
		clearCategory(category)
	else
		Visuals.Refresh(category)
	end
end

--// NEW OBJECTS
CollectionService:GetInstanceAddedSignal("hidden-metal"):Connect(function(o)
	if Config.Settings.METAL_ESP.ENABLED then
		createESP(o, "metal", Config.Settings.METAL_ESP.COLOR)
	end
end)

CollectionService:GetInstanceAddedSignal("treeOrb"):Connect(function(o)
	if Config.Settings.TREE_ESP.ENABLED then
		createESP(o, "tree", Config.Settings.TREE_ESP.COLOR)
	end
end)

CollectionService:GetInstanceAddedSignal("bee"):Connect(function(o)
	if Config.Settings.BEE_ESP.ENABLED and o.Name ~= "TamedBee" then
		createESP(o, "bee", Config.Settings.BEE_ESP.COLOR)
	end
end)

workspace.DescendantAdded:Connect(function(o)
	if Config.Settings.STAR_ESP.ENABLED and o:IsA("Model") and o.Name:lower():find("star") then
		task.wait(0.1)
		createESP(o, "star", Config.Settings.STAR_ESP.COLOR)
	end
end)

--// RESPAWN
player.CharacterAdded:Connect(function()
	task.wait(1)
	for cat in pairs(Active) do
		if Config.Settings[string.upper(cat).."_ESP"].ENABLED then
			clearCategory(cat)
			Visuals.Refresh(cat)
		end
	end
end)

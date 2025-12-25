local Visuals = {}
_G.Vain.Visuals = Visuals
local Config = _G.Vain.Config
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function getRoot(obj)
    if not obj then return end
    if obj:IsA("BasePart") then return obj end
    if obj:IsA("Model") then return obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true) end
    return obj.Parent and getRoot(obj.Parent)
end

function Visuals.Cleanup(category, target)
    local data = Config.ActiveObjects[category][target]
    if not data then return end
    if data.Highlight then data.Highlight:Destroy() end
    if data.Beam then data.Beam:Destroy() end
    if data.A0 then data.A0:Destroy() end
    if data.A1 then data.A1:Destroy() end
    Config.ActiveObjects[category][target] = nil
end

function Visuals.CreateESP(target, category)
    if not target or Config.ActiveObjects[category][target] then return end
    local settings = Config.Settings[category:upper() .. "_ESP"]
    if not settings or not settings.ENABLED then return end

    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local root = getRoot(target)
    if not root then return end

    local color = settings.COLOR
    -- Special Star Logic [cite: 3]
    if category == "star" then
        if target.Name:lower():find("green") then color = Color3.fromRGB(80, 255, 80)
        elseif target.Name:lower():find("yellow") then color = Color3.fromRGB(255, 230, 50) end
    end

    local data = {}
    data.Highlight = Instance.new("Highlight")
    data.Highlight.FillColor = color
    data.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    data.Highlight.Adornee = (root.Parent:IsA("Model") and root.Parent) or root
    data.Highlight.Parent = workspace

    data.A0 = Instance.new("Attachment", char.HumanoidRootPart)
    data.A1 = Instance.new("Attachment", root)
    data.Beam = Instance.new("Beam", workspace)
    data.Beam.Attachment0 = data.A0
    data.Beam.Attachment1 = data.A1
    data.Beam.Width0, data.Beam.Width1 = 0.15, 0.15
    data.Beam.Color = ColorSequence.new(color)

    Config.ActiveObjects[category][target] = data
end

function Visuals.Refresh(category)
    local settings = Config.Settings[category:upper() .. "_ESP"]
    if not settings.ENABLED then
        for target in pairs(Config.ActiveObjects[category]) do Visuals.Cleanup(category, target) end
        return
    end

    if category == "star" then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and obj.Name:lower():find("star") then Visuals.CreateESP(obj, "star") end
        end
    else
        for _, obj in ipairs(CollectionService:GetTagged(settings.TAG)) do
            if category == "bee" and obj.Name == "TamedBee" then continue end
            Visuals.CreateESP(obj, category)
        end
    end
end

-- Listeners for new spawns [cite: 5]
for _, cat in ipairs({"metal", "bee", "tree"}) do
    local tag = Config.Settings[cat:upper() .. "_ESP"].TAG
    CollectionService:GetInstanceAddedSignal(tag):Connect(function(obj) Visuals.CreateESP(obj, cat) end)
end

return Visuals

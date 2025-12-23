-- visuals.lua
_G.App.Visuals = _G.App.Visuals or {}

local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local player = Players.LocalPlayer

local ActiveBeams = {} -- Dictionary to track beams: { ["metal-loot"] = { [object] = {Beam, Attach0, Attach1} } }
local Connections = {} -- To store CollectionService signals

-- Private helper to create a single beam
local function createBeam(target, category, color)
    if not target:IsA("BasePart") then return end
    
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    local data = {}
    data.Attach0 = Instance.new("Attachment", hrp)
    data.Attach1 = Instance.new("Attachment", target)
    
    data.Beam = Instance.new("Beam")
    data.Beam.Attachment0 = data.Attach0
    data.Beam.Attachment1 = data.Attach1
    data.Beam.Width0 = 0.15
    data.Beam.Width1 = 0.15
    data.Beam.Color = ColorSequence.new(color)
    data.Beam.Parent = hrp

    if not ActiveBeams[category] then ActiveBeams[category] = {} end
    ActiveBeams[category][target] = data
end

-- Global Function to Enable Category
function _G.App.Visuals.EnableCategory(tagName, categoryName, color)
    -- 1. Setup Signal for new items
    if not Connections[categoryName] then
        Connections[categoryName] = CollectionService:GetInstanceAddedSignal(tagName):Connect(function(loot)
            createBeam(loot, categoryName, color)
        end)
    end

    -- 2. Create beams for existing items
    for _, loot in ipairs(CollectionService:GetTagged(tagName)) do
        createBeam(loot, categoryName, color)
    end
end

-- Global Function to Disable Category
function _G.App.Visuals.DisableCategory(categoryName)
    -- 1. Disconnect Signal
    if Connections[categoryName] then
        Connections[categoryName]:Disconnect()
        Connections[categoryName] = nil
    end

    -- 2. Cleanup Beams
    if ActiveBeams[categoryName] then
        for target, data in pairs(ActiveBeams[categoryName]) do
            if data.Beam then data.Beam:Destroy() end
            if data.Attach0 then data.Attach0:Destroy() end
            if data.Attach1 then data.Attach1:Destroy() end
        end
        ActiveBeams[categoryName] = nil
    end
end

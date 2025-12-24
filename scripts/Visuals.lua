local Visuals = _G.Vain.Visuals
local Config = _G.Vain.Config

local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")

function Visuals.CreateESP(target, category)
	-- 👉 dein createESP Code
	-- benutze Config.Settings & Config.ActiveObjects
end

function Visuals.Toggle(category, state)
	-- dein toggleCategory Code
end

function Visuals.Refresh()
	-- dein RefreshESP Code
end

-- Listener
CollectionService:GetInstanceAddedSignal("hidden-metal"):Connect(function(o)
	Visuals.CreateESP(o, "metal")
end)

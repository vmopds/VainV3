-- Visuals.lua
local Visuals = {}

local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")

function Visuals.CreateESP(target, category, color, enabled, config)
	-- dein createESP Code
end

function Visuals.ToggleCategory(category, state, config)
	-- dein toggleCategory Code
end

function Visuals.Refresh(config)
	-- dein RefreshESP Code
end

function Visuals.Init(config)
	CollectionService:GetInstanceAddedSignal("hidden-metal"):Connect(function(o)
		Visuals.CreateESP(o,"metal",config.Settings.METAL_ESP.COLOR,config.Settings.METAL_ESP.ENABLED,config)
	end)

	-- die restlichen Listener
end

return Visuals


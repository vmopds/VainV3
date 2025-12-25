local Config = {
    Settings = {
        METAL_ESP = { ENABLED = false, COLOR = Color3.fromRGB(0, 170, 255), TAG = "hidden-metal" },
        BEE_ESP   = { ENABLED = false, COLOR = Color3.fromRGB(255, 214, 6), TAG = "bee" },
        STAR_ESP  = { ENABLED = false, COLOR = Color3.fromRGB(255, 255, 255), TAG = nil }, -- Special handling
        TREE_ESP  = { ENABLED = false, COLOR = Color3.fromRGB(255, 100, 0), TAG = "treeOrb" },
        
        AIM_ASSIST = { ENABLED = false, SMOOTHNESS = 0.15, MAX_DISTANCE = 94, MAX_ANGLE = 90 },
        UI_COLOR = Color3.fromRGB(12, 12, 14),
        VISIBLE = true
    },
    ActiveObjects = { metal = {}, star = {}, tree = {}, bee = {} }
}
_G.Vain = { Config = Config }

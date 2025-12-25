return {
    DefaultSettings = {
        Enabled = true,
        ShowBeams = true,
        ShowDistance = true,
        Brightness = 50
    },

    Run = function(settings)
        task.spawn(function()
            while task.wait(2) do
                if settings.Enabled then
                    print("[MetalESP]", settings.ShowBeams, settings.ShowDistance, settings.Brightness)
                end
            end
        end)
    end
}

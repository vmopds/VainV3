return {
    DefaultSettings = {
        Enabled = true,
        ShowBeams = true,
        ShowDistance = true
    },

    Run = function(settings)
        task.spawn(function()
            while task.wait(2) do
                if settings.Enabled then
                    print("[MetalESP]", settings.ShowBeams, settings.ShowDistance)
                end
            end
        end)
    end
}

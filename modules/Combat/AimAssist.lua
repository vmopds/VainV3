return {
    DefaultSettings = {
        Enabled = true,
        Smoothness = .5,
        Distance = 50152
    },

    Run = function(settings)
        task.spawn(function()
            while task.wait(2) do
                if settings.Enabled then
                    print("Hi")
                end
            end
        end)
    end
}

local module = {}

module.DefaultSettings = {
    Enabled = true,
    ShowBeams = true,
    ShowDistance = true
}

return function(settings)
    task.spawn(function()
        while task.wait(2) do
            if settings.Enabled then
                print("[MetalESP]")
                print("ShowBeams:", settings.ShowBeams)
                print("ShowDistance:", settings.ShowDistance)
            end
        end
    end)
end

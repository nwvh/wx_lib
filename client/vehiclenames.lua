Citizen.CreateThread(function()
    for model, label in pairs(wx.vehicleNames) do
        AddTextEntry(model, label)
    end
end)

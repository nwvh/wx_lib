local spawnedvehicles = {}
local spawnedpeds = {}
local spawnedobjects = {}

function SpawnVehicle(model,coords,data)
    if not data then
        data = {
            locked = false,
            color = data.color or {255,0,0}
            ---@todo: more options
        }
    end
    if not IsModelValid(model) then -- Return an error if the vehicle model doesn't exist
        return ("[ERROR] The specified vehicle model - [%s] doesn't exist!"):format(model)
    end
    RequestModel(model) -- Request the vehicle model
    while not HasModelLoaded(model) do Wait(5) end -- Wait for the vehicle to load
    local spawnedvehicle = CreateVehicle(model, coords, true, false) -- Finally spawn the vehicle
    if data.locked then
        SetVehicleDoorsLocked(spawnedvehicle,2)
    end
    SetVehicleCustomPrimaryColour(spawnedvehicle,data.color[1],data.color[2],data.color[3])
    table.insert(spawnedvehicles,{
        entity = spawnedvehicle,
        coords = GetEntityCoords(spawnedvehicle),
        heading = GetEntityHeading(spawnedvehicle),
        locked = data.locked,
    })
    return spawnedvehicle
end

function SpawnPed(model,coords,data)
    if not data then
        data = {
            freeze = false,
            reactions = true,
            god = false,
            scenario = nil
        }
    end
    if not IsModelValid(model) then -- Return an error if the vehicle model doesn't exist
        return ("[ERROR] The specified ped model - [%s] doesn't exist!"):format(model)
    end
    RequestModel(model) -- Request the ped model
    while not HasModelLoaded(model) do Wait(5) end -- Wait for the ped to load
    local spawnedped = CreatePed(0, model, coords, true,false)
    if data.freeze then
        FreezeEntityPosition(spawnedped,true)
    end
    if not data.reactions then
        SetBlockingOfNonTemporaryEvents(spawnedped,true)
    end
    if data.god then
        SetEntityInvincible(spawnedped,true)
    end
    if data.anim then
        RequestAnimDict(data.anim[1])
        TaskPlayAnim(spawnedped, data.anim[1],data.anim[2], 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
    if data.scenario then
        TaskStartScenarioInPlace(spawnedped,data.scenario,0,true)
    end
    table.insert(spawnedpeds,{
        entity = spawnedped,
        coords = GetEntityCoords(spawnedped),
        heading = GetEntityHeading(spawnedped),
        freeze = data.freeze,
        reactions = data.reactions,
        god = data.god,
        anim = data.anim,
        scenario = data.scenario,
    })
    return spawnedped
end

function SpawnObject(model,coords,heading,data)
    if not IsModelValid(model) then return end
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end
    local network = data.network or false
    local freeze = data.freeze or false
    local spawnedobject = CreateObject(model, coords.x, coords.y, coords.z, network, true, false)
    SetEntityHeading(spawnedobject,heading or 0.0)
    SetEntityAsNoLongerNeeded(spawnedobject)
    PlaceObjectOnGroundProperly(spawnedobject)
    FreezeEntityPosition(spawnedobject,freeze)
    table.insert(spawnedobjects,{
        model = model,
        coords = coords,
        network = network,
        freeze = data.freeze,
        heading = heading
    })
end

function BetterPrint(text,type)
    local types = {
        ["error"] = "^7[^1 ERROR ^7] ",
        ["warning"] = "^7[^3 WARNING ^7] ",
        ["info"] = "^7[^5 INFO ^7] ",
        ["success"] = "^7[^2 SUCCESS ^7] ",
    }
    if not types[type] then types[type] = "^7[^1 WX CORE ^7] " end
    return print(types[string.lower(type)]..text)
end

function RandomString(length, num)
    math.randomseed(GetGameTimer())
    local chars = "abcdefghijklmnopqrstuvwxyz" .. (num and "0123456789" or "")
    local randomString = ""

    for _ = 1, length do
        local randomIndex = math.random(#chars)
        randomString = randomString .. chars:sub(randomIndex, randomIndex)
    end

    return randomString
end

exports("SpawnVehicle",function (model,coords,data)
    return SpawnVehicle(model,coords,data)
end)

exports("SpawnVehicle",function (model,coords,data)
    return SpawnVehicle(model,coords,data)
end)

exports("print",function (text,type)
    return BetterPrint(text,type)
end)

exports("spawnedVehicles",function ()
    return spawnedvehicles
end)

exports("spawnedPeds",function ()
    return spawnedpeds
end)

exports("spawnedObjects",function ()
    return spawnedobjects
end)

exports("randomString",function (length,numbers)
    return RandomString(length,numbers)
end)

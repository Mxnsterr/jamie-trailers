local inZone = false

CreateThread(function()
    RequestModel(Config.Npc.name)
    while not HasModelLoaded(Config.Npc.name) do
        Wait(0)
    end

    local npc = CreatePed(0, Config.Npc.name, Config.Npc.position.xy, Config.Npc.position.z - 1, Config.Npc.position.w, false, false)
    
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    TaskStartScenarioInPlace(npc, Config.Npc.animation, true, true)
end)

CreateThread(function()
    local trailerZone = PolyZone:Create(Config.Npc.zone, {
      name="trailerZone",
      minZ = Config.Npc.position.z - 1,
      maxZ = Config.Npc.position.z + 1,
      debugPoly = false,
    })
  
  
    trailerZone:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            inZone = true
            HelpText("Press [E] to choose a trailer")
        else
            inZone = false
        end
    end)
end)

CreateThread(function()
    while true do
        if inZone then
            if IsControlJustPressed(0,38) then
                OpenTrailerMenu()
            end
        else
            Wait(500)
        end
        Wait(0)
    end
end)

function OpenTrailerMenu()
    local trailerMenu = {
        {
            header =  'Trailer rental',
            txt = 'Rent a trailer for your car',
            isMenuHeader = true,
        },
    }

    for k,v in pairs(Config.Trailers.list) do
        trailerMenu[#trailerMenu + 1] = {
            header = 'Rent '..v.name,
            txt = 'Price of trailer: '..Config.Currency..v.price,
            params = {
                event = 'jamie-trailers:client:spawnTrailer',
                args = {
                    hash = v.name,
                    price = v.price
                },
            }
        }
    end
    exports['jamie-menu']:openMenu(trailerMenu)
end

RegisterNetEvent('jamie-trailers:client:spawnTrailer', function(trailer)
    local money = exports['driftV']:GetMoney()

    if money >= trailer.price then
        RequestModel(trailer.hash)
        while not HasModelLoaded(trailer.hash) do
            Wait(0)
        end
    
        local spawnedTrailer = CreateVehicle(trailer.hash, Config.Trailers.spawnpoint, true, false)
    else
        TriggerEvent("FeedM:showNotification", "Not enough money", 5000)
    end 
end)

function HelpText(text, sound, loop)
    BeginTextCommandDisplayHelp("jamyfafi")
    AddTextComponentSubstringPlayerName(text)
    if string.len(text) > 99 then
        AddLongString(text)
    end
    EndTextCommandDisplayHelp(0, loop or 0, sound or true, -1)
end
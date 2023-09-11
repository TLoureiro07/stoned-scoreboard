ESX = exports["es_extended"]:getSharedObject()
-- Codigo

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true

        ESX.TriggerServerCallback('qb-scoreboard:server:GetConfig', function(config)
            Config.IllegalActions = config
        end)

end)

local scoreboardOpen = false

GetPlayers = function()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end
    return players
end


Citizen.CreateThread(function()
    while true do
        local isActivatorPressed = IsControlJustPressed(0, Config.OpenKey)
        local isSecondaryPressed =  IsControlPressed(0, Config.OpenKey)
        local isPauseESCPressed = IsControlJustPressed(0, 322)
        local isPausePPressed = IsControlJustPressed(0, 199)
        if isActivatorPressed then
                if not scoreboardOpen then
                    ESX.TriggerServerCallback('qb-scoreboard:server:GetActiveCops', function(cops)
                        Config.CurrentCops = cops
                        ESX.TriggerServerCallback('qb-scoreboard:server:Estado', function(estado)
                            ESX.TriggerServerCallback('qb-scoreboard:server:GetActiveINEM', function(INEM)
                                Config.currentINEM = INEM
                                if estado == "on" then
                                    local paramedicsOnline = 0
                                
                                    for _, player in ipairs(GetActivePlayers()) do
                                        local xPlayer = ESX.GetPlayerData(player)
                                
                                        if xPlayer.job.name == Config.ambulancejob then
                                            paramedicsOnline = paramedicsOnline + 1
                                        end
                                    end
                                
                                    --print("Paramedics Online: " .. paramedicsOnline) -- Verifique se a contagem está correta no console
                                
                                    SendNUIMessage({
                                        action = "open",
                                        estado = "on",
                                        players = GetCurrentPlayers(),
                                        maxPlayers = Config.MaxPlayers,
                                        requiredCops = Config.IllegalActions,
                                        requiredParamedics = Config.ambulancejob,
                                        currentCops = Config.CurrentCops,
                                        currentParamedics = paramedicsOnline,
                                    })
                                elseif estado == "off" then
                                    SendNUIMessage({
                                        action = "open",
                                        estado = "off",
                                        players = GetCurrentPlayers(),
                                        maxPlayers = Config.MaxPlayers,
                                        requiredCops = Config.IllegalActions,
                                        requiredParamedics = Config.ambulancejob,
                                        currentCops = Config.CurrentCops,
                                        currentParamedics = 0,
                                    })
                                end
                                
                                
                                scoreboardOpen = true
                            end)
                        end)
                    end)
                end
        end

        if isPauseESCPressed or isSecondaryPressed then
            if scoreboardOpen then
                SendNUIMessage({
                    action = "close",
                })
                scoreboardOpen = false
            end
        end

        Citizen.Wait(5)
    end
end)

function GetCurrentPlayers()
    local TotalPlayers = 0

    for _, player in ipairs(GetActivePlayers()) do
        TotalPlayers = TotalPlayers + 1
    end

    return TotalPlayers
end

RegisterNetEvent('qb-scoreboard:client:SetActivityBusy')
AddEventHandler('qb-scoreboard:client:SetActivityBusy', function(activity, busy)
    Config.IllegalActions[activity].busy = busy
end)
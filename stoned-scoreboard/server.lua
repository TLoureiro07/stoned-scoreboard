
ESX = exports["es_extended"]:getSharedObject()
local estado = "on"


-- Code

    ESX.RegisterServerCallback('qb-scoreboard:server:GetActiveCops', function(source, cb)
        local retval = 0
        
        for k, v in pairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(v)
            
            if xPlayer.job.name == Config.policejob1 or xPlayer.job.name == Config.policejob2 then
                retval = retval + 1
            end
        end

        cb(retval)
        
    end)



    ESX.RegisterServerCallback('qb-scoreboard:server:GetActiveINEM', function(source, cb)
        local retval = 0
        
        for k, v in pairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(v)
            
            if xPlayer.job.name == Config.ambulancejob then
                retval = retval + 1
            end
        end

        cb(retval)

    end)


    ESX.RegisterServerCallback('qb-scoreboard:server:Estado', function(source, cb)
        cb(estado)
    end)


    ESX.RegisterServerCallback('qb-scoreboard:server:GetConfig', function(source, cb)
        cb(Config.IllegalActions)
    end)

RegisterServerEvent('qb-scoreboard:server:SetActivityBusy')
AddEventHandler('qb-scoreboard:server:SetActivityBusy', function(activity, bool)
    Config.IllegalActions[activity].busy = bool
    TriggerClientEvent('qb-scoreboard:client:SetActivityBusy', -1, activity, bool)
end)

--[[RegisterCommand("ilegal", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local argumento = args[1]
    if xPlayer.job.name == Config.policejob1 or xPlayer.job.name == Config.policejob2 then
        if argumento ~= nil then
            if argumento == "on" or argumento == "ON" then
                TriggerClientEvent("chat:addMessage", -1, {args = {"💉 ILEGAL", "Atividade ilegal permitida na cidade!"},color = { 213, 0, 0 }})
                TriggerClientEvent('mythic_notify:client:SendAlert', -1, { type = 'inform', text = "<h1>💉 ILEGAL 💉</h1> RPs agressivos permitidos!", length = 20000 })
                estado = "on"
            elseif argumento == "off" or argumento == "OFF" then
                TriggerClientEvent("chat:addMessage", -1, {args = {"💉 ILEGAL", "Atividade ilegal proibida temporariamente na cidade!"},color = { 213, 0, 0 }})
                TriggerClientEvent('mythic_notify:client:SendAlert', -1, { type = 'inform', text = "<h1>💉 ILEGAL 💉</h1> RPs agressivos proibidos temporariamente!", length = 20000 })
                estado = "off"
            else
                TriggerClientEvent("chat:addMessage", source, {args = {"💉 ILEGAL", "Argumento errado. Utiliza ON ou OFF!"},color = { 213, 0, 0 }})
            end
        else
            TriggerClientEvent("chat:addMessage", source, {args = {"💉 ILEGAL", "Utilização do comando: /ilegal [on/off]"},color = { 213, 0, 0 }})
        end
    else
      TriggerClientEvent("chat:addMessage", source, {args = {"💉 ILEGAL", "Não tens permissão para utilizar este comando!"},color = { 213, 0, 0 }})
    end
end)]]



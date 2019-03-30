local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_welcome")

RegisterNetEvent('faby:server_welcome')
AddEventHandler('faby:server_welcome', function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local numelelumattystaaici = vRP.getPlayerName({source})
    TriggerClientEvent('faby:welcome',player,user_id,numelelumattystaaici)
end)
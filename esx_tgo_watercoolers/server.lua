ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_tgo_watercoolers:refillThirst')
AddEventHandler('esx_tgo_watercoolers:refillThirst', function()
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_status:add', source, 'hunger', 15000)
end)

ESX = nil

ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('esx_tgo_watercoolers:refillThirst')
AddEventHandler('esx_tgo_watercoolers:refillThirst', function()
	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
end)

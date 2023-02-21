ESX = nil

local waterCoolers = {-742198632}
local IsAnimated = false

Citizen.CreateThread(function()
	ESX = exports['es_extended']:getSharedObject()
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if not IsAnimated then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)

            for i = 1, #waterCoolers do
                local watercooler = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, waterCoolers[i], false, false, false)
                local waterCoolerPos = GetEntityCoords(watercooler)
                local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, waterCoolerPos.x, waterCoolerPos.y, waterCoolerPos.z, true)

                if dist < 1.8 then
                    local loc = vector3(waterCoolerPos.x, waterCoolerPos.y, waterCoolerPos.z + 1.0)
                    
                    ESX.Game.Utils.DrawText3D(loc, 'Πατήστε [~y~E~w~] για να πείτε νερό.', 0.7)
                    if IsControlJustReleased(0, 38) then

                        if not IsAnimated then
                            prop_name = prop_name or 'prop_cs_paper_cup'
                            IsAnimated = true

                            TriggerServerEvent('esx_tgo_watercoolers:refillThirst')

                            Citizen.CreateThread(function()
                                local playerPed = PlayerPedId()
                                local x,y,z = table.unpack(GetEntityCoords(playerPed))
                                local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
                                local boneIndex = GetPedBoneIndex(playerPed, 18905)
                                AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)
                    
                                ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
                                    TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

                                    Citizen.Wait(3000)
                                    IsAnimated = false
                                    ClearPedSecondaryTask(playerPed)
                                    DeleteObject(prop)
                                end)
                            end)
                        end
                    end
                else
                    Citizen.Wait(1500)
                end
            end
        end
    end
end)

local ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	ESX.PlayerData = ESX.GetPlayerData()
end)

local currentmotel = nil
local closestroom = nil
local pinkcagecoord = vector3(566.211, -1778.0, 29.3531)
local pinkcage = {
    [1] = {door = vector3(566.211, -1778.0, 29.3531), h = 68.9096, doortext = vector3(566.211, -1778.0, 29.3531), stash = vector3(560.916, -1780.8, 29.3382), obj = nil, clothe = vector3(564.448, -1781.6, 29.2875), locked = true},
    [2] = {door = vector3(550.738, -1775.6, 29.3118), h = 68.9096, doortext = vector3(550.738, -1775.6, 29.3118), stash = vector3(546.842, -1773.6, 29.2875), obj = nil, clothe = vector3(548.447, -1774.2, 29.2875), locked = true},
    [3] = {door = vector3(552.315, -1771.6, 29.3120), h = 338.946, doortext = vector3(552.315, -1771.6, 29.3120), stash = vector3(551.621, -1768.8, 29.3109), obj = nil, clothe = vector3(550.161, -1767.9, 29.3110), locked = true},
    [4] = {door = vector3(554.975, -1766.3, 29.3121), h = 158.946, doortext = vector3(554.975, -1766.3, 29.3121), stash = vector3(554.243, -1763.9, 29.2996), obj = nil, clothe = vector3(551.782, -1765.2, 29.2996), locked = true},
    [5] = {door = vector3(558.081, -1759.7, 29.3137), h = 68.9096, doortext = vector3(558.081, -1759.7, 29.3137), stash = vector3(557.724, -1756.3, 29.3109), obj = nil, clothe = vector3(554.776, -1758.7, 29.3113), locked = true},
    [6] = {door = vector3(561.634, -1751.7, 29.2799), h = 68.9096, doortext = vector3(561.634, -1751.7, 29.2799), stash = vector3(561.012, -1748.5, 29.3109), obj = nil, clothe = vector3(558.286, -1750.6, 29.2626), locked = true},
    [7] = {door = vector3(559.110, -1777.2, 33.4427), h = 338.946, doortext = vector3(559.110, -1777.2, 33.4427), stash = vector3(553.206, -1779.9, 33.2169), obj = nil, clothe = vector3(554.805, -1776.4, 33.4471), locked = true},
    [8] = {door = vector3(550.024, -1772.9, 33.4427), h = 248.909, doortext = vector3(550.024, -1772.9, 33.4427), stash = vector3(552.689, -1775.8, 33.2169), obj = nil, clothe = vector3(551.166, -1779.4, 33.4526), locked = true},
    [9] = {door = vector3(550.228, -1770.5, 33.4427), h = 248.909, doortext = vector3(550.228, -1770.5, 33.4427), stash = vector3(549.505, -1767.8, 33.2169), obj = nil, clothe = vector3(548.122, -1766.9, 33.5685), locked = true},
    [10]= {door = vector3(552.933, -1765.3, 33.4427), h = 248.909, doortext = vector3(552.933, -1765.3, 33.4427), stash = vector3(551.983, -1762.5, 33.2169), obj = nil, clothe = vector3(549.551, -1764.2, 33.4472), locked = true},
    [11]= {door = vector3(556.130, -1758.8, 33.4427), h = 158.946, doortext = vector3(556.130, -1758.8, 33.4427), stash = vector3(555.295, -1755.6, 33.2169), obj = nil, clothe = vector3(552.724, -1757.6, 33.4472), locked = true},
    [12]= {door = vector3(559.590, -1750.9, 33.4427), h = 248.909, doortext = vector3(559.590, -1750.9, 33.4427), stash = vector3(559.059, -1747.7, 33.2169), obj = nil, clothe = vector3(556.304, -1749.8, 33.4472), locked = true},
    [13]= {door = vector3(561.756, -1747.3, 33.4427), h = 248.909, doortext = vector3(561.756, -1747.3, 33.4427), stash = vector3(564.289, -1741.8, 33.2169), obj = nil, clothe = vector3(565.379, -1747.3, 33.4472), locked = true},
    [14]= {door = vector3(560.209, -1777.1, 33.4427), h = 248.909, doortext = vector3(560.209, -1777.1, 33.4427), stash = vector3(563.141, -1781.2, 33.4903), obj = nil, clothe = vector3(564.425, -1779.0, 33.4477), locked = true},
}

local firstSpawn = true
AddEventHandler('playerSpawned', function()
    if firstSpawn then
        -- TriggerServerEvent('m3:motel:server:getLockStates')
        currentmotel = math.random(1, #pinkcage)
        notify('inform', 'Yeni motel odası verildi! Oda numaran: '..currentmotel)
        firstSpawn = false
    end
end)

RegisterCommand('yenimotelodasi', function()
    currentmotel = math.random(1, #pinkcage)
    notify('inform', 'Yeni motel odası verildi! Oda numaran: '..currentmotel)
end)

RegisterCommand('motelcik', function()
    local player = PlayerPedId()
    local playercoords = GetEntityCoords(player)
    local moteldistance = #(playercoords - pinkcagecoord)

    if moteldistance <= 45.0 then
        SetEntityCoords(player, 311.491, -206.25, 58.0151, 0, 0, 0, 0)
        SetEntityHeading(player, 242.37)
        notify('inform', 'Odadan ayrıldın.')
    end
end)

-- RegisterNetEvent('m3:motel:client:sendDoorlockState')
-- AddEventHandler('m3:motel:client:sendDoorlockState', function(doorlocktable)
--     for i=1, #pinkcage, 1 do
--         pinkcage[i].locked = doorlocktable[i].locked
--     end
-- end)

-- RegisterNetEvent('m3:motel:client:sendDoorlockState2')
-- AddEventHandler('m3:motel:client:sendDoorlockState2', function(doorid, lockstate)
--     pinkcage[doorid].locked = lockstate
-- end)

Citizen.CreateThread(function()
    local gblip = AddBlipForCoord(pinkcagecoord)
    SetBlipSprite(gblip, 475)
    SetBlipDisplay(gblip, 4)
    SetBlipScale (gblip, 0.6)
    SetBlipColour(gblip, 1)
    SetBlipAsShortRange(gblip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Bilingstate Motel")
    EndTextCommandSetBlipName(gblip)
end)

Citizen.CreateThread(function()
    while true do
        if currentmotel ~= nil then
            local player = PlayerPedId()
            local playercoords = GetEntityCoords(player)
            local stashdistance = #(playercoords - pinkcage[currentmotel].stash)
            local clothedistance = #(playercoords - pinkcage[currentmotel].clothe)
            local doordistance = #(playercoords - pinkcage[currentmotel].doortext)
            local moteldistance = #(playercoords - pinkcagecoord)

            if moteldistance <= 45.0 then
                if doordistance <= 30.0 then
                    DrawMarker(2, pinkcage[currentmotel].doortext.x, pinkcage[currentmotel].doortext.y, pinkcage[currentmotel].doortext.z - 0.3, 0, 0, 0, 0, 0, 0, 0.2, 0.2, 0.2, 32, 236, 54, 100, 0, 0, 0, 1, 0, 0, 0)
                end

                -- if stashdistance <= 3.0 then
                    -- DrawMarker(2, pinkcage[currentmotel].stash.x, pinkcage[currentmotel].stash.y, pinkcage[currentmotel].stash.z - 0.3, 0, 0, 0, 0, 0, 0, 0.1, 0.1, 0.1, 32, 236, 54, 100, 0, 0, 0, 1, 0, 0, 0)
                    if stashdistance <= 1.5 then
                        DrawText3D(pinkcage[currentmotel].stash, '[~g~E~w~] - Sandık')
                        if IsControlJustReleased(0, 38) then
                            OpenMotelInventory()
                        end
                    end
                -- end
                -- if clothedistance <= 3.0 then
                    -- DrawMarker(2, pinkcage[currentmotel].clothe.x, pinkcage[currentmotel].clothe.y, pinkcage[currentmotel].clothe.z - 0.3, 0, 0, 0, 0, 0, 0, 0.1, 0.1, 0.1, 32, 236, 54, 100, 0, 0, 0, 1, 0, 0, 0)
                    if clothedistance <= 1.5 then
                        DrawText3D(pinkcage[currentmotel].clothe, '[~g~E~w~] - Gardrop')
                        if IsControlJustReleased(0, 38) then
                            OpenMotelWardrobe()
                        end
                    end
                -- end
            else
                Citizen.Wait(500)
            end
        end
        Citizen.Wait(5)
    end
end)

function openHouseAnim()
    loadAnimDict("anim@heists@keycard@") 
    TaskPlayAnim(PlayerPedId(), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Citizen.Wait(400)
    ClearPedTasks(PlayerPedId())
end

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(5)
    end
end

function OpenMotelWardrobe()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room',{
		title    = 'Gardrop',
		align    = 'right',
		elements = {
            {label = 'Kıyafetler', value = 'player_dressing'},
	        {label = 'Kıyafet Sil', value = 'remove_cloth'}
        }
	}, function(data, menu)

		if data.current.value == 'player_dressing' then 
            menu.close()
			ESX.TriggerServerCallback('m3:motel:server:getPlayerDressing', function(dressing)
				elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing',
				{
					title    = 'Kıyafetler',
					align    = 'right',
					elements = elements
				}, function(data2, menu2)

					TriggerEvent('skinchanger:getSkin', function(skin)
						ESX.TriggerServerCallback('m3:motel:server:getPlayerOutfit', function(clothes)
							TriggerEvent('skinchanger:loadClothes', skin, clothes)
							TriggerEvent('esx_skin:setLastSkin', skin)

							TriggerEvent('skinchanger:getSkin', function(skin)
								TriggerServerEvent('esx_skin:save', skin)
							end)
						end, data2.current.value)
					end)

				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		elseif data.current.value == 'remove_cloth' then
            menu.close()
			ESX.TriggerServerCallback('m3:motel:server:getPlayerDressing', function(dressing)
				elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_cloth', {
					title    = 'Kıyafet Sil',
					align    = 'right',
					elements = elements
				}, function(data2, menu2)
					menu2.close()
					TriggerServerEvent('m3:motel:server:removeOutfit', data2.current.value)
                    TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Kıyafet silindi!'})
				end, function(data2, menu2)
					menu2.close()
				end)
			end)
		end
	end, function(data, menu)
        menu.close()
	end)
end

function OpenMotelInventory()
    ESX.PlayerData = xPlayer
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Motel"..ESX.GetPlayerData().identifier)
    TriggerEvent("inventory:client:SetCurrentStash","Motel"..ESX.GetPlayerData().identifier)
end

function notify(type, text, time)
    if length == nil then length = 5000 end 
    TriggerEvent('mythic_notify:client:SendAlert', { type = type, text = text, length = length})
end

function DrawText3D(coord, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(coord.x, coord.y, coord.z)
	local px,py,pz=table.unpack(GetGameplayCamCoords()) 
	local scale = 0.3
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextDropshadow(0)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 380
        DrawRect(_x, _y + 0.0120, 0.0 + factor, 0.025, 41, 11, 41, 100)
	end
end
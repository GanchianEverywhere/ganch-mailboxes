local QBCore = exports['qb-core']:GetCoreObject()

local CheckPed = nil
local Targets = {}
local time = 1000

local function LoadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
end

local function callCops()
    TriggerEvent('ganch-mail:client:CallPolice')
end

CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.MailboxModels, {
        options = { 
            {
                type = "client",
                event = "ganch-mail:client:robMail",
                icon = "fas fa-envelope",
                label = "Steal mail",
            }  
        },
        distance = 2.0
    })
    CreateModelHide(vector3(Config.PedLocation.x, Config.PedLocation.y, Config.PedLocation.z), 1.0, `v_corp_bk_chair3`, true)
    CheckPed = makePed('U_M_M_BankMan', Config.PedLocation, false, false)

	Targets["ganchcheck"] =
	exports['qb-target']:AddCircleZone("ganchcheck", vector3(Config.PedLocation.x, Config.PedLocation.y, Config.PedLocation.z), 2.0, { name="ganchcheck", debugPoly= false, useZ=true, },
		{ options = {
                { 
                    type = "client",
                    event = "ganch-mail:client:cashCheck",
                    icon = "fas fa-receipt",
                    label = "Cash check",
                }
            },
		distance = 2.0 })

end)

function makePed(model, coords, freeze, collision, scenario, anim)
	loadModel(model)
	local ped = CreatePed(0, model, coords.x, coords.y, coords.z-1.03, coords.w, false, false)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, freeze or true)
    if collision then SetEntityNoCollisionEntity(ped, PlayerPedId(), false) end
    if scenario then TaskStartScenarioInPlace(ped, scenario, 0, true) end
    if anim then
        loadAnimDict(anim[1])
        TaskPlayAnim(ped, anim[1], anim[2], 1.0, 1.0, -1, 1, 0.2, 0, 0, 0)
    end
    return ped
end

function loadModel(model) if not HasModelLoaded(model) then
	if Config.Debug then print("^5Debug^7: ^2Loading Model^7: '^6"..model.."^7'") end
	while not HasModelLoaded(model) do
		if time > 0 then time -= 1 RequestModel(model)
		else time = 1000 print("^5Debug^7: ^3LoadModel^7: ^2Timed out loading model ^7'^6"..model.."^7'") break
		end
		Wait(10)
	end
end end

RegisterNetEvent('ganch-mail:client:robMail', function()
    local gopher = QBCore.Functions.HasItem('gopher')
    local ped = PlayerPedId()
    local callcops = math.random(1, 100)
    if IsPedInAnyVehicle(ped, true) then return end

    exports["qb-cooldowns"]:GetCooldown(function(cooldown)
        if cooldown > 0 then 
            QBCore.Functions.Notify('You need to wait ' .. cooldown .. ' more seconds to rob a mailbox again', 'error')
        else 
            if not gopher then 
                QBCore.Functions.Notify('How are you gonna grab it?', 'error')
            else
                if math.random(1, 100) <= Config.CallPoliceChance then
                    callCops()
                end
                QBCore.Functions.Progressbar('grab', "Attempting to grab some mail", 10000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = 'amb@prop_human_bum_bin@base',
                    anim = 'base',
                    flags = 1,
                }, {}, {}, function() -- Done
                    StopAnimTask(source, 'amb@prop_human_bum_bin@base', 'base', 1.0)
                    exports['ps-ui']:Circle(function(success)
                        if success then 
                            TriggerServerEvent('ganch-mail:server:robMail')
                        else 
                            QBCore.Functions.Notify('You failed to grab something from the mailbox', 'error')
                        end
                    end, 4, math.random(10, 15))
                    myFunction()
                    --TriggerServerEvent('qb-cooldowns:setCooldown', 'mailbox_robbery', os.time() + Config.CooldownTime)
                    
                end, function() -- Cancel
                    StopAnimTask(source, 'amb@prop_human_bum_bin@base', 'base', 1.0)
                    QBCore.Functions.Notify('You canceled the action', 'error')
                end)
            end
        end
    end, 'mailbox_robbery')
end)
function myFunction()
    TriggerServerEvent('qb-cooldowns:setCooldown', 'robbery_shop', Citizen. + Config.CooldownTime)
end

RegisterNetEvent('ganch-mail:client:cashCheck', function()
    local check = QBCore.Functions.HasItem('stolencheck')
    local chance = math.random(1, 100)

    if check then 
        if chance <= Config.FalseCheckRejectChance then
            callCops()
            TriggerServerEvent('ganch-mail:server:removeCheck')
        else 
            TriggerServerEvent('ganch-mail:server:cashCheck')
        end
    else 
    end
end)
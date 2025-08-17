local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('ganch-mail:server:robMail', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local chance = math.random(1, 100)
    local pack = math.random(1, 2)

    if chance <= Config.JunkItemChance then 
        Player.Functions.AddItem('junkmail', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['junkmail'], 'add')
    elseif chance > Config.JunkItemChance and chance <= Config.JunkItemChance + Config.MoneyChance then
        Player.Functions.AddItem('cashenvelope', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cashenvelope'], 'add')
    elseif chance > Config.JunkItemChance + Config.MoneyChance and chance <= Config.JunkItemChance + Config.MoneyChance + Config.FalseCheckChance then
        Player.Functions.AddItem('checkenvelope', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['checkenvelope'], 'add')
    else
        if pack == 1 then
            Player.Functions.AddItem('packageone', 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['packageone'], 'add')
        else
            Player.Functions.AddItem('packagetwo', 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['packagetwo'], 'add')
        end
    end
end)

RegisterNetEvent('ganch-mail:server:cashCheck', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local rand = math.random(1, #Config.FalseCheckAmounts)
    local randomAmount = Config.FalseCheckAmounts[rand]
    Player.Functions.AddMoney('cash', randomAmount)
    Player.Functions.RemoveItem('stolencheck', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['stolencheck'], 'remove', 1)
end)

RegisterNetEvent('ganch-mail:server:removeCheck', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('stolencheck', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['stolencheck'], 'remove', 1)
end)

QBCore.Functions.CreateUseableItem('cashenvelope', function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amt = math.random(Config.MoneyAmountMin, Config.MoneyAmountMax)
    Player.Functions.AddMoney('cash', amt, 'cashevenlope')
    Player.Functions.RemoveItem('cashenvelope', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cashenvelope'], 'remove', 1)
end)

QBCore.Functions.CreateUseableItem('checkenvelope', function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('stolencheck', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['stolencheck'], 'add', 1)
    Player.Functions.RemoveItem('checkenvelope', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['checkenvelope'], 'remove', 1)
end)

QBCore.Functions.CreateUseableItem('packageone', function(source)
    TriggerEvent('ganch-mail:server:packageOne', source)
end)

QBCore.Functions.CreateUseableItem('packagetwo', function(source)
    TriggerEvent('ganch-mail:server:packageTwo', source)
end)

RegisterNetEvent('ganch-mail:server:packageOne', function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local rand = math.random(1, #Config.PackageItems)
    local randomItem = Config.PackageItems[rand]
    local amount = math.random(Config.PackageItemAmountMin, Config.PackageItemAmountMax)

    Player.Functions.AddItem(randomItem, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomItem], 'add', amount)
    Player.Functions.RemoveItem('packageone', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['packageone'], 'remove', 1)
end)

RegisterNetEvent('ganch-mail:server:packageTwo', function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local randItem = math.random(1, #Config.GiftItems)
    local randomItem = Config.GiftItems[randItem]

    Player.Functions.AddItem(randomItem, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomItem], 'add')
    Player.Functions.RemoveItem('packagetwo', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['packagetwo'], 'remove', 1)
end)

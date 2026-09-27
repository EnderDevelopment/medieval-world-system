ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Register net events
RegisterNetEvent('medievalworldsystem:startQuest')
AddEventHandler('medievalworldsystem:startQuest', function(questName)
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        local quest = Config.Quests[questName]
        if quest then
            -- Start quest logic
            xPlayer.showNotification('Quest started: ' .. quest.name)
        else
            xPlayer.showNotification('Quest not found')
        end
    end
end)

RegisterNetEvent('medievalworldsystem:completeQuest')
AddEventHandler('medievalworldsystem:completeQuest', function(questName)
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        local quest = Config.Quests[questName]
        if quest then
            -- Complete quest logic
            xPlayer.addMoney(quest.rewards.money)
            xPlayer.addXp(quest.rewards.xp)
            xPlayer.showNotification('Quest completed: ' .. quest.name)
        else
            xPlayer.showNotification('Quest not found')
        end
    end
end)

RegisterNetEvent('medievalworldsystem:buyItem')
AddEventHandler('medievalworldsystem:buyItem', function(shopName, itemName)
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        local shop = Config.Shops[shopName]
        if shop then
            local item = nil
            for k, v in pairs(shop.items) do
                if v.name == itemName then
                    item = v
                    break
                end
            end
            if item then
                if xPlayer.getMoney() >= item.price then
                    xPlayer.removeMoney(item.price)
                    xPlayer.addInventoryItem(itemName, 1)
                    xPlayer.showNotification('Item purchased: ' .. itemName)
                else
                    xPlayer.showNotification('Not enough money')
                end
            else
                xPlayer.showNotification('Item not found')
            end
        else
            xPlayer.showNotification('Shop not found')
        end
    end
end)

RegisterNetEvent('medievalworldsystem:upgradeItem')
AddEventHandler('medievalworldsystem:upgradeItem', function(itemName)
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        local upgrade = Config.Upgrades[itemName]
        if upgrade then
            if xPlayer.getMoney() >= upgrade.cost then
                xPlayer.removeMoney(upgrade.cost)
                xPlayer.addInventoryItem(itemName .. '_upgrade', 1)
                xPlayer.showNotification('Item upgraded: ' .. itemName)
            else
                xPlayer.showNotification('Not enough money')
            end
        else
            xPlayer.showNotification('Upgrade not found')
        end
    end
end)

RegisterNetEvent('medievalworldsystem:spawnMob')
AddEventHandler('medievalworldsystem:spawnMob', function(mobName)
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        local mob = Config.Mobs[mobName]
        if mob then
            -- Spawn mob logic
            xPlayer.showNotification('Mob spawned: ' .. mob.name)
        else
            xPlayer.showNotification('Mob not found')
        end
    end
end)

RegisterNetEvent('medievalworldsystem:spawnBoss')
AddEventHandler('medievalworldsystem:spawnBoss', function(bossName)
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        local boss = Config.Bosses[bossName]
        if boss then
            -- Spawn boss logic
            xPlayer.showNotification('Boss spawned: ' .. boss.name)
        else
            xPlayer.showNotification('Boss not found')
        end
    end
end)

RegisterNetEvent('medievalworldsystem:spawnPlayer')
AddEventHandler('medievalworldsystem:spawnPlayer', function(spawnName)
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        local spawn = Config.Spawns[spawnName]
        if spawn then
            -- Spawn player logic
            xPlayer.showNotification('Player spawned at: ' .. spawnName)
        else
            xPlayer.showNotification('Spawn not found')
        end
    end
end)

-- Register commands
ESX.RegisterCommand('startquest', 'user', function(xPlayer, args, showError)
    local questName = args.questName
    if questName then
        TriggerClientEvent('medievalworldsystem:startQuest', xPlayer.source, questName)
    else
        xPlayer.showNotification('Please specify a quest name')
    end
end, false, {help = 'Start a quest', validate = true, arguments = {
    {name = 'questName', help = 'The name of the quest', type = 'string'}
}})

ESX.RegisterCommand('completequest', 'user', function(xPlayer, args, showError)
    local questName = args.questName
    if questName then
        TriggerClientEvent('medievalworldsystem:completeQuest', xPlayer.source, questName)
    else
        xPlayer.showNotification('Please specify a quest name')
    end
end, false, {help = 'Complete a quest', validate = true, arguments = {
    {name = 'questName', help = 'The name of the quest', type = 'string'}
}})

ESX.RegisterCommand('buyitem', 'user', function(xPlayer, args, showError)
    local shopName = args.shopName
    local itemName = args.itemName
    if shopName and itemName then
        TriggerClientEvent('medievalworldsystem:buyItem', xPlayer.source, shopName, itemName)
    else
        xPlayer.showNotification('Please specify a shop name and item name')
    end
end, false, {help = 'Buy an item from a shop', validate = true, arguments = {
    {name = 'shopName', help = 'The name of the shop', type = 'string'},
    {name = 'itemName', help = 'The name of the item', type = 'string'}
}})

ESX.RegisterCommand('upgradeitem', 'user', function(xPlayer, args, showError)
    local itemName = args.itemName
    if itemName then
        TriggerClientEvent('medievalworldsystem:upgradeItem', xPlayer.source, itemName)
    else
        xPlayer.showNotification('Please specify an item name')
    end
end, false, {help = 'Upgrade an item', validate = true, arguments = {
    {name = 'itemName', help = 'The name of the item', type = 'string'}
}})

ESX.RegisterCommand('spawnmob', 'user', function(xPlayer, args, showError)
    local mobName = args.mobName
    if mobName then
        TriggerClientEvent('medievalworldsystem:spawnMob', xPlayer.source, mobName)
    else
        xPlayer.showNotification('Please specify a mob name')
    end
end, false, {help = 'Spawn a mob', validate = true, arguments = {
    {name = 'mobName', help = 'The name of the mob', type = 'string'}
}})

ESX.RegisterCommand('spawnboss', 'user', function(xPlayer, args, showError)
    local bossName = args.bossName
    if bossName then
        TriggerClientEvent('medievalworldsystem:spawnBoss', xPlayer.source, bossName)
    else
        xPlayer.showNotification('Please specify a boss name')
    end
end, false, {help = 'Spawn a boss', validate = true, arguments = {
    {name = 'bossName', help = 'The name of the boss', type = 'string'}
}})

ESX.RegisterCommand('spawnplayer', 'user', function(xPlayer, args, showError)
    local spawnName = args.spawnName
    if spawnName then
        TriggerClientEvent('medievalworldsystem:spawnPlayer', xPlayer.source, spawnName)
    else
        xPlayer.showNotification('Please specify a spawn name')
    end
end, false, {help = 'Spawn a player', validate = true, arguments = {
    {name = 'spawnName', help = 'The name of the spawn', type = 'string'}
}})
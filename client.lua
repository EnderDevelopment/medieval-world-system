ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    -- Load world settings
    Config = Config or {}
    Config.WorldName = Config.WorldName or 'Medieval World'
    Config.WorldDescription = Config.WorldDescription or 'A medieval-themed world with custom elements'

    -- Load story mode settings
    Config.StoryModeEnabled = Config.StoryModeEnabled or true
    Config.StoryModeStartQuest = Config.StoryModeStartQuest or 'tutorial'

    -- Load quest settings
    Config.Quests = Config.Quests or {
        tutorial = {
            name = 'Tutorial',
            description = 'Learn the basics of the medieval world',
            rewards = {
                money = 100,
                xp = 50
            }
        }
    }

    -- Load shop settings
    Config.Shops = Config.Shops or {
        blacksmith = {
            name = 'Blacksmith',
            items = {
                {name = 'sword', price = 100},
                {name = 'shield', price = 150}
            }
        }
    }

    -- Load upgrade settings
    Config.Upgrades = Config.Upgrades or {
        sword = {
            name = 'Sword Upgrade',
            description = 'Upgrade your sword',
            cost = 200
        }
    }

    -- Load mob settings
    Config.Mobs = Config.Mobs or {
        goblin = {
            name = 'Goblin',
            health = 100,
            damage = 10,
            rewards = {
                money = 50,
                xp = 20
            }
        }
    }

    -- Load boss settings
    Config.Bosses = Config.Bosses or {
        dragon = {
            name = 'Dragon',
            health = 500,
            damage = 50,
            rewards = {
                money = 500,
                xp = 200
            }
        }
    }

    -- Load spawn settings
    Config.Spawns = Config.Spawns or {
        tutorial = {
            x = 0.0,
            y = 0.0,
            z = 0.0,
            heading = 0.0
        }
    }

    -- Register net events
    RegisterNetEvent('medievalworldsystem:updatePlayerData')
    AddEventHandler('medievalworldsystem:updatePlayerData', function(data)
        -- Handle player data updates
    end)

    -- Register commands
    RegisterCommand('startquest', function(source, args, rawCommand)
        local playerId = source
        local questName = args[1]
        if questName then
            TriggerServerEvent('medievalworldsystem:startQuest', questName)
        else
            ESX.ShowNotification('Please specify a quest name')
        end
    end, false)

    RegisterCommand('completequest', function(source, args, rawCommand)
        local playerId = source
        local questName = args[1]
        if questName then
            TriggerServerEvent('medievalworldsystem:completeQuest', questName)
        else
            ESX.ShowNotification('Please specify a quest name')
        end
    end, false)

    RegisterCommand('buyitem', function(source, args, rawCommand)
        local playerId = source
        local shopName = args[1]
        local itemName = args[2]
        if shopName and itemName then
            TriggerServerEvent('medievalworldsystem:buyItem', shopName, itemName)
        else
            ESX.ShowNotification('Please specify a shop name and item name')
        end
    end, false)

    RegisterCommand('upgradeitem', function(source, args, rawCommand)
        local playerId = source
        local itemName = args[1]
        if itemName then
            TriggerServerEvent('medievalworldsystem:upgradeItem', itemName)
        else
            ESX.ShowNotification('Please specify an item name')
        end
    end, false)

    RegisterCommand('spawnmob', function(source, args, rawCommand)
        local playerId = source
        local mobName = args[1]
        if mobName then
            TriggerServerEvent('medievalworldsystem:spawnMob', mobName)
        else
            ESX.ShowNotification('Please specify a mob name')
        end
    end, false)

    RegisterCommand('spawnboss', function(source, args, rawCommand)
        local playerId = source
        local bossName = args[1]
        if bossName then
            TriggerServerEvent('medievalworldsystem:spawnBoss', bossName)
        else
            ESX.ShowNotification('Please specify a boss name')
        end
    end, false)

    RegisterCommand('spawnplayer', function(source, args, rawCommand)
        local playerId = source
        local spawnName = args[1]
        if spawnName then
            TriggerServerEvent('medievalworldsystem:spawnPlayer', spawnName)
        else
            ESX.ShowNotification('Please specify a spawn name')
        end
    end, false)

    -- Register NPCs
    for k, v in pairs(Config.Shops) do
        local shopNPC = {
            model = 's_m_y_blackops_01',
            coords = vector3(0.0, 0.0, 0.0),
            heading = 0.0,
            name = v.name,
            shopName = k
        }
        ESX.Game.SpawnPed(shopNPC.model, shopNPC.coords, shopNPC.heading, function(ped)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_STAND_MOBILE', 0, true)
        end)
    end

    -- Register mobs
    for k, v in pairs(Config.Mobs) do
        local mob = {
            model = 'a_c_chickenhawk',
            coords = vector3(0.0, 0.0, 0.0),
            heading = 0.0,
            name = v.name,
            health = v.health,
            damage = v.damage,
            rewards = v.rewards
        }
        ESX.Game.SpawnPed(mob.model, mob.coords, mob.heading, function(ped)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_STAND_MOBILE', 0, true)
        end)
    end

    -- Register bosses
    for k, v in pairs(Config.Bosses) do
        local boss = {
            model = 'a_c_chickenhawk',
            coords = vector3(0.0, 0.0, 0.0),
            heading = 0.0,
            name = v.name,
            health = v.health,
            damage = v.damage,
            rewards = v.rewards
        }
        ESX.Game.SpawnPed(boss.model, boss.coords, boss.heading, function(ped)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_STAND_MOBILE', 0, true)
        end)
    end

    -- Register spawns
    for k, v in pairs(Config.Spawns) do
        local spawn = {
            coords = vector3(v.x, v.y, v.z),
            heading = v.heading,
            name = k
        }
        ESX.Game.SpawnPed('s_m_y_blackops_01', spawn.coords, spawn.heading, function(ped)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_STAND_MOBILE', 0, true)
        end)
    end
end)
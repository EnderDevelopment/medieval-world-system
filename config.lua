Config = {}

-- World settings
Config.WorldName = 'Medieval World'
Config.WorldDescription = 'A medieval-themed world with custom elements'

-- Story mode settings
Config.StoryModeEnabled = true
Config.StoryModeStartQuest = 'tutorial'

-- Quest settings
Config.Quests = {
    tutorial = {
        name = 'Tutorial',
        description = 'Learn the basics of the medieval world',
        rewards = {
            money = 100,
            xp = 50
        }
    }
}

-- Shop settings
Config.Shops = {
    blacksmith = {
        name = 'Blacksmith',
        items = {
            {name = 'sword', price = 100},
            {name = 'shield', price = 150}
        }
    }
}

-- Upgrade settings
Config.Upgrades = {
    sword = {
        name = 'Sword Upgrade',
        description = 'Upgrade your sword',
        cost = 200
    }
}

-- Mob settings
Config.Mobs = {
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

-- Boss settings
Config.Bosses = {
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

-- Spawn settings
Config.Spawns = {
    tutorial = {
        x = 0.0,
        y = 0.0,
        z = 0.0,
        heading = 0.0
    }
}
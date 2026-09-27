CREATE TABLE IF NOT EXISTS medieval_world_players (
    identifier VARCHAR(60) PRIMARY KEY,
    story_mode_progress TEXT,
    quests_completed TEXT,
    upgrades TEXT,
    inventory TEXT
);

INSERT INTO medieval_world_players (identifier, story_mode_progress, quests_completed, upgrades, inventory) VALUES ('default', 'tutorial', '{}', '{}', '{}');
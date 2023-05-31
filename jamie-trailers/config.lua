Config = {}

Config.Currency = '€'

Config.Npc = {
    name = 'cs_floyd', --https://docs.fivem.net/docs/game-references/ped-models/
    position = vector4(21.65, -2638.63, 6.03, 168.64), --x,y,z,heading
    animation = 'WORLD_HUMAN_CLIPBOARD_FACILITY', --https://github.com/DioneB/gtav-scenarios
    zone = {
        vector2(20.26, -2637.81), --x,y
        vector2(20.55, -2639.92),
        vector2(22.71, -2640.03),
        vector2(22.59, -2638.06)
    }
}

Config.Trailers = {
    spawnpoint = vector4(6.5, -2638.99, 6.04, 271.49), --x,y,z,heading
    list = { --add your trailers here (spawncodes)
        [1] = {
            name = 'elegy',
            price = 10000,
        },
        [2] = {
            name = 'sultan',
            price = 10000,
        },
    },
}
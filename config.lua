local Config = {}

Config.Inventory = (GetResourceState('ox_inventory') ~= 'missing' and 'ox') or (GetResourceState('qb-inventory') and 'qb') or (GetResourceState('es_extended') ~= 'missing' and 'esx')
Config.Distance = 2

Config.Weed = {
    WeedPick = {
        PickTime = 5000,
        Item = "weed_skunk",
        amount = 1
    },
    WeedProccess = {
        ProcTime = 5000,
        Item = "water",
        ProccessItem = 5, -- Amount of WeedPick Item required to Swap item
        amount = 2
    }
}

Config.Locations = {
    WeedLocations = {
        vec3(1056.2, -3203.71, -39.14),
        vec3(1060.37, -3204.13, -39.15),
        vec3(1061.6, -3205.9, -39.07),
        vec3(1061.46, -3204.59, -39.11),
        vec3(1061.54, -3202.74, -39.13),
        vec3(1061.45, -3201.37, -39.14),
        vec3(1057.41, -3197.62, -39.14),
        vec3(1056.36, -3197.06, -39.06),
        vec3(1053.7, -3199.31, -39.15),
        vec3(1053.56, -3201.21, -39.15),
        vec3(1058.56, -3197.39, -39.05),
        vec3(1051.48, -3201.42, -39.12),
        vec3(1050.05, -3201.14, -39.15),
        vec3(1053.09, -3205.01, -39.11),
        vec3(1051.42, -3204.67, -39.12),
        vec3(1049.93, -3204.77, -39.13),
        vec3(1060.96, -3200.18, -39.16),
        vec3(1060.65, -3198.27, -39.16),
        vec3(1060.81, -3196.93, -39.16),
        vec3(1060.78, -3194.91, -39.15),
        vec3(1060.94, -3193.28, -39.08),
        vec3(1060.79, -3191.79, -39.15),
        vec3(1058.78, -3203.92, -39.13)
    },

    Procces = {
        vec3(1039.24, -3205.38, -38.17),
        vec3(1037.52, -3205.36, -38.17),
        vec3(1036.28, -3203.81, -38.17),
        vec3(1033.96, -3203.81, -38.18),
        vec3(1034.65, -3205.58, -38.18),
        vec3(1032.93, -3205.55, -38.18)
    }
}

Config.Password = {
    Text = true,
    Health = true,
    pass = 'DOLLAR'
}

Config.InteriorLocations = {
    Enter = vector3(1066.3, -3183.49, -39.16),
    Exit = vector3(412.28, 313.93, 103.02)
}


Config.Ui = {
    Pick = {
        Text = "[E] - Collect",
        position = "right-center",
        icon = "cannabis",
        borderRadius = 0,
        backgroundColor = "#52078f",
        color = "white"
    },
    Procces = {
        Text = "[E] - Process",
        position = "right-center",
        icon = "cannabis",
        borderRadius = 0,
        backgroundColor = "#52078f",
        color = "white"
    },
    Enter = {
        position = "right-center",
        icon = "right-to-bracket",
        borderRadius = 0,
        backgroundColor = "#52078f",
        color = "white"
    },
    Exit = {
        position = "right-center",
        icon = "left-to-bracket",
        borderRadius = 0,
        backgroundColor = "#52078f",
        color = "white"
    },
    Notify = {
        id = 'notif',
        title = 'Weed Notification',
        description = 'You have collected 1x weed',
        position = 'top-right',
        style = {
            backgroundColor = "#52078f",
            color = "white"
        },
        icon = 'cannabis',
        iconColor = '#ffff'
    },
    NotifyProccess = {
        id = 'notif2',
        title = 'Weed Notification',
        description = 'You have produced one packaged weed',
        position = 'top-right',
        style = {
            backgroundColor = "#52078f",
            color = "white"
        },
        icon = 'cannabis',
        iconColor = '#ffff'
    },
    NotifyError = {
        title = 'Weed Notification',
        description = "You don't have enough items (minimum"..' '..Config.Weed.WeedProccess.ProccessItem..'x)',
        type = 'error'

    },
    NotifyErrorFull = {
        title = 'Weed Notification',
        description = "Your inventory is full",
        type = 'error'

    },
    NotifyPasswordError = {
        id = 'notif3',
        title = 'Weed Notification',
        description =  "Incorrect password",
        position = 'top-right',
        style = {
            backgroundColor = "red",
            color = "black"
        },
        icon = 'cannabis',
        iconColor = '#ffff'
    },
    InputUi =  {
        Header = 'WEED COLLECTING',
        label = 'Password',
        description = '2+2?',
        icon = 'user',
    },
    HackNotify =  {
        text = 'Stop using exploits, mate?'
    },
    DoorText = {
        enter = '[E] - Enter',
        exit = '[E] - Exit'
    }
}


Config.Enter = {
    {text = Config.Ui.DoorText.enter, status = "enter", coords = vector3(412.28, 313.93, 103.02)},
    {text = Config.Ui.DoorText.exit, status = "exit", coords = vector3(1066.3, -3183.49, -39.16)}
}

return Config
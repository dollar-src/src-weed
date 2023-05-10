Core = nil



local pressed = false

local NumberCharset = {}
local Charset = {}

for i = 48, 57 do
    table.insert(NumberCharset, string.char(i))
end

for i = 65, 90 do
    table.insert(Charset, string.char(i))
end
for i = 97, 122 do
    table.insert(Charset, string.char(i))
end

function GetRandomNumber(length)
    Wait(0)
    if length > 0 then
        return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
    else
        return ""
    end
end


Citizen.CreateThread(
    function()
        local sleep
        while true do
            sleep = 1000
            pcord = GetEntityCoords(PlayerPedId())

            local WeedLocations = Config.Locations[1].WeedLocations
            local isPlayerNearUi = false

            for k, v in ipairs(Config.Locations) do
                for i = 1, #WeedLocations do
                    dst = GetDistanceBetweenCoords(pcord, WeedLocations[i])
                    if dst < 1 and not pressed then
                        isPlayerNearUi = true
                        sleep = 5
                        lib.showTextUI(
                            Config.Ui.Pick.Text .. " " .. i,
                            {
                                position = Config.Ui.Pick.position,
                                icon = Config.Ui.Pick.icon,
                                style = {
                                    borderRadius = Config.Ui.Pick.borderRadius,
                                    backgroundColor = Config.Ui.Pick.backgroundColor,
                                    color = Config.Ui.Pick.color
                                }
                            }
                        )
                        if dst < 1 and IsControlJustReleased(1, 51) then
                            local Key = GetRandomNumber(10)
                            pressed = true
                            sleep = 1000
                            animweed(Key)
                        end
                    end
                end
            end

            if not isPlayerNearUi then
                lib.hideTextUI()
            end

            Citizen.Wait(sleep)
        end
    end
)

Citizen.CreateThread(
    function()
        local sleep
        while true do
            sleep = 1000
            pcord = GetEntityCoords(PlayerPedId())

            local Locations = Config.Locations[1].Procces
            local isPlayerNearUi = false

            for k, v in ipairs(Config.Locations) do
                for i = 1, #Locations do
                    dst = GetDistanceBetweenCoords(pcord, Locations[i])
                    if dst < 1 and not pressed then
                        isPlayerNearUi = true
                        sleep = 5
                        lib.showTextUI(
                            Config.Ui.Procces.Text .. " " .. i,
                            {
                                position = Config.Ui.Procces.position,
                                icon = Config.Ui.Procces.icon,
                                style = {
                                    borderRadius = Config.Ui.Procces.borderRadius,
                                    backgroundColor = Config.Ui.Procces.backgroundColor,
                                    color = Config.Ui.Procces.color
                                }
                            }
                        )
                        if dst < 1 and IsControlJustReleased(1, 51) then
                            local Key = GetRandomNumber(10)
                            pressed = true
                            sleep = 1000
                            Proccessweed(Key)
                        end
                    end
                end
            end

            if not isPlayerNearUi then
                lib.hideTextUI()
            end

            Citizen.Wait(sleep)
        end
    end
)


CreateThread(function()
    while true do
        Wait(1)
        letSleep = true
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed, true)
        for k, v in pairs(Config.Enter) do
            local loc = #(playerCoords - v.coords)

            if loc < 3.0 then
                letSleep = false
                if loc < 2.0 then
                    lib.showTextUI(
                        v.text,
                        {
                            position = Config.Ui.Enter.position,
                            icon = Config.Ui.Enter.icon,
                            style = {
                                borderRadius = Config.Ui.Enter.borderRadius,
                                backgroundColor = Config.Ui.Enter.backgroundColor,
                                color = Config.Ui.Pick.color
                            }
                        }
                    )

                    if IsControlJustPressed(0, 38) then
                        enter(v)
                    end
                end
            end
        end

        if letSleep then
            lib.hideTextUI()
            Wait(1000)
        end
    end
end)

function animweed(Key)
    local ped = PlayerPedId()
    if lib.progressCircle({
        duration = Config.Weed.WeedPick.PickTime,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
        },
        anim = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_stand_checkingleaves_kneeling_01_inspector",
        },
    }) then 
       setsleep(false)
       TriggerServerEvent("src-weed:collect", Key)

     else
       setsleep(false)
    end

end

function setsleep(status)
    pressed = status
end

function enter(data)
    local playerPed = PlayerPedId()
    local health = GetEntityHealth(playerPed)

    if data.status == "enter" then
        local input =
            lib.inputDialog(
            Config.Ui.InputUi.Header,
            {
                {type = "input", label =  Config.Ui.InputUi.label, description = Config.Ui.InputUi.description, icon = Config.Ui.InputUi.icon, required = true}
            }
        )

        if input ~= nil then
            if Config.Password.Text then
                text = input[1]
            else
                text = tonumber(input[1])
         end
            if text == Config.Password.pass then
                SetEntityCoords(
                    playerPed,
                    Config.InteriorLocations.Enter.x,
                    Config.InteriorLocations.Enter.y,
                    Config.InteriorLocations.Enter.z
                )
            else
                if Config.Password.Health then
                SetEntityHealth(playerPed, health - 10 )
                SetFlash(0, 0, 100, 1000, 500, 255, 0, 0, 0)
                end
                lib.notify({
                    id = Config.Ui.NotifyPasswordError.id,
                    title = Config.Ui.NotifyPasswordError.title,
                    description = Config.Ui.NotifyPasswordError.description,
                    position = Config.Ui.NotifyPasswordError.position,
                    style = {
                        backgroundColor = Config.Ui.NotifyPasswordError.style.backgroundColor,
                        color = Config.Ui.NotifyPasswordError.style.color
                    },
                    icon = Config.Ui.NotifyPasswordError.icon,
                    iconColor = Config.Ui.NotifyPasswordError.iconColor
                })
            end
        end
    elseif data.status == "exit" then
        SetEntityCoords(
            playerPed,
            Config.InteriorLocations.Exit.x,
            Config.InteriorLocations.Exit.y,
            Config.InteriorLocations.Exit.z
        )
    end
end



function Proccessweed(Key)
    lib.callback('src-weed:get', source, function(data)
     if data then
        if lib.progressCircle({
            duration = Config.Weed.WeedProccess.ProcTime,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
            },
            anim = {
                dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
                clip = "weed_stand_checkingleaves_kneeling_01_inspector",
            },
        }) then 
           setsleep(false)
           TriggerServerEvent("src-weed:proccess", Key)    
         else
           setsleep(false)
        end
    else
        lib.notify(
            {
                title = Config.Ui.NotifyError.title,
                description = Config.Ui.NotifyError.description,
                type = Config.Ui.NotifyError.type
            }
        )
        setsleep(false)

    end
    end)
end


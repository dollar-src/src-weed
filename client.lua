local ZonesWeed, Interior, action = {}, {}, false

for k,v in pairs(Config.Locations) do
    ZonesWeed[k] = {}
    for i = 1, #v do
        local coord = v[i]
        ZonesWeed[k][i] = lib.points.new({
            coords = coord,
            distance = 1,
            key = k,
            id = i,
        })

        local zone = ZonesWeed[k][i]

        function zone:onEnter()
            if self.key == "WeedLocations" then
                lib.showTextUI(
                    Config.Ui.Pick.Text .. " " .. self.id,
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
            elseif self.key == "Procces" then
                lib.showTextUI(
                    Config.Ui.Procces.Text .. " " .. self.id,
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
            end
        end

        function zone:onExit()
            lib.hideTextUI()
        end

        function zone:nearby()
            if not action then
                if self.currentDistance < 1 and IsControlJustPressed(1, 51) then
                    action = true
                    if self.key == "WeedLocations" then
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
                            }) 
                        then 
                            action = false
                            if self.currentDistance < 2 then
                                TriggerServerEvent("src-weed:server:interact", self.key, self.coords, self.id)
                            end
                        else
                            action = false
                        end
                    elseif self.key == "Procces" then
                        local can = lib.callback.await('src-weed:callback:canProcess')
                        if can then
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
                                }) 
                            then 
                                action = false
                                if self.currentDistance < 2 then
                                    TriggerServerEvent("src-weed:server:interact", self.key, self.coords, self.id)
                                end  
                            else
                                action = false
                            end
                        end
                    end
                end
            end
        end
    end
end

for i = 1, #Config.Enter do
    local value = Config.Enter[i]
    Interior[i] = lib.points.new({
        coords = value.coords,
        distance = Config.Distance,
        status = value.status,
        text = value.text,
    })

    local zone = Interior[i]

    function zone:onEnter()
        lib.showTextUI(
            self.text,
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
    end

    function zone:onExit()
        lib.hideTextUI()
    end

    function zone:nearby()
        if IsControlJustPressed(0, 38) then
            if action then return end
            action = true
            if self.status == "enter" then
                local input = lib.inputDialog( Config.Ui.InputUi.Header, {
                    {type = "input", label =  Config.Ui.InputUi.label, description = Config.Ui.InputUi.description, icon = Config.Ui.InputUi.icon, required = true}
                })

                if input then
                    local text
                    if Config.Password.Text then
                        text = input[1]
                    else
                        text = tonumber(input[1])
                    end
                    if text == Config.Password.pass then
                        SetEntityCoords(cache.ped, Config.InteriorLocations.Enter.x, Config.InteriorLocations.Enter.y, Config.InteriorLocations.Enter.z)
                    else
                        if Config.Password.Health then
                            SetEntityHealth(cache.ped, GetEntityHealth(cache.ped) - 10 )
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
            else
                SetEntityCoords(cache.ped, Config.InteriorLocations.Exit.x, Config.InteriorLocations.Exit.y, Config.InteriorLocations.Exit.z)
            end
        end
    end
end
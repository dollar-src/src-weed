if Config.Core == "qb" then
    Core = exports["qb-core"]:GetCoreObject()
elseif Config.Core == "esx" then
    Core = exports["es_extended"]:getSharedObject()
end

AddItem = function(src, item, count, metadata)
    return exports.ox_inventory:AddItem(src, item, count, metadata)
end

RemoveItem = function(src, item, count, metadata)
    return exports.ox_inventory:RemoveItem(src, item, count, metadata)
end


RegisterNetEvent(
    "src-weed:collect",
    function(key)
        local _ = source
        if key ~= nil then
            if math.floor(key / 1000000000) >= 1 and math.floor(key / 1000000000) < 10 then
                local src = source
                local Player = Core.Functions.GetPlayer(src)

                if Player ~= nil then
                    Player.Functions.AddItem(Config.Weed.WeedPick.Item, Config.Weed.WeedPick.amount)
                    data = {
                        id = Config.Ui.Notify.id,
                        title = Config.Ui.Notify.title,
                        description = Config.Ui.Notify.description,
                        position = Config.Ui.Notify.position,
                        style = {
                            backgroundColor = Config.Ui.Notify.style.backgroundColor,
                            color = Config.Ui.Notify.style.color
                        },
                        icon = Config.Ui.Notify.icon,
                        iconColor = Config.Ui.Notify.iconColor
                    }
                    
                    TriggerClientEvent('ox_lib:notify', source, data)
                end
            else
                DropPlayer(_, Config.Ui.HackNotify.text)
            end
        else
            DropPlayer(_, Config.Ui.HackNotify.text)
        end
    end
)

RegisterNetEvent(
    "src-weed:proccess",
    function(key)
        local _= source
        if Config.Core == "qb" then
            if key ~= nil then

                if math.floor(key / 1000000000) >= 1 and math.floor(key / 1000000000) < 10 then
                    local src = source
                    local Player = Core.Functions.GetPlayer(src)

                    if Player ~= nil then
                        Player.Functions.RemoveItem(Config.Weed.WeedPick.Item, Config.Weed.WeedProccess.ProccessItem)
                        Citizen.Wait(300)
                        Player.Functions.AddItem(Config.Weed.WeedProccess.Item, Config.Weed.WeedProccess.amount)
                        data = {
                            id = Config.Ui.NotifyProccess.id,
                            title = Config.Ui.NotifyProccess.title,
                            description = Config.Ui.NotifyProccess.description,
                            position = Config.Ui.NotifyProccess.position,
                            style = {
                                backgroundColor = Config.Ui.NotifyProccess.style.backgroundColor,
                                color = Config.Ui.NotifyProccess.style.color
                            },
                            icon = Config.Ui.NotifyProccess.icon,
                            iconColor = Config.Ui.NotifyProccess.iconColor
                        }
                        
                        TriggerClientEvent('ox_lib:notify', src, data)
                    end
                else
                    DropPlayer(_, Config.Ui.HackNotify.text)
                end
            else
                DropPlayer(_, Config.Ui.HackNotify.text)
            end
        elseif Config.Core == "esx" then
            local _ = source
            if key ~= nil then
                if math.floor(key / 1000000000) >= 1 and math.floor(key / 1000000000) < 10 then
                    local src = source
                    local Player = Core.GetPlayerFromId(src)

                    if Player ~= nil then
                        Player.removeInventoryItem(Config.Weed.WeedPick.Item, Config.Weed.WeedProccess.ProccessItem)
                        Citizen.Wait(300)
                        Player.addInventoryItem(Config.Weed.WeedProccess.Item, Config.Weed.WeedProccess.amount)
                    end
                else
                end
            else
            end
        else
            if key ~= nil then
                if math.floor(key / 1000000000) >= 1 and math.floor(key / 1000000000) < 10 then
                    local src = source
                    local Player = Core.GetPlayerFromId(src)

                    if Player ~= nil then
                        RemoveItem(src, Config.Weed.WeedPick.Item, Config.Weed.WeedProccess.ProccessItem)
                        Citizen.Wait(300)
                        AddItem(src, Config.Weed.WeedProccess.Item, Config.Weed.WeedProccess.amount, {})
                    end
                else
                    DropPlayer(_, Config.Ui.HackNotify.text)

                end
            else
                DropPlayer(_, Config.Ui.HackNotify.text)
            end
        end
    end
)

lib.callback.register(
    "src-weed:get",
    function(_, cb)
        if Config.Core == "qb" then
            local src = _
            local Player = Core.Functions.GetPlayer(src)
            local materialItem = Player.Functions.GetItemByName(Config.Weed.WeedPick.Item)

            if materialItem ~= nil then
                if materialItem.amount >= Config.Weed.WeedProccess.ProccessItem then
                    return true
                else
                    return false
                end
            else
                return false
            end
        elseif Config.Core == "esx" then
            local src = _
            local Player = Core.GetPlayerFromId(src)
            local materialItem = Player.getInventoryItem(Config.Weed.WeedPick.Item)
            if materialItem ~= nil then
                if materialItem.amount >= Config.Weed.WeedProccess.ProccessItem then
                    return true
                else
                    return true
                end
            else
                return false
            end
        else
            local src = _
            local materialItem =
                exports.ox_inventory:GetItem(src, Config.Weed.WeedPick.Item, {}, Config.Weed.WeedProccess.ProccessItem)
            if materialItem ~= nil then
                if materialItem then
                    return true
                else
                    return true
                end
            else
                return false
            end
        end
    end
)


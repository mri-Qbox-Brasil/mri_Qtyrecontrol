local Config = require "shared.config"
local ox_inventory = exports.ox_inventory

lib.callback.register(
    "mri_Qtyrecontrol:server:UseTyre",
    function(source)
        local coords = GetEntityCoords(GetPlayerPed(source))
        local vehicle = lib.getClosestVehicle(coords, 3.0, true)
        local toolItem = exports.ox_inventory:Search(source, "slots", Config.TyreChange.ItemTool.Name)

        if toolItem then
            toolItem = toolItem[1]
        else
            return false
        end

        ox_inventory:SetDurability(
            source,
            toolItem.slot,
            toolItem.metadata.durability - Config.TyreChange.ItemDurability.Loss
        )
        ox_inventory:RemoveItem(source, Config.TyreChange.ItemName, 1)
        return true
    end
)

AddEventHandler(
    "ox_inventory:usedItem",
    function(playerId, name, slotId, metadata)
        if name ~= Config.TyreChange.ItemName then
            return
        end
        lib.callback(
            "mri_Qtyrecontrol:client:UseTyre",
            playerId,
            function(source)
                return true
            end
        )
    end
)

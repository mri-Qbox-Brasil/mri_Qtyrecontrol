local Config = require "shared.config"
local ox_inventory = exports.ox_inventory

local function useTyre(event, item, inventory, slot, data)
    lib.callback(
        "mri_Qtyrecontrol:client:UseTyre",
        inventory.id,
        function(source)
            return true
        end
    )
end

exports("UseTyre", useTyre)

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

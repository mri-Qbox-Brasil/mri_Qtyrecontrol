local Config = require "shared.config"
local Utils = require "client.utils"

local ox_target = exports.ox_target

local bones = {
    "wheel_lf",
    "wheel_rf",
    "wheel_lr",
    "wheel_rr"
}

local function doProgressBar()
    return lib.progressBar(
        {
            duration = Config.TyreChange.ChangeTime,
            label = locale("changingTyre"),
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
                car = true
            },
            anim = {
                dict = Config.TyreChange.Anim.dict,
                clip = Config.TyreChange.Anim.anim
            },
            prop = {
                model = Config.TyreChange.Prop,
                pos = vec3(0.03, 0.03, 0.02),
                rot = vec3(0.0, 0.0, -1.5)
            }
        }
    )
end

local function doTyreChange(vehicle, tyre, target_name)
    if doProgressBar() then
        lib.callback(
            "mri_Qtyrecontrol:server:UseTyre",
            false,
            function(result)
                if result then
                    SetVehicleTyreFixed(vehicle, tyre)
                    ox_target:removeGlobalVehicle(target_name)
                    Utils.sendNotify(locale("tyreChanged"), "success")
                end
            end
        )
    else
        Utils.sendNotify(locale(tyreChangeCanceled))
    end
end

lib.callback.register(
    "mri_Qtyrecontrol:client:UseTyre",
    function()
        local coords = GetEntityCoords(cache.ped)
        local vehicle = lib.getClosestVehicle(coords, 3.0, true)

        if not vehicle then
            Utils.sendNotify(locale("noVehicle"))
            return
        end

        if not Utils.isAnyTyreBurst(vehicle) then
            Utils.sendNotify(locale("noTyreBurst"))
            return
        end

        if Config.TyreChange.ItemTool.Required then
            local toolItem = exports.ox_inventory:Search("slots", Config.TyreChange.ItemTool.Name)

            if toolItem then
                toolItem = toolItem[1]
            end

            if not toolItem then
                Utils.sendNotify(locale("toolNeeded", toolItem.label))
                return
            end

            if Config.TyreChange.ItemDurability.Enabled then
                if toolItem.metadata.durability <= 0 then
                    Utils.sendNotify(locale("toolWrecked", toolItem.label))
                    return
                end
            end
        end

        ExecuteCommand(string.format("e %s", Config.TyreChange.AnimationName))

        for i = 0, 3, 1 do
            local tyre = Utils.getTyre(i)
            print(tyre)
            if IsVehicleTyreBurst(vehicle, tyre, false) then
                local target_name = string.format("fix_tyre_%s", tyre)
                ox_target:addGlobalVehicle(
                    {
                        {
                            name = target_name,
                            label = locale("changeTyre", tyre, bones[i + 1]),
                            icon = "fa-solid fa-wrench",
                            bones = bones[i + 1],
                            distance = 1.5,
                            onSelect = function()
                                ExecuteCommand("e c")
                                doTyreChange(vehicle, tyre, target_name)
                            end
                        }
                    }
                )
            end
        end
    end
)

CreateThread(
    function()
        while true do
            if lib.progressActive() then
                Wait(1)
                if IsControlJustReleased(0, Config.TyreChange.CancelKey) then
                    lib.cancelProgress()
                end
            else
                Wait(1000)
            end
        end
    end
)

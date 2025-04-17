local Config = require "shared.config"
local Utils = require "client.utils"

local function BurstTyre(vehicle, tyre)
    local tyreToBurst = Utils.getTyre(tyre)
    if not vehicle or not tyre then
        return
    end
    if IsVehicleTyreBurst(vehicle, tyreToBurst, false) then
        return
    end
    Utils.debugNotification(locale("tyreBurst", tyreToBurst))
    SetVehicleTyreBurst(vehicle, tyreToBurst, true, 1000.0)
    SetVehicleTyreFixed(vehicle, tyreToBurst)
    SetVehicleTyreBurst(vehicle, tyreToBurst, false, 1000.0)
end

local function BurstAllTyres(vehicle)
    for i = 0, 3, 1 do
        BurstTyre(vehicle, i)
    end
end

local function doTyreBurstByHeight()
    if not Config.TyreBurstByHeight.Active then
        return
    end

    if not Utils.commonChecks() then
        return
    end

    if math.random(100) > Config.TyreBurstByHeight.BurstChance then
        return
    end

    local vehicle = GetVehiclePedIsIn(cache.ped, false)

    if Utils.getVehicleHeightFromGround(vehicle) < Config.TyreBurstByHeight.MinHeight then
        return
    end

    BurstAllTyres(vehicle)
end

local function doFullBurst()
    if not Config.FullBurstOnDegree.Active then
        return
    end

    if not Utils.commonChecks() then
        return
    end

    if math.random(100) > Config.FullBurstOnDegree.BurstChance then
        return
    end

    local vehicle = GetVehiclePedIsIn(cache.ped, false)
    local roll = GetEntityRoll(vehicle)

    if roll >= Config.FullBurstOnDegree.RollDegree then
        BurstAllTyres(vehicle)
        return
    end
end

local function doTyreBurst()
    if not Config.TyreBurst.Active then
        return
    end

    if not Utils.commonChecks() then
        return
    end

    local vehicle = GetVehiclePedIsIn(cache.ped, false)
    local roll = GetEntityRoll(vehicle)

    if roll < math.abs(Config.TyreBurst.RollDegree) then
        return
    end

    if math.random(100) > Config.TyreBurst.BurstChance then
        return
    end

    BurstTyre(vehicle, math.random(0, 3))
end

CreateThread(
    function()
        while true do
            doTyreBurst()
            Wait(Config.TyreBurst.LoopTimer)
        end
    end
)

CreateThread(
    function()
        while true do
            doTyreBurstByHeight()
            Wait(Config.TyreBurstByHeight.LoopTimer)
        end
    end
)

CreateThread(
    function()
        while true do
            doFullBurst()
            Wait(Config.FullBurstOnDegree.LoopTimer)
        end
    end
)

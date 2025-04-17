local Config = require "shared.config"

local function isClassAllowed(class)
    return Config.AllowedVehicleClasses[class] or false
end

local function sendNotify(message, msgType)
    lib.notify(
        {
            type = msgType or "error",
            title = msgType == "info" and string.format("Debug: %s", GetCurrentResourceName()) or "Debug" or nil,
            description = message,
            duration = Config.TyreChange.NotifyTime
        }
    )
end

local function debugNotification(message)
    if Config.Debug then
        sendNotify(message, "info")
    end
end

local function getTyre(id)
    return id > 1 and id + 2 or id
end

local function isAnyTyreBurst(vehicle)
    for i = 0, 3, 1 do
        if IsVehicleTyreBurst(vehicle, getTyre(i), false) then
            return true
        end
    end
    return false
end

local function getVehicleHeightFromGround(vehicle)
    local vehCoords = GetEntityCoords(vehicle)
    local success, groundZ = GetGroundZFor_3dCoord(vehCoords.x, vehCoords.y, vehCoords.z + 10.0)

    if not success then
        return 0.0
    end
    return vehCoords.z - groundZ
end

local function commonChecks()
    if not IsPedInAnyVehicle(cache.ped, false) then
        return false
    end

    local vehicle = GetVehiclePedIsIn(cache.ped, false)

    if not vehicle then
        return false
    end

    if not isClassAllowed(GetVehicleClass(vehicle)) then
        return false
    end

    if not GetPedInVehicleSeat(vehicle, -1) == cache.ped then
        return false
    end

    return true
end

return {
    sendNotify = sendNotify,
    debugNotification = debugNotification,
    isAnyTyreBurst = isAnyTyreBurst,
    getTyre = getTyre,
    getVehicleHeightFromGround = getVehicleHeightFromGround,
    commonChecks = commonChecks
}

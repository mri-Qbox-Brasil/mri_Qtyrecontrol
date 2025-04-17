return {
    Debug = false,
    AllowedVehicleClasses = {
        [0] = true, -- Compacts
        [1] = true, -- Sedans
        [2] = true, -- SUVs
        [3] = true, -- Coupes
        [4] = true, -- Muscle
        [5] = true, -- Sports Classics
        [6] = true, -- Sports
        [7] = true, -- Super
        [8] = true, -- Motorcycles
        [9] = true, -- Off-road
        [10] = false, -- Industrial
        [11] = false, -- Utility
        [12] = false, -- Vans
        [13] = false, -- Bicycles
        [14] = false, -- Boats
        [15] = false, -- Helicopters
        [16] = false, -- Planes
        [17] = false, -- Service
        [18] = false, -- Emergency
        [19] = false, -- Military
        [20] = false, -- Commercial
        [21] = false -- Trains
    },
    TyreBurst = {
        Active = true,
        LoopTimer = 1000,
        RollDegree = 75.0,
        BurstChance = 100
    },
    FullBurstOnDegree = {
        Active = true,
        LoopTimer = 100,
        RollDegree = 130.0,
        BurstChance = 100
    },
    TyreBurstByHeight = {
        Active = false,
        LoopTimer = 250,
        MinHeight = 20.0,
        BurstChance = 100
    },
    TyreChange = {
        ItemName = "tyre",
        CancelKey = 168,
        Prop = "prop_wheel_tyre",
        AnimationName = "tire",
        Anim = {dict = "anim@heists@box_carry@", anim = "idle"},
        ItemTool = {
            Required = true,
            Name = "WEAPON_WRENCH"
        },
        ItemDurability = {
            Enabled = true,
            Loss = 10
        },
        NotifyTime = 4000,
        ChangeTime = 10000
    }
}

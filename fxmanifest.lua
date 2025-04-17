fx_version "cerulean"
game "gta5"
lua54 "yes"
use_experimental_fxv2_oal "yes"

description "Sistema de controle de pneus dos veículos"
author "GFive"
version "1.0.0"

ox_lib "locale"

shared_scripts {
    "@ox_lib/init.lua",
    "@qbx_core/modules/playerdata.lua",
    "shared/*.lua"
}

server_scripts {
    "server/*.lua"
}

client_scripts {
    "client/*.lua"
}

dependencies {
    "qbx_core"
}

files {
    "locales/*.json"
}

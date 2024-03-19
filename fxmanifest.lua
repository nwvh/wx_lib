fx_version 'cerulean'
game 'gta5'
version '1.0.0'
lua54 'yes'
author 'wx / woox'
description 'combat mode pro rdrp protoze #boss'

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua',
}

shared_scripts {'@ox_lib/init.lua','configs/*.lua'}
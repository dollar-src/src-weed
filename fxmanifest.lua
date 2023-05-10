fx_version 'bodacious'

game 'gta5'

shared_script '@ox_lib/init.lua'
lua54 'yes'

client_scripts {
    'config.lua',
     'client.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server.lua'
}


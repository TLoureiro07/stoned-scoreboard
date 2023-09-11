author 'Loureiro #0111'
description 'Implementations & Based on qb-scoreboard default'
version '1.0'
url 'https://stoned.tebex.io/'

game 'gta5'
lua54 'yes'
fx_version 'adamant'

ui_page "html/ui.html"

client_scripts {
    'client.lua',
	'config.lua',
}

server_scripts {
	'config.lua',
	'server.lua',
}

files {
    "html/*"
}

escrow_ignore {
	'config.lua'
}
  
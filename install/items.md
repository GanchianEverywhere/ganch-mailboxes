Insert this at the bottom of qb-core\shared\items.lua


--Mailbox robberies
packageone = { name = 'packageone', label = 'Suspicious package', weight = 1500, type = 'item', image = 'packageone.png', unique = true, useable = true, shouldClose = true, description = 'Looks suspicious, maybe I should take it to the police'},
packagetwo = { name = 'packagetwo', label = 'Wrapped gift', weight = 1500, type = 'item', image = 'packagetwo.png', unique = true, useable = true, shouldClose = true, description = 'I hope there's something good in this'},
junkmail = { name = 'junkmail', label = 'Junk mail', weight = 1500, type = 'item', image = 'junkmail.png', unique = true, useable = true, shouldClose = true, description = 'Trash'},
cashenvelope = { name = 'cashenvelope', label = 'Thick envelope', weight = 1500, type = 'item', image = 'cashenvelope.png', unique = true, useable = true, shouldClose = true, description = 'Feels THICCC'},
checkenvelope = { name = 'checkenvelope', label = 'Thin envelope', weight = 1500, type = 'item', image = 'checkenvelope.png', unique = true, useable = true, shouldClose = true, description = 'Oooh, what's in it?'},
stolencheck = { name = 'stolencheck', label = 'Check', weight = 1500, type = 'item', image = 'stolencheck.png', unique = true, useable = true, shouldClose = true, description = 'Should I cash this in?'},

Add the images to qb-inventory\html\images
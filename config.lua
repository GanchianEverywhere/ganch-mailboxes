Config = {}

Config.MailboxModels = {
    'prop_postbox_01a', -- prop names
}

--[[
    These four need to equal 100
]]
Config.JunkItemChance = 50
Config.MoneyChance = 25
Config.FalseCheckChance = 15
Config.PackageChance = 10

Config.MoneyAmountMin = 100 -- minimum amount of money you get from cash envelopes
Config.MoneyAmountMax = 500 -- maximum amount of money you get from cash envelopes
Config.FalseCheckAmounts = { 250, 500, 1000, 2500 } -- amounts you can get from the checks
Config.FalseCheckRejectChance = 50 -- chance to not get money from check out of 100

Config.PackageItems = { 'cokebaggy', 'methbags', 'weed_ogkush', 'weed_ak47' } -- Items you get from opening the packages
Config.PackageItemAmountMin = 5 -- minimum amount from packages
Config.PackageItemAmountMax = 20 -- maximum amount from packages
Config.GiftItems = { 'weapon_dildo', 'weapon_horse_dildo' } -- Items you get from opening gifts

Config.CallPoliceChance = 75 -- chance to call cops when cashing check out of 100

Config.CooldownTime = 600 -- time in seconds 10 minutes default (this may or may not work, it's been a while since I've tested this)

--[[
    False check cash in location
    This can be moved anywhere, the ped and polyzone will move with it
]]
Config.PedLocation = vector4(262.2, 226.4, 106.28, 157.85)
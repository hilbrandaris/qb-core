shared = {}

local StringCharset = {}
local NumberCharset = {}

for i = 48,  57 do NumberCharset[#NumberCharset+1] = string.char(i) end
for i = 65,  90 do StringCharset[#StringCharset+1] = string.char(i) end
for i = 97, 122 do StringCharset[#StringCharset+1] = string.char(i) end

shared.randomStr = function(length)
    if length <= 0 then return '' end
    return shared.randomStr(length - 1) .. StringCharset[math.random(1, #StringCharset)]
end

shared.randomInt = function(length)
    if length <= 0 then return '' end
    return shared.randomInt(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
end

shared.splitStr = function(str, delimiter)
    local result = { }
    local from = 1
    local delim_from, delim_to = string.find(str, delimiter, from)
    while delim_from do
		result[#result+1] = string.sub(str, from, delim_from - 1)
        from = delim_to + 1
        delim_from, delim_to = string.find(str, delimiter, from)
    end
	result[#result+1] = string.sub(str, from)
    return result
end

shared.trim = function(value)
	if not value then return nil end
    return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
end

shared.round = function(value, numDecimalPlaces)
    if not numDecimalPlaces then return math.floor(value + 0.5) end
    local power = 10 ^ numDecimalPlaces
    return math.floor((value * power) + 0.5) / (power)
end

shared.changeVehicleExtra = function (vehicle, extra, enable)
	if DoesExtraExist(vehicle, extra) then
		if enable then
			SetVehicleExtra(vehicle, extra, false)
			if not IsVehicleExtraTurnedOn(vehicle, extra) then
				shared.changeVehicleExtra(vehicle, extra, enable)
			end
		else
			SetVehicleExtra(vehicle, extra, true)
			if IsVehicleExtraTurnedOn(vehicle, extra) then
				shared.changeVehicleExtra(vehicle, extra, enable)
			end
		end
	end
end

shared.setDefaultVehicleExtras = function (vehicle, config)
    -- Clear Extras
    for i=1,20 do
        if DoesExtraExist(vehicle, i) then
            SetVehicleExtra(vehicle, i, 1)
        end
    end

    for id, enabled in pairs(config) do
        shared.changeVehicleExtra(vehicle, tonumber(id), true)
    end
end

shared.starterItems = {
    ['phone'] = { amount = 1, item = 'phone' },
    ['id_card'] = { amount = 1, item = 'id_card' },
    ['driver_license'] = { amount = 1, item = 'driver_license' },
}

shared.Items = {
	-- WEAPONS
	-- Melee
	['weapon_unarmed'] 				 = {['name'] = 'weapon_unarmed', 		 	  	['label'] = 'Fists', 					['weight'] = 1000, 		['type'] = 'weapon',	['ammotype'] = nil, 					['image'] = 'placeholder.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'Fisticuffs'},
	['weapon_dagger'] 				 = {['name'] = 'weapon_dagger', 			 	['label'] = 'Dagger', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_dagger.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A short knife with a pointed and edged blade, used as a weapon'},
	['weapon_bat'] 					 = {['name'] = 'weapon_bat', 			 	  	['label'] = 'Bat', 					    ['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_bat.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'Used for hitting a ball in sports (or other things)'},
	['weapon_bottle'] 				 = {['name'] = 'weapon_bottle', 			 	['label'] = 'Broken Bottle', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_bottle.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A broken bottle'},
	['weapon_crowbar'] 				 = {['name'] = 'weapon_crowbar', 		 	  	['label'] = 'Crowbar', 				    ['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_crowbar.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'An iron bar with a flattened end, used as a lever'},
	['weapon_flashlight']			 = {['name'] = 'weapon_flashlight',				['label'] = 'Flashlight',				['weight'] = 1000,		['type'] = 'weapon',	['ammotype'] = nil,						['image'] = 'weapon_flashlight.png',	['unique'] = true,		['useable'] = false,	['description'] = 'A battery-operated portable light'},
	['weapon_golfclub'] 			 = {['name'] = 'weapon_golfclub', 		 	  	['label'] = 'Golfclub', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_golfclub.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A club used to hit the ball in golf'},
	['weapon_hammer'] 				 = {['name'] = 'weapon_hammer', 			 	['label'] = 'Hammer', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_hammer.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'Used for jobs such as breaking things (legs) and driving in nails'},
	['weapon_hatchet'] 				 = {['name'] = 'weapon_hatchet', 		 	  	['label'] = 'Hatchet', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_hatchet.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A small axe with a short handle for use in one hand'},
	['weapon_knuckle'] 				 = {['name'] = 'weapon_knuckle', 		 	  	['label'] = 'Knuckle', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_knuckle.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A metal guard worn over the knuckles in fighting, especially to increase the effect of the blows'},
	['weapon_knife'] 				 = {['name'] = 'weapon_knife', 			 	  	['label'] = 'Knife', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_knife.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'An instrument composed of a blade fixed into a handle, used for cutting or as a weapon'},
	['weapon_machete'] 				 = {['name'] = 'weapon_machete', 		 	  	['label'] = 'Machete', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_machete.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A broad, heavy knife used as a weapon'},
	['weapon_switchblade'] 			 = {['name'] = 'weapon_switchblade', 	 	  	['label'] = 'Switchblade', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_switchblade.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A knife with a blade that springs out from the handle when a button is pressed'},
	['weapon_nightstick'] 			 = {['name'] = 'weapon_nightstick', 		 	['label'] = 'Nightstick', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_nightstick.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A police officer\'s club or billy'},
	['weapon_wrench'] 				 = {['name'] = 'weapon_wrench', 			 	['label'] = 'Wrench', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_wrench.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A tool used for gripping and turning nuts, bolts, pipes, etc'},
	['weapon_battleaxe'] 			 = {['name'] = 'weapon_battleaxe', 		 	  	['label'] = 'Battle Axe', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_battleaxe.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A large broad-bladed axe used in ancient warfare'},
	['weapon_poolcue'] 				 = {['name'] = 'weapon_poolcue', 		 	  	['label'] = 'Poolcue', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_poolcue.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A stick used to strike a ball, usually the cue ball (or other things)'},
	['weapon_briefcase'] 			 = {['name'] = 'weapon_briefcase', 		 	  	['label'] = 'Briefcase', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_briefcase.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A briefcase for storing important documents'},
	['weapon_briefcase_02'] 		 = {['name'] = 'weapon_briefcase_02', 	 	  	['label'] = 'Suitcase', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_briefcase2.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'Wonderfull for nice vacation to Liberty City'},
	['weapon_garbagebag'] 			 = {['name'] = 'weapon_garbagebag', 		 	['label'] = 'Garbage Bag', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_garbagebag.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A garbage bag'},
	['weapon_handcuffs'] 			 = {['name'] = 'weapon_handcuffs', 		 	  	['label'] = 'Handcuffs', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_handcuffs.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A pair of lockable linked metal rings for securing a prisoner\'s wrists'},
	['weapon_bread'] 				 = {['name'] = 'weapon_bread', 				 	['label'] = 'Baquette', 		        ['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'baquette.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'Bread...?'},
	['weapon_stone_hatchet'] 		 = {['name'] = 'weapon_stone_hatchet', 		 	['label'] = 'Stone Hatchet', 	        ['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_stone_hatchet.png', ['unique'] = true, 		['useable'] = true, 	['description'] = 'Stone ax'},

	-- Handguns
	['weapon_pistol'] 				 = {['name'] = 'weapon_pistol', 			 	['label'] = 'Walther P99', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_pistol.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A small firearm designed to be held in one hand'},
	['weapon_pistol_mk2'] 			 = {['name'] = 'weapon_pistol_mk2', 			['label'] = 'Pistol Mk II', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_pistol_mk2.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'An upgraded small firearm designed to be held in one hand'},
	['weapon_combatpistol'] 		 = {['name'] = 'weapon_combatpistol', 	 	  	['label'] = 'Combat Pistol', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_combatpistol.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A combat version small firearm designed to be held in one hand'},
	['weapon_appistol'] 			 = {['name'] = 'weapon_appistol', 		 	  	['label'] = 'AP Pistol', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_appistol.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A small firearm designed to be held in one hand that is automatic'},
	['weapon_stungun'] 				 = {['name'] = 'weapon_stungun', 		 	  	['label'] = 'Taser', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_stungun.png', 		 ['unique'] = true, 	['useable'] = false, 	['description'] = 'A weapon firing barbs attached by wires to batteries, causing temporary paralysis'},
	['weapon_pistol50'] 			 = {['name'] = 'weapon_pistol50', 		 	  	['label'] = 'Pistol .50', 			    ['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_pistol50.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A .50 caliber firearm designed to be held with both hands'},
	['weapon_snspistol'] 			 = {['name'] = 'weapon_snspistol', 		 	  	['label'] = 'SNS Pistol', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_snspistol.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A very small firearm designed to be easily concealed'},
	['weapon_heavypistol'] 			 = {['name'] = 'weapon_heavypistol', 	 	  	['label'] = 'Heavy Pistol', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_heavypistol.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A hefty firearm designed to be held in one hand (or attempted)'},
	['weapon_vintagepistol'] 		 = {['name'] = 'weapon_vintagepistol', 	 	  	['label'] = 'Vintage Pistol', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_vintagepistol.png', ['unique'] = true, 		['useable'] = false, 	['description'] = 'An antique firearm designed to be held in one hand'},
	['weapon_flaregun'] 			 = {['name'] = 'weapon_flaregun', 		 	  	['label'] = 'Flare Gun', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_FLARE',			['image'] = 'weapon_flaregun.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A handgun for firing signal rockets'},
	['weapon_marksmanpistol'] 		 = {['name'] = 'weapon_marksmanpistol', 	 	['label'] = 'Marksman Pistol', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_marksmanpistol.png', ['unique'] = true, 	['useable'] = false, 	['description'] = 'A very accurate small firearm designed to be held in one hand'},
	['weapon_revolver'] 			 = {['name'] = 'weapon_revolver', 		 	  	['label'] = 'Revolver', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_revolver.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A pistol with revolving chambers enabling several shots to be fired without reloading'},
	['weapon_revolver_mk2'] 		 = {['name'] = 'weapon_revolver_mk2', 		 	['label'] = 'Violence', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_revolver_mk2.png', 	['unique'] = true, 		['useable'] = true, 	['description'] = 'da Violence'},
	['weapon_doubleaction'] 	     = {['name'] = 'weapon_doubleaction', 		 	['label'] = 'Double Action Revolver', 	['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_doubleaction.png', 	['unique'] = true, 		['useable'] = true, 	['description'] = 'Double Action Revolver'},
	['weapon_snspistol_mk2'] 	     = {['name'] = 'weapon_snspistol_mk2', 		 	['label'] = 'SNS Pistol Mk II', 		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_snspistol_mk2.png', ['unique'] = true, 		['useable'] = true, 	['description'] = 'SNS Pistol MK2'},
	['weapon_raypistol']			 = {['name'] = 'weapon_raypistol',				['label'] = 'Up-n-Atomizer',			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_raypistol.png',		['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Raypistol'},
	['weapon_ceramicpistol']		 = {['name'] = 'weapon_ceramicpistol', 		 	['label'] = 'Ceramic Pistol',		    ['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_ceramicpistol.png',	['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Ceramicpistol'},
	['weapon_navyrevolver']        	 = {['name'] = 'weapon_navyrevolver', 		 	['label'] = 'Navy Revolver',		    ['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_navyrevolver.png',	['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Navyrevolver'},
	['weapon_gadgetpistol'] 		 = {['name'] = 'weapon_gadgetpistol', 		 	['label'] = 'Perico Pistol',		    ['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_gadgetpistol.png',	['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Gadgetpistol'},

	-- Submachine Guns
	['weapon_microsmg'] 			 = {['name'] = 'weapon_microsmg', 		 	  	['label'] = 'Micro SMG', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SMG',				['image'] = 'weapon_microsmg.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A handheld lightweight machine gun'},
	['weapon_smg'] 				 	 = {['name'] = 'weapon_smg', 			 	  	['label'] = 'SMG', 						['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SMG',				['image'] = 'weapon_smg.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'A handheld lightweight machine gun'},
	['weapon_smg_mk2'] 				 = {['name'] = 'weapon_smg_mk2', 			 	['label'] = 'SMG Mk II', 				['weight'] = 1000,		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SMG',				['image'] = 'weapon_smg_mk2.png', 		['unique'] = true, 		['useable'] = true, 	['description'] = 'SMG MK2'},
	['weapon_assaultsmg'] 			 = {['name'] = 'weapon_assaultsmg', 		 	['label'] = 'Assault SMG', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SMG',				['image'] = 'weapon_assaultsmg.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'An assault version of a handheld lightweight machine gun'},
	['weapon_combatpdw'] 			 = {['name'] = 'weapon_combatpdw', 		 	  	['label'] = 'Combat PDW', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SMG',				['image'] = 'weapon_combatpdw.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A combat version of a handheld lightweight machine gun'},
	['weapon_machinepistol'] 		 = {['name'] = 'weapon_machinepistol', 	 	  	['label'] = 'Tec-9', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_machinepistol.png', ['unique'] = true, 		['useable'] = false, 	['description'] = 'A self-loading pistol capable of burst or fully automatic fire'},
	['weapon_minismg'] 				 = {['name'] = 'weapon_minismg', 		 	  	['label'] = 'Mini SMG', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SMG',				['image'] = 'weapon_minismg.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A mini handheld lightweight machine gun'},
	['weapon_raycarbine']	         = {['name'] = 'weapon_raycarbine', 		 	['label'] = 'Unholy Hellbringer',		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SMG',				['image'] = 'weapon_raycarbine.png',	['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Raycarbine'},

	-- Shotguns
	['weapon_pumpshotgun'] 			 = {['name'] = 'weapon_pumpshotgun', 	 	  	['label'] = 'Pump Shotgun', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'weapon_pumpshotgun.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A pump-action smoothbore gun for firing small shot at short range'},
	['weapon_sawnoffshotgun'] 		 = {['name'] = 'weapon_sawnoffshotgun', 	 	['label'] = 'Sawn-off Shotgun', 		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'weapon_sawnoffshotgun.png', ['unique'] = true, 	['useable'] = false, 	['description'] = 'A sawn-off smoothbore gun for firing small shot at short range'},
	['weapon_assaultshotgun'] 		 = {['name'] = 'weapon_assaultshotgun', 	 	['label'] = 'Assault Shotgun', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'weapon_assaultshotgun.png', ['unique'] = true, 	['useable'] = false, 	['description'] = 'An assault version of asmoothbore gun for firing small shot at short range'},
	['weapon_bullpupshotgun'] 		 = {['name'] = 'weapon_bullpupshotgun', 	 	['label'] = 'Bullpup Shotgun', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'weapon_bullpupshotgun.png', ['unique'] = true, 	['useable'] = false, 	['description'] = 'A compact smoothbore gun for firing small shot at short range'},
	['weapon_musket'] 			     = {['name'] = 'weapon_musket', 			 	['label'] = 'Musket', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'weapon_musket.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'An infantryman\'s light gun with a long barrel, typically smooth-bored, muzzleloading, and fired from the shoulder'},
	['weapon_heavyshotgun'] 		 = {['name'] = 'weapon_heavyshotgun', 	 	  	['label'] = 'Heavy Shotgun', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'weapon_heavyshotgun.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A large smoothbore gun for firing small shot at short range'},
	['weapon_dbshotgun'] 			 = {['name'] = 'weapon_dbshotgun', 		 	  	['label'] = 'Double-barrel Shotgun', 	['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'weapon_dbshotgun.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A shotgun with two parallel barrels, allowing two single shots to be fired in quick succession'},
	['weapon_autoshotgun'] 			 = {['name'] = 'weapon_autoshotgun', 	 	  	['label'] = 'Auto Shotgun', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'weapon_autoshotgun.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A shotgun capable of rapid continous fire'},
	['weapon_pumpshotgun_mk2']		 = {['name'] = 'weapon_pumpshotgun_mk2',		['label'] = 'Pumpshotgun Mk II', 		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'weapon_pumpshotgun_mk2.png', ['unique'] = true, 	['useable'] = true, 	['description'] = 'Pumpshotgun MK2'},
	['weapon_combatshotgun']		 = {['name'] = 'weapon_combatshotgun', 		 	['label'] = 'Combat Shotgun',		    ['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'weapon_combatshotgun.png', ['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Combatshotgun'},

	-- Assault Rifles
	['weapon_assaultrifle'] 		 = {['name'] = 'weapon_assaultrifle', 	 	  	['label'] = 'Assault Rifle', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'weapon_assaultrifle.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A rapid-fire, magazine-fed automatic rifle designed for infantry use'},
	['weapon_assaultrifle_mk2'] 	 = {['name'] = 'weapon_assaultrifle_mk2', 	 	['label'] = 'Assault Rifle Mk II', 		['weight'] = 1000,		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'weapon_assaultrifle_mk2.png', ['unique'] = true, 	['useable'] = true, 	['description'] = 'Assault Rifle MK2'},
	['weapon_carbinerifle'] 		 = {['name'] = 'weapon_carbinerifle', 	 	  	['label'] = 'Carbine Rifle', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'weapon_carbinerifle.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A lightweight automatic rifle'},
	['weapon_carbinerifle_mk2'] 	 = {['name'] = 'weapon_carbinerifle_mk2', 	 	['label'] = 'Carbine Rifle Mk II', 		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'weapon_carbinerifle_mk2.png', ['unique'] = true, 	['useable'] = true, 	['description'] = 'Carbine Rifle MK2'},
	['weapon_advancedrifle'] 		 = {['name'] = 'weapon_advancedrifle', 	 	  	['label'] = 'Advanced Rifle', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'weapon_advancedrifle.png', ['unique'] = true, 		['useable'] = false, 	['description'] = 'An assault version of a rapid-fire, magazine-fed automatic rifle designed for infantry use'},
	['weapon_specialcarbine'] 		 = {['name'] = 'weapon_specialcarbine', 	 	['label'] = 'Special Carbine', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'weapon_specialcarbine.png', ['unique'] = true, 	['useable'] = false, 	['description'] = 'An extremely versatile assault rifle for any combat situation'},
	['weapon_bullpuprifle'] 		 = {['name'] = 'weapon_bullpuprifle', 	 	  	['label'] = 'Bullpup Rifle', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'weapon_bullpuprifle.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A compact automatic assault rifle'},
	['weapon_compactrifle'] 		 = {['name'] = 'weapon_compactrifle', 	 	  	['label'] = 'Compact Rifle', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'weapon_compactrifle.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A compact version of an assault rifle'},
	['weapon_specialcarbine_mk2']	 = {['name'] = 'weapon_specialcarbine_mk2', 	['label'] = 'Special Carbine Mk II',    ['weight'] = 1000, 	    ['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'weapon_specialcarbine_mk2.png', ['unique'] = true, ['useable'] = true, 	['description'] = 'Weapon Wpecialcarbine MK2'},
	['weapon_bullpuprifle_mk2']		 = {['name'] = 'weapon_bullpuprifle_mk2', 		['label'] = 'Bullpup Rifle Mk II',		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'weapon_bullpuprifle_mk2.png', ['unique'] = true, 	['useable'] = true, 	['description'] = 'Bull Puprifle MK2'},
	['weapon_militaryrifle']		 = {['name'] = 'weapon_militaryrifle', 		 	['label'] = 'Military Rifle',		    ['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'weapon_militaryrifle.png', ['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Militaryrifle'},

	-- Light Machine Guns
	['weapon_mg'] 					 = {['name'] = 'weapon_mg', 				 	['label'] = 'Machinegun', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',				['image'] = 'weapon_mg.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'An automatic gun that fires bullets in rapid succession for as long as the trigger is pressed'},
	['weapon_combatmg'] 			 = {['name'] = 'weapon_combatmg', 		 	  	['label'] = 'Combat MG', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',				['image'] = 'weapon_combatmg.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A combat version of an automatic gun that fires bullets in rapid succession for as long as the trigger is pressed'},
	['weapon_gusenberg'] 			 = {['name'] = 'weapon_gusenberg', 		 	  	['label'] = 'Thompson SMG', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',				['image'] = 'weapon_gusenberg.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'An automatic rifle commonly referred to as a tommy gun'},
	['weapon_combatmg_mk2']	 		 = {['name'] = 'weapon_combatmg_mk2', 		 	['label'] = 'Combat MG Mk II',		    ['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',				['image'] = 'weapon_combatmg_mk2.png', 	['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Combatmg MK2'},

	-- Sniper Rifles
	['weapon_sniperrifle'] 			 = {['name'] = 'weapon_sniperrifle', 	 	  	['label'] = 'Sniper Rifle', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SNIPER',			['image'] = 'weapon_sniperrifle.png', 	 ['unique'] = true, 	['useable'] = false, 	['description'] = 'A high-precision, long-range rifle'},
	['weapon_heavysniper'] 			 = {['name'] = 'weapon_heavysniper', 	 	  	['label'] = 'Heavy Sniper', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SNIPER',			['image'] = 'weapon_heavysniper.png', 	 ['unique'] = true, 	['useable'] = false, 	['description'] = 'An upgraded high-precision, long-range rifle'},
	['weapon_marksmanrifle'] 		 = {['name'] = 'weapon_marksmanrifle', 	 	  	['label'] = 'Marksman Rifle', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SNIPER',			['image'] = 'weapon_marksmanrifle.png', ['unique'] = true, 		['useable'] = false, 	['description'] = 'A very accurate single-fire rifle'},
	['weapon_remotesniper'] 		 = {['name'] = 'weapon_remotesniper', 	 	  	['label'] = 'Remote Sniper', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SNIPER_REMOTE',	['image'] = 'weapon_remotesniper.png', 	 ['unique'] = true, 	['useable'] = false, 	['description'] = 'A portable high-precision, long-range rifle'},
	['weapon_heavysniper_mk2']		 = {['name'] = 'weapon_heavysniper_mk2', 		['label'] = 'Heavy Sniper Mk II',	    ['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SNIPER',			['image'] = 'weapon_heavysniper_mk2.png', ['unique'] = true, 	['useable'] = true, 	['description'] = 'Weapon Heavysniper MK2'},
	['weapon_marksmanrifle_mk2']	 = {['name'] = 'weapon_marksmanrifle_mk2', 		['label'] = 'Marksman Rifle Mk II',	    ['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SNIPER',			['image'] = 'weapon_marksmanrifle_mk2.png',	['unique'] = true, 	['useable'] = true, 	['description'] = 'Weapon Marksmanrifle MK2'},

	-- Heavy Weapons
	['weapon_rpg'] 					 = {['name'] = 'weapon_rpg', 			      	['label'] = 'RPG', 						['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RPG',				['image'] = 'weapon_rpg.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'A rocket-propelled grenade launcher'},
	['weapon_grenadelauncher'] 		 = {['name'] = 'weapon_grenadelauncher', 	  	['label'] = 'Grenade Launcher', 		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_GRENADELAUNCHER',	['image'] = 'weapon_grenadelauncher.png', ['unique'] = true, 	['useable'] = false, 	['description'] = 'A weapon that fires a specially-designed large-caliber projectile, often with an explosive, smoke or gas warhead'},
	['weapon_grenadelauncher_smoke'] = {['name'] = 'weapon_grenadelauncher_smoke', 	['label'] = 'Smoke Grenade Launcher', 	['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_GRENADELAUNCHER',	['image'] = 'weapon_smokegrenade.png', 	 ['unique'] = true, 	['useable'] = false, 	['description'] = 'A bomb that produces a lot of smoke when it explodes'},
	['weapon_minigun'] 				 = {['name'] = 'weapon_minigun', 		      	['label'] = 'Minigun', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MINIGUN',			['image'] = 'weapon_minigun.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A portable machine gun consisting of a rotating cluster of six barrels and capable of variable rates of fire of up to 6,000 rounds per minute'},
	['weapon_firework'] 			 = {['name'] = 'weapon_firework', 		 	  	['label'] = 'Firework Launcher', 		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_firework.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A device containing gunpowder and other combustible chemicals that causes a spectacular explosion when ignited'},
	['weapon_railgun'] 				 = {['name'] = 'weapon_railgun', 		 	  	['label'] = 'Railgun', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_railgun.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A weapon that uses electromagnetic force to launch high velocity projectiles'},
	['weapon_hominglauncher'] 		 = {['name'] = 'weapon_hominglauncher', 	 	['label'] = 'Homing Launcher', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_STINGER',			['image'] = 'weapon_hominglauncher.png', ['unique'] = true, 	['useable'] = false, 	['description'] = 'A weapon fitted with an electronic device that enables it to find and hit a target'},
	['weapon_compactlauncher'] 		 = {['name'] = 'weapon_compactlauncher',  	  	['label'] = 'Compact Launcher', 		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_compactlauncher.png', 	['unique'] = true, 	['useable'] = false, 	['description'] = 'A compact grenade launcher'},
	['weapon_rayminigun']			 = {['name'] = 'weapon_rayminigun', 		 	['label'] = 'Widowmaker',		        ['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MINIGUN',			['image'] = 'weapon_rayminigun.png',	['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Rayminigun'},

	-- Throwables
	['weapon_grenade'] 				 = {['name'] = 'weapon_grenade', 		      	['label'] = 'Grenade', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_grenade.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A handheld throwable bomb'},
	['weapon_bzgas'] 				 = {['name'] = 'weapon_bzgas', 			      	['label'] = 'BZ Gas', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_bzgas.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A cannister of gas that causes extreme pain'},
	['weapon_molotov'] 				 = {['name'] = 'weapon_molotov', 		      	['label'] = 'Molotov', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_molotov.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A crude bomb made of a bottle filled with a flammable liquid and fitted with a wick for lighting'},
	['weapon_stickybomb'] 			 = {['name'] = 'weapon_stickybomb', 		    ['label'] = 'C4', 						['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_stickybomb.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'An explosive charge covered with an adhesive that when thrown against an object sticks until it explodes'},
	['weapon_proxmine'] 			 = {['name'] = 'weapon_proxmine', 		 	  	['label'] = 'Proxmine Grenade', 		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_proximitymine.png', ['unique'] = true, 		['useable'] = false, 	['description'] = 'A bomb placed on the ground that detonates when going within its proximity'},
	['weapon_snowball'] 		     = {['name'] = 'weapon_snowball', 		 	  	['label'] = 'Snowball', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_snowball.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A ball of packed snow, especially one made for throwing at other people for fun'},
	['weapon_pipebomb'] 			 = {['name'] = 'weapon_pipebomb', 		 	  	['label'] = 'Pipe Bomb', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_pipebomb.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A homemade bomb, the components of which are contained in a pipe'},
	['weapon_ball'] 				 = {['name'] = 'weapon_ball', 			 	  	['label'] = 'Ball', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_BALL',				['image'] = 'weapon_ball.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'A solid or hollow spherical or egg-shaped object that is kicked, thrown, or hit in a game'},
	['weapon_smokegrenade'] 		 = {['name'] = 'weapon_smokegrenade', 	      	['label'] = 'Smoke Grenade', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_c4.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'An explosive charge that can be remotely detonated'},
	['weapon_flare'] 				 = {['name'] = 'weapon_flare', 			 	  	['label'] = 'Flare pistol', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_FLARE',			['image'] = 'weapon_flare.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A small pyrotechnic devices used for illumination and signalling'},

	-- Miscellaneous
	['weapon_petrolcan'] 			 = {['name'] = 'weapon_petrolcan', 		 	  	['label'] = 'Petrol Can', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PETROLCAN',		['image'] = 'weapon_petrolcan.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A robust liquid container made from pressed steel'},
	['weapon_fireextinguisher'] 	 = {['name'] = 'weapon_fireextinguisher',      	['label'] = 'Fire Extinguisher', 		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_fireextinguisher.png', 	['unique'] = true, 	['useable'] = false, 	['description'] = 'A portable device that discharges a jet of water, foam, gas, or other material to extinguish a fire'},
	['weapon_hazardcan']			 = {['name'] = 'weapon_hazardcan',				['label'] = 'Hazardous Jerry Can',		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PETROLCAN',		['image'] = 'weapon_hazardcan.png',		['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Hazardcan'},

	-- PISTOL ATTACHMENTS
	['pistol_defaultclip'] 			 = {['name'] = 'pistol_defaultclip', 			['label'] = 'Pistol Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Pistol Default Clip'},
	['pistol_extendedclip'] 		 = {['name'] = 'pistol_extendedclip', 			['label'] = 'Pistol EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Pistol Extended Clip'},
	['pistol_flashlight'] 			 = {['name'] = 'pistol_flashlight', 			['label'] = 'Pistol Flashlight', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'smg_flashlight.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Pistol Flashlight Attachment'},
	['pistol_suppressor'] 			 = {['name'] = 'pistol_suppressor', 			['label'] = 'Pistol Suppressor', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Pistol Suppressor Attachment'},
	['pistol_luxuryfinish'] 	     = {['name'] = 'pistol_luxuryfinish', 			['label'] = 'Pistol Finish', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Pistol Luxury Finish'},
	['combatpistol_defaultclip'] 	 = {['name'] = 'combatpistol_defaultclip', 		['label'] = 'Pistol Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Combat Pistol Default Clip'},
	['combatpistol_extendedclip']    = {['name'] = 'combatpistol_extendedclip', 	['label'] = 'Pistol EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Combat Pistol Extended Clip'},
	['combatpistol_luxuryfinish'] 	 = {['name'] = 'combatpistol_luxuryfinish', 	['label'] = 'Pistol Finish', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Combat Pistol Luxury Finish'},
	['appistol_defaultclip'] 		 = {['name'] = 'appistol_defaultclip', 			['label'] = 'Pistol Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'APPistol Default Clip'},
	['appistol_extendedclip'] 		 = {['name'] = 'appistol_extendedclip', 		['label'] = 'Pistol EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'APPistol Extended Clip'},
	['appistol_luxuryfinish'] 	     = {['name'] = 'appistol_luxuryfinish', 		['label'] = 'Pistol Finish', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'APPistol Luxury Finish'},
	['pistol50_defaultclip'] 		 = {['name'] = 'pistol50_defaultclip', 			['label'] = 'Pistol Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = '.50 Pistol Default Clip'},
	['pistol50_extendedclip'] 		 = {['name'] = 'pistol50_extendedclip', 		['label'] = 'Pistol EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = '.50 Pistol Extended Clip'},
	['pistol50_luxuryfinish'] 	     = {['name'] = 'pistol50_luxuryfinish', 		['label'] = 'Pistol Finish', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = '.50 Pistol Luxury Finish'},
	['revolver_defaultclip'] 		 = {['name'] = 'revolver_defaultclip', 			['label'] = 'Pistol Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Revovler Default Clip'},
	['revolver_vipvariant'] 		 = {['name'] = 'revolver_vipvariant', 		    ['label'] = 'Pistol Variant', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Revovler Variant'},
	['revolver_bodyguardvariant'] 	 = {['name'] = 'revolver_bodyguardvariant', 	['label'] = 'Pistol Variant', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Revovler Variant'},
	['snspistol_defaultclip'] 		 = {['name'] = 'snspistol_defaultclip', 		['label'] = 'Pistol Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'SNS Pistol Default Clip'},
	['snspistol_extendedclip'] 		 = {['name'] = 'snspistol_extendedclip', 		['label'] = 'Pistol EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'SNS Pistol Extended Clip'},
	['snspistol_grip'] 	             = {['name'] = 'snspistol_grip', 		        ['label'] = 'Pistol Grip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'SNS Pistol Grip Attachment'},
	['heavypistol_defaultclip'] 	 = {['name'] = 'heavypistol_defaultclip', 		['label'] = 'Pistol Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Heavy Pistol Default Clip'},
	['heavypistol_extendedclip'] 	 = {['name'] = 'heavypistol_extendedclip', 		['label'] = 'Pistol EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Heavy Pistol Extended Clip'},
	['heavypistol_grip'] 	         = {['name'] = 'heavypistol_grip', 		        ['label'] = 'Pistol Grip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Heavy Pistol Grip Attachment'},
	['vintagepistol_defaultclip'] 	 = {['name'] = 'vintagepistol_defaultclip', 	['label'] = 'Pistol Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Vintage Pistol Default Clip'},
	['vintagepistol_extendedclip'] 	 = {['name'] = 'vintagepistol_extendedclip', 	['label'] = 'Pistol EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Vintage Pistol Default Clip'},

	-- SMG ATTACHMENTS
	['microsmg_defaultclip'] 	     = {['name'] = 'microsmg_defaultclip', 			['label'] = 'SMG Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Micro SMG Default Clip'},
	['microsmg_extendedclip'] 		 = {['name'] = 'microsmg_extendedclip', 		['label'] = 'SMG EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Micro SMG Extended Clip'},
	['microsmg_scope'] 			     = {['name'] = 'microsmg_scope', 			    ['label'] = 'SMG Scope', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'smg_scope.png', 			['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Micro SMG Scope Attachment'},
	['microsmg_luxuryfinish'] 	     = {['name'] = 'microsmg_luxuryfinish', 		['label'] = 'SMG Finish', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Micro SMG Luxury Finish'},
	['smg_defaultclip'] 	         = {['name'] = 'smg_defaultclip', 			    ['label'] = 'SMG Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'SMG Default Clip'},
	['smg_extendedclip'] 	         = {['name'] = 'smg_extendedclip', 		        ['label'] = 'SMG EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'SMG Extended Clip'},
	['smg_drum']                     = {['name'] = 'smg_drum', 	                    ['label'] = 'SMG Drum', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'rifle_drummag.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'SMG Drum'},
	['smg_scope'] 	                 = {['name'] = 'smg_scope', 	                ['label'] = 'SMG Scope', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'smg_scope.png', 			['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'SMG Scope Attachment'},
	['smg_luxuryfinish'] 		     = {['name'] = 'smg_luxuryfinish', 			    ['label'] = 'SMG Finish', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'SMG Luxury Finish'},
	['assaultsmg_defaultclip'] 		 = {['name'] = 'assaultsmg_defaultclip', 		['label'] = 'SMG Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Assault SMG Default Clip'},
	['assaultsmg_extendedclip'] 	 = {['name'] = 'assaultsmg_extendedclip', 		['label'] = 'SMG EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Assault SMG Extended Clip'},
	['assaultsmg_luxuryfinish']      = {['name'] = 'assaultsmg_luxuryfinish', 		['label'] = 'SMG Finish', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Assault SMG Luxury Finish'},
	['minismg_defaultclip'] 		 = {['name'] = 'minismg_defaultclip', 		    ['label'] = 'SMG Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Mini SMG Default Clip'},
	['minismg_extendedclip'] 	     = {['name'] = 'minismg_extendedclip', 		    ['label'] = 'SMG EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Mini SMG Extended Clip'},
	['machinepistol_defaultclip']    = {['name'] = 'machinepistol_defaultclip', 	['label'] = 'SMG Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Machine Pistol Default Clip'},
	['machinepistol_extendedclip']   = {['name'] = 'machinepistol_extendedclip', 	['label'] = 'SMG EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Machine Pistol Extended Clip'},
	['machinepistol_drum'] 	         = {['name'] = 'machinepistol_drum', 	        ['label'] = 'SMG Drum', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'rifle_drummag.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Machine Pistol Drum'},
	['combatpdw_defaultclip'] 		 = {['name'] = 'combatpdw_defaultclip', 		['label'] = 'SMG Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Combat PDW Default Clip'},
	['combatpdw_extendedclip'] 		 = {['name'] = 'combatpdw_extendedclip', 		['label'] = 'SMG EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Combat PDW Extended Clip'},
	['combatpdw_drum'] 	             = {['name'] = 'combatpdw_drum', 		        ['label'] = 'SMG Drum', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'rifle_drummag.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Combat PDW Drum'},
	['combatpdw_grip'] 	             = {['name'] = 'combatpdw_grip', 				['label'] = 'SMG Grip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Combat PDW Grip Attachment'},
	['combatpdw_scope'] 	         = {['name'] = 'combatpdw_scope', 				['label'] = 'SMG Scope', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'smg_scope.png', 			['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Combat PDW Scope Attachment'},

	-- SHOTGUN ATTACHMENTS
	['shotgun_suppressor'] 	         = {['name'] = 'shotgun_suppressor', 			['label'] = 'Shotgun Suppressor', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Shotgun Suppressor Attachment'},
	['pumpshotgun_luxuryfinish'] 	 = {['name'] = 'pumpshotgun_luxuryfinish', 		['label'] = 'Shotgun Finish', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Pump Shotgun Luxury Finish'},
	['sawnoffshotgun_luxuryfinish']  = {['name'] = 'sawnoffshotgun_luxuryfinish', 	['label'] = 'Shotgun Finish', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Sawn Off Shotgun Luxury Finish'},
	['assaultshotgun_defaultclip'] 	 = {['name'] = 'assaultshotgun_defaultclip', 	['label'] = 'Shotgun Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Assault Shotgun Default Clip'},
	['assaultshotgun_extendedclip']  = {['name'] = 'assaultshotgun_extendedclip', 	['label'] = 'Shotgun EXT Clip', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Assault Shotgun Extended Clip'},
	['heavyshotgun_defaultclip'] 	 = {['name'] = 'heavyshotgun_defaultclip', 		['label'] = 'Shotgun Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Heavy Shotgun Default Clip'},
	['heavyshotgun_extendedclip']    = {['name'] = 'heavyshotgun_extendedclip', 	['label'] = 'Shotgun EXT Clip', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Heavy Shotgun Extended Clip'},
	['heavyshotgun_drum'] 	         = {['name'] = 'heavyshotgun_drum', 	        ['label'] = 'Shotgun Drum', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'rifle_drummag.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Heavy Shotgun Drum'},

	-- RIFLE ATTACHMENTS
	['assaultrifle_defaultclip'] 	 = {['name'] = 'assaultrifle_defaultclip', 		['label'] = 'Rifle Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Assault Rifle Default Clip'},
	['assaultrifle_extendedclip']    = {['name'] = 'assaultrifle_extendedclip', 	['label'] = 'Rifle EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Assault Rifle Extended Clip'},
	['assaultrifle_drum'] 			 = {['name'] = 'assaultrifle_drum', 			['label'] = 'Rifle Drum', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'rifle_drummag.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Assault Rifle Drum'},
	['rifle_flashlight'] 	         = {['name'] = 'rifle_flashlight', 		        ['label'] = 'Rifle Flashlight', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'smg_flashlight.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Rifle Flashlight Attachment'},
	['rifle_grip'] 	                 = {['name'] = 'rifle_grip', 			        ['label'] = 'Rifle Grip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Rifle Grip Attachment'},
	['rifle_suppressor'] 	         = {['name'] = 'rifle_suppressor', 		        ['label'] = 'Rifle Suppressor', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Rifle Suppressor Attachment'},
	['assaultrifle_luxuryfinish'] 	 = {['name'] = 'assaultrifle_luxuryfinish',     ['label'] = 'Rifle Finish', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Assault Rifle Luxury Finish'},
	['carbinerifle_defaultclip']     = {['name'] = 'carbinerifle_defaultclip', 	    ['label'] = 'Rifle Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Carbine Rifle Default Clip'},
	['carbinerifle_extendedclip'] 	 = {['name'] = 'carbinerifle_extendedclip', 	['label'] = 'Rifle EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Carbine Rifle Extended Clip'},
	['carbinerifle_drum'] 		     = {['name'] = 'carbinerifle_drum', 			['label'] = 'Rifle Drum', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'rifle_drummag.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Carbine Rifle Drum'},
	['carbinerifle_scope'] 		     = {['name'] = 'carbinerifle_scope', 		    ['label'] = 'Rifle Scope', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'smg_scope.png', 			['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Carbine Rifle Scope'},
	['carbinerifle_luxuryfinish'] 	 = {['name'] = 'carbinerifle_luxuryfinish', 	['label'] = 'Rifle Finish', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Carbine Rifle Luxury Finish'},
	['advancedrifle_defaultclip']    = {['name'] = 'advancedrifle_defaultclip', 	['label'] = 'Rifle Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Advanced Rifle Default Clip'},
	['advancedrifle_extendedclip'] 	 = {['name'] = 'advancedrifle_extendedclip',    ['label'] = 'Rifle EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Advanced Rifle Extended Clip'},
	['advancedrifle_luxuryfinish'] 	 = {['name'] = 'advancedrifle_luxuryfinish', 	['label'] = 'Rifle Finish', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Advanced Rifle Luxury Finish'},
	['specialcarbine_defaultclip']   = {['name'] = 'specialcarbine_defaultclip', 	['label'] = 'Rifle Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Special Carbine Default Clip'},
	['specialcarbine_extendedclip']  = {['name'] = 'specialcarbine_extendedclip', 	['label'] = 'Rifle EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Special Carbine Extended Clip'},
	['specialcarbine_drum'] 	     = {['name'] = 'specialcarbine_drum', 	        ['label'] = 'Rifle Drum', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'rifle_drummag.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Special Carbine Drum'},
	['specialcarbine_luxuryfinish']  = {['name'] = 'specialcarbine_luxuryfinish', 	['label'] = 'Rifle Finish', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Special Carbine Luxury Finish'},
	['bullpuprifle_defaultclip']     = {['name'] = 'bullpuprifle_defaultclip', 		['label'] = 'Rifle Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Bullpup Rifle Default Clip'},
	['bullpuprifle_extendedclip'] 	 = {['name'] = 'bullpuprifle_extendedclip', 	['label'] = 'Rifle EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Bullpup Rifle Extended Clip'},
	['bullpuprifle_luxuryfinish'] 	 = {['name'] = 'bullpuprifle_luxuryfinish', 	['label'] = 'Rifle Finish', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Bullpup Rifle Luxury Finish'},
	['compactrifle_defaultclip'] 	 = {['name'] = 'compactrifle_defaultclip', 		['label'] = 'Rifle Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Compact Rifle Default Clip'},
	['compactrifle_extendedclip'] 	 = {['name'] = 'compactrifle_extendedclip', 	['label'] = 'Rifle EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Compact Rifle Extended Clip'},
	['compactrifle_drum'] 	         = {['name'] = 'compactrifle_drum', 		    ['label'] = 'Rifle Drum', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'rifle_drummag.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Compact Rifle Drum'},
	['gusenberg_defaultclip'] 	     = {['name'] = 'gusenberg_defaultclip', 		['label'] = 'Rifle Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Gusenberg Default Clip'},
	['gusenberg_extendedclip'] 	     = {['name'] = 'gusenberg_extendedclip', 		['label'] = 'Rifle EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Gusenberg Extended Clip'},

	-- SNIPER ATTACHMENTS
	['sniperrifle_defaultclip'] 	 = {['name'] = 'sniperrifle_defaultclip', 		['label'] = 'Sniper Suppressor', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Sniper Rifle Default Clip'},
	['sniper_scope'] 	             = {['name'] = 'sniper_scope', 		            ['label'] = 'Sniper Scope', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'smg_scope.png', 			['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Sniper Rifle Scope Attachment'},
	['snipermax_scope']              = {['name'] = 'snipermax_scope', 	            ['label'] = 'Sniper Max Scope', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'smg_scope.png', 			['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Sniper Rifle Max Scope Attachment'},
	['sniper_grip'] 	             = {['name'] = 'sniper_grip', 	                ['label'] = 'Sniper Grip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Sniper Rifle Grip Attachment'},
	['heavysniper_defaultclip']      = {['name'] = 'heavysniper_defaultclip', 	    ['label'] = 'Sniper Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Heavy Sniper Default Clip'},
	['marksmanrifle_defaultclip'] 	 = {['name'] = 'marksmanrifle_defaultclip', 	['label'] = 'Sniper Clip', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Marksman Rifle Default Clip'},
	['marksmanrifle_extendedclip']   = {['name'] = 'marksmanrifle_extendedclip', 	['label'] = 'Sniper EXT Clip', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_extendedclip.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Marksman Rifle Extended Clip'},
	['marksmanrifle_scope'] 	     = {['name'] = 'marksmanrifle_scope', 	        ['label'] = 'Sniper Scope', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'smg_scope.png', 			['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Marksman Rifle Scope Attachment'},
	['marksmanrifle_luxuryfinish'] 	 = {['name'] = 'marksmanrifle_luxuryfinish', 	['label'] = 'Sniper Finish', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pistol_suppressor.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Marksman Rifle Luxury Finish'},

	-- Weapon Tints
	['weapontint_black']             = {['name'] = 'weapontint_black', 	            ['label'] = 'Default Tint', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'weapontint_black.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Default/Black Weapon Tint'},
	['weapontint_green'] 	         = {['name'] = 'weapontint_green', 	            ['label'] = 'Green Tint', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'weapontint_green.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Green Weapon Tint'},
	['weapontint_gold']      		 = {['name'] = 'weapontint_gold', 	    		['label'] = 'Gold Tint', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'weapontint_gold.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Gold Weapon Tint'},
	['weapontint_pink'] 	 		 = {['name'] = 'weapontint_pink', 				['label'] = 'Pink Tint', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'weapontint_pink.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Pink Weapon Tint'},
	['weapontint_army']   			 = {['name'] = 'weapontint_army', 				['label'] = 'Army Tint', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'weapontint_army.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Army Weapon Tint'},
	['weapontint_lspd'] 	     	 = {['name'] = 'weapontint_lspd', 	        	['label'] = 'LSPD Tint', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'weapontint_lspd.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'LSPD Weapon Tint'},
	['weapontint_orange'] 	 		 = {['name'] = 'weapontint_orange', 			['label'] = 'Orange Tint', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'weapontint_orange.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Orange Weapon Tint'},
	['weapontint_plat'] 	 		 = {['name'] = 'weapontint_plat', 				['label'] = 'Platinum Tint', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'weapontint_plat.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Platinum Weapon Tint'},

	-- ITEMS

	-- Ammo ITEMS
	['pistol_ammo'] 				 = {['name'] = 'pistol_ammo', 			  	  	['label'] = 'Pistol ammo', 				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'pistol_ammo.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Ammo for Pistols'},
	['rifle_ammo'] 				 	 = {['name'] = 'rifle_ammo', 			  	  	['label'] = 'Rifle ammo', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'rifle_ammo.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Ammo for Rifles'},
	['smg_ammo'] 				 	 = {['name'] = 'smg_ammo', 			  	  		['label'] = 'SMG ammo', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'smg_ammo.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Ammo for Sub Machine Guns'},
	['shotgun_ammo'] 				 = {['name'] = 'shotgun_ammo', 			  	  	['label'] = 'Shotgun ammo', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'shotgun_ammo.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Ammo for Shotguns'},
	['mg_ammo'] 				 	 = {['name'] = 'mg_ammo', 			  	  		['label'] = 'MG ammo', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'mg_ammo.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Ammo for Machine Guns'},
	['snp_ammo'] 				 	 = {['name'] = 'snp_ammo', 			  	  		['label'] = 'Sniper ammo', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'rifle_ammo.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Ammo for Sniper Rifles'},

	-- Card ITEMS
	['id_card'] 					 = {['name'] = 'id_card', 			 	  	  	['label'] = 'ID Card', 					['weight'] = 0, 		['type'] = 'item', 		['image'] = 'id_card.png', 				['unique'] = true, 		['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'A card containing all your information to identify yourself'},
	['driver_license'] 				 = {['name'] = 'driver_license', 			  	['label'] = 'Drivers License', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'driver_license.png', 		['unique'] = true, 		['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Permit to show you can drive a vehicle'},
	['lawyerpass'] 					 = {['name'] = 'lawyerpass', 			 	  	['label'] = 'Lawyer Pass', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'lawyerpass.png', 			['unique'] = true, 		['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Pass exclusive to lawyers to show they can represent a suspect'},
	['weaponlicense'] 				 = {['name'] = 'weaponlicense',				    ['label'] = 'Weapon License',			['weight'] = 0,			['type'] = 'item',		['image'] = 'weapon_license.png',		['unique'] = true,		['useable'] = true,		['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Weapon License'},
	['visa'] 					 	 = {['name'] = 'visa', 			 	  	  		['label'] = 'Visa Card', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'visacard.png', 			['unique'] = true, 		['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Visa can be used via ATM'},
	['mastercard'] 					 = {['name'] = 'mastercard', 					['label'] = 'Master Card', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'mastercard.png', 			['unique'] = true, 		['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'MasterCard can be used via ATM'},
	['security_card_01'] 			 = {['name'] = 'security_card_01', 			  	['label'] = 'Security Card A', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'security_card_01.png', 	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A security card... I wonder what it goes to'},
	['security_card_02'] 			 = {['name'] = 'security_card_02', 			  	['label'] = 'Security Card B', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'security_card_02.png', 	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A security card... I wonder what it goes to'},

	-- Eat ITEMS
	['tosti'] 						 = {['name'] = 'tosti', 			 	  	  	['label'] = 'Grilled Cheese Sandwich', 	['weight'] = 200, 		['type'] = 'item', 		['image'] = 'tosti.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Nice to eat'},
	['twerks_candy'] 				 = {['name'] = 'twerks_candy', 			  	  	['label'] = 'Twerks', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'twerks_candy.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Some delicious candy :O'},
	['snikkel_candy'] 				 = {['name'] = 'snikkel_candy', 			  	['label'] = 'Snikkel', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'snikkel_candy.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Some delicious candy :O'},
	['sandwich'] 				 	 = {['name'] = 'sandwich', 			  	  		['label'] = 'Sandwich', 				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'sandwich.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Nice bread for your stomach'},

	-- Drink ITEMS
	['water_bottle'] 				 = {['name'] = 'water_bottle', 			  	  	['label'] = 'Bottle of Water', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'water_bottle.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'For all the thirsty out there'},
	['coffee'] 				 		 = {['name'] = 'coffee', 			  	  		['label'] = 'Coffee', 					['weight'] = 200, 		['type'] = 'item', 		['image'] = 'coffee.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Pump 4 Caffeine'},
	['kurkakola'] 				 	 = {['name'] = 'kurkakola', 			  	  	['label'] = 'Cola', 					['weight'] = 500, 		['type'] = 'item', 		['image'] = 'cola.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'For all the thirsty out there'},

	-- Alcohol
	['beer'] 				 		 = {['name'] = 'beer', 			  	  			['label'] = 'Beer', 					['weight'] = 500, 		['type'] = 'item', 		['image'] = 'beer.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Nothing like a good cold beer!'},
	['whiskey'] 				 	 = {['name'] = 'whiskey', 			  	  		['label'] = 'Whiskey', 					['weight'] = 500, 		['type'] = 'item', 		['image'] = 'whiskey.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'For all the thirsty out there'},
	['vodka'] 				 		 = {['name'] = 'vodka', 			  	  		['label'] = 'Vodka', 					['weight'] = 500, 		['type'] = 'item', 		['image'] = 'vodka.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'For all the thirsty out there'},
	['grape'] 					 	 = {['name'] = 'grape', 						['label'] = 'Grape', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'grape.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Mmmmh yummie, grapes'},
	['wine'] 					 	 = {['name'] = 'wine', 							['label'] = 'Wine', 					['weight'] = 300, 		['type'] = 'item', 		['image'] = 'wine.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Some good wine to drink on a fine evening'},
	['grapejuice'] 					 = {['name'] = 'grapejuice', 					['label'] = 'Grape Juice', 				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'grapejuice.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Grape juice is said to be healthy'},

	-- Drugs
	['joint'] 						 = {['name'] = 'joint', 			  	  		['label'] = 'Joint', 					['weight'] = 0, 		['type'] = 'item', 		['image'] = 'joint.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Sidney would be very proud at you'},
	['cokebaggy'] 					 = {['name'] = 'cokebaggy', 			  	  	['label'] = 'Bag of Coke', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'cocaine_baggy.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'To get happy real quick'},
	['crack_baggy'] 				 = {['name'] = 'crack_baggy', 			  	  	['label'] = 'Bag of Crack', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'crack_baggy.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'To get happy faster'},
	['xtcbaggy'] 					 = {['name'] = 'xtcbaggy', 			  	  		['label'] = 'Bag of XTC', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'xtc_baggy.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Pop those pills baby'},
	['weed_brick'] 		 			 = {['name'] = 'weed_brick', 					['label'] = 'Weed Brick', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'weed_brick.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = '1KG Weed Brick to sell to large customers.'},
	['coke_brick'] 		 			 = {['name'] = 'coke_brick', 					['label'] = 'Coke Brick', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'coke_brick.png', 			['unique'] = true, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Heavy package of cocaine, mostly used for deals and takes a lot of space'},
	['coke_small_brick'] 		 	 = {['name'] = 'coke_small_brick', 				['label'] = 'Coke Package', 			['weight'] = 350, 		['type'] = 'item', 		['image'] = 'coke_small_brick.png', 	['unique'] = true, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Small package of cocaine, mostly used for deals and takes a lot of space'},
	['oxy'] 				 		 = {['name'] = 'oxy',				    		['label'] = 'Prescription Oxy',			['weight'] = 0,			['type'] = 'item',		['image'] = 'oxy.png',					['unique'] = false,		['useable'] = true,		['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'The Label Has Been Ripped Off'},
	['meth'] 					 	 = {['name'] = 'meth', 							['label'] = 'Meth', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'meth_baggy.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A baggie of Meth'},
	['rolling_paper'] 			 	 = {['name'] = 'rolling_paper', 			  	['label'] = 'Rolling Paper', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'rolling_paper.png', 		['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = {accept = {'weed_white-widow', 'weed_skunk', 'weed_purple-haze', 'weed_og-kush', 'weed_amnesia', 'weed_ak47'}, reward = 'joint', anim = {['dict'] = 'anim@amb@business@weed@weed_inspecting_high_dry@', ['lib'] = 'weed_inspecting_high_base_inspector', ['text'] = 'Rolling joint', ['timeOut'] = 5000,}},   ['description'] = 'Paper made specifically for encasing and smoking tobacco or cannabis.'},

	-- Seed And Weed
	['weed_white-widow'] 			 = {['name'] = 'weed_white-widow', 			 	['label'] = 'White Widow 2g', 			['weight'] = 200, 		['type'] = 'item', 		['image'] = 'weed_baggy.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'A weed bag with 2g White Widow'},
	['weed_skunk'] 				  	 = {['name'] = 'weed_skunk', 			 		['label'] = 'Skunk 2g', 				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'weed_baggy.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'A weed bag with 2g Skunk'},
	['weed_purple-haze'] 			 = {['name'] = 'weed_purple-haze', 			 	['label'] = 'Purple Haze 2g', 			['weight'] = 200, 		['type'] = 'item', 		['image'] = 'weed_baggy.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'A weed bag with 2g Purple Haze'},
	['weed_og-kush'] 				 = {['name'] = 'weed_og-kush', 			 		['label'] = 'OGKush 2g', 				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'weed_baggy.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'A weed bag with 2g OG Kush'},
	['weed_amnesia'] 				 = {['name'] = 'weed_amnesia', 			 		['label'] = 'Amnesia 2g', 				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'weed_baggy.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'A weed bag with 2g Amnesia'},
	['weed_ak47'] 				     = {['name'] = 'weed_ak47', 			 		['label'] = 'AK47 2g', 					['weight'] = 200, 		['type'] = 'item', 		['image'] = 'weed_baggy.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'A weed bag with 2g AK47'},
	['weed_white-widow_seed'] 		 = {['name'] = 'weed_white-widow_seed', 		['label'] = 'White Widow Seed', 		['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_seed.png', 		    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'A weed seed of White Widow'},
	['weed_skunk_seed'] 			 = {['name'] = 'weed_skunk_seed', 			    ['label'] = 'Skunk Seed', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_seed.png', 		    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A weed seed of Skunk'},
	['weed_purple-haze_seed'] 		 = {['name'] = 'weed_purple-haze_seed', 		['label'] = 'Purple Haze Seed', 		['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_seed.png', 		    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A weed seed of Purple Haze'},
	['weed_og-kush_seed'] 			 = {['name'] = 'weed_og-kush_seed', 			['label'] = 'OGKush Seed', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_seed.png', 		    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A weed seed of OG Kush'},
	['weed_amnesia_seed'] 			 = {['name'] = 'weed_amnesia_seed', 			['label'] = 'Amnesia Seed', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_seed.png', 		    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A weed seed of Amnesia'},
	['weed_ak47_seed'] 				 = {['name'] = 'weed_ak47_seed', 			    ['label'] = 'AK47 Seed', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_seed.png', 		    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A weed seed of AK47'},
	['empty_weed_bag'] 				 = {['name'] = 'empty_weed_bag', 			    ['label'] = 'Empty Weed Bag', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_baggy_empty.png', 	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A small empty bag'},
	['weed_nutrition'] 				 = {['name'] = 'weed_nutrition', 			    ['label'] = 'Plant Fertilizer', 		['weight'] = 2000, 		['type'] = 'item', 		['image'] = 'weed_nutrition.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Plant nutrition'},

	-- Material
	['plastic'] 					 = {['name'] = 'plastic', 			  	  	  	['label'] = 'Plastic', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'plastic.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'RECYCLE! - Greta Thunberg 2019'},
	['metalscrap'] 					 = {['name'] = 'metalscrap', 			  	  	['label'] = 'Metal Scrap', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'metalscrap.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'You can probably make something nice out of this'},
	['copper'] 					 	 = {['name'] = 'copper', 			  	  		['label'] = 'Copper', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'copper.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Nice piece of metal that you can probably use for something'},
	['aluminum'] 					 = {['name'] = 'aluminum', 			  	  		['label'] = 'Aluminium', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'aluminum.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Nice piece of metal that you can probably use for something'},
	['aluminumoxide'] 				 = {['name'] = 'aluminumoxide', 			  	['label'] = 'Aluminium Powder', 		['weight'] = 100, 		['type'] = 'item', 		['image'] = 'aluminumoxide.png', 		['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Some powder to mix with'},
	['iron'] 				 	     = {['name'] = 'iron', 			  				['label'] = 'Iron', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'iron.png', 			    ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Handy piece of metal that you can probably use for something'},
	['ironoxide'] 				 	 = {['name'] = 'ironoxide', 			  		['label'] = 'Iron Powder', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'ironoxide.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = {accept = {'aluminumoxide'}, reward = 'thermite', anim = {['dict'] = 'anim@amb@business@weed@weed_inspecting_high_dry@', ['lib'] = 'weed_inspecting_high_base_inspector', ['text'] = 'Mixing powder..', ['timeOut'] = 10000}},   ['description'] = 'Some powder to mix with.'},
	['steel'] 				 	 	 = {['name'] = 'steel', 			  			['label'] = 'Steel', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'steel.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Nice piece of metal that you can probably use for something'},
	['rubber'] 				 	 	 = {['name'] = 'rubber', 			  			['label'] = 'Rubber', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'rubber.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Rubber, I believe you can make your own rubber ducky with it :D'},
	['glass'] 				 	 	 = {['name'] = 'glass', 			  			['label'] = 'Glass', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'glass.png', 			    ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'It is very fragile, watch out'},

	-- Tools
	['lockpick'] 					 = {['name'] = 'lockpick', 			 	  	  	['label'] = 'Lockpick', 				['weight'] = 300, 		['type'] = 'item', 		['image'] = 'lockpick.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = {accept = {'screwdriverset'}, reward = 'advancedlockpick', anim = {['dict'] = 'anim@amb@business@weed@weed_inspecting_high_dry@', ['lib'] = 'weed_inspecting_high_base_inspector', ['text'] = 'Crafting lockpick', ['timeOut'] = 7500,}},   ['description'] = 'Very useful if you lose your keys a lot.. or if you want to use it for something else...'},
	['advancedlockpick'] 			 = {['name'] = 'advancedlockpick', 			 	['label'] = 'Advanced Lockpick', 		['weight'] = 500, 		['type'] = 'item', 		['image'] = 'advancedlockpick.png', 	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'If you lose your keys a lot this is very useful... Also useful to open your beers'},
	['electronickit'] 				 = {['name'] = 'electronickit', 			  	['label'] = 'Electronic Kit', 			['weight'] = 100, 		['type'] = 'item', 		['image'] = 'electronickit.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = {accept = {'gatecrack'}, reward = 'trojan_usb', anim = nil}, ['description'] = 'If you\'ve always wanted to build a robot you can maybe start here. Maybe you\'ll be the new Elon Musk?'},
	['gatecrack'] 				 	 = {['name'] = 'gatecrack', 			  	  	['label'] = 'Gatecrack', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'usb_device.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Handy software to tear down some fences'},
	['thermite'] 			 	 	 = {['name'] = 'thermite', 			  			['label'] = 'Thermite', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'thermite.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Sometimes you\'d wish for everything to burn'},
	['trojan_usb'] 				 	 = {['name'] = 'trojan_usb', 			  	  	['label'] = 'Trojan USB', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'usb_device.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Handy software to shut down some systems'},
	['screwdriverset'] 				 = {['name'] = 'screwdriverset', 			    ['label'] = 'Toolkit', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'screwdriverset.png', 		['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Very useful to screw... screws...'},
	['drill'] 				 		 = {['name'] = 'drill', 			    		['label'] = 'Drill', 					['weight'] = 20000, 	['type'] = 'item', 		['image'] = 'drill.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'The real deal...'},

	-- Vehicle Tools
	['nitrous'] 				 	 = {['name'] = 'nitrous', 			  	  		['label'] = 'Nitrous', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'nitrous.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Speed up, gas pedal! :D'},
	['repairkit'] 					 = {['name'] = 'repairkit', 			 	  	['label'] = 'Repairkit', 				['weight'] = 2500, 		['type'] = 'item', 		['image'] = 'repairkit.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A nice toolbox with stuff to repair your vehicle'},
	['advancedrepairkit'] 			 = {['name'] = 'advancedrepairkit', 			['label'] = 'Advanced Repairkit', 		['weight'] = 4000, 		['type'] = 'item', 		['image'] = 'advancedkit.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A nice toolbox with stuff to repair your vehicle'},
	['cleaningkit'] 				 = {['name'] = 'cleaningkit', 			 	  	['label'] = 'Cleaning Kit', 			['weight'] = 250, 		['type'] = 'item', 		['image'] = 'cleaningkit.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A microfiber cloth with some soap will let your car sparkle again!'},
	['tunerlaptop'] 				 = {['name'] = 'tunerlaptop', 			    	['label'] = 'Tunerchip', 				['weight'] = 2000, 		['type'] = 'item', 		['image'] = 'tunerchip.png', 			['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'With this tunerchip you can get your car on steroids... If you know what you\'re doing'},
	['harness'] 				 	 = {['name'] = 'harness', 			  	  		['label'] = 'Race Harness', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'harness.png', 				['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Racing Harness so no matter what you stay in the car'},
    ['jerry_can'] 			 		 = {['name'] = 'jerry_can', 					['label'] = 'Jerrycan 20L', 			['weight'] = 20000, 	['type'] = 'item', 		['image'] = 'jerry_can.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A can full of Fuel'},

	-- Medication
	['firstaid'] 			 		 = {['name'] = 'firstaid', 						['label'] = 'First Aid', 				['weight'] = 2500, 		['type'] = 'item', 		['image'] = 'firstaid.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'You can use this First Aid kit to get people back on their feet'},
	['bandage'] 			 		 = {['name'] = 'bandage', 						['label'] = 'Bandage', 					['weight'] = 0, 		['type'] = 'item', 		['image'] = 'bandage.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A bandage works every time'},
	['painkillers'] 			 	 = {['name'] = 'painkillers', 					['label'] = 'Painkillers', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'painkillers.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'For pain you can\'t stand anymore, take this pill that\'d make you feel great again'},
	['walkstick'] 				 	 = {['name'] = 'walkstick', 			  	  	['label'] = 'Walking Stick', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'walkstick.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Walking stick for ya\'ll grannies out there.. HAHA'},
	
	-- Communication
	['phone'] 			 	 	 	 = {['name'] = 'phone', 			  			['label'] = 'Phone', 					['weight'] = 700, 		['type'] = 'item', 		['image'] = 'phone.png', 				['unique'] = true, 		['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Neat phone ya got there'},
	['radio'] 			 	 		 = {['name'] = 'radio', 			  			['label'] = 'Radio', 					['weight'] = 2000, 		['type'] = 'item', 		['image'] = 'radio.png', 				['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'You can communicate with this through a signal'},
	['iphone'] 				 	 	 = {['name'] = 'iphone', 			  	  		['label'] = 'iPhone', 				    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'iphone.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Very expensive phone'},
	['samsungphone'] 				 = {['name'] = 'samsungphone', 			  	  	['label'] = 'Samsung S10', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'samsungphone.png', 		['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Very expensive phone'},
	['laptop'] 				 		 = {['name'] = 'laptop', 			  	  		['label'] = 'Laptop', 					['weight'] = 4000, 		['type'] = 'item', 		['image'] = 'laptop.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Expensive laptop'},
	['tablet'] 				 		 = {['name'] = 'tablet', 			  	  		['label'] = 'Tablet', 					['weight'] = 2000, 		['type'] = 'item', 		['image'] = 'tablet.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Expensive tablet'},
	['fitbit'] 			 	 	 	 = {['name'] = 'fitbit', 			  			['label'] = 'Fitbit', 					['weight'] = 500, 		['type'] = 'item', 		['image'] = 'fitbit.png', 				['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'I like fitbit'},
    ['radioscanner'] 			 	 = {['name'] = 'radioscanner', 			  		['label'] = 'Radio Scanner', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'radioscanner.png', 		['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'With this you can get some police alerts. Not 100% effective however'},
	['pinger'] 			 			 = {['name'] = 'pinger', 						['label'] = 'Pinger', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pinger.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'With a pinger and your phone you can send out your location'},
    ['cryptostick'] 			 	 = {['name'] = 'cryptostick', 			  		['label'] = 'Crypto Stick', 			['weight'] = 200, 		['type'] = 'item', 		['image'] = 'cryptostick.png', 			['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Why would someone ever buy money that doesn\'t exist.. How many would it contain..?'},

	-- Theft and Jewelry
	['rolex'] 				 	 	 = {['name'] = 'rolex', 			  	  		['label'] = 'Golden Watch', 			['weight'] = 1500, 		['type'] = 'item', 		['image'] = 'rolex.png', 			    ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A golden watch seems like the jackpot to me!'},
	['diamond_ring'] 				 = {['name'] = 'diamond_ring', 			  	  	['label'] = 'Diamond Ring', 			['weight'] = 1500, 		['type'] = 'item', 		['image'] = 'diamond_ring.png', 		['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A diamond ring seems like the jackpot to me!'},
	['goldchain'] 				 	 = {['name'] = 'goldchain', 			  	  	['label'] = 'Golden Chain', 			['weight'] = 1500, 		['type'] = 'item', 		['image'] = 'goldchain.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A golden chain seems like the jackpot to me!'},
	['10kgoldchain'] 				 = {['name'] = '10kgoldchain', 			  	  	['label'] = '10k Gold Chain', 			['weight'] = 2000, 		['type'] = 'item', 		['image'] = '10kgoldchain.png', 		['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = '10 carat golden chain'},
	['goldbar'] 			 	 	 = {['name'] = 'goldbar', 			  			['label'] = 'Gold Bar', 				['weight'] = 7000, 	    ['type'] = 'item', 		['image'] = 'goldbar.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Looks pretty expensive to me'},

	-- Cops Tools
	['armor'] 		 				 = {['name'] = 'armor', 						['label'] = 'Armor', 					['weight'] = 5000, 	    ['type'] = 'item', 		['image'] = 'armor.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Some protection won\'t hurt... right?'},
	['heavyarmor'] 		 			 = {['name'] = 'heavyarmor', 					['label'] = 'Heavy Armor', 				['weight'] = 5000, 	    ['type'] = 'item', 		['image'] = 'armor.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Some protection won\'t hurt... right?'},
	['handcuffs'] 				 	 = {['name'] = 'handcuffs', 			    	['label'] = 'Handcuffs', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'handcuffs.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Comes in handy when people misbehave. Maybe it can be used for something else?'},
	['police_stormram'] 			 = {['name'] = 'police_stormram', 			  	['label'] = 'Stormram', 				['weight'] = 18000, 	['type'] = 'item', 		['image'] = 'police_stormram.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A nice tool to break into doors'},
	['empty_evidence_bag'] 			 = {['name'] = 'empty_evidence_bag', 			['label'] = 'Empty Evidence Bag', 		['weight'] = 0, 		['type'] = 'item', 		['image'] = 'evidence.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Used a lot to keep DNA from blood, bullet shells and more'},
	['filled_evidence_bag'] 		 = {['name'] = 'filled_evidence_bag', 			['label'] = 'Evidence Bag', 			['weight'] = 200, 		['type'] = 'item', 		['image'] = 'evidence.png', 			['unique'] = true, 		['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'A filled evidence bag to see who committed the crime >:('},

	-- Firework Tools
	['firework1'] 				 	 = {['name'] = 'firework1', 			  	  	['label'] = '2Brothers', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'firework1.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Fireworks'},
	['firework2'] 				 	 = {['name'] = 'firework2', 			  	  	['label'] = 'Poppelers', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'firework2.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Fireworks'},
	['firework3'] 				 	 = {['name'] = 'firework3', 			  	  	['label'] = 'WipeOut', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'firework3.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Fireworks'},
	['firework4'] 				 	 = {['name'] = 'firework4', 			  	  	['label'] = 'Weeping Willow', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'firework4.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Fireworks'},

	-- Sea Tools
    ['dendrogyra_coral'] 			 = {['name'] = 'dendrogyra_coral', 			  	['label'] = 'Dendrogyra', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'dendrogyra_coral.png', 	['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Its also known as pillar coral'},
    ['antipatharia_coral'] 			 = {['name'] = 'antipatharia_coral', 			['label'] = 'Antipatharia', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'antipatharia_coral.png', 	['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Its also known as black corals or thorn corals'},
	['diving_gear'] 			     = {['name'] = 'diving_gear', 					['label'] = 'Diving Gear', 				['weight'] = 30000, 	['type'] = 'item', 		['image'] = 'diving_gear.png', 			['unique'] = true, 	    ['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'An oxygen tank and a rebreather'},

	-- Other Tools
	['casinochips'] 				 = {['name'] = 'casinochips', 			  	  	['label'] = 'Casino Chips', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'casinochips.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['description'] = 'Chips For Casino Gambling'},
	['stickynote'] 			 	 	 = {['name'] = 'stickynote', 			  		['label'] = 'Sticky note', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'stickynote.png', 			['unique'] = true, 		['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Sometimes handy to remember something :)'},
	['moneybag'] 			 		 = {['name'] = 'moneybag', 						['label'] = 'Money Bag', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'moneybag.png', 			['unique'] = true, 	    ['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A bag with cash'},
	['parachute'] 			   		 = {['name'] = 'parachute', 					['label'] = 'Parachute', 				['weight'] = 30000, 	['type'] = 'item', 		['image'] = 'parachute.png', 			['unique'] = true, 	    ['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'The sky is the limit! Woohoo!'},
	['binoculars'] 			 	 	 = {['name'] = 'binoculars', 					['label'] = 'Binoculars', 				['weight'] = 600, 		['type'] = 'item', 		['image'] = 'binoculars.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Sneaky Breaky...'},
	['snowball'] 		     		 = {['name'] = 'snowball', 		 	  			['label'] = 'Snowball', 				['weight'] = 0, 		['type'] = 'item', 	 	['image'] = 'snowball.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Should have catched it :D'},
	['lighter'] 				 	 = {['name'] = 'lighter', 			  	  		['label'] = 'Lighter', 					['weight'] = 0, 		['type'] = 'item', 		['image'] = 'lighter.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'On new years eve a nice fire to stand next to'},
	['certificate'] 				 = {['name'] = 'certificate', 			  	  	['label'] = 'Certificate', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'certificate.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Certificate that proves you own certain stuff'},
	['markedbills'] 				 = {['name'] = 'markedbills', 			  	  	['label'] = 'Marked Money', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'markedbills.png', 			['unique'] = true, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Money?'},
	['labkey'] 			 			 = {['name'] = 'labkey', 						['label'] = 'Key', 						['weight'] = 500, 		['type'] = 'item', 		['image'] = 'labkey.png', 				['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Key for a lock...?'},
	['printerdocument'] 			 = {['name'] = 'printerdocument', 				['label'] = 'Document', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'printerdocument.png', 		['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A nice document'},
}

-- // HASH WEAPON ITEMS, NEED SOMETIMES TO GET INFO FOR CLIENT

shared.Weapons = {
	-- // WEAPONS
	-- Melee
	[`weapon_unarmed`] 				 = {['name'] = 'weapon_unarmed', 		 	  	['label'] = 'Fists', 					['weight'] = 1000, 		['type'] = 'weapon',	['ammotype'] = nil, 					['image'] = 'placeholder.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'Fisticuffs'},
	[`weapon_dagger`] 				 = {['name'] = 'weapon_dagger', 			 	['label'] = 'Dagger', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_dagger.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A short knife with a pointed and edged blade, used as a weapon'},
	[`weapon_bat`] 					 = {['name'] = 'weapon_bat', 			 	  	['label'] = 'Bat', 					    ['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_bat.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'Used for hitting a ball in sports (or other things)'},
	[`weapon_bottle`] 				 = {['name'] = 'weapon_bottle', 			 	['label'] = 'Broken Bottle', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_bottle.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A broken bottle'},
	[`weapon_crowbar`] 				 = {['name'] = 'weapon_crowbar', 		 	  	['label'] = 'Crowbar', 				    ['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_crowbar.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'An iron bar with a flattened end, used as a lever'},
	[`weapon_flashlight`] 			 = {['name'] = 'weapon_flashlight', 		 	['label'] = 'Flashlight', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_flashlight.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A small size sun that will make things brighter.'},
	[`weapon_golfclub`] 			 = {['name'] = 'weapon_golfclub', 		 	  	['label'] = 'Golfclub', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_golfclub.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A club used to hit the ball in golf'},
	[`weapon_hammer`] 				 = {['name'] = 'weapon_hammer', 			 	['label'] = 'Hammer', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_hammer.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'Used for jobs such as breaking things (legs) and driving in nails'},
	[`weapon_hatchet`] 				 = {['name'] = 'weapon_hatchet', 		 	  	['label'] = 'Hatchet', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_hatchet.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A small axe with a short handle for use in one hand'},
	[`weapon_knuckle`] 				 = {['name'] = 'weapon_knuckle', 		 	  	['label'] = 'Knuckle', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_knuckle.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A metal guard worn over the knuckles in fighting, especially to increase the effect of the blows'},
	[`weapon_knife`] 				 = {['name'] = 'weapon_knife', 			 	  	['label'] = 'Knife', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_knife.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'An instrument composed of a blade fixed into a handle, used for cutting or as a weapon'},
	[`weapon_machete`] 				 = {['name'] = 'weapon_machete', 		 	  	['label'] = 'Machete', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_machete.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A broad, heavy knife used as a weapon'},
	[`weapon_switchblade`] 			 = {['name'] = 'weapon_switchblade', 	 	  	['label'] = 'Switchblade', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_switchblade.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A knife with a blade that springs out from the handle when a button is pressed'},
	[`weapon_nightstick`] 			 = {['name'] = 'weapon_nightstick', 		 	['label'] = 'Nightstick', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_nightstick.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A police officer\'s club or billy'},
	[`weapon_wrench`] 				 = {['name'] = 'weapon_wrench', 			 	['label'] = 'Wrench', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_wrench.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A tool used for gripping and turning nuts, bolts, pipes, etc'},
	[`weapon_battleaxe`] 			 = {['name'] = 'weapon_battleaxe', 		 	  	['label'] = 'Battle Axe', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_battleaxe.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A large broad-bladed axe used in ancient warfare'},
	[`weapon_poolcue`] 				 = {['name'] = 'weapon_poolcue', 		 	  	['label'] = 'Poolcue', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_poolcue.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A stick used to strike a ball, usually the cue ball (sometimes)'},
	[`weapon_briefcase`] 			 = {['name'] = 'weapon_briefcase', 		 	  	['label'] = 'Briefcase', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_briefcase.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A briefcase'},
	[`weapon_briefcase_02`] 		 = {['name'] = 'weapon_briefcase_02', 	 	  	['label'] = 'Briefcase', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_briefcase2.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A briefcase'},
	[`weapon_garbagebag`] 			 = {['name'] = 'weapon_garbagebag', 		 	['label'] = 'Garbage Bag', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_garbagebag.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A garbage bag'},
	[`weapon_handcuffs`] 			 = {['name'] = 'weapon_handcuffs', 		 	  	['label'] = 'Handcuffs', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_handcuffs.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A pair of lockable linked metal rings for securing a prisoner\'s wrists'},
	[`weapon_bread`] 				 = {['name'] = 'weapon_bread', 				 	['label'] = 'Baquette', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'baquette.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'Bread..?'},
	[`weapon_stone_hatchet`] 		 = {['name'] = 'weapon_stone_hatchet', 		 	['label'] = 'Weapon Stone Hatchet', 	['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'stone_hatchet.png', 		['unique'] = true, 		['useable'] = true, 	['description'] = 'Stone ax'},

    -- Handguns
	[`weapon_pistol`] 				 = {['name'] = 'weapon_pistol', 			 	['label'] = 'Walther P99', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_pistol.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A small firearm designed to be held in one hand'},
	[`weapon_pistol_mk2`] 			 = {['name'] = 'weapon_pistol_mk2', 			['label'] = 'Pistol Mk II', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_pistolmk2.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'An upgraded small firearm designed to be held in one hand'},
	[`weapon_combatpistol`] 		 = {['name'] = 'weapon_combatpistol', 	 	  	['label'] = 'Combat Pistol', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_combatpistol.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A combat version small firearm designed to be held in one hand'},
	[`weapon_appistol`] 			 = {['name'] = 'weapon_appistol', 		 	  	['label'] = 'AP Pistol', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_appistol.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A small firearm designed to be held in one hand that is automatic'},
	[`weapon_stungun`] 				 = {['name'] = 'weapon_stungun', 		 	  	['label'] = 'Taser', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_taser.png', 		 ['unique'] = true, 	['useable'] = false, 	['description'] = 'A weapon firing barbs attached by wires to batteries, causing temporary paralysis'},
	[`weapon_pistol50`] 			 = {['name'] = 'weapon_pistol50', 		 	  	['label'] = 'Pistol .50 Cal', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_pistol50.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A .50 caliber firearm designed to be held with both hands'},
	[`weapon_snspistol`] 			 = {['name'] = 'weapon_snspistol', 		 	  	['label'] = 'SNS Pistol', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_snspistol.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A very small firearm designed to be easily concealed'},
	[`weapon_heavypistol`] 			 = {['name'] = 'weapon_heavypistol', 	 	  	['label'] = 'Heavy Pistol', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_heavypistol.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A hefty firearm designed to be held in one hand (or attempted)'},
	[`weapon_vintagepistol`] 		 = {['name'] = 'weapon_vintagepistol', 	 	  	['label'] = 'Vintage Pistol', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_vintagepistol.png', ['unique'] = true, 		['useable'] = false, 	['description'] = 'An antique firearm designed to be held in one hand'},
	[`weapon_flaregun`] 			 = {['name'] = 'weapon_flaregun', 		 	  	['label'] = 'Flare Gun', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_FLARE',			['image'] = 'weapon_flaregun.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A handgun for firing signal rockets'},
	[`weapon_marksmanpistol`] 		 = {['name'] = 'weapon_marksmanpistol', 	 	['label'] = 'Marksman Pistol', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_marksmanpistol.png', ['unique'] = true, 	['useable'] = false, 	['description'] = 'A very accurate small firearm designed to be held in one hand'},
	[`weapon_revolver`] 			 = {['name'] = 'weapon_revolver', 		 	  	['label'] = 'Revolver', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_revolver.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A pistol with revolving chambers enabling several shots to be fired without reloading'},
	[`weapon_revolver_mk2`] 		 = {['name'] = 'weapon_revolver_mk2', 		 	['label'] = 'Violence', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'revolvermk2.png', 			['unique'] = true, 		['useable'] = true, 	['description'] = 'da Violence'},
	[`weapon_doubleaction`] 	     = {['name'] = 'weapon_doubleaction', 		 	['label'] = 'Double Action Revolver', 	['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'doubleaction.png', 		['unique'] = true, 		['useable'] = true, 	['description'] = 'Double Action Revolver'},
	[`weapon_snspistol_mk2`] 	     = {['name'] = 'weapon_snspistol_mk2', 		 	['label'] = 'SNS Pistol MK2', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'snspistol_mk2.png', 		['unique'] = true, 		['useable'] = true, 	['description'] = 'SNS Pistol MK2'},
	[`weapon_raypistol`]			 = {['name'] = 'weapon_raypistol',				['label'] = 'Weapon Raypistol',			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_raypistol.png',		['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Raypistol'},
	[`weapon_ceramicpistol`]		 = {['name'] = 'weapon_ceramicpistol', 		 	['label'] = 'Weapon Ceramicpistol',		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_ceramicpistol.png',	['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Ceramicpistol'},
	[`weapon_navyrevolver`]        	 = {['name'] = 'weapon_navyrevolver', 		 	['label'] = 'Weapon Navyrevolver',		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_navyrevolver.png',	['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Navyrevolver'},
	[`weapon_gadgetpistol`] 		 = {['name'] = 'weapon_gadgetpistol', 		 	['label'] = 'Weapon Gadgetpistol',		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_gadgetpistol.png',	['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Gadgetpistol'},

    -- Submachine Guns
	[`weapon_microsmg`] 			 = {['name'] = 'weapon_microsmg', 		 	  	['label'] = 'Micro SMG', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SMG',				['image'] = 'weapon_microsmg.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A handheld lightweight machine gun'},
	[`weapon_smg`] 				 	 = {['name'] = 'weapon_smg', 			 	  	['label'] = 'SMG', 						['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SMG',				['image'] = 'weapon_smg.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'A handheld lightweight machine gun'},
	[`weapon_smg_mk2`] 				 = {['name'] = 'weapon_smg_mk2', 			 	['label'] = 'PD MP5 2', 				['weight'] = 1000,		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SMG',				['image'] = 'smg.png', 					['unique'] = true, 		['useable'] = true, 	['description'] = 'SMG MK2'},
	[`weapon_assaultsmg`] 			 = {['name'] = 'weapon_assaultsmg', 		 	['label'] = 'Assault SMG', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SMG',				['image'] = 'weapon_assaultsmg.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'An assault version of a handheld lightweight machine gun'},
	[`weapon_combatpdw`] 			 = {['name'] = 'weapon_combatpdw', 		 	  	['label'] = 'Combat PDW', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SMG',				['image'] = 'weapon_combatpdw.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A combat version of a handheld lightweight machine gun'},
	[`weapon_machinepistol`] 		 = {['name'] = 'weapon_machinepistol', 	 	  	['label'] = 'Tec-9', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PISTOL',			['image'] = 'weapon_machinepistol.png', ['unique'] = true, 		['useable'] = false, 	['description'] = 'A self-loading pistol capable of burst or fully automatic fire'},
	[`weapon_minismg`] 				 = {['name'] = 'weapon_minismg', 		 	  	['label'] = 'Mini SMG', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SMG',				['image'] = 'weapon_minismg.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A mini handheld lightweight machine gun'},
	[`weapon_raycarbine`]	         = {['name'] = 'weapon_raycarbine', 		 	['label'] = 'Weapon Raycarbine',		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SMG',				['image'] = 'weapon_raycarbine.png',	['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Raycarbine'},

    -- Shotguns
	[`weapon_pumpshotgun`] 			 = {['name'] = 'weapon_pumpshotgun', 	 	  	['label'] = 'Pump Shotgun', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'weapon_pumpshotgun.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A pump-action smoothbore gun for firing small shot at short range'},
	[`weapon_sawnoffshotgun`] 		 = {['name'] = 'weapon_sawnoffshotgun', 	 	['label'] = 'Sawn-off Shotgun', 		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'weapon_sawnoffshotgun.png', ['unique'] = true, 	['useable'] = false, 	['description'] = 'A sawn-off smoothbore gun for firing small shot at short range'},
	[`weapon_assaultshotgun`] 		 = {['name'] = 'weapon_assaultshotgun', 	 	['label'] = 'Assault Shotgun', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'weapon_assaultshotgun.png', ['unique'] = true, 	['useable'] = false, 	['description'] = 'An assault version of asmoothbore gun for firing small shot at short range'},
	[`weapon_bullpupshotgun`] 		 = {['name'] = 'weapon_bullpupshotgun', 	 	['label'] = 'Bullpup Shotgun', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'weapon_bullpupshotgun.png', ['unique'] = true, 	['useable'] = false, 	['description'] = 'A compact smoothbore gun for firing small shot at short range'},
	[`weapon_musket`] 			     = {['name'] = 'weapon_musket', 			 	['label'] = 'Musket', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'weapon_musket.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'An infantryman\'s light gun with a long barrel, typically smooth-bored, muzzleloading, and fired from the shoulder'},
	[`weapon_heavyshotgun`] 		 = {['name'] = 'weapon_heavyshotgun', 	 	  	['label'] = 'Heavy Shotgun', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'weapon_heavyshotgun.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A large smoothbore gun for firing small shot at short range'},
	[`weapon_dbshotgun`] 			 = {['name'] = 'weapon_dbshotgun', 		 	  	['label'] = 'Double-barrel Shotgun', 	['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'weapon_dbshotgun.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A shotgun with two parallel barrels, allowing two single shots to be fired in quick succession'},
	[`weapon_autoshotgun`] 			 = {['name'] = 'weapon_autoshotgun', 	 	  	['label'] = 'Auto Shotgun', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'weapon_autoshotgun.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A shotgun capable of rapid continous fire'},
	[`weapon_pumpshotgun_mk2`]		 = {['name'] = 'weapon_pumpshotgun_mk2',		['label'] = 'Pumpshotgun MK2', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'pumpshotgun_mk2.png', 		['unique'] = true, 		['useable'] = true, 	['description'] = 'Pumpshotgun MK2'},
	[`weapon_combatshotgun`]		 = {['name'] = 'weapon_combatshotgun', 		 	['label'] = 'Weapon Combatshotgun',		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'combatshotgun.png', 		['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Combatshotgun'},

    -- Assault Rifles
	[`weapon_assaultrifle`] 		 = {['name'] = 'weapon_assaultrifle', 	 	  	['label'] = 'Assault Rifle', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'weapon_assaultrifle.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A rapid-fire, magazine-fed automatic rifle designed for infantry use'},
	[`weapon_assaultrifle_mk2`] 	 = {['name'] = 'weapon_assaultrifle_mk2', 	 	['label'] = 'AK-47 MK2', 				['weight'] = 1000,		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'assaultriflemk2.png', 		['unique'] = true, 		['useable'] = true, 	['description'] = 'Assault Rifle MK2'},
	[`weapon_carbinerifle`] 		 = {['name'] = 'weapon_carbinerifle', 	 	  	['label'] = 'Carbine Rifle', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'weapon_carbinerifle.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A lightweight automatic rifle'},
    [`weapon_carbinerifle_mk2`] 	 = {['name'] = 'weapon_carbinerifle_mk2', 	 	['label'] = 'PD 762', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'carbineriflemk2.png', 		['unique'] = true, 		['useable'] = true, 	['description'] = 'Carbine Rifle MK2'},
	[`weapon_advancedrifle`] 		 = {['name'] = 'weapon_advancedrifle', 	 	  	['label'] = 'Advanced Rifle', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'weapon_advancedrifle.png', ['unique'] = true, 		['useable'] = false, 	['description'] = 'An assault version of a rapid-fire, magazine-fed automatic rifle designed for infantry use'},
	[`weapon_specialcarbine`] 		 = {['name'] = 'weapon_specialcarbine', 	 	['label'] = 'Special Carbine', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'weapon_specialcarbine.png', ['unique'] = true, 	['useable'] = false, 	['description'] = 'An extremely versatile assault rifle for any combat situation'},
	[`weapon_bullpuprifle`] 		 = {['name'] = 'weapon_bullpuprifle', 	 	  	['label'] = 'Bullpup Rifle', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'weapon_bullpuprifle.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A compact automatic assault rifle'},
	[`weapon_compactrifle`] 		 = {['name'] = 'weapon_compactrifle', 	 	  	['label'] = 'Compact Rifle', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'weapon_compactrifle.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A compact version of an assault rifle'},
	[`weapon_specialcarbine_mk2`]	 = {['name'] = 'weapon_specialcarbine_mk2', 	['label'] = 'Weapon Wpecialcarbine MK2',['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'specialcarbine_mk2.png',	['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Wpecialcarbine MK2'},
	[`weapon_bullpuprifle_mk2`]		 = {['name'] = 'weapon_bullpuprifle_mk2', 		['label'] = 'Bull Puprifle MK2',		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'bullpuprifle_mk2.png',		['unique'] = true, 		['useable'] = true, 	['description'] = 'Bull Puprifle MK2'},
	[`weapon_militaryrifle`]		 = {['name'] = 'weapon_militaryrifle', 		 	['label'] = 'Weapon Militaryrifle',		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RIFLE',			['image'] = 'militaryrifle.png', 		['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Militaryrifle'},

    -- Light Machine Guns
	[`weapon_mg`] 					 = {['name'] = 'weapon_mg', 				 	['label'] = 'Machinegun', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',				['image'] = 'weapon_mg.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'An automatic gun that fires bullets in rapid succession for as long as the trigger is pressed'},
	[`weapon_combatmg`] 			 = {['name'] = 'weapon_combatmg', 		 	  	['label'] = 'Combat MG', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',				['image'] = 'weapon_combatmg.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A combat version of an automatic gun that fires bullets in rapid succession for as long as the trigger is pressed'},
	[`weapon_gusenberg`] 			 = {['name'] = 'weapon_gusenberg', 		 	  	['label'] = 'Thompson SMG', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',				['image'] = 'weapon_gusenberg.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'An automatic rifle commonly referred to as a tommy gun'},
	[`weapon_combatmg_mk2`]	 		 = {['name'] = 'weapon_combatmg_mk2', 		 	['label'] = 'Weapon Combatmg MK2',		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',				['image'] = 'combatmg_mk2.png', 		['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Combatmg MK2'},

    -- Sniper Rifles
	[`weapon_sniperrifle`] 			 = {['name'] = 'weapon_sniperrifle', 	 	  	['label'] = 'Sniper Rifle', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SNIPER',			['image'] = 'weapon_sniperrifle.png', 	 ['unique'] = true, 	['useable'] = false, 	['description'] = 'A high-precision, long-range rifle'},
	[`weapon_heavysniper`] 			 = {['name'] = 'weapon_heavysniper', 	 	  	['label'] = 'Heavy Sniper', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SNIPER',			['image'] = 'weapon_heavysniper.png', 	 ['unique'] = true, 	['useable'] = false, 	['description'] = 'An upgraded high-precision, long-range rifle'},
	[`weapon_marksmanrifle`] 		 = {['name'] = 'weapon_marksmanrifle', 	 	  	['label'] = 'Marksman Rifle', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SNIPER',			['image'] = 'weapon_marksmanrifle.png', ['unique'] = true, 		['useable'] = false, 	['description'] = 'A very accurate single-fire rifle'},
	[`weapon_remotesniper`] 		 = {['name'] = 'weapon_remotesniper', 	 	  	['label'] = 'Remote Sniper', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SNIPER_REMOTE',	['image'] = 'weapon_remotesniper.png', 	 ['unique'] = true, 	['useable'] = false, 	['description'] = 'A portable high-precision, long-range rifle'},
	[`weapon_heavysniper_mk2`]		 = {['name'] = 'weapon_heavysniper_mk2', 		['label'] = 'Weapon Heavysniper MK2',	['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SNIPER',			['image'] = 'heavysniper_mk2.png', 		['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Heavysniper MK2'},
	[`weapon_marksmanrifle_mk2`]	 = {['name'] = 'weapon_marksmanrifle_mk2', 		['label'] = 'Weapon Marksmanrifle MK2',	['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SNIPER',			['image'] = 'marksmanrifle_mk2.png',	['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Marksmanrifle MK2'},

    -- Heavy Weapons
	[`weapon_rpg`] 					 = {['name'] = 'weapon_rpg', 			      	['label'] = 'RPG', 						['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_RPG',				['image'] = 'weapon_rpg.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'A rocket-propelled grenade launcher'},
	[`weapon_grenadelauncher`] 		 = {['name'] = 'weapon_grenadelauncher', 	  	['label'] = 'Grenade Launcher', 		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_GRENADELAUNCHER',	['image'] = 'weapon_grenadelauncher.png', ['unique'] = true, 	['useable'] = false, 	['description'] = 'A weapon that fires a specially-designed large-caliber projectile, often with an explosive, smoke or gas warhead'},
	[`weapon_grenadelauncher_smoke`] = {['name'] = 'weapon_grenadelauncher_smoke', 	['label'] = 'Smoke Grenade Launcher', 	['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_GRENADELAUNCHER',	['image'] = 'weapon_smokegrenade.png', 	 ['unique'] = true, 	['useable'] = false, 	['description'] = 'A bomb that produces a lot of smoke when it explodes'},
	[`weapon_minigun`] 				 = {['name'] = 'weapon_minigun', 		      	['label'] = 'Minigun', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MINIGUN',			['image'] = 'weapon_minigun.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A portable machine gun consisting of a rotating cluster of six barrels and capable of variable rates of fire of up to 6,000 rounds per minute'},
	[`weapon_firework`] 			 = {['name'] = 'weapon_firework', 		 	  	['label'] = 'Firework Launcher', 		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_firework.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A device containing gunpowder and other combustible chemicals that causes a spectacular explosion when ignited'},
	[`weapon_railgun`] 				 = {['name'] = 'weapon_railgun', 		 	  	['label'] = 'Railgun', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_railgun.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A weapon that uses electromagnetic force to launch high velocity projectiles'},
	[`weapon_hominglauncher`] 		 = {['name'] = 'weapon_hominglauncher', 	 	['label'] = 'Homing Launcher', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_STINGER',			['image'] = 'weapon_hominglauncher.png', ['unique'] = true, 	['useable'] = false, 	['description'] = 'A weapon fitted with an electronic device that enables it to find and hit a target'},
	[`weapon_compactlauncher`] 		 = {['name'] = 'weapon_compactlauncher',  	  	['label'] = 'Compact Launcher', 		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_compactlauncher.png', 	['unique'] = true, 	['useable'] = false, 	['description'] = 'A compact grenade launcher'},
	[`weapon_rayminigun`]			 = {['name'] = 'weapon_rayminigun', 		 	['label'] = 'Weapon Rayminigun',		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MINIGUN',			['image'] = 'weapon_rayminigun.png',	['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Rayminigun'},

    -- Throwables
	[`weapon_grenade`] 				 = {['name'] = 'weapon_grenade', 		      	['label'] = 'Grenade', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_grenade.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A handheld throwable bomb'},
	[`weapon_bzgas`] 				 = {['name'] = 'weapon_bzgas', 			      	['label'] = 'BZ Gas', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_bzgas.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A cannister of gas that causes extreme pain'},
	[`weapon_molotov`] 				 = {['name'] = 'weapon_molotov', 		      	['label'] = 'Molotov', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_molotov.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A crude bomb made of a bottle filled with a flammable liquid and fitted with a wick for lighting'},
	[`weapon_stickybomb`] 			 = {['name'] = 'weapon_stickybomb', 		    ['label'] = 'C4', 						['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_stickybomb.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'An explosive charge covered with an adhesive that when thrown against an object sticks until it explodes'},
	[`weapon_proxmine`] 			 = {['name'] = 'weapon_proxmine', 		 	  	['label'] = 'Proxmine Grenade', 		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_proximitymine.png', ['unique'] = true, 		['useable'] = false, 	['description'] = 'A bomb placed on the ground that detonates when going within its proximity'},
	[`weapon_snowball`] 		     = {['name'] = 'weapon_snowball', 		 	  	['label'] = 'Snowball', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_snowball.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A ball of packed snow, especially one made for throwing at other people for fun'},
	[`weapon_pipebomb`] 			 = {['name'] = 'weapon_pipebomb', 		 	  	['label'] = 'Pipe Bomb', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_pipebomb.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A homemade bomb, the components of which are contained in a pipe'},
	[`weapon_ball`] 				 = {['name'] = 'weapon_ball', 			 	  	['label'] = 'Ball', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_BALL',				['image'] = 'weapon_ball.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'A solid or hollow spherical or egg-shaped object that is kicked, thrown, or hit in a game'},
	[`weapon_smokegrenade`] 		 = {['name'] = 'weapon_smokegrenade', 	      	['label'] = 'Smoke Grenade', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_c4.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'An explosive charge that can be remotely detonated'},
	[`weapon_flare`] 				 = {['name'] = 'weapon_flare', 			 	  	['label'] = 'Flare pistol', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_FLARE',			['image'] = 'weapon_flare.png', 		['unique'] = true, 		['useable'] = false, 	['description'] = 'A small pyrotechnic devices used for illumination and signalling'},

    -- Miscellaneous
	[`weapon_petrolcan`] 			 = {['name'] = 'weapon_petrolcan', 		 	  	['label'] = 'Petrol Can', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PETROLCAN',		['image'] = 'weapon_petrolcan.png', 	['unique'] = true, 		['useable'] = false, 	['description'] = 'A robust liquid container made from pressed steel'},
	[`weapon_fireextinguisher`] 	 = {['name'] = 'weapon_fireextinguisher',      	['label'] = 'Fire Extinguisher', 		['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_fireextinguisher.png', 	['unique'] = true, 	['useable'] = false, 	['description'] = 'A portable device that discharges a jet of water, foam, gas, or other material to extinguish a fire'},
	[`weapon_hazardcan`]			 = {['name'] = 'weapon_hazardcan',				['label'] = 'Weapon Hazardcan',			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_PETROLCAN',		['image'] = 'weapon_hazardcan.png',		['unique'] = true, 		['useable'] = true, 	['description'] = 'Weapon Hazardcan'},
}

-- groups
shared.groups = {
	['none'] = {
		label = 'Geen',
		grades = {
            {
                name = 'Geen'
            },
        },
	},
	['lostmc'] = {
		label = 'The Lost MC',
		grades = {
            {
                name = 'Hang Around'
            },
			{
                name = 'Prospect'
            },
			{
                name = 'Member'
            },
			{
                name = 'Road Captain'
            },
			{
                name = 'Sergeant At Arms'
            },
			{
                name = 'Treasurer'
            },
			{
                name = 'Secretary'
            },
			{
                name = 'Vice President',
				isboss = true
            },
			{
                name = 'President',
				isboss = true
            },
        },
	},
	['families'] = {
		label = 'Families',
		grades = {
            {
                name = 'Recruit'
            },
			{
                name = 'Enforcer'
            },
			{
                name = 'Shot Caller'
            },
			{
                name = 'Boss',
				isboss = true
            },
        },
	},
	['ballas'] = {
		label = 'Ballas',
		grades = {
            {
                name = 'Recruit'
            },
			{
                name = 'Enforcer'
            },
			{
                name = 'Shot Caller'
            },
			{
                name = 'Boss',
				isboss = true
            },
        },
	},
	['vagos'] = {
		label = 'Vagos',
		grades = {
            {
                name = 'Recruit'
            },
			{
                name = 'Enforcer'
            },
			{
                name = 'Shot Caller'
            },
			{
                name = 'Boss',
				isboss = true
            },
        },
	},
	['cartel'] = {
		label = 'Madrazo Cartel',
		grades = {
            {
                name = 'Recruit'
            },
			{
                name = 'Enforcer'
            },
			{
                name = 'Shot Caller'
            },
			{
                name = 'Boss',
				isboss = true
            },
        },
	},
	['triads'] = {
		label = 'Triads',
		grades = {
            {
                name = 'Recruit'
            },
			{
                name = 'Enforcer'
            },
			{
                name = 'Shot Caller'
            },
			{
                name = 'Boss',
				isboss = true
            },
        },
	},
	['mafia'] = {
		label = 'Armenian Mob',
		grades = {
            {
                name = 'Recruit'
            },
			{
                name = 'Enforcer'
            },
			{
                name = 'Shot Caller'
            },
			{
                name = 'Boss',
				isboss = true
            },
        },
	},
	['aztecas'] = {
		label = 'Aztecas',
		grades = {
            {
                name = 'Recruit'
            },
			{
                name = 'Enforcer'
            },
			{
                name = 'Shot Caller'
            },
			{
                name = 'Boss',
				isboss = true
            },
        },
	},
	['korean'] = {
		label = 'Kkangpae',
		grades = {
            {
                name = 'Recruit'
            },
			{
                name = 'Enforcer'
            },
			{
                name = 'Shot Caller'
            },
			{
                name = 'Boss',
				isboss = true
            },
        },
	},
	['marabunta'] = {
		label = 'Marabunta Grande',
		grades = {
            {
                name = 'Recruit'
            },
			{
                name = 'Enforcer'
            },
			{
                name = 'Shot Caller'
            },
			{
                name = 'Boss',
				isboss = true
            },
        },
	}
}

--[[
	, , 
]]

-- Jobs
shared.ForceJobDefaultDutyAtLogin = false -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
shared.Jobs = {
	['unemployed'] = {
		label = 'Burger',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            {
                name = 'Freelancer',
                payment = 10
            },
        },
	},
	['police'] = {
		label = 'Los Santos Police Department',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            {
                name = 'Cadet',
                payment = 50
            },
			{
                name = 'Officer',
                payment = 75
            },
			{
                name = 'Sergeant',
                payment = 100
            },
			{
                name = 'Lieutenant',
                payment = 125
            },
			{
                name = 'Captain',
                payment = 125
            },
			{
                name = 'Assistant Chief',
                payment = 125
            },
			{
                name = 'Chief',
				isboss = true,
                payment = 150
            },
        },
	},
	['ambulance'] = {
		label = 'EMS',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            {
                name = 'Recruit',
                payment = 50
            },
			{
                name = 'Paramedic',
                payment = 75
            },
			{
                name = 'Doctor',
                payment = 100
            },
			{
                name = 'Surgeon',
                payment = 125
            },
			{
                name = 'Chief',
				isboss = true,
                payment = 150
            },
        },
	},
	['realestate'] = {
		label = 'Real Estate',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            {
                name = 'Recruit',
                payment = 50
            },
			{
                name = 'House Sales',
                payment = 75
            },
			{
                name = 'Business Sales',
                payment = 100
            },
			{
                name = 'Broker',
                payment = 125
            },
			{
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['taxi'] = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            {
                name = 'Recruit',
                payment = 50
            },
			{
                name = 'Driver',
                payment = 75
            },
			{
                name = 'Event Driver',
                payment = 100
            },
			{
                name = 'Sales',
                payment = 125
            },
			{
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
     ['bus'] = {
		label = 'Bus',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            {
                name = 'Driver',
                payment = 50
            },
		},
	},
	['cardealer'] = {
		label = 'Vehicle Dealer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            {
                name = 'Recruit',
                payment = 50
            },
			{
                name = 'Showroom Sales',
                payment = 75
            },
			{
                name = 'Business Sales',
                payment = 100
            },
			{
                name = 'Finance',
                payment = 125
            },
			{
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['mechanic'] = {
		label = 'Mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            {
                name = 'Recruit',
                payment = 50
            },
			{
                name = 'Novice',
                payment = 75
            },
			{
                name = 'Experienced',
                payment = 100
            },
			{
                name = 'Advanced',
                payment = 125
            },
			{
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['judge'] = {
		label = 'Honorary',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            {
                name = 'Judge',
                payment = 100
            },
        },
	},
	['lawyer'] = {
		label = 'Law Firm',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            {
                name = 'Associate',
                payment = 50
            },
        },
	},
	['reporter'] = {
		label = 'Reporter',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            {
                name = 'Journalist',
                payment = 50
            },
        },
	},
	['trucker'] = {
		label = 'Trucker',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            {
                name = 'Driver',
                payment = 50
            },
        },
	},
	['tow'] = {
		label = 'Towing',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            {
                name = 'Driver',
                payment = 50
            },
        },
	},
	['garbage'] = {
		label = 'Garbage',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            {
                name = 'Collector',
                payment = 50
            },
        },
	},
	['vineyard'] = {
		label = 'Vineyard',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            {
                name = 'Picker',
                payment = 50
            },
        },
	},
	['hotdog'] = {
		label = 'Hotdog',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            {
                name = 'Sales',
                payment = 50
            },
        },
	},
}

-- Vehicles
shared.Vehicles = {
	--- Compacts
	['asbo'] = { ['name'] = 'Asbo', ['brand'] = 'Maxwell', ['model'] = 'asbo', ['price'] = 4000, ['category'] = 'compacts', ['hash'] = `asbo`, ['shop'] = 'pdm' },
	['blista'] = { ['name'] = 'Blista', ['brand'] = 'Dinka', ['model'] = 'blista', ['price'] = 13000, ['category'] = 'compacts', ['hash'] = `blista`, ['shop'] = 'pdm' },
	['brioso'] = { ['name'] = 'Brioso R/A', ['brand'] = 'Grotti', ['model'] = 'brioso', ['price'] = 20000, ['category'] = 'compacts', ['hash'] = `brioso`, ['shop'] = 'pdm' },
	['club'] = { ['name'] = 'Club', ['brand'] = 'BF', ['model'] = 'club', ['price'] = 8000, ['category'] = 'compacts', ['hash'] = `club`, ['shop'] = 'pdm' },
	['dilettante'] = { ['name'] = 'Dilettante', ['brand'] = 'Karin', ['model'] = 'dilettante', ['price'] = 9000, ['category'] = 'compacts', ['hash'] = `dilettante`, ['shop'] = 'pdm' },
	['dilettante2'] = { ['name'] = 'Dilettante Patrol', ['brand'] = 'Karin', ['model'] = 'dilettante2', ['price'] = 12000, ['category'] = 'compacts', ['hash'] = `dilettante2`, ['shop'] = 'pdm' },
	['kanjo'] = { ['name'] = 'Blista Kanjo', ['brand'] = 'Dinka', ['model'] = 'kanjo', ['price'] = 12000, ['category'] = 'compacts', ['hash'] = `kanjo`, ['shop'] = 'pdm' },
	['issi2'] = { ['name'] = 'Issi', ['brand'] = 'Weeny', ['model'] = 'issi2', ['price'] = 7000, ['category'] = 'compacts', ['hash'] = `issi2`, ['shop'] = 'pdm' },
	['issi3'] = { ['name'] = 'Issi Classic', ['brand'] = 'Weeny', ['model'] = 'issi3', ['price'] = 5000, ['category'] = 'compacts', ['hash'] = `issi3`, ['shop'] = 'pdm' },
	['issi4'] = { ['name'] = 'Issi Arena', ['brand'] = 'Weeny', ['model'] = 'issi4', ['price'] = 80000, ['category'] = 'compacts', ['hash'] = `issi4`, ['shop'] = 'issi4' },
	['issi5'] = { ['name'] = 'Issi Arena', ['brand'] = 'Weeny', ['model'] = 'issi5', ['price'] = 80000, ['category'] = 'compacts', ['hash'] = `issi5`, ['shop'] = 'issi5' },
	['issi6'] = { ['name'] = 'Issi Arena', ['brand'] = 'Weeny', ['model'] = 'issi6', ['price'] = 80000, ['category'] = 'compacts', ['hash'] = `issi6`, ['shop'] = 'issi6' },
	['panto'] = { ['name'] = 'Panto', ['brand'] = 'Benefactor', ['model'] = 'panto', ['price'] = 3200, ['category'] = 'compacts', ['hash'] = `panto`, ['shop'] = 'pdm' },
	['prairie'] = { ['name'] = 'Prairie', ['brand'] = 'Bollokan', ['model'] = 'prairie', ['price'] = 30000, ['category'] = 'compacts', ['hash'] = `prairie`, ['shop'] = 'pdm' },
	['rhapsody'] = { ['name'] = 'Rhapsody', ['brand'] = 'Declasse', ['model'] = 'rhapsody', ['price'] = 10000, ['category'] = 'compacts', ['hash'] = `rhapsody`, ['shop'] = 'pdm' },
	['brioso2'] = { ['name'] = 'Brioso 300', ['brand'] = 'Grotti', ['model'] = 'brioso2', ['price'] = 12000, ['category'] = 'compacts', ['hash'] = `brioso2`, ['shop'] = 'pdm' },
	['weevil'] = { ['name'] = 'Weevil', ['brand'] = 'BF', ['model'] = 'weevil', ['price'] = 9000, ['category'] = 'compacts', ['hash'] = `weevil`, ['shop'] = 'pdm' },
	--- Coupes
	['cogcabrio'] = { ['name'] = 'Cognoscenti Cabrio', ['brand'] = 'Enus', ['model'] = 'cogcabrio', ['price'] = 30000, ['category'] = 'coupes', ['hash'] = `cogcabrio`, ['shop'] = 'pdm' },
	['exemplar'] = { ['name'] = 'Exemplar', ['brand'] = 'Dewbauchee', ['model'] = 'exemplar', ['price'] = 40000, ['category'] = 'coupes', ['hash'] = `exemplar`, ['shop'] = 'pdm' },
	['f620'] = { ['name'] = 'F620', ['brand'] = 'Ocelot', ['model'] = 'f620', ['price'] = 32500, ['category'] = 'coupes', ['hash'] = `f620`, ['shop'] = 'pdm' },
	['felon'] = { ['name'] = 'Felon', ['brand'] = 'Lampadati', ['model'] = 'felon', ['price'] = 31000, ['category'] = 'coupes', ['hash'] = `felon`, ['shop'] = 'pdm' },
	['felon2'] = { ['name'] = 'Felon GT', ['brand'] = 'Lampadati', ['model'] = 'felon2', ['price'] = 37000, ['category'] = 'coupes', ['hash'] = `felon2`, ['shop'] = 'pdm' },
	['jackal'] = { ['name'] = 'Jackal', ['brand'] = 'Ocelot', ['model'] = 'jackal', ['price'] = 19000, ['category'] = 'coupes', ['hash'] = `jackal`, ['shop'] = 'pdm' },
	['oracle'] = { ['name'] = 'Oracle', ['brand'] = 'Ubermacht', ['model'] = 'oracle', ['price'] = 22000, ['category'] = 'sedans', ['hash'] = `oracle`, ['shop'] = 'pdm' },
	['oracle2'] = { ['name'] = 'Oracle XS', ['brand'] = 'Übermacht', ['model'] = 'oracle2', ['price'] = 28000, ['category'] = 'coupes', ['hash'] = `oracle2`, ['shop'] = 'pdm' },
	['sentinel'] = { ['name'] = 'Sentinel', ['brand'] = 'Übermacht', ['model'] = 'sentinel', ['price'] = 30000, ['category'] = 'coupes', ['hash'] = `sentinel`, ['shop'] = 'pdm' },
	['sentinel2'] = { ['name'] = 'Sentinel XS', ['brand'] = ' Übermacht', ['model'] = 'sentinel2', ['price'] = 33000, ['category'] = 'coupes', ['hash'] = `sentinel2`, ['shop'] = 'pdm' },
	['windsor'] = { ['name'] = 'Windsor', ['brand'] = 'Enus', ['model'] = 'windsor', ['price'] = 27000, ['category'] = 'coupes', ['hash'] = `windsor`, ['shop'] = 'pdm' },
	['windsor2'] = { ['name'] = 'Windsor Drop', ['brand'] = 'Enus', ['model'] = 'windsor2', ['price'] = 34000, ['category'] = 'coupes', ['hash'] = `windsor2`, ['shop'] = 'pdm' },
	['zion'] = { ['name'] = 'Zion', ['brand'] = 'Übermacht', ['model'] = 'zion', ['price'] = 22000, ['category'] = 'coupes', ['hash'] = `zion`, ['shop'] = 'pdm' },
	['zion2'] = { ['name'] = 'Zion Cabrio', ['brand'] = 'Übermacht', ['model'] = 'zion2', ['price'] = 28000, ['category'] = 'coupes', ['hash'] = `zion2`, ['shop'] = 'pdm' },
	['previon'] = { ['name'] = 'Previon', ['brand'] = 'Karin', ['model'] = 'previon', ['price'] = 149000, ['category'] = 'coupes', ['hash'] = `previon`, ['shop'] = 'previon' },
	--- Cycles
	['bmx'] = { ['name'] = 'BMX', ['price'] = bmx, ['category'] = '160', ['model'] = 'cycles', ['hash'] = `bmx`, ['shop'] = 'pdm' },
	['cruiser'] = { ['name'] = 'Cruiser', ['price'] = cruiser, ['category'] = '510', ['model'] = 'cycles', ['hash'] = `cruiser`, ['shop'] = 'pdm' },
	['fixter'] = { ['name'] = 'Fixter', ['price'] = fixter, ['category'] = '225', ['model'] = 'cycles', ['hash'] = `fixter`, ['shop'] = 'pdm' },
	['scorcher'] = { ['name'] = 'Scorcher', ['price'] = scorcher, ['category'] = '280', ['model'] = 'cycles', ['hash'] = `scorcher`, ['shop'] = 'pdm' },
	['tribike'] = { ['name'] = 'Tri Bike', ['price'] = tribike, ['category'] = '500', ['model'] = 'cycles', ['hash'] = `tribike`, ['shop'] = 'pdm' },
	['tribike2'] = { ['name'] = 'Tri Bike 2', ['model'] = 'tribike2', ['price'] = 700, ['category'] = 'cycles', ['hash'] = `tribike2`, ['shop'] = 'pdm' },
	['tribike3'] = { ['name'] = 'Tri Bike 3', ['price'] = tribike3, ['category'] = '520', ['model'] = 'cycles', ['hash'] = `tribike3`, ['shop'] = 'pdm' },
	--- Motorcycles
	['akuma'] = { ['name'] = 'Akuma', ['brand'] = 'Dinka', ['model'] = 'akuma', ['price'] = 55000, ['category'] = 'motorcycles', ['hash'] = `akuma`, ['shop'] = 'pdm' },
	['avarus'] = { ['name'] = 'Avarus', ['brand'] = 'LCC', ['model'] = 'avarus', ['price'] = 20000, ['category'] = 'motorcycles', ['hash'] = `avarus`, ['shop'] = 'pdm' },
	['bagger'] = { ['name'] = 'Bagger', ['brand'] = 'WMC', ['model'] = 'bagger', ['price'] = 13500, ['category'] = 'motorcycles', ['hash'] = `bagger`, ['shop'] = 'pdm' },
	['bati'] = { ['name'] = 'Bati 801', ['brand'] = 'Pegassi', ['model'] = 'bati', ['price'] = 24000, ['category'] = 'motorcycles', ['hash'] = `bati`, ['shop'] = 'pdm' },
	['bati2'] = { ['name'] = 'Bati 801RR', ['brand'] = 'Pegassi', ['model'] = 'bati2', ['price'] = 19000, ['category'] = 'motorcycles', ['hash'] = `bati2`, ['shop'] = 'pdm' },
	['bf400'] = { ['name'] = 'BF400', ['brand'] = 'Nagasaki', ['model'] = 'bf400', ['price'] = 22000, ['category'] = 'motorcycles', ['hash'] = `bf400`, ['shop'] = 'pdm' },
	['carbonrs'] = { ['name'] = 'Carbon RS', ['brand'] = 'Nagasaki', ['model'] = 'carbonrs', ['price'] = 22000, ['category'] = 'motorcycles', ['hash'] = `carbonrs`, ['shop'] = 'pdm' },
	['chimera'] = { ['name'] = 'Chimera', ['brand'] = 'Nagasaki', ['model'] = 'chimera', ['price'] = 21000, ['category'] = 'motorcycles', ['hash'] = `chimera`, ['shop'] = 'pdm' },
	['cliffhanger'] = { ['name'] = 'Cliffhanger', ['brand'] = 'Western', ['model'] = 'cliffhanger', ['price'] = 28500, ['category'] = 'motorcycles', ['hash'] = `cliffhanger`, ['shop'] = 'pdm' },
	['daemon'] = { ['name'] = 'Daemon', ['brand'] = 'WMC', ['model'] = 'daemon', ['price'] = 14000, ['category'] = 'motorcycles', ['hash'] = `daemon`, ['shop'] = 'pdm' },
	['daemon2'] = { ['name'] = 'Daemon Custom', ['brand'] = 'Western', ['model'] = 'daemon2', ['price'] = 23000, ['category'] = 'motorcycles', ['hash'] = `daemon2`, ['shop'] = 'pdm' },
	['defiler'] = { ['name'] = 'Defiler', ['brand'] = 'Shitzu', ['model'] = 'defiler', ['price'] = 30000, ['category'] = 'motorcycles', ['hash'] = `defiler`, ['shop'] = 'pdm' },
	['deathbike'] = { ['name'] = 'deathbike', ['brand'] = 'deathbike', ['model'] = 'deathbike', ['price'] = 30000, ['category'] = 'motorcycles', ['hash'] = `deathbike`, ['shop'] = 'deathbike' },
	['deathbike2'] = { ['name'] = 'deathbike2', ['brand'] = 'deathbike', ['model'] = 'deathbike2', ['price'] = 30000, ['category'] = 'motorcycles', ['hash'] = `deathbike2`, ['shop'] = 'deathbike2' },
	['deathbike3'] = { ['name'] = 'deathbike3', ['brand'] = 'deathbike', ['model'] = 'deathbike3', ['price'] = 30000, ['category'] = 'motorcycles', ['hash'] = `deathbike3`, ['shop'] = 'deathbike3' },
	['diablous'] = { ['name'] = 'Diablous', ['brand'] = 'Principe', ['model'] = 'diablous', ['price'] = 30000, ['category'] = 'motorcycles', ['hash'] = `diablous`, ['shop'] = 'pdm' },
	['diablous2'] = { ['name'] = 'Diablous Custom', ['brand'] = 'Principe', ['model'] = 'diablous2', ['price'] = 38000, ['category'] = 'motorcycles', ['hash'] = `diablous2`, ['shop'] = 'pdm' },
	['double'] = { ['name'] = 'Double-T', ['brand'] = 'Dinka', ['model'] = 'double', ['price'] = 28000, ['category'] = 'motorcycles', ['hash'] = `double`, ['shop'] = 'pdm' },
	['enduro'] = { ['name'] = 'Enduro', ['brand'] = 'Dinka', ['model'] = 'enduro', ['price'] = 5500, ['category'] = 'motorcycles', ['hash'] = `enduro`, ['shop'] = 'pdm' },
	['esskey'] = { ['name'] = 'Esskey', ['brand'] = 'Pegassi', ['model'] = 'esskey', ['price'] = 12000, ['category'] = 'motorcycles', ['hash'] = `esskey`, ['shop'] = 'pdm' },
	['faggio'] = { ['name'] = 'Faggio Sport', ['brand'] = 'Pegassi', ['model'] = 'faggio', ['price'] = 2000, ['category'] = 'motorcycles', ['hash'] = `faggio`, ['shop'] = 'pdm' },
	['faggio2'] = { ['name'] = 'Faggio', ['brand'] = 'Pegassi', ['model'] = 'faggio2', ['price'] = 1900, ['category'] = 'motorcycles', ['hash'] = `faggio2`, ['shop'] = 'pdm' },
	['faggio3'] = { ['name'] = 'Faggio Mod', ['brand'] = 'Pegassi', ['model'] = 'faggio3', ['price'] = 2500, ['category'] = 'motorcycles', ['hash'] = `faggio3`, ['shop'] = 'pdm' },
	['fcr'] = { ['name'] = 'FCR 1000', ['brand'] = 'Pegassi', ['model'] = 'fcr', ['price'] = 5000, ['category'] = 'motorcycles', ['hash'] = `fcr`, ['shop'] = 'pdm' },
	['fcr2'] = { ['name'] = 'FCR 1000 Custom', ['brand'] = 'Pegassi', ['model'] = 'fcr2', ['price'] = 19000, ['category'] = 'motorcycles', ['hash'] = `fcr2`, ['shop'] = 'pdm' },
	['gargoyle'] = { ['name'] = 'Gargoyle', ['brand'] = 'Western', ['model'] = 'gargoyle', ['price'] = 32000, ['category'] = 'motorcycles', ['hash'] = `gargoyle`, ['shop'] = 'pdm' },
	['hakuchou'] = { ['name'] = 'Hakuchou', ['brand'] = 'Shitzu', ['model'] = 'hakuchou', ['price'] = 17000, ['category'] = 'motorcycles', ['hash'] = `hakuchou`, ['shop'] = 'pdm' },
	['hakuchou2'] = { ['name'] = 'Hakuchou Drag', ['brand'] = 'Shitzu', ['model'] = 'hakuchou2', ['price'] = 45000, ['category'] = 'motorcycles', ['hash'] = `hakuchou2`, ['shop'] = 'pdm' },
	['hexer'] = { ['name'] = 'Hexer', ['brand'] = 'LCC', ['model'] = 'hexer', ['price'] = 16000, ['category'] = 'motorcycles', ['hash'] = `hexer`, ['shop'] = 'pdm' },
	['innovation'] = { ['name'] = 'Innovation', ['brand'] = 'LLC', ['model'] = 'innovation', ['price'] = 33500, ['category'] = 'motorcycles', ['hash'] = `innovation`, ['shop'] = 'pdm' },
	['lectro'] = { ['name'] = 'Lectro', ['brand'] = 'Principe', ['model'] = 'lectro', ['price'] = 28000, ['category'] = 'motorcycles', ['hash'] = `lectro`, ['shop'] = 'pdm' },
	['manchez'] = { ['name'] = 'Manchez', ['brand'] = 'Maibatsu', ['model'] = 'manchez', ['price'] = 8300, ['category'] = 'motorcycles', ['hash'] = `manchez`, ['shop'] = 'pdm' },
	['nemesis'] = { ['name'] = 'Nemesis', ['brand'] = 'Principe', ['model'] = 'nemesis', ['price'] = 20000, ['category'] = 'motorcycles', ['hash'] = `nemesis`, ['shop'] = 'pdm' },
	['nightblade'] = { ['name'] = 'Nightblade', ['brand'] = 'WMC', ['model'] = 'nightblade', ['price'] = 23000, ['category'] = 'motorcycles', ['hash'] = `nightblade`, ['shop'] = 'pdm' },
	['oppressor'] = { ['name'] = 'Oppressor', ['brand'] = 'Pegassi', ['model'] = 'oppressor', ['price'] = 9999999, ['category'] = 'super', ['hash'] = `oppressor`, ['shop'] = 'luxury' },
	['pcj'] = { ['name'] = 'PCJ-600', ['brand'] = 'Shitzu', ['model'] = 'pcj', ['price'] = 15000, ['category'] = 'motorcycles', ['hash'] = `pcj`, ['shop'] = 'pdm' },
	['ratbike'] = { ['name'] = 'Rat Bike', ['brand'] = 'Western', ['model'] = 'ratbike', ['price'] = 3000, ['category'] = 'motorcycles', ['hash'] = `ratbike`, ['shop'] = 'pdm' },
	['ruffian'] = { ['name'] = 'Ruffian', ['brand'] = 'Pegassi', ['model'] = 'ruffian', ['price'] = 25000, ['category'] = 'motorcycles', ['hash'] = `ruffian`, ['shop'] = 'pdm' },
	['sanchez'] = { ['name'] = 'Sanchez Livery', ['brand'] = 'Maibatsu', ['model'] = 'sanchez', ['price'] = 5300, ['category'] = 'motorcycles', ['hash'] = `sanchez`, ['shop'] = 'pdm' },
	['sanchez2'] = { ['name'] = 'Sanchez', ['brand'] = 'Maibatsu', ['model'] = 'sanchez2', ['price'] = 5300, ['category'] = 'motorcycles', ['hash'] = `sanchez2`, ['shop'] = 'pdm' },
	['sanctus'] = { ['name'] = 'Sanctus', ['brand'] = 'LCC', ['model'] = 'sanctus', ['price'] = 35000, ['category'] = 'motorcycles', ['hash'] = `sanctus`, ['shop'] = 'pdm' },
	['shotaro'] = { ['name'] = 'Shotaro Concept', ['brand'] = 'Nagasaki', ['model'] = 'shotaro', ['price'] = 320000, ['category'] = 'motorcycles', ['hash'] = `shotaro`, ['shop'] = 'pdm' },
	['sovereign'] = { ['name'] = 'Sovereign', ['brand'] = 'WMC', ['model'] = 'sovereign', ['price'] = 8000, ['category'] = 'motorcycles', ['hash'] = `sovereign`, ['shop'] = 'pdm' },
	['stryder'] = { ['name'] = 'Stryder', ['brand'] = 'Nagasaki', ['model'] = 'stryder', ['price'] = 50000, ['category'] = 'motorcycles', ['hash'] = `stryder`, ['shop'] = 'pdm' },
	['thrust'] = { ['name'] = 'Thrust', ['brand'] = 'Dinka', ['model'] = 'thrust', ['price'] = 22000, ['category'] = 'motorcycles', ['hash'] = `thrust`, ['shop'] = 'pdm' },
	['vader'] = { ['name'] = 'Vader', ['brand'] = 'Shitzu', ['model'] = 'vader', ['price'] = 7200, ['category'] = 'motorcycles', ['hash'] = `vader`, ['shop'] = 'pdm' },
	['vindicator'] = { ['name'] = 'Vindicator', ['brand'] = 'Dinka', ['model'] = 'vindicator', ['price'] = 19000, ['category'] = 'motorcycles', ['hash'] = `vindicator`, ['shop'] = 'pdm' },
	['vortex'] = { ['name'] = 'Vortex', ['brand'] = 'Pegassi', ['model'] = 'vortex', ['price'] = 31000, ['category'] = 'motorcycles', ['hash'] = `vortex`, ['shop'] = 'pdm' },
	['wolfsbane'] = { ['name'] = 'Wolfsbane', ['brand'] = 'Western', ['model'] = 'wolfsbane', ['price'] = 14000, ['category'] = 'motorcycles', ['hash'] = `wolfsbane`, ['shop'] = 'pdm' },
	['zombiea'] = { ['name'] = 'Zombie Bobber', ['brand'] = 'Western', ['model'] = 'zombiea', ['price'] = 28000, ['category'] = 'motorcycles', ['hash'] = `zombiea`, ['shop'] = 'pdm' },
	['zombieb'] = { ['name'] = 'Zombie Chopper', ['brand'] = 'Western', ['model'] = 'zombieb', ['price'] = 27000, ['category'] = 'motorcycles', ['hash'] = `zombieb`, ['shop'] = 'pdm' },
	['manchez2'] = { ['name'] = 'Manchez', ['brand'] = 'Maibatsu', ['model'] = 'manchez2', ['price'] = 14000, ['category'] = 'motorcycles', ['hash'] = `manchez2`, ['shop'] = 'pdm' },
	--- Muscle
	['blade'] = { ['name'] = 'Blade', ['brand'] = 'Vapid', ['model'] = 'blade', ['price'] = 23500, ['category'] = 'muscle', ['hash'] = `blade`, ['shop'] = 'pdm' },
	['buccaneer'] = { ['name'] = 'Buccaneer', ['brand'] = 'Albany', ['model'] = 'buccaneer', ['price'] = 22500, ['category'] = 'muscle', ['hash'] = `buccaneer`, ['shop'] = 'pdm' },
	['buccaneer2'] = { ['name'] = 'Buccaneer Rider', ['brand'] = 'Albany', ['model'] = 'buccaneer2', ['price'] = 24500, ['category'] = 'muscle', ['hash'] = `buccaneer2`, ['shop'] = 'pdm' },
	['chino'] = { ['name'] = 'Chino', ['brand'] = 'Vapid', ['model'] = 'chino', ['price'] = 5000, ['category'] = 'muscle', ['hash'] = `chino`, ['shop'] = 'pdm' },
	['chino2'] = { ['name'] = 'Chino Luxe', ['brand'] = 'Vapid', ['model'] = 'chino2', ['price'] = 8000, ['category'] = 'muscle', ['hash'] = `chino2`, ['shop'] = 'pdm' },
	['clique'] = { ['name'] = 'Clique', ['brand'] = 'Vapid', ['model'] = 'clique', ['price'] = 20000, ['category'] = 'muscle', ['hash'] = `clique`, ['shop'] = 'clique' },
	['coquette3'] = { ['name'] = 'Coquette BlackFin', ['brand'] = 'Invetero', ['model'] = 'coquette3', ['price'] = 180000, ['category'] = 'muscle', ['hash'] = `coquette3`, ['shop'] = 'pdm' },
	['deviant'] = { ['name'] = 'Deviant', ['brand'] = 'Schyster', ['model'] = 'deviant', ['price'] = 70000, ['category'] = 'muscle', ['hash'] = `deviant`, ['shop'] = 'deviant' },
	['dominator'] = { ['name'] = 'Dominator', ['brand'] = 'Vapid', ['model'] = 'dominator', ['price'] = 62500, ['category'] = 'muscle', ['hash'] = `dominator`, ['shop'] = 'pdm' },
	['dominator2'] = { ['name'] = 'Pißwasser Dominator', ['brand'] = 'Vapid', ['price'] = dominator2, ['category'] = '50000', ['model'] = 'muscle', ['hash'] = `dominator2`, ['shop'] = 'dominator2' },
	['dominator3'] = { ['name'] = 'Dominator GTX', ['brand'] = 'Vapid', ['model'] = 'dominator3', ['price'] = 70000, ['category'] = 'muscle', ['hash'] = `dominator3`, ['shop'] = 'pdm' },
	['dominator4'] = { ['name'] = 'Dominator Arena', ['brand'] = 'Vapid', ['model'] = 'dominator4', ['price'] = 200000, ['category'] = 'muscle', ['hash'] = `dominator4`, ['shop'] = 'dominator4' },
	['dominator7'] = { ['name'] = 'Dominator ASP', ['brand'] = 'Vapid', ['model'] = 'dominator7', ['price'] = 110000, ['category'] = 'muscle', ['hash'] = `dominator7`, ['shop'] = 'dominator7' },
	['dominator8'] = { ['name'] = 'Dominator GTT', ['brand'] = 'Vapid', ['model'] = 'dominator8', ['price'] = 80000, ['category'] = 'muscle', ['hash'] = `dominator8`, ['shop'] = 'dominator8' },
	['dukes'] = { ['name'] = 'Dukes', ['brand'] = 'Imponte', ['model'] = 'dukes', ['price'] = 23500, ['category'] = 'muscle', ['hash'] = `dukes`, ['shop'] = 'pdm' },
	['dukes2'] = { ['name'] = 'Dukes Nightrider', ['brand'] = 'Imponte', ['model'] = 'dukes2', ['price'] = 60000, ['category'] = 'muscle', ['hash'] = `dukes2`, ['shop'] = 'pdm' },
	['dukes3'] = { ['name'] = 'Beater Dukes', ['brand'] = 'Imponte', ['model'] = 'dukes3', ['price'] = 45000, ['category'] = 'muscle', ['hash'] = `dukes3`, ['shop'] = 'pdm' },
	['faction'] = { ['name'] = 'Faction', ['brand'] = 'Willard', ['model'] = 'faction', ['price'] = 17000, ['category'] = 'muscle', ['hash'] = `faction`, ['shop'] = 'pdm' },
	['faction2'] = { ['name'] = 'Faction Rider', ['brand'] = 'Willard', ['model'] = 'faction2', ['price'] = 19000, ['category'] = 'muscle', ['hash'] = `faction2`, ['shop'] = 'pdm' },
	['faction3'] = { ['name'] = 'Faction Custom Donk', ['brand'] = 'Willard', ['model'] = 'faction3', ['price'] = 35000, ['category'] = 'muscle', ['hash'] = `faction3`, ['shop'] = 'pdm' },
	['ellie'] = { ['name'] = 'Ellie', ['brand'] = 'Vapid', ['model'] = 'ellie', ['price'] = 42250, ['category'] = 'muscle', ['hash'] = `ellie`, ['shop'] = 'pdm' },
	['gauntlet'] = { ['name'] = 'Gauntlet', ['brand'] = 'Bravado', ['model'] = 'gauntlet', ['price'] = 28500, ['category'] = 'muscle', ['hash'] = `gauntlet`, ['shop'] = 'pdm' },
	['gauntlet2'] = { ['name'] = 'Redwood Gauntlet', ['brand'] = 'Bravado', ['model'] = 'gauntlet2', ['price'] = 70000, ['category'] = 'muscle', ['hash'] = `gauntlet2`, ['shop'] = 'pdm' },
	['gauntlet3'] = { ['name'] = 'Classic Gauntlet', ['brand'] = 'Bravado', ['model'] = 'gauntlet3', ['price'] = 75000, ['category'] = 'muscle', ['hash'] = `gauntlet3`, ['shop'] = 'gauntlet3' },
	['gauntlet4'] = { ['name'] = 'Gauntlet Hellfire', ['brand'] = 'Bravado', ['model'] = 'gauntlet4', ['price'] = 80000, ['category'] = 'muscle', ['hash'] = `gauntlet4`, ['shop'] = 'gauntlet4' },
	['gauntlet5'] = { ['name'] = 'Gauntlet Classic Custom', ['brand'] = 'Bravado', ['model'] = 'gauntlet5', ['price'] = 120000, ['category'] = 'muscle', ['hash'] = `gauntlet5`, ['shop'] = 'pdm' },
	['hermes'] = { ['name'] = 'Hermes', ['brand'] = 'Albany', ['model'] = 'hermes', ['price'] = 535000, ['category'] = 'muscle', ['hash'] = `hermes`, ['shop'] = 'pdm' },
	['hotknife'] = { ['name'] = 'Hotknife', ['brand'] = 'Vapid', ['model'] = 'hotknife', ['price'] = 90000, ['category'] = 'muscle', ['hash'] = `hotknife`, ['shop'] = 'pdm' },
	['hustler'] = { ['name'] = 'Hustler', ['brand'] = 'Vapid', ['model'] = 'hustler', ['price'] = 95000, ['category'] = 'muscle', ['hash'] = `hustler`, ['shop'] = 'pdm' },
	['impaler'] = { ['name'] = 'impaler', ['brand'] = 'Vapid', ['model'] = 'impaler', ['price'] = 95000, ['category'] = 'muscle', ['hash'] = `impaler`, ['shop'] = 'impaler' },
	['impaler2'] = { ['name'] = 'impaler2', ['brand'] = 'Vapid', ['model'] = 'impaler2', ['price'] = 95000, ['category'] = 'muscle', ['hash'] = `impaler2`, ['shop'] = 'impaler2' },
	['impaler3'] = { ['name'] = 'impaler3', ['brand'] = 'Vapid', ['model'] = 'impaler3', ['price'] = 95000, ['category'] = 'muscle', ['hash'] = `impaler3`, ['shop'] = 'impaler3' },
	['impaler4'] = { ['name'] = 'impaler4', ['brand'] = 'Vapid', ['model'] = 'impaler4', ['price'] = 95000, ['category'] = 'muscle', ['hash'] = `impaler4`, ['shop'] = 'impaler4' },
	['imperator'] = { ['name'] = 'imperator', ['brand'] = 'Vapid', ['model'] = 'imperator', ['price'] = 95000, ['category'] = 'muscle', ['hash'] = `imperator`, ['shop'] = 'imperator' },
	['imperator2'] = { ['name'] = 'imperator2', ['brand'] = 'Vapid', ['model'] = 'imperator2', ['price'] = 95000, ['category'] = 'muscle', ['hash'] = `imperator2`, ['shop'] = 'imperator2' },
	['imperator3'] = { ['name'] = 'imperator3', ['brand'] = 'Vapid', ['model'] = 'imperator3', ['price'] = 95000, ['category'] = 'muscle', ['hash'] = `imperator3`, ['shop'] = 'imperator3' },
	['lurcher'] = { ['name'] = 'Gauntlet Classic Custom', ['brand'] = 'Bravado', ['model'] = 'lurcher', ['price'] = 21000, ['category'] = 'muscle', ['hash'] = `lurcher`, ['shop'] = 'pdm' },
	['moonbeam'] = { ['name'] = 'Moonbeam', ['brand'] = 'Declasse', ['model'] = 'moonbeam', ['price'] = 13000, ['category'] = 'vans', ['hash'] = `moonbeam`, ['shop'] = 'pdm' },
	['moonbeam2'] = { ['name'] = 'Moonbeam Custom', ['brand'] = 'Declasse', ['model'] = 'moonbeam2', ['price'] = 15000, ['category'] = 'vans', ['hash'] = `moonbeam2`, ['shop'] = 'pdm' },
	['nightshade'] = { ['name'] = 'Nightshade', ['brand'] = 'Imponte', ['model'] = 'nightshade', ['price'] = 70000, ['category'] = 'muscle', ['hash'] = `nightshade`, ['shop'] = 'pdm' },
	['peyote2'] = { ['name'] = 'Peyote Gasser', ['brand'] = 'Vapid', ['model'] = 'peyote2', ['price'] = 40000, ['category'] = 'sportsclassic', ['hash'] = `peyote2`, ['shop'] = 'peyote2' },
	['phoenix'] = { ['name'] = 'Phoenix', ['brand'] = 'Imponte', ['model'] = 'phoenix', ['price'] = 65000, ['category'] = 'muscle', ['hash'] = `phoenix`, ['shop'] = 'pdm' },
	['picador'] = { ['name'] = 'Picador', ['brand'] = 'Cheval', ['model'] = 'picador', ['price'] = 20000, ['category'] = 'muscle', ['hash'] = `picador`, ['shop'] = 'pdm' },
	['ratloader2'] = { ['name'] = 'ratloader2', ['brand'] = 'Ratloader2', ['model'] = 'ratloader2', ['price'] = 20000, ['category'] = 'muscle', ['hash'] = `ratloader2`, ['shop'] = 'pdm' },
	['ruiner'] = { ['name'] = 'Ruiner', ['brand'] = 'Imponte', ['model'] = 'ruiner', ['price'] = 29000, ['category'] = 'muscle', ['hash'] = `ruiner`, ['shop'] = 'pdm' },
	['ruiner2'] = { ['name'] = 'Ruiner 2000', ['brand'] = 'Imponte', ['model'] = 'ruiner2', ['price'] = 50000, ['category'] = 'muscle', ['hash'] = `ruiner2`, ['shop'] = 'pdm' },
	['sabregt'] = { ['name'] = 'Sabre Turbo', ['brand'] = 'Declasse', ['model'] = 'sabregt', ['price'] = 23000, ['category'] = 'muscle', ['hash'] = `sabregt`, ['shop'] = 'pdm' },
	['sabregt2'] = { ['name'] = 'Sabre GT', ['brand'] = 'Declasse', ['model'] = 'sabregt2', ['price'] = 26500, ['category'] = 'muscle', ['hash'] = `sabregt2`, ['shop'] = 'pdm' },
	['slamvan'] = { ['name'] = 'Slam Van', ['brand'] = 'Vapid', ['model'] = 'slamvan', ['price'] = 30000, ['category'] = 'muscle', ['hash'] = `slamvan`, ['shop'] = 'pdm' },
	['slamvan2'] = { ['name'] = 'Lost Slam Van', ['brand'] = 'Vapid', ['model'] = 'slamvan2', ['price'] = 90000, ['category'] = 'muscle', ['hash'] = `slamvan2`, ['shop'] = 'pdm' },
	['slamvan3'] = { ['name'] = 'Slam Van Custom', ['brand'] = 'Vapid', ['model'] = 'slamvan3', ['price'] = 17000, ['category'] = 'muscle', ['hash'] = `slamvan3`, ['shop'] = 'pdm' },
	['stalion'] = { ['name'] = 'Stallion', ['brand'] = 'Declasse', ['model'] = 'stalion', ['price'] = 33000, ['category'] = 'muscle', ['hash'] = `stalion`, ['shop'] = 'pdm' },
	['stalion2'] = { ['name'] = 'Stallion Burgershot', ['brand'] = 'Declasse', ['model'] = 'stalion2', ['price'] = 40000, ['category'] = 'muscle', ['hash'] = `stalion2`, ['shop'] = 'pdm' },
	['tampa'] = { ['name'] = 'Tampa', ['brand'] = 'Declasse', ['model'] = 'tampa', ['price'] = 24500, ['category'] = 'muscle', ['hash'] = `tampa`, ['shop'] = 'pdm' },
	['tulip'] = { ['name'] = 'Tulip', ['brand'] = 'Declasse', ['model'] = 'tulip', ['price'] = 80000, ['category'] = 'muscle', ['hash'] = `tulip`, ['shop'] = 'tulip' },
	['vamos'] = { ['name'] = 'Vamos', ['brand'] = 'Declasse', ['model'] = 'vamos', ['price'] = 30000, ['category'] = 'muscle', ['hash'] = `vamos`, ['shop'] = 'vamos' },
	['vigero'] = { ['name'] = 'Vigero', ['brand'] = 'Declasse', ['model'] = 'vigero', ['price'] = 39500, ['category'] = 'muscle', ['hash'] = `vigero`, ['shop'] = 'pdm' },
	['virgo'] = { ['name'] = 'Virgo', ['brand'] = 'Albany', ['model'] = 'virgo', ['price'] = 22000, ['category'] = 'muscle', ['hash'] = `virgo`, ['shop'] = 'pdm' },
	['virgo2'] = { ['name'] = 'Virgo Custom Classic', ['brand'] = 'Dundreary', ['model'] = 'virgo2', ['price'] = 21000, ['category'] = 'muscle', ['hash'] = `virgo2`, ['shop'] = 'pdm' },
	['virgo3'] = { ['name'] = 'Virgo Custom Classic', ['brand'] = 'Dundreary', ['model'] = 'virgo3', ['price'] = 21000, ['category'] = 'muscle', ['hash'] = `virgo3`, ['shop'] = 'pdm' },
	['voodoo'] = { ['name'] = 'Voodoo', ['brand'] = 'Declasse', ['model'] = 'voodoo', ['price'] = 13000, ['category'] = 'muscle', ['hash'] = `voodoo`, ['shop'] = 'pdm' },
	['yosemite'] = { ['name'] = 'Yosemite', ['brand'] = 'Declasse', ['model'] = 'yosemite', ['price'] = 19500, ['category'] = 'muscle', ['hash'] = `yosemite`, ['shop'] = 'pdm' },
	['yosemite2'] = { ['name'] = 'Yosemite Drift', ['brand'] = 'Declasse', ['model'] = 'yosemite2', ['price'] = 55000, ['category'] = 'muscle', ['hash'] = `yosemite2`, ['shop'] = 'pdm' },
	['yosemite3'] = { ['name'] = 'Yosemite Rancher', ['brand'] = 'Declasse', ['price'] = 425000, ['category'] = 'offroad', ['model'] = 'yosemite3', ['hash'] = `yosemite3`, ['shop'] = 'yosemite3' },
	--- Off-Road
	['bfinjection'] = { ['name'] = 'Bf Injection', ['brand'] = 'Annis', ['price'] = 9000, ['category'] = 'offroad', ['model'] = 'bfinjection', ['hash'] = `bfinjection`, ['shop'] = 'bfinjection' },
	['bifta'] = { ['name'] = 'Bifta', ['brand'] = 'Annis', ['price'] = 15500, ['category'] = 'offroad', ['model'] = 'bifta', ['hash'] = `bifta`, ['shop'] = 'bifta' },
	['blazer'] = { ['name'] = 'Blazer', ['brand'] = 'Annis', ['price'] = 7500, ['category'] = 'offroad', ['model'] = 'blazer', ['hash'] = `blazer`, ['shop'] = 'blazer' },
	['blazer2'] = { ['name'] = 'Blazer Lifeguard', ['brand'] = 'Nagasaki', ['model'] = 'blazer2', ['price'] = 7000, ['category'] = 'offroad', ['hash'] = `blazer2`, ['shop'] = 'pdm' },
	['blazer3'] = { ['name'] = 'Blazer Hot Rod', ['brand'] = 'Nagasaki', ['model'] = 'blazer3', ['price'] = 7000, ['category'] = 'offroad', ['hash'] = `blazer3`, ['shop'] = 'pdm' },
	['blazer4'] = { ['name'] = 'Blazer Sport', ['brand'] = 'Annis', ['price'] = 9250, ['category'] = 'offroad', ['model'] = 'blazer4', ['hash'] = `blazer4`, ['shop'] = 'blazer4' },
	['blazer5'] = { ['name'] = 'Blazer Aqua', ['brand'] = 'Nagasaki', ['model'] = 'blazer5', ['price'] = 40000, ['category'] = 'offroad', ['hash'] = `blazer5`, ['shop'] = 'pdm' },
	['brawler'] = { ['name'] = 'Brawler', ['brand'] = 'Annis', ['price'] = 40000, ['category'] = 'offroad', ['model'] = 'brawler', ['hash'] = `brawler`, ['shop'] = 'brawler' },
	['caracara'] = { ['name'] = 'Caracara', ['brand'] = 'Vapid', ['model'] = 'caracara', ['price'] = 60000, ['category'] = 'offroad', ['hash'] = `caracara`, ['shop'] = 'pdm' },
	['caracara2'] = { ['name'] = 'Caracara 4x4', ['brand'] = 'Vapid', ['model'] = 'caracara2', ['price'] = 80000, ['category'] = 'offroad', ['hash'] = `caracara2`, ['shop'] = 'caracara2' },
	['dubsta3'] = { ['name'] = 'Dubsta 6x6', ['brand'] = 'Annis', ['price'] = 34000, ['category'] = 'offroad', ['model'] = 'dubsta3', ['hash'] = `dubsta3`, ['shop'] = 'dubsta3' },
	['dune'] = { ['name'] = 'Dune Buggy', ['brand'] = 'Annis', ['price'] = 14000, ['category'] = 'offroad', ['model'] = 'dune', ['hash'] = `dune`, ['shop'] = 'dune' },
	['everon'] = { ['name'] = 'Everon', ['brand'] = 'Karin', ['model'] = 'everon', ['price'] = 60000, ['category'] = 'offroad', ['hash'] = `everon`, ['shop'] = 'pdm' },
	['freecrawler'] = { ['name'] = 'Freecrawler', ['brand'] = 'Canis', ['model'] = 'freecrawler', ['price'] = 24000, ['category'] = 'offroad', ['hash'] = `freecrawler`, ['shop'] = 'freecrawler' },
	['hellion'] = { ['name'] = 'Hellion', ['brand'] = 'Annis', ['model'] = 'hellion', ['price'] = 38000, ['category'] = 'offroad', ['hash'] = `hellion`, ['shop'] = 'hellion' },
	['kalahari'] = { ['name'] = 'Kalahari', ['brand'] = 'Canis', ['model'] = 'kalahari', ['price'] = 14000, ['category'] = 'offroad', ['hash'] = `kalahari`, ['shop'] = 'pdm' },
	['kamacho'] = { ['name'] = 'Kamacho', ['brand'] = 'Canis', ['model'] = 'kamacho', ['price'] = 50000, ['category'] = 'offroad', ['hash'] = `kamacho`, ['shop'] = 'pdm' },
	['mesa3'] = { ['name'] = 'Mesa Merryweather', ['brand'] = 'Canis', ['model'] = 'mesa3', ['price'] = 400000, ['category'] = 'offroad', ['hash'] = `mesa3`, ['shop'] = 'pdm' },
	['outlaw'] = { ['name'] = 'Outlaw', ['brand'] = 'Nagasaki', ['model'] = 'outlaw', ['price'] = 15000, ['category'] = 'offroad', ['hash'] = `outlaw`, ['shop'] = 'pdm' },
	['rancherxl'] = { ['name'] = 'Rancher XL', ['brand'] = 'Declasse', ['model'] = 'rancherxl', ['price'] = 24000, ['category'] = 'offroad', ['hash'] = `rancherxl`, ['shop'] = 'pdm' },
	['rebel2'] = { ['name'] = 'Rebel', ['brand'] = 'Annis', ['model'] = 'rebel2', ['price'] = 20000, ['category'] = 'offroad', ['hash'] = `rebel2`, ['shop'] = 'pdm' },
	['riata'] = { ['name'] = 'Riata', ['brand'] = 'Vapid', ['model'] = 'riata', ['price'] = 380000, ['category'] = 'offroad', ['hash'] = `riata`, ['shop'] = 'pdm' },
	['sandking'] = { ['name'] = 'Sandking', ['brand'] = 'Annis', ['price'] = 25000, ['category'] = 'offroad', ['model'] = 'sandking', ['hash'] = `sandking`, ['shop'] = 'sandking' },
	['sandking2'] = { ['name'] = 'Sandking SWB', ['brand'] = 'Annis', ['price'] = 38000, ['category'] = 'offroad', ['model'] = 'sandking2', ['hash'] = `sandking2`, ['shop'] = 'sandking2' },
	['trophytruck'] = { ['name'] = 'Trophy Truck', ['brand'] = 'Annis', ['price'] = 60000, ['category'] = 'offroad', ['model'] = 'trophytruck', ['hash'] = `trophytruck`, ['shop'] = 'trophytruck' },
	['trophytruck2'] = { ['name'] = 'Trophy Truck Limited', ['brand'] = 'Annis', ['price'] = 80000, ['category'] = 'offroad', ['model'] = 'trophytruck2', ['hash'] = `trophytruck2`, ['shop'] = 'trophytruck2' },
	['vagrant'] = { ['name'] = 'Vagrant', ['brand'] = 'Maxwell', ['price'] = 50000, ['category'] = 'offroad', ['model'] = 'vagrant', ['hash'] = `vagrant`, ['shop'] = 'vagrant' },
	['verus'] = { ['name'] = 'Verus', ['brand'] = 'Dinka', ['price'] = 20000, ['category'] = 'offroad', ['model'] = 'verus', ['hash'] = `verus`, ['shop'] = 'verus' },
	['winky'] = { ['name'] = 'Winky', ['brand'] = 'Vapid', ['price'] = 10000, ['category'] = 'offroad', ['model'] = 'winky', ['hash'] = `winky`, ['shop'] = 'winky' },
	--- SUVs
	['baller'] = { ['name'] = 'Baller', ['brand'] = 'Gallivanter', ['model'] = 'baller', ['price'] = 22000, ['category'] = 'suvs', ['hash'] = `baller`, ['shop'] = 'pdm' },
	['baller2'] = { ['name'] = 'Baller', ['brand'] = 'Gallivanter', ['model'] = 'baller2', ['price'] = 15000, ['category'] = 'suvs', ['hash'] = `baller2`, ['shop'] = 'pdm' },
	['baller3'] = { ['name'] = 'Baller LE', ['brand'] = 'Gallivanter', ['model'] = 'baller3', ['price'] = 15000, ['category'] = 'suvs', ['hash'] = `baller3`, ['shop'] = 'pdm' },
	['baller4'] = { ['name'] = 'Baller LE LWB', ['brand'] = 'Gallivanter', ['model'] = 'baller4', ['price'] = 29000, ['category'] = 'suvs', ['hash'] = `baller4`, ['shop'] = 'pdm' },
	['baller5'] = { ['name'] = 'Baller LE (Armored)', ['brand'] = 'Gallivanter', ['model'] = 'baller5', ['price'] = 78000, ['category'] = 'suvs', ['hash'] = `baller5`, ['shop'] = 'baller5' },
	['baller6'] = { ['name'] = 'Baller LE LWB (Armored)', ['brand'] = 'Gallivanter', ['model'] = 'baller6', ['price'] = 82000, ['category'] = 'suvs', ['hash'] = `baller6`, ['shop'] = 'baller6' },
	['bjxl'] = { ['name'] = 'BeeJay XL', ['brand'] = 'Karin', ['model'] = 'bjxl', ['price'] = 19000, ['category'] = 'suvs', ['hash'] = `bjxl`, ['shop'] = 'pdm' },
	['cavalcade'] = { ['name'] = 'Cavalcade', ['brand'] = 'Albany', ['model'] = 'cavalcade', ['price'] = 14000, ['category'] = 'suvs', ['hash'] = `cavalcade`, ['shop'] = 'pdm' },
	['cavalcade2'] = { ['name'] = 'Cavalcade', ['brand'] = 'Albany', ['model'] = 'cavalcade2', ['price'] = 16500, ['category'] = 'suvs', ['hash'] = `cavalcade2`, ['shop'] = 'pdm' },
	['contender'] = { ['name'] = 'Contender', ['brand'] = 'Vapid', ['model'] = 'contender', ['price'] = 35000, ['category'] = 'suvs', ['hash'] = `contender`, ['shop'] = 'pdm' },
	['dubsta'] = { ['name'] = 'Dubsta', ['brand'] = 'Benefactor', ['model'] = 'dubsta', ['price'] = 19000, ['category'] = 'suvs', ['hash'] = `dubsta`, ['shop'] = 'pdm' },
	['dubsta2'] = { ['name'] = 'Dubsta Luxuary', ['brand'] = 'Benefactor', ['model'] = 'dubsta2', ['price'] = 19500, ['category'] = 'suvs', ['hash'] = `dubsta2`, ['shop'] = 'pdm' },
	['fq2'] = { ['name'] = 'FQ2', ['brand'] = 'Fathom', ['model'] = 'fq2', ['price'] = 18500, ['category'] = 'suvs', ['hash'] = `fq2`, ['shop'] = 'pdm' },
	['granger'] = { ['name'] = 'Granger', ['brand'] = 'Declasse', ['model'] = 'granger', ['price'] = 22000, ['category'] = 'suvs', ['hash'] = `granger`, ['shop'] = 'pdm' },
	['gresley'] = { ['name'] = 'Gresley', ['brand'] = 'Bravado', ['model'] = 'gresley', ['price'] = 25000, ['category'] = 'suvs', ['hash'] = `gresley`, ['shop'] = 'pdm' },
	['habanero'] = { ['name'] = 'Habanero', ['brand'] = 'Emperor', ['model'] = 'habanero', ['price'] = 20000, ['category'] = 'suvs', ['hash'] = `habanero`, ['shop'] = 'pdm' },
	['huntley'] = { ['name'] = 'Huntley S', ['brand'] = 'Enus', ['model'] = 'huntley', ['price'] = 24500, ['category'] = 'suvs', ['hash'] = `huntley`, ['shop'] = 'pdm' },
	['landstalker'] = { ['name'] = 'Landstalker', ['brand'] = 'Dundreary', ['model'] = 'landstalker', ['price'] = 12000, ['category'] = 'suvs', ['hash'] = `landstalker`, ['shop'] = 'pdm' },
	['landstalker2'] = { ['name'] = 'Landstalker XL', ['brand'] = 'Dundreary', ['model'] = 'landstalker2', ['price'] = 26000, ['category'] = 'suvs', ['hash'] = `landstalker2`, ['shop'] = 'pdm' },
	['mesa'] = { ['name'] = 'Mesa', ['brand'] = 'Canis', ['model'] = 'mesa', ['price'] = 12000, ['category'] = 'offroad', ['hash'] = `mesa`, ['shop'] = 'pdm' },
	['novak'] = { ['name'] = 'Novak', ['brand'] = 'Lampadati', ['model'] = 'novak', ['price'] = 70000, ['category'] = 'suvs', ['hash'] = `novak`, ['shop'] = 'novak' },
	['patriot'] = { ['name'] = 'Patriot', ['brand'] = 'Mammoth', ['model'] = 'patriot', ['price'] = 21000, ['category'] = 'suvs', ['hash'] = `patriot`, ['shop'] = 'pdm' },
	['radi'] = { ['name'] = 'Radius', ['brand'] = 'Vapid', ['model'] = 'radi', ['price'] = 18000, ['category'] = 'suvs', ['hash'] = `radi`, ['shop'] = 'pdm' },
	['rebla'] = { ['name'] = 'Rebla GTS', ['brand'] = 'Übermacht', ['model'] = 'rebla', ['price'] = 21000, ['category'] = 'suvs', ['hash'] = `rebla`, ['shop'] = 'pdm' },
	['rocoto'] = { ['name'] = 'Rocoto', ['brand'] = 'Obey', ['model'] = 'rocoto', ['price'] = 13000, ['category'] = 'suvs', ['hash'] = `rocoto`, ['shop'] = 'pdm' },
	['seminole'] = { ['name'] = 'Seminole', ['brand'] = 'Canis', ['model'] = 'seminole', ['price'] = 20000, ['category'] = 'suvs', ['hash'] = `seminole`, ['shop'] = 'pdm' },
	['seminole2'] = { ['name'] = 'Seminole Frontier', ['brand'] = 'Canis', ['model'] = 'seminole2', ['price'] = 13000, ['category'] = 'suvs', ['hash'] = `seminole2`, ['shop'] = 'pdm' },
	['serrano'] = { ['name'] = 'Serrano', ['brand'] = 'Benefactor', ['model'] = 'serrano', ['price'] = 48000, ['category'] = 'suvs', ['hash'] = `serrano`, ['shop'] = 'pdm' },
	['toros'] = { ['name'] = 'Toros', ['brand'] = 'Pegassi', ['model'] = 'toros', ['price'] = 65000, ['category'] = 'suvs', ['hash'] = `toros`, ['shop'] = 'toros' },
	['xls'] = { ['name'] = 'XLS', ['brand'] = 'Benefactor', ['model'] = 'xls', ['price'] = 17000, ['category'] = 'suvs', ['hash'] = `xls`, ['shop'] = 'pdm' },
	--- Sedans
	['asea'] = { ['name'] = 'Asea', ['brand'] = 'Declasse', ['model'] = 'asea', ['price'] = 2500, ['category'] = 'sedans', ['hash'] = `asea`, ['shop'] = 'pdm' },
	['asterope'] = { ['name'] = 'Asterope', ['brand'] = 'Karin', ['model'] = 'asterope', ['price'] = 11000, ['category'] = 'sedans', ['hash'] = `asterope`, ['shop'] = 'pdm' },
	['cog55'] = { ['name'] = 'Cognoscenti 55', ['brand'] = 'Enus', ['model'] = 'cog55', ['price'] = 22000, ['category'] = 'sedans', ['hash'] = `cog55`, ['shop'] = 'pdm' },
	['cognoscenti'] = { ['name'] = 'Cognoscenti', ['brand'] = 'Enus', ['model'] = 'cognoscenti', ['price'] = 22500, ['category'] = 'sedans', ['hash'] = `cognoscenti`, ['shop'] = 'pdm' },
	['emperor'] = { ['name'] = 'Emperor', ['brand'] = 'Albany', ['model'] = 'emperor', ['price'] = 4250, ['category'] = 'sedans', ['hash'] = `emperor`, ['shop'] = 'pdm' },
	['fugitive'] = { ['name'] = 'Fugitive', ['brand'] = 'Cheval', ['model'] = 'fugitive', ['price'] = 20000, ['category'] = 'sedans', ['hash'] = `fugitive`, ['shop'] = 'pdm' },
	['glendale'] = { ['name'] = 'Glendale', ['brand'] = 'Benefactor', ['model'] = 'glendale', ['price'] = 3400, ['category'] = 'sedans', ['hash'] = `glendale`, ['shop'] = 'pdm' },
	['glendale2'] = { ['name'] = 'Glendale', ['brand'] = 'Benefactor', ['model'] = 'glendale2', ['price'] = 12000, ['category'] = 'sedans', ['hash'] = `glendale2`, ['shop'] = 'pdm' },
	['ingot'] = { ['name'] = 'Ingot', ['brand'] = 'Vulcar', ['model'] = 'ingot', ['price'] = 4999, ['category'] = 'sedans', ['hash'] = `ingot`, ['shop'] = 'pdm' },
	['intruder'] = { ['name'] = 'Intruder', ['brand'] = 'Karin', ['model'] = 'intruder', ['price'] = 11250, ['category'] = 'sedans', ['hash'] = `intruder`, ['shop'] = 'pdm' },
	['premier'] = { ['name'] = 'Premier', ['brand'] = 'Declasse', ['model'] = 'premier', ['price'] = 12000, ['category'] = 'sedans', ['hash'] = `premier`, ['shop'] = 'pdm' },
	['primo'] = { ['name'] = 'Primo', ['brand'] = 'Albany', ['model'] = 'primo', ['price'] = 5000, ['category'] = 'sedans', ['hash'] = `primo`, ['shop'] = 'pdm' },
	['primo2'] = { ['name'] = 'Primo Custom', ['brand'] = 'Albany', ['model'] = 'primo2', ['price'] = 14500, ['category'] = 'sedans', ['hash'] = `primo2`, ['shop'] = 'pdm' },
	['regina'] = { ['name'] = 'Regina', ['brand'] = 'Dundreary', ['model'] = 'regina', ['price'] = 7000, ['category'] = 'sedans', ['hash'] = `regina`, ['shop'] = 'pdm' },
	['stafford'] = { ['name'] = 'Stafford', ['brand'] = 'Enus', ['model'] = 'stafford', ['price'] = 30000, ['category'] = 'sedans', ['hash'] = `stafford`, ['shop'] = 'stafford' },
	['stanier'] = { ['name'] = 'Stanier', ['brand'] = 'Vapid', ['model'] = 'stanier', ['price'] = 19000, ['category'] = 'sedans', ['hash'] = `stanier`, ['shop'] = 'pdm' },
	['stratum'] = { ['name'] = 'Stratum', ['brand'] = 'Zirconium', ['model'] = 'stratum', ['price'] = 15000, ['category'] = 'sedans', ['hash'] = `stratum`, ['shop'] = 'pdm' },
	['stretch'] = { ['name'] = 'Stretch', ['brand'] = 'Dundreary', ['model'] = 'stretch', ['price'] = 19000, ['category'] = 'sedans', ['hash'] = `stretch`, ['shop'] = 'pdm' },
	['superd'] = { ['name'] = 'Super Diamond', ['brand'] = 'Enus', ['model'] = 'superd', ['price'] = 17000, ['category'] = 'sedans', ['hash'] = `superd`, ['shop'] = 'pdm' },
	['surge'] = { ['name'] = 'Surge', ['brand'] = 'Cheval', ['model'] = 'surge', ['price'] = 20000, ['category'] = 'sedans', ['hash'] = `surge`, ['shop'] = 'pdm' },
	['tailgater'] = { ['name'] = 'Tailgater', ['brand'] = 'Obey', ['model'] = 'tailgater', ['price'] = 22000, ['category'] = 'sedans', ['hash'] = `tailgater`, ['shop'] = 'pdm' },
	['warrener'] = { ['name'] = 'Warrener', ['brand'] = 'Vulcar', ['model'] = 'warrener', ['price'] = 4000, ['category'] = 'sedans', ['hash'] = `warrener`, ['shop'] = 'pdm' },
	['washington'] = { ['name'] = 'Washington', ['brand'] = 'Albany', ['model'] = 'washington', ['price'] = 7000, ['category'] = 'sedans', ['hash'] = `washington`, ['shop'] = 'pdm' },
	['tailgater2'] = { ['name'] = 'Tailgater S', ['brand'] = 'Obey', ['model'] = 'tailgater2', ['price'] = 51000, ['category'] = 'sedans', ['hash'] = `tailgater2`, ['shop'] = 'tailgater2' },
	--- Sports
	['alpha'] = { ['name'] = 'Alpha', ['brand'] = 'Albany', ['model'] = 'alpha', ['price'] = 53000, ['category'] = 'sports', ['hash'] = `alpha`, ['shop'] = 'luxury' },
	['banshee'] = { ['name'] = 'Banshee', ['brand'] = 'Bravado', ['model'] = 'banshee', ['price'] = 56000, ['category'] = 'sports', ['hash'] = `banshee`, ['shop'] = 'luxury' },
	['bestiagts'] = { ['name'] = 'Bestia GTS', ['brand'] = 'Grotti', ['model'] = 'bestiagts', ['price'] = 37000, ['category'] = 'sports', ['hash'] = `bestiagts`, ['shop'] = 'luxury' },
	['blista2'] = { ['name'] = 'Blista Compact', ['brand'] = 'Dinka', ['model'] = 'blista2', ['price'] = 18950, ['category'] = 'compacts', ['hash'] = `blista2`, ['shop'] = 'pdm' },
	['blista3'] = { ['name'] = 'Blista Go Go Monkey', ['brand'] = 'Dinka', ['model'] = 'blista3', ['price'] = 15000, ['category'] = 'compacts', ['hash'] = `blista3`, ['shop'] = 'pdm' },
	['buffalo'] = { ['name'] = 'Buffalo', ['brand'] = 'Bravado', ['model'] = 'buffalo', ['price'] = 18750, ['category'] = 'sports', ['hash'] = `buffalo`, ['shop'] = 'luxury' },
	['buffalo2'] = { ['name'] = 'Buffalo S', ['brand'] = 'Bravado', ['model'] = 'buffalo2', ['price'] = 24500, ['category'] = 'sports', ['hash'] = `buffalo2`, ['shop'] = 'luxury' },
	['carbonizzare'] = { ['name'] = 'Carbonizzare', ['brand'] = 'Grotti', ['model'] = 'carbonizzare', ['price'] = 155000, ['category'] = 'sports', ['hash'] = `carbonizzare`, ['shop'] = 'luxury' },
	['comet2'] = { ['name'] = 'Comet', ['brand'] = 'Pfister', ['model'] = 'comet2', ['price'] = 130000, ['category'] = 'sports', ['hash'] = `comet2`, ['shop'] = 'luxury' },
	['comet3'] = { ['name'] = 'Comet Retro Custom', ['brand'] = 'Pfister', ['model'] = 'comet3', ['price'] = 175000, ['category'] = 'sports', ['hash'] = `comet3`, ['shop'] = 'luxury' },
	['comet4'] = { ['name'] = 'Comet Safari', ['brand'] = 'Pfister', ['model'] = 'comet4', ['price'] = 110000, ['category'] = 'sports', ['hash'] = `comet4`, ['shop'] = 'luxury' },
	['comet5'] = { ['name'] = 'Comet SR', ['brand'] = 'Pfister', ['model'] = 'comet5', ['price'] = 155000, ['category'] = 'sports', ['hash'] = `comet5`, ['shop'] = 'luxury' },
	['coquette'] = { ['name'] = 'Coquette', ['brand'] = 'Invetero', ['model'] = 'coquette', ['price'] = 145000, ['category'] = 'sports', ['hash'] = `coquette`, ['shop'] = 'luxury' },
	['coquette2'] = { ['name'] = 'Coquette Classic', ['brand'] = 'Invetero', ['model'] = 'coquette2', ['price'] = 165000, ['category'] = 'sportsclassics', ['hash'] = `coquette2`, ['shop'] = 'pdm' },
	['coquette4'] = { ['name'] = 'Coquette D10', ['brand'] = 'Invetero', ['model'] = 'coquette4', ['price'] = 220000, ['category'] = 'sports', ['hash'] = `coquette4`, ['shop'] = 'luxury' },
	['drafter'] = { ['name'] = '8F Drafter', ['brand'] = 'Obey', ['model'] = 'drafter', ['price'] = 80000, ['category'] = 'sports', ['hash'] = `drafter`, ['shop'] = 'drafter' },
	['deveste'] = { ['name'] = 'Deveste', ['brand'] = 'Principe', ['model'] = 'deveste', ['price'] = 234000, ['category'] = 'super', ['hash'] = `deveste`, ['shop'] = 'deveste' },
	['elegy'] = { ['name'] = 'Elegy Retro Custom', ['brand'] = 'Annis', ['model'] = 'elegy', ['price'] = 145000, ['category'] = 'sports', ['hash'] = `elegy`, ['shop'] = 'elegy' },
	['elegy2'] = { ['name'] = 'Elegy RH8', ['brand'] = 'Annis', ['model'] = 'elegy2', ['price'] = 150000, ['category'] = 'sports', ['hash'] = `elegy2`, ['shop'] = 'luxury' },
	['feltzer2'] = { ['name'] = 'Feltzer', ['brand'] = 'Benefactor', ['model'] = 'feltzer2', ['price'] = 97000, ['category'] = 'sports', ['hash'] = `feltzer2`, ['shop'] = 'luxury' },
	['flashgt'] = { ['name'] = 'Flash GT', ['brand'] = 'Vapid', ['model'] = 'flashgt', ['price'] = 48000, ['category'] = 'sports', ['hash'] = `flashgt`, ['shop'] = 'luxury' },
	['furoregt'] = { ['name'] = 'Furore GT', ['brand'] = 'Lampadati', ['model'] = 'furoregt', ['price'] = 78000, ['category'] = 'sports', ['hash'] = `furoregt`, ['shop'] = 'luxury' },
	['futo'] = { ['name'] = 'Futo', ['brand'] = 'Karin', ['model'] = 'futo', ['price'] = 17500, ['category'] = 'coupes', ['hash'] = `futo`, ['shop'] = 'pdm' },
	['gb200'] = { ['name'] = 'GB 200', ['brand'] = 'Vapid', ['model'] = 'gb200', ['price'] = 140000, ['category'] = 'sports', ['hash'] = `gb200`, ['shop'] = 'luxury' },
	['komoda'] = { ['name'] = 'Komoda', ['brand'] = 'Lampadati', ['model'] = 'komoda', ['price'] = 55000, ['category'] = 'sports', ['hash'] = `komoda`, ['shop'] = 'luxury' },
	['imorgon'] = { ['name'] = 'Imorgon', ['brand'] = 'Overflod', ['model'] = 'imorgon', ['price'] = 120000, ['category'] = 'sports', ['hash'] = `imorgon`, ['shop'] = 'luxury' },
	['issi7'] = { ['name'] = 'Issi Sport', ['brand'] = 'Weeny', ['model'] = 'issi7', ['price'] = 100000, ['category'] = 'compacts', ['hash'] = `issi7`, ['shop'] = 'issi7' },
	['italigto'] = { ['name'] = 'Itali GTO', ['brand'] = 'Progen', ['model'] = 'italigto', ['price'] = 260000, ['category'] = 'sports', ['hash'] = `italigto`, ['shop'] = 'italigto' },
	['jugular'] = { ['name'] = 'Jugular', ['brand'] = 'Ocelot', ['model'] = 'jugular', ['price'] = 80000, ['category'] = 'sports', ['hash'] = `jugular`, ['shop'] = 'jugular' },
	['jester'] = { ['name'] = 'Jester', ['brand'] = 'Dinka', ['model'] = 'jester', ['price'] = 132250, ['category'] = 'sports', ['hash'] = `jester`, ['shop'] = 'luxury' },
	['jester2'] = { ['name'] = 'Jester Racecar', ['brand'] = 'Dinka', ['model'] = 'jester2', ['price'] = 210000, ['category'] = 'sports', ['hash'] = `jester2`, ['shop'] = 'luxury' },
	['jester3'] = { ['name'] = 'Jester Classic', ['brand'] = 'Dinka', ['model'] = 'jester3', ['price'] = 85000, ['category'] = 'sports', ['hash'] = `jester3`, ['shop'] = 'luxury' },
	['khamelion'] = { ['name'] = 'Khamelion', ['brand'] = 'Hijak', ['model'] = 'khamelion', ['price'] = 90000, ['category'] = 'sports', ['hash'] = `khamelion`, ['shop'] = 'luxury' },
	['kuruma'] = { ['name'] = 'Kuruma', ['brand'] = 'Karin', ['model'] = 'kuruma', ['price'] = 72000, ['category'] = 'sports', ['hash'] = `kuruma`, ['shop'] = 'luxury' },
	['kuruma2'] = { ['name'] = 'kuruma2', ['brand'] = 'Karin2', ['model'] = 'kuruma2', ['price'] = 72000, ['category'] = 'sports', ['hash'] = `kuruma2`, ['shop'] = 'luxury' },
	['locust'] = { ['name'] = 'Locust', ['brand'] = 'Ocelot', ['model'] = 'locust', ['price'] = 200000, ['category'] = 'sports', ['hash'] = `locust`, ['shop'] = 'locust' },
	['lynx'] = { ['name'] = 'Lynx', ['brand'] = 'Ocelot', ['model'] = 'lynx', ['price'] = 150000, ['category'] = 'sports', ['hash'] = `lynx`, ['shop'] = 'luxury' },
	['massacro'] = { ['name'] = 'Massacro', ['brand'] = 'Dewbauchee', ['model'] = 'massacro', ['price'] = 110000, ['category'] = 'sports', ['hash'] = `massacro`, ['shop'] = 'luxury' },
	['massacro2'] = { ['name'] = 'Massacro Racecar', ['brand'] = 'Dewbauchee', ['model'] = 'massacro2', ['price'] = 80000, ['category'] = 'sports', ['hash'] = `massacro2`, ['shop'] = 'luxury' },
	['neo'] = { ['name'] = 'Neo', ['brand'] = 'Vysser', ['model'] = 'neo', ['price'] = 230000, ['category'] = 'sports', ['hash'] = `neo`, ['shop'] = 'neo' },
	['neon'] = { ['name'] = 'Neon', ['brand'] = 'Pfister', ['model'] = 'neon', ['price'] = 220000, ['category'] = 'sports', ['hash'] = `neon`, ['shop'] = 'neon' },
	['ninef'] = { ['name'] = '9F', ['brand'] = 'Obey', ['model'] = 'ninef', ['price'] = 95000, ['category'] = 'sports', ['hash'] = `ninef`, ['shop'] = 'luxury' },
	['ninef2'] = { ['name'] = '9F Cabrio', ['brand'] = 'Obey', ['model'] = 'ninef2', ['price'] = 105000, ['category'] = 'sports', ['hash'] = `ninef2`, ['shop'] = 'luxury' },
	['omnis'] = { ['name'] = 'Omnis', ['brand'] = 'Wow', ['model'] = 'omnis', ['price'] = 90000, ['category'] = 'sports', ['hash'] = `omnis`, ['shop'] = 'luxury' },
	['paragon'] = { ['name'] = 'Paragon', ['brand'] = 'Enus', ['model'] = 'paragon', ['price'] = 60000, ['category'] = 'sports', ['hash'] = `paragon`, ['shop'] = 'paragon' },
	['pariah'] = { ['name'] = 'Pariah', ['brand'] = 'Ocelot', ['model'] = 'pariah', ['price'] = 90000, ['category'] = 'sports', ['hash'] = `pariah`, ['shop'] = 'luxury' },
	['penumbra'] = { ['name'] = 'Penumbra', ['brand'] = 'Maibatsu', ['model'] = 'penumbra', ['price'] = 22000, ['category'] = 'sports', ['hash'] = `penumbra`, ['shop'] = 'luxury' },
	['penumbra2'] = { ['name'] = 'Penumbra FF', ['brand'] = 'Maibatsu', ['model'] = 'penumbra2', ['price'] = 30000, ['category'] = 'sports', ['hash'] = `penumbra2`, ['shop'] = 'luxury' },
	['rapidgt'] = { ['name'] = 'Rapid GT', ['brand'] = 'Dewbauchee', ['model'] = 'rapidgt', ['price'] = 86000, ['category'] = 'sports', ['hash'] = `rapidgt`, ['shop'] = 'luxury' },
	['rapidgt2'] = { ['name'] = 'Rapid GT Convertible', ['brand'] = 'Dewbauchee', ['model'] = 'rapidgt2', ['price'] = 92000, ['category'] = 'sports', ['hash'] = `rapidgt2`, ['shop'] = 'luxury' },
	['raptor'] = { ['name'] = 'Raptor', ['brand'] = 'BF', ['model'] = 'raptor', ['price'] = 90000, ['category'] = 'sports', ['hash'] = `raptor`, ['shop'] = 'luxury' },
	['revolter'] = { ['name'] = 'Revolter', ['brand'] = 'Ubermacht', ['model'] = 'revolter', ['price'] = 95000, ['category'] = 'sports', ['hash'] = `revolter`, ['shop'] = 'luxury' },
	['ruston'] = { ['name'] = 'Ruston', ['brand'] = 'Hijak', ['model'] = 'ruston', ['price'] = 130000, ['category'] = 'sports', ['hash'] = `ruston`, ['shop'] = 'luxury' },
	['schafter2'] = { ['name'] = 'Schafter', ['brand'] = 'Benefactor', ['model'] = 'schafter2', ['price'] = 16000, ['category'] = 'sedans', ['hash'] = `schafter2`, ['shop'] = 'pdm' },
	['schafter3'] = { ['name'] = 'Schafter V12', ['brand'] = 'Benefactor', ['model'] = 'schafter3', ['price'] = 35000, ['category'] = 'sports', ['hash'] = `schafter3`, ['shop'] = 'luxury' },
	['schafter4'] = { ['name'] = 'Schafter LWB', ['brand'] = 'Benefactor', ['model'] = 'schafter4', ['price'] = 21000, ['category'] = 'sports', ['hash'] = `schafter4`, ['shop'] = 'luxury' },
	['schlagen'] = { ['name'] = 'Schlagen GT', ['brand'] = 'Benefactor', ['model'] = 'schlagen', ['price'] = 160000, ['category'] = 'sports', ['hash'] = `schlagen`, ['shop'] = 'schlagen' },
	['schwarzer'] = { ['name'] = 'Schwartzer', ['brand'] = 'Benefactor', ['model'] = 'schwarzer', ['price'] = 47000, ['category'] = 'sports', ['hash'] = `schwarzer`, ['shop'] = 'luxury' },
	['sentinel3'] = { ['name'] = 'Sentinel Classic', ['brand'] = 'Übermacht', ['model'] = 'sentinel3', ['price'] = 70000, ['category'] = 'coupes', ['hash'] = `sentinel3`, ['shop'] = 'pdm' },
	['seven70'] = { ['name'] = 'Seven-70', ['brand'] = 'Dewbauchee', ['model'] = 'seven70', ['price'] = 140000, ['category'] = 'sports', ['hash'] = `seven70`, ['shop'] = 'luxury' },
	['specter'] = { ['name'] = 'Specter', ['brand'] = 'Dewbauchee', ['model'] = 'specter', ['price'] = 160000, ['category'] = 'sports', ['hash'] = `specter`, ['shop'] = 'luxury' },
	['streiter'] = { ['name'] = 'Streiter', ['brand'] = 'Benefactor', ['model'] = 'streiter', ['price'] = 40000, ['category'] = 'sports', ['hash'] = `streiter`, ['shop'] = 'luxury' },
	['sugoi'] = { ['name'] = 'Sugoi', ['brand'] = 'Dinka', ['model'] = 'sugoi', ['price'] = 85000, ['category'] = 'sports', ['hash'] = `sugoi`, ['shop'] = 'luxury' },
	['sultan'] = { ['name'] = 'Sultan', ['brand'] = 'Karin', ['model'] = 'sultan', ['price'] = 50000, ['category'] = 'sports', ['hash'] = `sultan`, ['shop'] = 'luxury' },
	['sultan2'] = { ['name'] = 'Sultan Custom', ['brand'] = 'Karin', ['model'] = 'sultan2', ['price'] = 55000, ['category'] = 'sports', ['hash'] = `sultan2`, ['shop'] = 'luxury' },
	['surano'] = { ['name'] = 'Surano', ['brand'] = ' Benefactor', ['model'] = 'surano', ['price'] = 80000, ['category'] = 'sports', ['hash'] = `surano`, ['shop'] = 'luxury' },
	['tampa2'] = { ['name'] = 'Drift Tampa', ['brand'] = 'Declasse', ['model'] = 'tampa2', ['price'] = 80000, ['category'] = 'muscle', ['hash'] = `tampa2`, ['shop'] = 'pdm' },
	['tropos'] = { ['name'] = 'Tropos Rallye', ['brand'] = 'Lampadati', ['model'] = 'tropos', ['price'] = 65000, ['category'] = 'sports', ['hash'] = `tropos`, ['shop'] = 'luxury' },
	['verlierer2'] = { ['name'] = 'Verlierer', ['brand'] = 'Bravado', ['model'] = 'verlierer2', ['price'] = 90500, ['category'] = 'sports', ['hash'] = `verlierer2`, ['shop'] = 'luxury' },
	['vstr'] = { ['name'] = 'V-STR', ['brand'] = 'Albany', ['model'] = 'vstr', ['price'] = 80000, ['category'] = 'sports', ['hash'] = `vstr`, ['shop'] = 'luxury' },
	['italirsx'] = { ['name'] = 'Itali RSX', ['brand'] = 'Progen', ['model'] = 'italirsx', ['price'] = 260000, ['category'] = 'sports', ['hash'] = `italirsx`, ['shop'] = 'luxury' },
	['zr350'] = { ['name'] = 'ZR350', ['brand'] = 'Annis', ['model'] = 'zr350', ['price'] = 38000, ['category'] = 'sports', ['hash'] = `zr350`, ['shop'] = 'zr350' },
	['calico'] = { ['name'] = 'Calico GTF', ['brand'] = 'Karin', ['model'] = 'calico', ['price'] = 39000, ['category'] = 'sports', ['hash'] = `calico`, ['shop'] = 'calico' },
	['futo2'] = { ['name'] = 'Futo GTX', ['brand'] = 'Karin', ['model'] = 'futo2', ['price'] = 39000, ['category'] = 'sports', ['hash'] = `futo2`, ['shop'] = 'futo2' },
	['euros'] = { ['name'] = 'Euros', ['brand'] = 'Annis', ['model'] = 'euros', ['price'] = 80000, ['category'] = 'sports', ['hash'] = `euros`, ['shop'] = 'euros' },
	['jester4'] = { ['name'] = 'Jester RR', ['brand'] = 'Dinka', ['model'] = 'jester4', ['price'] = 240000, ['category'] = 'sports', ['hash'] = `jester4`, ['shop'] = 'jester4' },
	['remus'] = { ['name'] = 'Remus', ['brand'] = 'Annis', ['model'] = 'remus', ['price'] = 48000, ['category'] = 'sports', ['hash'] = `remus`, ['shop'] = 'remus' },
	['comet6'] = { ['name'] = 'Comet S2', ['brand'] = 'Pfister', ['model'] = 'comet6', ['price'] = 230000, ['category'] = 'sports', ['hash'] = `comet6`, ['shop'] = 'comet6' },
	['growler'] = { ['name'] = 'Growler', ['brand'] = 'Pfister', ['model'] = 'growler', ['price'] = 205000, ['category'] = 'sports', ['hash'] = `growler`, ['shop'] = 'growler' },
	['vectre'] = { ['name'] = 'Emperor Vectre', ['brand'] = 'Emperor', ['model'] = 'vectre', ['price'] = 80000, ['category'] = 'sports', ['hash'] = `vectre`, ['shop'] = 'vectre' },
	['cypher'] = { ['name'] = 'Cypher', ['brand'] = 'Ubermacht', ['model'] = 'cypher', ['price'] = 155000, ['category'] = 'sports', ['hash'] = `cypher`, ['shop'] = 'cypher' },
	['sultan3'] = { ['name'] = 'Sultan Classic Custom', ['brand'] = 'Karin', ['model'] = 'sultan3', ['price'] = 56000, ['category'] = 'sports', ['hash'] = `sultan3`, ['shop'] = 'sultan3' },
	['rt3000'] = { ['name'] = 'RT3000', ['brand'] = 'Dinka', ['model'] = 'rt3000', ['price'] = 65000, ['category'] = 'sports', ['hash'] = `rt3000`, ['shop'] = 'rt3000' },
	--- Sports Classic
	['ardent'] = { ['name'] = 'Ardent', ['brand'] = 'Ocelot', ['model'] = 'ardent', ['price'] = 30000, ['category'] = 'sportsclassics', ['hash'] = `ardent`, ['shop'] = 'pdm' },
	['btype'] = { ['name'] = 'Roosevelt', ['brand'] = 'Albany', ['model'] = 'btype', ['price'] = 75000, ['category'] = 'sportsclassics', ['hash'] = `btype`, ['shop'] = 'btype' },
	['btype2'] = { ['name'] = 'Franken Stange', ['brand'] = 'Albany', ['model'] = 'btype2', ['price'] = 87000, ['category'] = 'sportsclassics', ['hash'] = `btype2`, ['shop'] = 'pdm' },
	['btype3'] = { ['name'] = 'Roosevelt Valor', ['brand'] = 'Albany', ['model'] = 'btype3', ['price'] = 63000, ['category'] = 'sportsclassics', ['hash'] = `btype3`, ['shop'] = 'pdm' },
	['casco'] = { ['name'] = 'Casco', ['brand'] = 'Lampadati', ['model'] = 'casco', ['price'] = 100000, ['category'] = 'sportsclassics', ['hash'] = `casco`, ['shop'] = 'pdm' },
	['cheetah2'] = { ['name'] = 'Cheetah Classic', ['brand'] = 'Grotti', ['model'] = 'cheetah2', ['price'] = 195000, ['category'] = 'sports', ['hash'] = `cheetah2`, ['shop'] = 'luxury' },
	['deluxo'] = { ['name'] = 'Deluxo', ['brand'] = 'Imponte', ['model'] = 'deluxo', ['price'] = 55000, ['category'] = 'sportsclassic', ['hash'] = `deluxo`, ['shop'] = 'pdm' },
	['dynasty'] = { ['name'] = 'Dynasty', ['brand'] = 'Weeny', ['model'] = 'dynasty', ['price'] = 25000, ['category'] = 'sportsclassic', ['hash'] = `dynasty`, ['shop'] = 'dynasty' },
	['fagaloa'] = { ['name'] = 'Fagaloa', ['brand'] = 'Vulcar', ['model'] = 'fagaloa', ['price'] = 13000, ['category'] = 'sportsclassics', ['hash'] = `fagaloa`, ['shop'] = 'pdm' },
	['feltzer3'] = { ['name'] = 'Stirling GT', ['brand'] = 'Benefactor', ['model'] = 'feltzer3', ['price'] = 115000, ['category'] = 'sportsclassics', ['hash'] = `feltzer3`, ['shop'] = 'feltzer3' },
	['gt500'] = { ['name'] = 'GT500', ['brand'] = 'Grotti', ['model'] = 'gt500', ['price'] = 130000, ['category'] = 'sportsclassics', ['hash'] = `gt500`, ['shop'] = 'pdm' },
	['infernus2'] = { ['name'] = 'Infernus Classic', ['brand'] = 'Pegassi', ['model'] = 'infernus2', ['price'] = 245000, ['category'] = 'sportsclassics', ['hash'] = `infernus2`, ['shop'] = 'pdm' },
	['jb700'] = { ['name'] = 'JB 700', ['brand'] = 'Dewbauchee', ['model'] = 'jb700', ['price'] = 240000, ['category'] = 'sportsclassic', ['hash'] = `jb700`, ['shop'] = 'pdm' },
	['jb7002'] = { ['name'] = 'JB 700W', ['brand'] = 'Dewbauchee', ['model'] = 'jb7002', ['price'] = 40000, ['category'] = 'sportsclassic', ['hash'] = `jb7002`, ['shop'] = 'pdm' },
	['mamba'] = { ['name'] = 'Mamba', ['brand'] = 'Declasse', ['model'] = 'mamba', ['price'] = 140000, ['category'] = 'sportsclassics', ['hash'] = `mamba`, ['shop'] = 'pdm' },
	['manana'] = { ['name'] = 'Manana', ['brand'] = 'Albany', ['model'] = 'manana', ['price'] = 12800, ['category'] = 'muscle', ['hash'] = `manana`, ['shop'] = 'pdm' },
	['manana2'] = { ['name'] = 'Manana Custom', ['brand'] = 'Albany', ['model'] = 'manana2', ['price'] = 24000, ['category'] = 'muscle', ['hash'] = `manana2`, ['shop'] = 'pdm' },
	['michelli'] = { ['name'] = 'Michelli GT', ['brand'] = 'Lampadati', ['model'] = 'michelli', ['price'] = 30000, ['category'] = 'sportsclassic', ['hash'] = `michelli`, ['shop'] = 'pdm' },
	['monroe'] = { ['name'] = 'Monroe', ['brand'] = 'Pegassi', ['model'] = 'monroe', ['price'] = 115000, ['category'] = 'sportsclassics', ['hash'] = `monroe`, ['shop'] = 'pdm' },
	['nebula'] = { ['name'] = 'Nebula', ['brand'] = 'Vulcar', ['model'] = 'nebula', ['price'] = 22000, ['category'] = 'sportsclassic', ['hash'] = `nebula`, ['shop'] = 'nebula' },
	['peyote'] = { ['name'] = 'Peyote', ['brand'] = 'Vapid', ['model'] = 'peyote', ['price'] = 23500, ['category'] = 'sportsclassic', ['hash'] = `peyote`, ['shop'] = 'pdm' },
	['peyote3'] = { ['name'] = 'Peyote Custom', ['brand'] = 'Vapid', ['model'] = 'peyote3', ['price'] = 48000, ['category'] = 'sportsclassic', ['hash'] = `peyote3`, ['shop'] = 'pdm' },
	['pigalle'] = { ['name'] = 'Pigalle', ['brand'] = 'Lampadati', ['model'] = 'pigalle', ['price'] = 92000, ['category'] = 'sportsclassics', ['hash'] = `pigalle`, ['shop'] = 'pdm' },
	['rapidgt3'] = { ['name'] = 'Rapid GT', ['brand'] = 'Dewbauchee', ['model'] = 'rapidgt3', ['price'] = 90000, ['category'] = 'sportsclassics', ['hash'] = `rapidgt3`, ['shop'] = 'pdm' },
	['retinue'] = { ['name'] = 'Retinue', ['brand'] = 'Vapid', ['model'] = 'retinue', ['price'] = 32000, ['category'] = 'sportsclassic', ['hash'] = `retinue`, ['shop'] = 'pdm' },
	['retinue2'] = { ['name'] = 'Retinue MKII', ['brand'] = 'Vapid', ['model'] = 'retinue2', ['price'] = 38000, ['category'] = 'sportsclassic', ['hash'] = `retinue2`, ['shop'] = 'pdm' },
	['savestra'] = { ['name'] = 'Savestra', ['brand'] = 'Annis', ['model'] = 'savestra', ['price'] = 67000, ['category'] = 'sportsclassic', ['hash'] = `savestra`, ['shop'] = 'pdm' },
	['stinger'] = { ['name'] = 'Stinger', ['brand'] = 'Grotti', ['model'] = 'stinger', ['price'] = 39500, ['category'] = 'sportsclassic', ['hash'] = `stinger`, ['shop'] = 'pdm' },
	['stingergt'] = { ['name'] = 'Stinger GT', ['brand'] = 'Grotti', ['model'] = 'stingergt', ['price'] = 70000, ['category'] = 'sportsclassics', ['hash'] = `stingergt`, ['shop'] = 'pdm' },
	['stromberg'] = { ['name'] = 'Stromberg', ['brand'] = 'Ocelot', ['model'] = 'stromberg', ['price'] = 80000, ['category'] = 'sportsclassic', ['hash'] = `stromberg`, ['shop'] = 'pdm' },
	['swinger'] = { ['name'] = 'Swinger', ['brand'] = 'Ocelot', ['model'] = 'swinger', ['price'] = 221000, ['category'] = 'sportsclassic', ['hash'] = `swinger`, ['shop'] = 'swinger' },
	['torero'] = { ['name'] = 'Torero', ['brand'] = 'Pegassi', ['model'] = 'torero', ['price'] = 84000, ['category'] = 'sportsclassics', ['hash'] = `torero`, ['shop'] = 'pdm' },
	['tornado'] = { ['name'] = 'Tornado', ['brand'] = 'Declasse', ['model'] = 'tornado', ['price'] = 21000, ['category'] = 'sportsclassic', ['hash'] = `tornado`, ['shop'] = 'pdm' },
	['tornado2'] = { ['name'] = 'Tornado Gang', ['brand'] = 'Declasse', ['model'] = 'tornado2', ['price'] = 22000, ['category'] = 'sportsclassic', ['hash'] = `tornado2`, ['shop'] = 'pdm' },
	['tornado5'] = { ['name'] = 'Tornado Custom', ['brand'] = 'Declasse', ['model'] = 'tornado5', ['price'] = 22000, ['category'] = 'sportsclassic', ['hash'] = `tornado5`, ['shop'] = 'pdm' },
	['turismo2'] = { ['name'] = 'Turismo Classic', ['brand'] = 'Grotti', ['model'] = 'turismo2', ['price'] = 170000, ['category'] = 'sportsclassic', ['hash'] = `turismo2`, ['shop'] = 'pdm' },
	['viseris'] = { ['name'] = 'Viseris', ['brand'] = 'Lampadati', ['model'] = 'viseris', ['price'] = 210000, ['category'] = 'sportsclassic', ['hash'] = `viseris`, ['shop'] = 'pdm' },
	['z190'] = { ['name'] = '190Z', ['brand'] = 'Karin', ['model'] = 'z190', ['price'] = 78000, ['category'] = 'sportsclassics', ['hash'] = `z190`, ['shop'] = 'pdm' },
	['ztype'] = { ['name'] = 'Z-Type', ['brand'] = 'Truffade', ['model'] = 'ztype', ['price'] = 270000, ['category'] = 'sportsclassics', ['hash'] = `ztype`, ['shop'] = 'pdm' },
	['zion3'] = { ['name'] = 'Zion Classic', ['brand'] = 'Übermacht', ['model'] = 'zion3', ['price'] = 45000, ['category'] = 'sportsclassic', ['hash'] = `zion3`, ['shop'] = 'zion3' },
	['cheburek'] = { ['name'] = 'Cheburek', ['brand'] = 'Rune', ['model'] = 'cheburek', ['price'] = 7000, ['category'] = 'sportsclassic', ['hash'] = `cheburek`, ['shop'] = 'pdm' },
	['toreador'] = { ['name'] = 'Toreador', ['brand'] = 'Pegassi', ['model'] = 'toreador', ['price'] = 50000, ['category'] = 'sportsclassic', ['hash'] = `toreador`, ['shop'] = 'pdm' },
	--- Super
	['adder'] = { ['name'] = 'Adder', ['brand'] = 'Truffade', ['model'] = 'adder', ['price'] = 280000, ['category'] = 'super', ['hash'] = `adder`, ['shop'] = 'luxury' },
	['autarch'] = { ['name'] = 'Autarch', ['brand'] = 'Överflöd', ['model'] = 'autarch', ['price'] = 224000, ['category'] = 'super', ['hash'] = `autarch`, ['shop'] = 'autarch' },
	['banshee2'] = { ['name'] = 'Banshee 900R', ['brand'] = 'Bravado', ['model'] = 'banshee2', ['price'] = 120000, ['category'] = 'super', ['hash'] = `banshee2`, ['shop'] = 'luxury' },
	['bullet'] = { ['name'] = 'Bullet', ['brand'] = 'Vapid', ['model'] = 'bullet', ['price'] = 120000, ['category'] = 'super', ['hash'] = `bullet`, ['shop'] = 'luxury' },
	['cheetah'] = { ['name'] = 'Cheetah', ['brand'] = 'Grotti', ['model'] = 'cheetah', ['price'] = 214000, ['category'] = 'super', ['hash'] = `cheetah`, ['shop'] = 'luxury' },
	['cyclone'] = { ['name'] = 'Cyclone', ['brand'] = 'Coil', ['model'] = 'cyclone', ['price'] = 300000, ['category'] = 'super', ['hash'] = `cyclone`, ['shop'] = 'cyclone' },
	['entity2'] = { ['name'] = 'Entity XXR', ['brand'] = 'Överflöd', ['model'] = 'entity2', ['price'] = 164000, ['category'] = 'super', ['hash'] = `entity2`, ['shop'] = 'entity2' },
	['entityxf'] = { ['name'] = 'Entity XF', ['brand'] = 'Överflöd', ['model'] = 'entityxf', ['price'] = 180000, ['category'] = 'super', ['hash'] = `entityxf`, ['shop'] = 'entityxf' },
	['emerus'] = { ['name'] = 'Emerus', ['brand'] = 'Progen', ['model'] = 'emerus', ['price'] = 220000, ['category'] = 'super', ['hash'] = `emerus`, ['shop'] = 'emerus' },
	['fmj'] = { ['name'] = 'FMJ', ['brand'] = 'Vapid', ['model'] = 'fmj', ['price'] = 125000, ['category'] = 'super', ['hash'] = `fmj`, ['shop'] = 'luxury' },
	['furia'] = { ['name'] = 'Furia', ['brand'] = 'Grotti', ['model'] = 'furia', ['price'] = 230000, ['category'] = 'super', ['hash'] = `furia`, ['shop'] = 'luxury' },
	['gp1'] = { ['name'] = 'GP1', ['brand'] = 'Progen', ['model'] = 'gp1', ['price'] = 110000, ['category'] = 'super', ['hash'] = `gp1`, ['shop'] = 'luxury' },
	['infernus'] = { ['name'] = 'Infernus', ['brand'] = 'Pegassi', ['model'] = 'infernus', ['price'] = 235000, ['category'] = 'super', ['hash'] = `infernus`, ['shop'] = 'luxury' },
	['italigtb'] = { ['name'] = 'Itali GTB', ['brand'] = 'Progen', ['model'] = 'italigtb', ['price'] = 170000, ['category'] = 'super', ['hash'] = `italigtb`, ['shop'] = 'luxury' },
	['italigtb2'] = { ['name'] = 'Itali GTB', ['brand'] = 'Progen', ['model'] = 'italigtb2', ['price'] = 250000, ['category'] = 'super', ['hash'] = `italigtb2`, ['shop'] = 'luxury' },
	['krieger'] = { ['name'] = 'Krieger', ['brand'] = 'Benefactor', ['model'] = 'krieger', ['price'] = 222000, ['category'] = 'super', ['hash'] = `krieger`, ['shop'] = 'krieger' },
	['le7b'] = { ['name'] = 'RE-7B', ['brand'] = 'Annis', ['model'] = 'le7b', ['price'] = 260000, ['category'] = 'super', ['hash'] = `le7b`, ['shop'] = 'luxury' },
	['nero'] = { ['name'] = 'Nero', ['brand'] = 'Truffade', ['model'] = 'nero', ['price'] = 200000, ['category'] = 'super', ['hash'] = `nero`, ['shop'] = 'luxury' },
	['nero2'] = { ['name'] = 'Nero Custom', ['brand'] = 'Truffade', ['model'] = 'nero2', ['price'] = 260000, ['category'] = 'super', ['hash'] = `nero2`, ['shop'] = 'luxury' },
	['osiris'] = { ['name'] = 'Osiris', ['brand'] = 'Pegassi', ['model'] = 'osiris', ['price'] = 220000, ['category'] = 'super', ['hash'] = `osiris`, ['shop'] = 'luxury' },
	['penetrator'] = { ['name'] = 'Penetrator', ['brand'] = 'Ocelot', ['model'] = 'penetrator', ['price'] = 130000, ['category'] = 'super', ['hash'] = `penetrator`, ['shop'] = 'luxury' },
	['pfister811'] = { ['name'] = '811', ['brand'] = 'Pfister', ['model'] = 'pfister811', ['price'] = 220000, ['category'] = 'super', ['hash'] = `pfister811`, ['shop'] = 'luxury' },
	['prototipo'] = { ['name'] = 'X80 Proto', ['brand'] = 'Grotti', ['model'] = 'prototipo', ['price'] = 235000, ['category'] = 'super', ['hash'] = `prototipo`, ['shop'] = 'luxury' },
	['reaper'] = { ['name'] = 'Reaper', ['brand'] = 'Pegassi', ['model'] = 'reaper', ['price'] = 100000, ['category'] = 'super', ['hash'] = `reaper`, ['shop'] = 'luxury' },
	['s80'] = { ['name'] = 'S80RR', ['brand'] = 'Annis', ['model'] = 's80', ['price'] = 205000, ['category'] = 'super', ['hash'] = `s80`, ['shop'] = 's80' },
	['sc1'] = { ['name'] = 'SC1', ['brand'] = 'Übermacht', ['model'] = 'sc1', ['price'] = 90000, ['category'] = 'super', ['hash'] = `sc1`, ['shop'] = 'luxury' },
	['sheava'] = { ['name'] = 'ETR1', ['brand'] = 'Emperor', ['model'] = 'sheava', ['price'] = 220000, ['category'] = 'super', ['hash'] = `sheava`, ['shop'] = 'sheava' },
	['sultanrs'] = { ['name'] = 'Sultan RS', ['brand'] = 'Karin', ['model'] = 'sultanrs', ['price'] = 76500, ['category'] = 'sports', ['hash'] = `sultanrs`, ['shop'] = 'luxury' },
	['t20'] = { ['name'] = 'T20', ['brand'] = 'Progen', ['model'] = 't20', ['price'] = 1650000, ['category'] = 'super', ['hash'] = `t20`, ['shop'] = 'luxury' },
	['taipan'] = { ['name'] = 'Taipan', ['brand'] = 'Cheval', ['model'] = 'taipan', ['price'] = 1850000, ['category'] = 'super', ['hash'] = `taipan`, ['shop'] = 'luxury' },
	['tempesta'] = { ['name'] = 'Tempesta', ['brand'] = 'Pegassi', ['model'] = 'tempesta', ['price'] = 120000, ['category'] = 'super', ['hash'] = `tempesta`, ['shop'] = 'luxury' },
	['tezeract'] = { ['name'] = 'Tezeract', ['brand'] = 'Pegassi', ['model'] = 'tezeract', ['price'] = 220000, ['category'] = 'super', ['hash'] = `tezeract`, ['shop'] = 'luxury' },
	['thrax'] = { ['name'] = 'Thrax', ['brand'] = 'Truffade', ['model'] = 'thrax', ['price'] = 180000, ['category'] = 'super', ['hash'] = `thrax`, ['shop'] = 'thrax' },
	['tigon'] = { ['name'] = 'Tigon', ['brand'] = 'Lampadati', ['model'] = 'tigon', ['price'] = 240000, ['category'] = 'super', ['hash'] = `tigon`, ['shop'] = 'luxury' },
	['turismor'] = { ['name'] = 'Turismo R', ['brand'] = 'Grotti', ['model'] = 'turismor', ['price'] = 140000, ['category'] = 'super', ['hash'] = `turismor`, ['shop'] = 'luxury' },
	['tyrant'] = { ['name'] = 'Tyrant', ['brand'] = ' Överflöd', ['model'] = 'tyrant', ['price'] = 2100000, ['category'] = 'super', ['hash'] = `tyrant`, ['shop'] = 'tyrant' },
	['tyrus'] = { ['name'] = 'Tyrus', ['brand'] = 'Progen', ['model'] = 'tyrus', ['price'] = 230000, ['category'] = 'super', ['hash'] = `tyrus`, ['shop'] = 'luxury' },
	['vacca'] = { ['name'] = 'Vacca', ['brand'] = 'Pegassi', ['model'] = 'vacca', ['price'] = 105000, ['category'] = 'super', ['hash'] = `vacca`, ['shop'] = 'luxury' },
	['vagner'] = { ['name'] = 'Vagner', ['brand'] = 'Dewbauchee', ['model'] = 'vagner', ['price'] = 1660000, ['category'] = 'super', ['hash'] = `vagner`, ['shop'] = 'luxury' },
	['visione'] = { ['name'] = 'Visione', ['brand'] = 'Grotti', ['model'] = 'visione', ['price'] = 750000, ['category'] = 'sports', ['hash'] = `visione`, ['shop'] = 'luxury' },
	['voltic'] = { ['name'] = 'Voltic', ['brand'] = 'Coil', ['model'] = 'voltic', ['price'] = 120000, ['category'] = 'super', ['hash'] = `voltic`, ['shop'] = 'luxury' },
	['voltic2'] = { ['name'] = 'Rocket Voltic', ['brand'] = 'Coil', ['model'] = 'voltic2', ['price'] = 9830400, ['category'] = 'super', ['hash'] = `voltic2`, ['shop'] = 'luxury' },
	['xa21'] = { ['name'] = 'XA-21', ['brand'] = 'Ocelot', ['model'] = 'xa21', ['price'] = 180000, ['category'] = 'super', ['hash'] = `xa21`, ['shop'] = 'luxury' },
	['zentorno'] = { ['name'] = 'Zentorno', ['brand'] = 'Pegassi', ['model'] = 'zentorno', ['price'] = 340000, ['category'] = 'super', ['hash'] = `zentorno`, ['shop'] = 'luxury' },
	['zorrusso'] = { ['name'] = 'Zorrusso', ['brand'] = 'Pegassi', ['model'] = 'zorrusso', ['price'] = 277000, ['category'] = 'super', ['hash'] = `zorrusso`, ['shop'] = 'zorrusso' },
	-- Vans
	['bison'] = { ['name'] = 'Bison', ['brand'] = 'Bravado', ['model'] = 'bison', ['price'] = 18000, ['category'] = 'vans', ['hash'] = `bison`, ['shop'] = 'pdm' },
	['bobcatxl'] = { ['name'] = 'Bobcat XL Open', ['brand'] = 'Vapid', ['model'] = 'bobcatxl', ['price'] = 13500, ['category'] = 'vans', ['hash'] = `bobcatxl`, ['shop'] = 'pdm' },
	['burrito3'] = { ['name'] = 'Burrito', ['brand'] = 'Declasse', ['model'] = 'burrito3', ['price'] = 4000, ['category'] = 'vans', ['hash'] = `burrito3`, ['shop'] = 'pdm' },
	['gburrito2'] = { ['name'] = 'Burrito Custom', ['brand'] = 'Declasse', ['model'] = 'gburrito2', ['price'] = 11500, ['category'] = 'vans', ['hash'] = `gburrito2`, ['shop'] = 'pdm' },
	['rumpo'] = { ['name'] = 'Rumpo', ['brand'] = 'Bravado', ['model'] = 'rumpo', ['price'] = 9000, ['category'] = 'vans', ['hash'] = `rumpo`, ['shop'] = 'pdm' },
	['journey'] = { ['name'] = 'Journey', ['brand'] = 'Zirconium', ['model'] = 'journey', ['price'] = 6500, ['category'] = 'vans', ['hash'] = `journey`, ['shop'] = 'pdm' },
	['minivan'] = { ['name'] = 'Minivan', ['brand'] = 'Vapid', ['model'] = 'minivan', ['price'] = 7000, ['category'] = 'vans', ['hash'] = `minivan`, ['shop'] = 'pdm' },
	['minivan2'] = { ['name'] = 'Minivan Custom', ['brand'] = 'Vapid', ['model'] = 'minivan2', ['price'] = 10000, ['category'] = 'vans', ['hash'] = `minivan2`, ['shop'] = 'pdm' },
	['paradise'] = { ['name'] = 'Paradise', ['brand'] = 'Bravado', ['model'] = 'paradise', ['price'] = 9000, ['category'] = 'vans', ['hash'] = `paradise`, ['shop'] = 'pdm' },
	['rumpo3'] = { ['name'] = 'Rumpo Custom', ['brand'] = 'Bravado', ['model'] = 'rumpo3', ['price'] = 19500, ['category'] = 'vans', ['hash'] = `rumpo3`, ['shop'] = 'pdm' },
	['speedo'] = { ['name'] = 'Speedo', ['brand'] = 'Vapid', ['model'] = 'speedo', ['price'] = 10000, ['category'] = 'vans', ['hash'] = `speedo`, ['shop'] = 'pdm' },
	['speedo4'] = { ['name'] = 'Speedo Custom', ['brand'] = 'Vapid', ['model'] = 'speedo4', ['price'] = 15000, ['category'] = 'vans', ['hash'] = `speedo4`, ['shop'] = 'pdm' },
	['surfer'] = { ['name'] = 'Surfer', ['brand'] = 'BF', ['model'] = 'surfer', ['price'] = 9000, ['category'] = 'vans', ['hash'] = `surfer`, ['shop'] = 'pdm' },
	['youga3'] = { ['name'] = 'Youga Classic 4x4', ['brand'] = 'Bravado', ['model'] = 'youga3', ['price'] = 15000, ['category'] = 'vans', ['hash'] = `youga3`, ['shop'] = 'pdm' },
	['youga'] = { ['name'] = 'Youga', ['brand'] = 'Bravado', ['model'] = 'youga', ['price'] = 8000, ['category'] = 'vans', ['hash'] = `youga`, ['shop'] = 'pdm' },
	['youga2'] = { ['name'] = 'Youga Classic', ['brand'] = 'Bravado', ['model'] = 'youga2', ['price'] = 14500, ['category'] = 'vans', ['hash'] = `youga2`, ['shop'] = 'pdm' },
	-- Utility
	['sadler'] = { ['name'] = 'Sadler', ['brand'] = 'Vapid', ['model'] = 'sadler', ['price'] = 20000, ['category'] = 'offroad', ['hash'] = `sadler`, ['shop'] = 'pdm' },
	['guardian'] = { ['name'] = 'Guardian', ['brand'] = 'Annis', ['price'] = 21000, ['category'] = 'offroad', ['model'] = 'guardian', ['hash'] = `guardian`, ['shop'] = 'pdm' },
	['slamtruck'] = { ['name'] = 'Slam Truck', ['brand'] = 'Vapid', ['model'] = 'slamtruck', ['price'] = 100000, ['category'] = 'muscle', ['hash'] = `slamtruck`, ['shop'] = 'pdm' },
	['warrener2'] = { ['name'] = 'Warrener HKR', ['brand'] = 'Vulcar', ['model'] = 'warrener2', ['price'] = 30000, ['category'] = 'sedans', ['hash'] = `warrener2`, ['shop'] = 'warrener2' },
}

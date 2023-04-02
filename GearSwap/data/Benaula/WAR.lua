-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff['Mighty Strikes'] = buffactive['Mighty Strikes'] or false
    state.Buff['Aggressor'] = buffactive.Aggressor or false
	state.Buff['Berserk'] = buffactive.Berserk or false
	state.Buff['Defender'] = buffactive.Defender or false
	state.Buff["Warrior's Charge"] = buffactive["Warrior's Charge"] or false
	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Evasion', 'Accuracy', 'Defense')
    state.HybridMode:options('Normal', 'Evasion', 'Accuracy', 'Defense')
	state.WeaponskillMode:options('Normal', 'WC')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
	state.PhysicalDefenseMode:options('None', 'PDT', 'MDT')

    select_default_macro_book()
end


--Begin initializing gear swaps
function init_gear_sets()

	--BUFF SPECIFIC
	--ATK/DEF
	sets.buff['Aggressor'] = {
		body="adaman hauberk",
		hands="Dusk Gloves +1",
		back="Shadow Mantle",
	}
	--ACC/EVA
	sets.buff['Berserk'] = {
		head="panther mask +1",
		body="adaman hauberk",
		hands="Dusk Gloves +1",
		ring1="Rajas Ring",
		back="shadow mantle",
		waist="Velocious Belt",
		legs="Byakko's Haidate",
		feet="Dusk Ledelsens +1"
	}
	--PDT/DEF
	sets.buff['Defender'] = {
		back="shadow mantle",
		ring1="jelly ring",
		ring2="defending ring",
	}
	--Full Accuracy
	sets.buff['Mighty Strikes'] = {
		body="adaman hauberk",
		ring1="lava's ring",
		ring2="kusha's ring",
		waist="potent belt",
	}

	-------------------------------------------------------------------------------------
	--PRECAST Sets
	--Job Abilities
	sets.precast.JA['Berserk'] = {feet="Warrior's Calligae"}
	sets.precast.JA['Warcry'] = {head="Warrior's Mask"}
	--Full Enmity
	sets.precast.JA['Provoke'] = {head="Aegishjalmr"}
	
	--Waltz
	--CHR then VIT
	sets.precast.JA.Waltz = {
		head="koenig schaller",
		neck="Flower Necklace",
		body="koenig cuirass",
		hands="koenig handschuhs",
		ring1="moon Ring",
		ring2="moon Ring",
		back="Shadow Mantle",
		waist="Corsette +1",
		legs="koenig diechlings",
		feet="koenig schuhs",
	}
	
	--Weaponskills
	--Default
	sets.precast.WS = {
		head="Hecatomb Cap +1",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Merman's Earring",
		body="adaman hauberk",
		hands="Hct. Mittens +1",
		ring1="Rajas Ring",
		ring2="Harmonius Ring",
		back="Amemet Mantle +1",
		waist="Potent Belt",
		legs="Warrior's Cuisses",
		feet="Hct. Leggings +1",
	}

	--Job Ability
	--AGGRESSOR
	--Full Atk
	sets.precast.WS.Aggressor = set_combine(sets.precast.WS, {
		legs="Hct. Subligar +1",
		waist="swordbelt +1",
	})
	--BERSERK
	--More Acc
	sets.precast.WS.Berserk = set_combine(sets.precast.WS, {
		
	})
	
	--STEEL CYCLONE
	--1hit lets make sure it hits
	--166% atk
	sets.precast.WS['Steel Cyclone'] = set_combine(sets.precast.WS, {
		waist="Potent Belt",
		ring2="Sniper's Ring +1",
	})
	sets.precast.WS['Steel Cyclone'].Berserk = sets.precast.WS['Steel Cyclone']
	
	--UKKO'S
	--Atk/STR
	sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {
		body="Byrnie +1",
		waist="swordbelt +1",
		legs="hct. subligar +1",
	})
	sets.precast.WS["Ukko's Fury"].Berserk = sets.precast.WS["Ukko's Fury"]
	
	--RAMPAGE
	--Atk/Acc/Dex
	sets.precast.WS['Rampage'] = set_combine(sets.precast.WS, {
		--ear2="Pixie Earring",
		body="zahak's mail",
		legs="Byakko's Haidate",
		waist="Potent Belt",
	})
	sets.precast.WS['Raging Rush'] = sets.precast.WS['Rampage']
	
	--STR INT
	sets.precast.WS['Freezebite'] = {
		head="Voyager Sallet",
		body="Haubergeon +1",
		neck="Fotia Gorget",
		ear1="Star Earring",
		ear2="Moldavite Earring",
		hands="Wood Gloves",
		ring1="Rajas Ring",
		ring2="Omniscient Ring",
		back="Amemet Mantle +1",
		waist="Warwolf Belt",
		legs="Warrior's Cuisses",
		feet="Mgn. F Ledelsens",
	}
	

	-------------------------------------------------------------------------------------
	--MIDCAST Sets
	sets.midcast.RA = {
		head="Wivre Mask +1",
		neck="Peacock Amulet",
		ear1="Drone Earring",
		ear2="Drone Earring",
		body="Scp. Harness +1",
		hands="Seiryu's Kote",
		ring1="merman's ring",
		ring2="merman's ring",
		back="boxer's mantle",
		waist="Survival Belt",
		legs="dusk trousers +1",
		feet="Warrior's calligae",
	}

	--Attributes

	-------------------------------------------------------------------------------------
	--AFTERCAST
	
	--------------------------
	--Engaged
	--------------------------
	sets.engaged = {
		head="Panther Mask +1",
		neck="Chivalrous Chain",
		ear1="Brutal Earring",
		ear2="Fowling Earring",
		body="adaman hauberk",
		hands="Dusk Gloves +1",
		ring1="Rajas Ring",
		ring2="defending ring",
		back="amemet Mantle +1",
		waist="Velocious Belt",
		legs="Byakko's Haidate",
		feet="Dusk Ledelsens +1",
	}
	sets.engaged.Accuracy = set_combine(sets.engaged, {
		neck="Peacock Amulet",
		body="adaman hauberk",
		ring1="kusha's ring",
		ring2="lava's ring",
	})
	sets.engaged.Accuracy.Evasion = {
		--ammo,
		neck="Peacock Amulet",
		ring1="Rajas Ring",
		ring2="Sniper's Ring +1",
		head="Wivre Mask +1",
		ear1="Brutal Earring",
		ear2="Elusive Earring",
		body="Scp. Harness +1",
		hands="Dusk Gloves +1",
		feet="Dusk Ledelsens +1",
		back="boxer's mantle",
		waist="Velocious Belt",
		legs="Byakko's Haidate",
		}
	sets.engaged.Haste = {}
	sets.engaged.Evasion = {
		--ammo,
		head="Wivre Mask +1",
		neck="Chivalrous Chain",
		ear1="Brutal Earring",
		ear2="Elusive Earring",
		body="Scp. Harness +1",
		hands="Dusk Gloves +1",
		ring1="Rajas Ring",
		ring2="Harmonius Ring",
		back="boxer's mantle",
		waist="Velocious Belt",
		legs="Byakko's Haidate",
		feet="Dusk Ledelsens +1",
	}
	sets.engaged.Defense = {
		--ammo,
		head="Unicorn Cap",
		neck="Chivalrous Chain",
		ear1="Brutal Earring",
		ear2="Elusive Earring",
		body="Unicorn Harness",
		hands="koenig handschuhs",
		ring1="Rajas Ring",
		ring2="Harmonius Ring",
		back="Shadow Mantle",
		waist="Velocious Belt",
		legs="koenig diechlings",
		feet="koenig schuhs",
	}
	
	--------------------------
	--Defense
	--------------------------
	sets.defense.PDT = {
		back="shadow mantle",
		ring1="jelly ring",
		ring2="defending ring",
	}
	sets.defense.MDT = {
		head="merman's cap",
		ear1="merman's Earring",
		ear2="merman's Earring",
		body="merman's harness",
		hands="I.R. Dastanas",
		ring1="merman's Ring",
		ring2="defending ring",
		back="Lamia Mantle +1",
		legs="merman's subligar",
		feet="iron ram greaves", --2
	}
	-------------------------------------------------------------------------------------
	--NON-ACTION Sets
	--Resting
	--Idle
	sets.idle.Normal = {
		--ammo,
		head="Genbu's Kabuto",
		neck="Fortitude Torque", --keep ukko when zoning
		ear1="merman's Earring",
		ear2="merman's Earring",
		body="Unicorn Harness",
		hands="seiryu's kote",
		ring1="shadow Ring",
		ring2="defending ring",
		back="Shadow Mantle",
		waist="Velocious Belt",
		legs="Byakko's Haidate",
		feet="Suzaku's sune-ate",
	}

	--LATENT EFFECT
	sets.latent_regen = {
		neck="Orochi Nodowa +1",
		ring2="Hercules' Ring",
	}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for casting events.
-------------------------------------------------------------------------------------------------------------------
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'Weaponskill' then
		if state.Buff["Warrior's Charge"] then
			equip(sets.buff["Warrior's Charge"])
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
			if player.equipment.ammo == 'empty' then
				add_to_chat(122, 'No more Ammo!')
			end
	end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
function customize_melee_set(meleeSet)
	if buffactive['Mighty Strikes'] then
		meleeSet = set_combine(meleeSet, sets.buff['Mighty Strikes'])
	elseif buffactive.Aggressor then
		meleeSet = set_combine(meleeSet,sets.buff['Aggressor'])
	elseif buffactive.Berserk then
		meleeSet = set_combine(meleeSet,sets.buff['Berserk'])
	elseif buffactive.Defender then
		meleeSet = set_combine(meleeSet,sets.buff['Defender'])
	end
	
	if (player.hpp < 51) then
		meleeSet = set_combine(meleeSet, sets.latent_regen)
	end
	
	if player.equipment.main == 'Ridill' then
		meleeSet = set_combine(meleeSet, {neck="Temp. Torque"})
	elseif player.equipment.main == "Juggernaut" then
		meleeSet = set_combine(meleeSet, {neck="Fortitude Torque"})
	elseif player.equipment.main == "Byakko's Axe" then
		meleeSet = set_combine(meleeSet, {neck="Fortitude Torque"})
	elseif player.equipment.main == 'Fortitude Axe' then
		meleeSet = set_combine(meleeSet, {neck="Fortitude Torque",ammo="Virtue Stone"})
	end
	if player.equipment.sub == 'Ridill' then
		meleeSet = set_combine(meleeSet, {ear2="Suppanomimi"})
	elseif player.equipment.sub == 'Kraken Club' then
		meleeSet = set_combine(meleeSet, {ear2="Suppanomimi"})
	end
	return meleeSet
end

function customize_idle_set(idleSet)
	if (player.hpp < 51) then
		idleSet = set_combine(idleSet, sets.latent_regen)
	end
	return idleSet
end

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

	if state.Buff['Aggressor'] and state.Buff['Berserk'] then
		wsmode = 'Berserk'
	elseif state.Buff['Aggressor'] then
		wsmode = 'Aggressor'
	elseif state.Buff['Berserk'] then
		wsmode = 'Berserk'
    end

    return wsmode
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1,1)
end
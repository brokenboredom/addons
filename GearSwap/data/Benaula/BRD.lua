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
	update_combat_form()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Evasion', 'Haste', 'Acc')
    state.HybridMode:options('Normal', 'Evasion')
    state.CastingMode:options('Unlocked', 'Locked')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
	state.PhysicalDefenseMode:options('None', 'PDT')
	state.MagicalDefenseMode:options('None', 'MDT', 'Water', 'Fire', 'Thunder', 'Dark')
    
    select_default_macro_book()
end


--Begin initializing gear swaps
function init_gear_sets()

	--ELEMENTAL STAVES
	sets.ElementalStaff = {main="Chatoyant Staff"}
		sets.ElementalStaff.Fire = {main="Chatoyant Staff"}
		sets.ElementalStaff.Wind = {main="Chatoyant Staff"}
		sets.ElementalStaff.Water = {main="Chatoyant Staff"}
		sets.ElementalStaff.Earth = {main="Terra's Staff"}
		sets.ElementalStaff.Lightning = {main="Chatoyant Staff"}
		sets.ElementalStaff.Ice = {main="Chatoyant Staff"}
		sets.ElementalStaff.Light = {main="Chatoyant Staff"}
		sets.ElementalStaff.Dark = {main="Chatoyant Staff"}
	
	-------------------------------------------------------------------------------------
	--PRECAST Sets
	--JA


	--Fastcast (cast time reduction)
	sets.precast.fc = {
	}

	--Weaponskills
	--STR
	sets.precast.WS = {
		--ammo, Never ammo because of our instrument
		head="Hecatomb Cap +1",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Merman's Earring",
		body="bard's jstcorps",
		hands="hct. mittens +1",
		ring1="Rajas Ring",
		ring2="Harmonius Ring",
		back="Amemet Mantle +1",
		waist="warwolf belt",
		legs="Byakko's Haidate",
		feet="Hct. leggings +1",
	}
	--INT/DEX/AGI/MAB
	sets.precast.WS['Gust Slash'] = {
		head="Sinister Mask",
		neck="Fotia Gorget",
		ear1="Morion Earring +1",
		ear2="Moldavite Earring",
		body="Black Cotehardie",
		hands="Wood Gloves",
		ring1="Eremite's Ring +1",
		ring2="Zircon Ring",
		back="Rainbow Cape",
		waist="Al Zahbi Sash",
		legs="Hct. Subligar +1",
		feet="Mgn. F Ledelsens",
	}
	sets.precast.WS['Cyclone'] = sets.precast.WS['Gust Slash']
	--INT/STR/MAB
	sets.precast.WS['Red Lotus Blade'] = {
		head="Sinister Mask",
		neck="Fotia Gorget",
		ear1="Morion Earring +1",
		ear2="Moldavite Earring",
		body="Black Cotehardie",
		hands="Wood Gloves",
		ring1="Eremite's Ring +1",
		ring2="Zircon Ring",
		back="Rainbow Cape",
		waist="Al Zahbi Sash",
		legs="Hct. Subligar +1",
		feet="Mgn. F Ledelsens",
	}
	sets.precast.WS['Seraph Blade'] = sets.precast.WS['Red Lotus Blade']
	-------------------------------------------------------------------------------------
	--MIDCAST Sets

	--Haste/FC
	sets.midcast.FC = {
		head="Walahra Turban",
		hands="Dusk Gloves +1",
		waist="Velocious Belt",
		legs="Byakko's Haidate",
		feet="Dusk Ledelsens +1",
	}
	

	--Attributes
	sets.midcast.mnd = {
		head="Circe's Hat",
		neck="Justice Badge",
		ear1="Star Earring",
		ear2="Star Earring",
		hands="Dvt. Mitts +1",
		body="Errant Hpl.",
		ring1="Saintly Ring +1",
		ring2="Saintly Ring +1",
		back="Prism Cape",
		waist="Al Zahbi Sash",
		legs="Errant Slops",
	}
	sets.midcast.int = {
		head="Wizard's Petasos",
		neck="Mohbwa Scarf +1",
		ear1="Morion Earring +1",
		ear2="Moldavite Earring",
		body="Errant Hpl.",
		hands="Mahatma Cuffs",
		ring1="Eremite's Ring +1",
		ring2="Eremite's Ring +1",
		back="Prism Cape",
		waist="Al Zahbi Sash",
		legs="Errant Slops",
		feet="Cobra Crackows",
	}


	--Skills
	sets.midcast.BardSong = set_combine(sets.midcast.FC, {
		range="Iron Ram Horn",
		head="Bard's Roundlet", --5 Singing 5 CHR
		neck="Wind Torque",
		body="Minstrel's Coat", --Wind 3
		hands="chl. cuffs +1", --Sing 5 CHR 4
		back="Rainbow Cape", --CHR 2
		legs="Errant Slops", --CHR 7
		feet="Dance Shoes +1", --CHR 4
		ring1="Moon Ring", --CHR 3
		ring2="Moon Ring", --CHR 3
		waist="Corsette +1" --CHR 6
	})
	--Songs
	sets.midcast.March = set_combine(sets.midcast.BardSong,{ranged="Iron Ram Horn"})
	sets.midcast.Minuet = set_combine(sets.midcast.BardSong,{ranged="Cornette +1"})
	sets.midcast['Magic Finale'] = set_combine(sets.midcast.BardSong,{ranged="Military Harp"})
	sets.midcast.Lullaby = set_combine(sets.midcast.BardSong,{ranged="Military Harp"})


	--healing
	sets.midcast['Healing Magic'] = set_combine(sets.midcast.mnd, sets.midcast.resistant, {
		
	})

	--Resistant
	sets.resistant = {
		waist="Silver Obi +1",
	}

	-------------------------------------------------------------------------------------
	--AFTERCAST
	--------------------------
	--Engaged
	--------------------------
	--eg: sets.engaged.tpweapon.offense.defense
	--well rounded
	sets.engaged = {
		ranged="angel lyre",
		head="Walahra Turban",
		neck="Chivalrous Chain",
		ear1="Brutal Earring",
		ear2="Elusive Earring",
		body="bard's jstcorps",
		hands="Dusk Gloves +1",
		ring1="lava's ring",
		ring2="kusha's Ring",
		back="Amemet Mantle +1",
		waist="Velocious Belt",
		legs="Byakko's Haidate",
		feet="Dusk Ledelsens +1"
	}
	--acc/haste/no DA
	sets.engaged.Kraken = {
		ranged="angel lyre",
		head="Walahra Turban",
		neck="Peacock Amulet",
		ear1="elusive earring",
		ear2="Elusive Earring",
		body="Scp. Harness +1",
		hands="Dusk Gloves +1",
		ring1="lava's Ring",
		ring2="kusha's Ring",
		back="shadow mantle",
		waist="Velocious Belt",
		legs="Byakko's Haidate",
		feet="Dusk Ledelsens +1"
	}
    sets.engaged.Acc = {
		ranged="angel lyre",
		head="Dusk Mask",
		neck="Peacock Amulet",
		ear1="Brutal Earring",
		ear2="Elusive Earring",
		body="Scp. Harness +1",
		hands="Bard's Cuffs",
		ring1="lava's Ring",
		ring2="kusha's Ring",
		back="Amemet Mantle +1",
		waist="Potent Belt",
		legs="Byakko's Haidate",
		feet="Dusk Ledelsens +1"
	}
    sets.engaged.Evasion = {
		ranged="angel lyre",
		head="Wivre Mask +1",
		neck="Chivalrous Chain",
		ear1="Elusive Earring",
		ear2="Elusive Earring",
		body="Scp. Harness +1",
		hands="seiryu's kote",
		ring1="Rajas Ring",
		ring2="Harmonius Ring",
		back="boxer's mantle",
		waist="scouter's rope",
		legs="Byakko's Haidate",
		feet="Dance Shoes +1",
	}

	--------------------------
	--Defense
	--------------------------
	sets.defense.PDT = {
		head="genbu's kabuto",
		hands="seiryu's kote",
		legs="Byakko's Haidate",
		back="Shadow Mantle",
		feet="suzaku's sune-ate",
	}
	sets.defense.MDT = {
		head="genbu's kabuto",
		neck="Orochi Nodowa +1",
		ear1="merman's earring",
		ear2="merman's earring",
		ring1="marman's ring",
		ring2="shadow ring",
		hands="seiryu's kote",
		legs="Byakko's Haidate",
		back="Lamia Mantle +1",
		feet="suzaku's sune-ate",
	}
	sets.defense.Water = set_combine(sets.defense.MDT,{
		head="genbu's kabuto",
		neck="Orochi Nodowa +1",
		ear1="Star Earring",
		ear2="Star Earring",
		ring1="Sapphire Ring",
		ring2="Sapphire Ring",
		body="Scp. Harness +1",
		back="Lamia's Mantle +1",
	})
	sets.defense.Thunder = set_combine(sets.defense.MDT, {
		head="black ribbon",
		neck="Orochi Nodowa +1",
		legs="byakko's haidate",
		ring1="Spinel Ring",
		ring2="Adroit Ring +1",
	})
	sets.defense.Fire = set_combine(sets.defense.MDT,{
		head="Black Ribbon",
		neck="Orochi Nodowa +1",
		ear1="Star Earring",
		ear2="Star Earring",
		ring1="crimson ring",
		ring2="Harmonius Ring",
		feet="suzaku's sune-ate",
	})
	sets.defense.Dark = set_combine(sets.defense.MDT,{
		head="black ribbon",
		neck="Orochi Nodowa +1",
		body="Scp. Harness +1",
	})
	
	-------------------------------------------------------------------------------------
	--NON-ACTION Sets
	--Refresh
	--(only refresh gear)
	sets.refresh = {head="", body="Royal Cloak"}
	--Resting
	sets.resting = {
		main="Dark Staff",
		head="",
		body="Royal Cloak",
		ring1="Star Ring",
		ring2="Star Ring",
	}
	--------------------------
	--Idle
	--------------------------
	sets.idle = {
		neck="Orochi Nodowa +1",
		head="wivre mask +1",
		hands="seiryu's kote",
		body="scp. harness +1",
		legs="Byakko's Haidate",
		feet="Dance Shoes +1",
		ear1="Elusive Earring",
		ear2="Elusive Earring",
		back="Shadow Mantle",
		waist="scouter's rope",
		ring1="merman's Ring",
		ring2="shadow Ring",
	}
	sets.idle.PDT = sets.idle
	sets.idle.MDT = sets.idle




end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for casting events.
-------------------------------------------------------------------------------------------------------------------
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	equip(sets.ElementalStaff[spell.element])
	if state.CastingMode.value == 'Resistant' then
		equip(sets.midcast.resistant)
	end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:contains("Lullaby") then -- Foe Countdown --
            send_command('wait 15;input /echo Lullaby Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Lullaby Effect: [WEARING OFF IN 5 SEC.]')     
        end
    end
	--if buffactive['poison'] then
	--send_command('input /item "antidote" <me>')
	--end
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Casting Mode' and newValue == 'Unlocked' then
		enable('main','sub','range')
	else
		disable('main','sub','range')
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
function customize_melee_set(meleeSet)
	if player.equipment.sub ~= "Genbu's Shield" or player.equipment.sub ~= nil then
		meleeSet = set_combine(meleeSet, {ear2="Suppanomimi"})
	end
	return meleeSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function update_combat_form()
    if player.equipment.main == 'Kraken Club' or player.equipment.sub == 'Kraken Club' then
		state.CombatForm:set('Kraken')
	else
		state.CombatForm:reset()
	end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1,10)
end
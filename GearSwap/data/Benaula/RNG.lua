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
	state.Buff.Barrage = buffactive.Barrage or false
	state.Buff.Camouflage = buffactive.Camouflage or false
	state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.RangedMode:options('Normal', 'Acc')
	state.OffenseMode:options('Normal', 'Evasion')
	state.WeaponskillMode:options('Bow', 'Gun', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
	state.PhysicalDefenseMode:options('Normal', 'PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT', 'Water', 'Fire', 'Thunder', 'Dark')
	
	--gear.default.weaponskill_neck = "Ocachi Gorget"
	--gear.default.weaponskill_waist = "Elanid Belt"
	
	DefaultAmmo = {['Yoichinoyumi'] = "scorpion arrow", ['Culverin'] = "cannon shell"}
	U_Shot_Ammo = {['Yoichinoyumi'] = "Cmb.Cst. arrow", ['Culverin'] = "Heavy Shell"}

	select_default_macro_book()

	send_command('bind f9 gs c cycle RangedMode')
	send_command('bind ^f9 gs c cycle OffenseMode')
	send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind f9')
	send_command('unbind ^f9')
end
        

function init_gear_sets()
	-- Augmented gear

	-- Misc. Job Ability precasts
	sets.precast.JA['Camouflage'] = {body="Hunter's Jerkin"}
	sets.precast.JA['Sharpshot'] = {legs="Hunter's Braccae"}
	sets.precast.JA['Scavenge'] = {feet="Hunter's Socks"}
	sets.precast.JA['Shadowbind'] = {hands="Hunter's Bracers"}
	
	sets.precast.JA['Eagle Eye Shot'] = sets.precast.WS
	
	sets.idle = {
		head="genbu's kabuto",
		neck="Orochi Nodowa +1",
		ear1="Star Earring",
		ear2="Star Earring",
		body="scout's jerkin",
		hands="seiryu's kote",
		ring1="adroit ring +1",
		ring2="shadow Ring",
		back="Shadow Mantle",
		waist="scouter's rope",
		legs="blood cuisses",
		feet="blood greaves",
	}
	sets.idle.Regen = set_combine(sets.idle, {body="dusk jerkin +1",})
	sets.idle.PDT = set_combine(sets.idle, {})
	sets.kiting = set_combine(sets.idle, {legs="Blood Cuisses"})

	-- Engaged sets
	sets.engaged =  {
		head="Walahra Turban",
		neck="Peacock Amulet",
		ear1="Brutal Earring",
		ear2="Elusive Earring",
		body="kirin's osode",
		hands="Dusk Gloves +1",
		ring1="rajas Ring",
		ring2="defending Ring",
		back="Shadow Mantle",
		waist="Velocious Belt",
		legs="byakko's haidate",
		feet="Dusk Ledelsens +1",
	}
	sets.engaged.Evasion =  {
		head="Dusk Mask",
		neck="Peacock Amulet",
		ear1="Elusive Earring",
		ear2="Elusive Earring",
		body="scout's jerkin",
		hands="seiryu's kote",
		ring1="lava's Ring",
		ring2="kusha's Ring",
		back="boxer's mantle",
		waist="scouter's rope",
		legs="byakko's haidate",
		feet="Dance Shoes +1",
	}
	sets.engaged.Kraken = {
		head="walahra turban",
		neck="Peacock Amulet",
		ear1="Elusive Earring",
		ear2="Elusive Earring",
		body="kirin's osode",
		hands="Dusk Gloves +1",
		ring1="lava's Ring",
		ring2="kusha's Ring",
		back="Shadow Mantle",
		waist="velocious Belt",
		legs="byakko's haidate",
		feet="Dusk Ledelsens +1",
	}

	------------------------------------------------------------------
	-- Preshot / Snapshot sets
	------------------------------------------------------------------
	sets.precast.RA = {
		head="Hunter's Beret",
		body="scout's jerkin",
	}
	
	------------------------------------------------------------------
	-- Default Base Gear Sets for Ranged Attacks. Geared for Gun
	------------------------------------------------------------------
	
	sets.midcast.RA = { 
		head="Hunter's Beret",
		neck="ranger's necklace",
		ear1="Drone Earring",
		ear2="Drone Earring",
		body="scout's jerkin",
		hands="blood fng. gnt.",
		ring1="merman's Ring",
		ring2="merman's ring",
		back="Amemet Mantle +1",
		waist="scout's belt",
		legs="skadi's chausses",
		feet="scout's Socks",
	}
	sets.midcast.RA.Acc =  set_combine(sets.midcast.RA, {
		neck="Peacock amulet",
		body="Hunter's Jerkin",
		hands="seiryu's kote",
	})
   
   -- Weaponskill sets
	sets.precast.WS = {
		head="Hunter's beret",
		neck="Fotia Gorget",
		ear1="Drone Earring",
		ear2="Drone Earring",
		body="scout's jerkin",
		hands="blood fng. gnt.",
		ring2="merman's ring",
		ring1="Rajas Ring",
		back="Amemet Mantle +1",
		waist="Warwolf Belt",
		legs="scout's braccae",
		feet="scout's Socks",
	}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		body="Hunter's Jerkin",
		hands="seiryu's kote",
		ring2="merman's ring",
	})
	--BOW
	--More STR
	sets.precast.WS.Bow = sets.precast.WS
	--GUN
	--All AGI
	sets.precast.WS.Gun = set_combine(sets.precast.WS, {
		head="Hunter's beret",
		neck="Ranger's Necklace",
		ear1="Drone Earring",
		ear2="Drone Earring",
		body="scout's jerkin",
		hands="seiryu's kote",
		ring1="Breeze Ring",
		ring2="Breeze Ring",
		back="Amemet Mantle +1",
		--waist="warwolf Belt",
		legs="scout's braccae",
		feet="scout's Socks",
	})
	--INT/AGI/DEX/MAB
	sets.precast.WS['Gust Slash'] = {
		head="Sinister Mask",
		neck="enlightened chain",
		ear1="Morion Earring +1",
		ear2="Moldavite Earring",
		body="Black Cotehardie",
		hands="Wood Gloves",
		ring1="Omniscient Ring",
		ring2="Beeze Ring",
		--back
		waist="warwolf belt",
		legs="Magic Cuisses",
		feet="Mgn. F Ledelsens",
	}
	
	-- Resting sets
	sets.resting = {}
   
	-- Defense sets
	sets.defense.PDT = {
		head="genbu's kabuto",
		hands="dusk gloves +1",
		legs="byakko's haidate",
		feet="dusk ledelsens +1",
		back="Shadow Mantle",
	}
	--25% MDT
	sets.defense.MDT = {
		head="coral visor +1", --2
		ear1="merman's Earring", --2
		ear2="merman's Earring", --2
		body="avalon breastplate", --4
		hands="coral fng. gnt. +1", --2
		ring1="merman's Ring", --4
		ring2="defending ring", --4
		legs="coral cuisses +1", --3
		feet="coral greaves +1", --2
	}
	sets.defense.Water = set_combine(sets.defense.MDT, {
		neck="Orochi Nodowa +1",
		ear1="Star Earring",
		ear2="Star Earring",
		ring1="Sapphire Ring",
		legs="blood cuisses",
	})
	sets.defense.Fire = set_combine(sets.defense.MDT, {
		neck="Orochi Nodowa +1",
		ear1="Star Earring",
		ear2="Star Earring",
		ring1="Harmonius Ring",
		legs="blood cuisses",
	})
	sets.defense.Dark = set_combine(sets.defense.MDT, {
		head="black ribbon",
		neck="Orochi Nodowa +1",
		legs="blood cuisses",
	})

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	check_ammo()
	if spell.action_type == 'Ranged Attack' then
		state.CombatWeapon:set(player.equipment.range)
	end

	if spell.action_type == 'Ranged Attack' or
	  (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
		check_ammo(spell, action, spellMap, eventArgs)
	end
	
	if state.DefenseMode.value ~= 'None' and spell.type == 'WeaponSkill' then
		-- Don't gearswap for weaponskills when Defense is active.
		eventArgs.handled = true
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' and state.Buff.Barrage then
		equip(sets.buff.Barrage)
		eventArgs.handled = true
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
function customize_melee_set(meleeSet)
	if player.equipment.main == 'Ridill' then
		meleeSet = set_combine(meleeSet, {neck="Fortitude Torque"})
	elseif player.equipment.sub == 'Ridill' then
		meleeSet = set_combine(meleeSet, {neck="Fortitude Torque",ear2="Suppanomimi"})
	elseif player.equipment.sub == 'Kraken Club' then
		meleeSet = set_combine(meleeSet, {neck="Peacock Amulet",ear1="Suppanomimi"})
	end
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book

		set_macro_page(1, 11)

end



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
    state.Buff.Saboteur = buffactive.saboteur or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Unlocked', 'Locked', 'Accuracy', 'Refresh')
    state.HybridMode:options('Normal', 'PhysicalDef')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
	state.PhysicalDefenseMode:options('None', 'Evasion', 'PDT')
		

    select_default_macro_book()

end


--Begin initializing gear swaps
function init_gear_sets()
	--Template
	sets.mytemplate = {
		--main,
		--sub,
		--ranged,
		--ammo,
		--head,
		--neck,
		--ear1,
		--body,
		--hands,
		--ring1,
		--back,
		--waist,
		--legs,
		--feet,
		--ring2,  --delayed
		--ear2
	}

	--ELEMENTAL STAVES
	sets.ElementalStaff = {main="Chatoyant Staff"}
		sets.ElementalStaff.Fire = {main="Chatoyant Staff"}
		sets.ElementalStaff.Wind = {main="Chatoyant Staff"}
		sets.ElementalStaff.Water = {main="Chatoyant Staff"}
		sets.ElementalStaff.Earth = {main="Chatoyant Staff"}
		sets.ElementalStaff.Lightning = {main="Chatoyant Staff"}
		sets.ElementalStaff.Ice = {main="Aquilo's Staff"}
		sets.ElementalStaff.Light = {main="Chatoyant Staff"}
		sets.ElementalStaff.Dark = {main="Chatoyant Staff"}

	-------------------------------------------------------------------------------------
	--PRECAST Sets
	--JA


	--Fastcast (cast time reduction)
	sets.precast.FC = {
		--main,
		--sub,
		--ranged,
		--ammo,
		head="Warlock's Chapeau",
		--neck,
		--ear1,
		--ear2,
		body="Dls. Tabard +1"
		--hands,
		--ring1,
		--ring2,
		--back,
		--waist,
		--legs,
		--feet
	}

	--Weaponskills
	sets.precast.WS = {
		--main,
		--sub,
		--ranged,
		ammo="Attar Sachet",
		head="Voyager Sallet",
		neck="Chivalrous Chain",
		--ear1,
		--ear2,
		body="Assault Jerkin",
		hands="Hydra Gloves",
		ring1="Crimson Ring",
		back="Amemet Mantle +1",
		waist="Warwolf Belt",
		legs="Hydra Brais",
		feet="Mtt. Leggings +1",
		ring2="Rajas Ring"
	}
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		ear2="Star Earring",
		body="Crm. Scale Mail",
		hands="Dvt. Mitts +1",
	})
	-------------------------------------------------------------------------------------
	--MIDCAST Sets

	--Fastcast (recast reduction, haste and fastcast)
	sets.midcast.FC = {
		--main,
		--sub,
		--ranged,
		--ammo,
		head="Warlock's Chapeau",
		--neck,
		--ear1,
		--ear2,
		body="Dls. Tabard +1",
		hands="Dusk Gloves",
		--ring1,
		--ring2,
		--back,
		waist="Velocious Belt",
		--legs,
		feet="Dusk Ledelsens",
	}

	--Attributes
	--mnd
	sets.midcast.mnd = set_combine(sets.midcast.FC, {
		main="Chatoyant Staff",
		sub="Raptor Strap +1",
		--ranged,
		ammo="Hedgehog Bomb",
		head="Mahatma Hat",
		neck="Promise Badge",
		ear1="Star Earring",
		ear1="Star Earring",
		body="Crm. Scale Mail",
		hands="Zealot's Mitts",
		ring1="Star Ring",
		ring2="Star Ring",
		back="Red Cape +1",
		--waist="Ryl.Kgt. Belt",
		legs="Warlock's Tights",
		--feet
	})

	--int
	sets.midcast.int = set_combine(sets.midcast.FC, {
		main="Chatoyant Staff",
		sub="Raptor Strap +1",
		--ranged,
		ammo="Hedgehog Bomb",
		head="Mahatma Hat",
		neck="Mohbwa Scarf +1",
		ear1="Morion Earring +1",
		ear2="Morion Earring",
		body="Crm. Scale Mail",
		hands="Errant Cuffs",
		ring1="Diamond Ring",
		back="Red Cape +1",
		waist="Forest Rope",
		legs="Magic Cuisses",
		feet="Wise Pigaches +1",
		ring2="Diamond Ring"
	})

	--Skills
	--enfeebling
	sets.midcast['Enfeebling Magic'] = {
		--sub,
		--ranged,
		--ammo,
		head="Dls. Chapeau +1",
		neck="Enfeebling Torque",
		--ear1="Star Earring",
		--ear1="Star Earring",
		body="Warlock's Tabard",
		--hands,
		--ring1,
		--ring2,
		--back,
		--waist,
		--legs,
		feet="Wise Pigaches +1",
	}
	sets.midcast['Paralyze'] = set_combine(sets.midcast.mnd, sets.midcast['Enfeebling Magic'])
	sets.midcast['Paralyze II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.midcast.mnd, {head="Dls. Chapeau +1"})
	sets.midcast['Slow'] = set_combine(sets.midcast.mnd, sets.midcast['Enfeebling Magic'])
	sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.midcast.mnd)
	sets.midcast['Poison II'] = set_combine(sets.midcast.int, sets.midcast['Enfeebling Magic'])
	sets.midcast['Blind'] = set_combine(sets.midcast.int, sets.midcast['Enfeebling Magic'])
	sets.midcast['Blind II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.midcast.int)
	sets.midcast['Sleep'] = set_combine(sets.midcast.int, sets.midcast['Enfeebling Magic'])
	sets.midcast['Sleep II'] = set_combine(sets.midcast.int, sets.midcast['Enfeebling Magic'])
	sets.midcast['Sleepga'] = set_combine(sets.midcast.int, sets.midcast['Enfeebling Magic'])

	--enhancing
	sets.midcast['Enhancing Magic'] = set_combine({
		--sub,
		--ranged,
		--ammo,
		--head,
		--neck,
		--ear1,
		--ear2,
		body="Glamor Jupon",
		hands="Dls. Gloves +1",
		--ring1,
		--ring2,
		--back,
		--waist,
		legs="Warlock's Tights",
		--feet
	}, sets.midcast.FC)
	sets.midcast['Enhancing Magic'].Stoneskin = set_combine(sets.midcast.mnd, sets.midcast['Enhancing Magic'])
	sets.midcast['Refresh'] = set_combine(sets.midcast.FC, sets.resistant)

	--elemental
	sets.midcast['Elemental Magic'] = set_combine(sets.midcast.int, {
		--sub,
		--ranged,
		--ammo,
		head="Warlock's Chapeau",
		--neck,
		--ear1,
		ear2="Moldavite Earring",
		--body="Glamor Jupon"
		hands="Zenith Mitts",
		--ring1,
		--ring2,
		--back,
		--waist,
		legs="Druid's Slops",
		feet="Dls. Boots +1",
	})

	--dark
	sets.midcast['Dark Magic'] = set_combine(sets.midcast.FC, {
		neck="Dark Torque",
		body="Glamor Jupon",
		hands="Crimson Fng. Gnt.",
		feet="Wise Pigaches +1",
	})

	--healing
	sets.midcast['Healing Magic'] = set_combine(sets.midcast.mnd, sets.midcast.FC, {
		body="Dls. Tabard +1",
		legs="Warlock's Tights",
	})

	--Resistant (Spell interruption down)
	sets.resistant = {
		--main,
		--sub,
		--ranged,
		--ammo,
		--head=,
		--neck,
		--ear1,
		--ear2,
		body="Warlock's Tabard",
		--hands="Prt. Bangles",
		--ring1,
		--ring2,
		--back,
		--waist,
		--legs,
		--feet="Warlock's Boots"
	}

	sets.midcast.Resistant = set_combine(sets.midcast.FC, sets.resistant )

	-------------------------------------------------------------------------------------
	--AFTERCAST
	--Engaged
	--eg: sets.engaged.tpweapon.offense.defense
	sets.engaged = {
		main="Joyeuse",
		sub="Genbu's Shield",
		ammo="Attar Sachet",
		head="Dls. Chapeau +1",
		neck="Chivalrous Chain",
		ear1="Brutal Earring",
		body="Dalmatica",
		hands="Dusk Gloves",
		ring1="Crimson Ring",
		back="Amemet Mantle +1",
		waist="Velocious Belt",
		legs="Hydra Brais",
		feet="Dusk Ledelsens",
		ring2="Rajas Ring",
		ear2="Dodge Earring"
	}
	sets.engaged.DW = set_combine(sets.engaged, {ear2="Suppanomimi"})
	sets.engaged.Refresh = set_combine(sets.engaged, {
		head="Dls. Chapeau +1",
		body="Dalmatica",
	})
	sets.engaged.Accuracy = set_combine(sets.engaged, {
		neck="Peacock Amulet",
		body="Scorpion Harness +1",
		hands="Hydra Gloves",
		ring1="Sniper's Ring +1",
		ring2="Sniper's Ring +1",
		legs="Hydra Brais",
	})
	sets.engaged.PhysicalDef = set_combine(sets.engaged, {
		head="Blood Mask",
		body="Crm. Scale Mail",
		back="Umbra Cape",
		legs="Blood Cuisses",
		ring1="Jelly Ring",
		ring2="Defending Ring",
	})
	

	--------------------------
	--Defense
	--------------------------
	sets.defense.Evasion = {
		head="Wivre Mask",
		body="Scorpion Harness +1",
		hands="Hydra Gloves",
		ear1="Dodge Earring",
		ear2="Dodge Earring",
		legs="Hydra Brais",
		back="Bat Cape",
		feet="Dls. Boots +1"
	}
	sets.defense.PDT = {
		main="Terra's Staff",
		head="Darksteel Cap +1",
		hands="Dst. Mittens +1",
		back="Umbra Cape",
		legs="Dst. Subligar +1",
		feet="Dst. Leggings +1",
	}
	sets.defense.MDT = {
		main="Chatoyant Staff",
		neck="Jeweled Collar",
		ear1="Star Earring",
		ear2="Star Earring",
		body="Dalmatica",
		hands="Dls. Gloves +1",
		legs="Blood Cuisses",
		feet="Crimson Greaves",
		back="Lamia Mantle +1",
	}
	
	sets.Kiting = {legs="Blood Cuisses"}


	-------------------------------------------------------------------------------------
	--NON-ACTION Sets
	--Refresh
	--(only refresh gear)
	sets.refresh = {head="Dls. Chapeau +1", body="Dalmatica"}
	--Resting
	sets.resting = {
		main="Chatoyant Staff",
		sub="Raptor Strap +1",
		ammo="Hedgehog Bomb",
		head="Dls. Chapeau +1",
		neck="Promise Badge",
		ear1="Star Earring",
		ear2="Star Earring",
		body="Dalmatica",
		hands="Hydra Gloves",
		ring1="Star Ring",
		ring2="Star Ring",
		back="Lamia Mantle +1",
		waist="Forest Rope",
		legs="Hydra Brais",
		feet="Zenith Pumps",
		}
	--Idle
	sets.idle = {
		main="Earth Staff",
		sub="Raptor Strap +1",
		--ranged,
		ammo="Hedgehog Bomb",
		head="Dls. Chapeau +1",
		neck="Promise Badge",
		ear1="Star Earring",
		body="Dalmatica",
		hands="Crimson Fng. Gnt.",
		ring1="Star Ring",
		ring2="Star Ring",
		back="Umbra Cape",
		waist="Forest Rope",
		legs="Blood Cuisses",
		feet="Crimson Greaves",
		ear2="Star Earring"
	}
	sets.idle.Normal = sets.idle
	--Defense
	sets.idle.PDT = set_combine(sets.idle, sets.defense.PDT, {body="Dalmatica", head="Dls. Chapeau +1"})
	sets.idle.MDT = set_combine(sets.idle, sets.defense.MDT, {body="Dalmatica", head="Dls. Chapeau +1"})

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


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue ~= 'Unlocked' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
function customize_melee_set(meleeSet)
	if player.sub_job == 'DNC' or player.sub_job == 'NIN' then
		meleeSet = set_combine(meleeSet, {ear2="Suppanomimi"})
	end
	return meleeSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1,5)
end
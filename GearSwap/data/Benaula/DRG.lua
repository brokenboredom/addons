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

	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Evasion', 'Accuracy')
    state.HybridMode:options('Normal', 'Evasion', 'Accuracy')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
	state.PhysicalDefenseMode:options('Normal', 'PDT')
    state.MagicalDefenseMode:options('MDT', 'Water', 'Fire', 'Thunder', 'Dark')

    select_default_macro_book()
end


--Begin initializing gear swaps
function init_gear_sets()

	-------------------------------------------------------------------------------------
	--PRECAST Sets
	--Job Abilities
	
	--Waltz
	--CHR then VIT
	sets.precast.JA.Waltz = {
		--head="koenig schaller",
		neck="Flower Necklace",
		--body="koenig cuirass",
		--hands="koenig handschuhs",
		ring1="moon Ring",
		ring2="moon Ring",
		back="Shadow Mantle",
		waist="Corsette +1",
		--legs="koenig diechlings",
		--feet="koenig schuhs",
	}
	
	--Jump
	--We want these to hit more than anything else
	--But a little StoreTP for good measure
	--Affected by VIT
	sets.precast.JA.Jump = {
		ammo="black tathlum",
		head="ace's helm",
		neck="peacock amulet",
		ear1="brutal earring",
		ear2="fowling earring",
		body="zahak's mail",
		hands="hct. mittens +1",
		ring1="rajas ring",
		ring2="sniper's ring +1",
		back="amemet mantle +1",
		waist="potent belt",
		legs="hct. subligar +1",
		feet="drachen greaves",
	}
	--Not affected by VIT
	--Not affected by Drachen Greaves
	sets.precast.JA['High Jump'] = set_combine(sets.precast.JA.Jump, {feet="ares' sollerets"})
	sets.precast.JA['Call Wyvern'] = {body="Wyrm mail"}
	sets.precast.JA.Angon = {ammo="angon"}
	sets.precast.JA['Ancient Circle'] = {legs="drachen brais"}
	
	--Weaponskills
	--Default
	sets.precast.WS = {
		ammo="white tathlum",
		head="hecatomb cap +1",
		neck="fotia gorget",
		ear1="brutal Earring",
		ear2="fowling Earring",
		body="hct. harness +1",
		hands="hct. mittens +1",
		ring1="Rajas Ring",
		ring2="sniper's ring +1",
		back="Amemet Mantle +1",
		waist="potent belt",
		legs="hct. subligar +1",
		feet="hct. leggings +1",
	}
	
	--DRAKESBANE
	--Cirt
	sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {
		body="zahak's mail",
		feet="ares' sollerets",
	})
	sets.precast.WS['Skewer'] = sets.precast.WS['Drakesbane']
	--PENTA
	--More Acc
	sets.precast.WS['Penta Thrust'] = set_combine(sets.precast.WS, {
		neck="peacock amulet",
		body="hct. harness +1",
	})
	

	-------------------------------------------------------------------------------------
	--MIDCAST Sets
	--Healing Breath
	sets.midcast['Healing Magic'] = {head="drachen armet"}
	sets.midcast['Enhancing Magic'] = sets.midcast['Healing Magic']
	sets.midcast['Enfeebling Magic'] = sets.midcast['Healing Magic']

	--Attributes

	-------------------------------------------------------------------------------------
	--AFTERCAST
	
	--------------------------
	--Engaged
	--------------------------
	sets.engaged.Normal = {
		ammo="white tathlum",
		head="ace's helm",
		neck="Chivalrous Chain",
		ear1="brutal Earring",
		ear2="fowling Earring",
		body="zahak's mail",
		hands="Dusk Gloves +1",
		ring1="Rajas Ring",
		ring2="defending ring",
		back="shadow mantle",
		waist="velocious Belt",
		legs="dusk trousers +1",
		feet="homam gambieras",
	}
	sets.engaged.Accuracy = set_combine(sets.engaged, {
		ammo="black tathlum",
		head="homam zucchetto",
		neck="Peacock Amulet",
		ring1="lava's ring",
		ring2="kusha's Ring",
		waist="potent belt",
	})
	sets.engaged.Evasion = {
		ammo="white tathlum",
		head="Wivre Mask +1",
		neck="evasion torque",
		ear1="Elusive Earring",
		ear2="Elusive Earring",
		body="Scp. Harness +1",
		hands="askar manopolas",
		ring1="Rajas Ring",
		ring2="defending ring",
		back="boxer's mantle",
		waist="Velocious Belt",
		legs="blood cuisses",
		feet="homam gambieras",
	}
	sets.engaged.Evasion.Accuracy = set_combine(sets.engaged.Evasion, sets.engaged.Accuracy)
	--------------------------
	--Defense
	--------------------------
	sets.defense.PDT = {
		
	}
	sets.defense.MDT = {
		head="coral visor +1", --2
		ear1="merman's Earring", --2
		ear2="merman's Earring", --2
		body="cor. scale mail +1", --4
		hands="coral fng. gnt. +1", --2
		ring1="merman's Ring", --4
		ring2="defending ring",
		legs="coral cuisses +1", --3
		feet="coral greaves +1", --2
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
	sets.defense.Fire = set_combine(sets.defense.MDT,{
		head="Black Ribbon",
		neck="Orochi Nodowa +1",
		ear1="Star Earring",
		ear2="Star Earring",
		ring1="crimson ring",
		ring2="Harmonius Ring",
		back="Lamia's Mantle +1",
	})
	sets.defense.Thunder = set_combine(sets.defense.MDT, {
		legs="byakko's haidate",
		ring1="adroit Ring +1",
		neck="Orochi Nodowa +1",
		head="black ribbon",
	})
	sets.defense.Dark = set_combine(sets.defense.MDT,{
		neck="Orochi Nodowa +1",
		ring1="lava's Ring",
		ring2="kusha's Ring",
		body="Scp. Harness +1",
		back="Lamia's Mantle +1",
	})
	-------------------------------------------------------------------------------------
	--NON-ACTION Sets
	--Resting
	--Idle
	sets.idle.Normal = {
		--ammo,
		head="wivre mask +1",
		neck="Orochi Nodowa +1",
		ear1="merman's Earring",
		ear2="merman's Earring",
		body="cor. scale mail +1",
		hands="coral fng. gnt. +1",
		ring1="merman's Ring",
		ring2="defending ring",
		back="Shadow Mantle",
		waist="warwolf belt",
		legs="Blood cuisses",
		feet="blood greaves",
	}

	--LATENT EFFECT
	sets.latent_regen = {
		neck="Orochi Nodowa +1",
		body="barone corazza",
	}
	
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for casting events.
-------------------------------------------------------------------------------------------------------------------
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Jump" then -- Foe Countdown --
            send_command('wait 45;input /echo Jump [READY IN 15 SEC.];wait 10;input /echo Jump [READY IN 5 SEC.]')     
        end
    end
	--if buffactive['poison'] then
	--send_command('input /item "antidote" <me>')
	--end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
			if player.equipment.ammo == 'empty' then add_to_chat(122, 'No more Ammo!') end
	end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then handle_equipping_gear(player.status) end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
function customize_melee_set(meleeSet)
	
	return meleeSet
end

function customize_idle_set(idleSet)
	if (player.hpp < 51) then idleSet = set_combine(idleSet, sets.latent_regen) end
	if (player.pet and pet.hpp < 100) then idleSet = set_combine(idleSet, {body="drachen mail"}) end
	
	return idleSet
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1,14)
end

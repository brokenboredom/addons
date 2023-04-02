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
	state.Buff['Berserk'] = buffactive.Berserk or false
	state.Buff['Defender'] = buffactive.Defender or false
	state.Buff['Sentinel'] = buffactive.Sentinel or false
	update_combat_form()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Haste', 'Evasion', 'Accuracy', 'Defense')
    state.HybridMode:options('Normal', 'Evasion', 'Accuracy', 'Defense')
	state.WeaponskillMode:options('Normal', 'Attack')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
	state.PhysicalDefenseMode:options('None', 'PDT')
	state.MagicalDefenseMode:options('None', 'MDT', 'Water', 'Fire', 'Thunder', 'Dark')

    select_default_macro_book()
end

-- Additional local binds
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
	send_command('bind !f9 gs c cycle WeaponskillMode')


--Begin initializing gear swaps
function init_gear_sets()

	--BUFF SPECIFIC
	sets.buff['Sentinel'] = {feet="Vlr. Leggings +1"}

	-------------------------------------------------------------------------------------
	--PRECAST Sets
	--Job Abilities
	sets.precast.JA['Sentinel'] = {feet="Vlr. Leggings +1"}
	sets.precast.JA['Shield Bash'] = {hands="Vlr. Gauntlets +1", ear2="knightly earring"}
	sets.precast.JA['Rampart'] = {head="Vlr. Coronet +1"}
	--Full Enmity
	sets.precast.JA['Provoke'] = {
		head="Vlr. Coronet +1",
		feet="iron ram greaves",
		legs="Vlr. Leggings +1",
		hands="Vlr. Gauntlets +1",
		waist="warwolf belt",
	}
	
	--Waltz
	--CHR then VIT
	sets.precast.JA.Waltz = {
		head="koenig schaller",
		neck="temp. torque",
		body="avalon breastplate",
		hands="koenig handschuhs",
		ring1="moon Ring",
		ring2="moon Ring",
		back="Shadow Mantle",
		waist="Corsette +1",
		legs="koenig diechlings",
		feet="koenig schuhs",
	}
	sets.precast.JA.Fealty = sets.precast.JA.Waltz
	sets.precast.JA.Chivalry = sets.precast.JA.Waltz
	
	--Fastcast (cast time reduction)
	sets.precast.FC = {
		ear2="locquac. earring"
	}
	
	--Weaponskills
	--Default
	sets.precast.WS = {
		head="Hecatomb Cap +1",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Fowling Earring",
		body="hct. harness +1",
		hands="Hct. Mittens +1",
		ring1="Rajas Ring",
		ring2="Sniper's Ring +1",
		back="Amemet Mantle +1",
		waist="Potent Belt",
		legs="hct. subligar +1",
		feet="Hct. Leggings +1",
	}
	sets.precast.WS.Attack = set_combine(sets.precast.WS, {
		body="byrnie +1",
		feet="Ares' sollerets",
		ear2="merman's earring",
	})
	
	--Magical Weaponskills
	--STR INT
	sets.precast.WS['Freezebite'] = set_combine(sets.precast.WS, {
		neck="enlightened chain",
		ear1="Moldavite Earring",
		ear2="morion earring +1",
		body="blood scale mail",
		ring1="zircon ring",
		ring2="omniscient ring",
		waist="al zahbi sash",
		legs="magic cuisses",
	})
	sets.precast.WS['Red Lotus Blade'] = sets.precast.WS['Freezebite']
	sets.precast.WS['Sanguine Blade'] = sets.precast.WS['Freezebite']
	

	-------------------------------------------------------------------------------------
	--MIDCAST Sets
	--Haste/FC
	sets.midcast.FC = {
		head="homam zucchetto",
		hands="Dusk Gloves +1",
		waist="Velocious Belt",
		feet="homam gambieras",
		ear2="locquac. earring"
	}

	--Attributes
	sets.midcast.mnd = {
		neck="Justice Badge",
		ear1="Star Earring",
		ear2="Star Earring",
		body="blood scale mail",
		hands="Dvt. Mitts +1",
		ring1="aqua ring",
		ring2="aqua ring",
		legs="magic cuisses",
		feet="Vlr. Leggings +1",
	}
	sets.midcast.int = {
		body="blood scale mail",
		ear2="Morion Earring +1",
		ring1="Omniscient Ring",
		ring2="Eremite's Ring +1",
		waist="al zahbi sash",
		legs="magic cuisses",
	}
	sets.midcast.chr = sets.precast.JA.Waltz
	sets.midcast.MAB = {ear1="Moldavite Earring"}
	sets.midcast.resistant = {waist="volunteer's belt", legs="Valor breeches", ear2="knightly earring"}
	
	--enhancing
	sets.midcast['Enhancing Magic'] = sets.midcast.resistant
	sets.midcast['Enhancing Magic'].Stoneskin = set_combine(sets.midcast.mnd, sets.midcast['Enhancing Magic'])
	
	--healing
	sets.midcast['Healing Magic'] = set_combine(sets.midcast.mnd, {
		head="Vlr. Coronet +1"
	}, sets.midcast.resistant)
	
	--divine nuke
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.mnd, sets.midcast.chr, sets.midcast.resistant, sets.midcast.MAB)
	sets.midcast.Flash = set_combine(sets.midcast['Divine Magic'], sets.precast.JA['Provoke'], sets.midcast.FC)
	-------------------------------------------------------------------------------------
	--AFTERCAST
	
	--------------------------
	--Engaged
	--------------------------
	sets.engaged = {
		head="homam zucchetto",
		neck="Chivalrous Chain",
		ear1="Brutal Earring",
		ear2="Fowling Earring",
		body="avalon breastplate",
		hands="Dusk Gloves +1",
		ring1="Rajas Ring",
		ring2="defending ring",
		back="shadow mantle",
		waist="Velocious Belt",
		legs="koenig diechlings",
		feet="homam gambieras",
	}
	sets.engaged.Haste = {
		head="homam zucchetto",
		neck="Chivalrous Chain",
		ear1="Brutal Earring",
		ear2="Fowling Earring",
		body="haubergeon +1",
		hands="Dusk Gloves +1",
		ring1="Rajas Ring",
		ring2="sniper's ring +1",
		back="amemett mantle +1",
		waist="Velocious Belt",
		legs="dusk trousers +1",
		feet="homam gambieras",
	}
	
	
	sets.engaged.Accuracy = set_combine(sets.engaged, {
		--ammo="black tathlum",
		neck="Peacock Amulet",
		ring1="Lava's ring",
		ring2="Kusha's Ring",
	})

	sets.engaged.Accuracy.Evasion = {
		--ammo="black tathlum",
		neck="Peacock Amulet",
		ring1="Lava's ring",
		ring2="Kusha's Ring",
		head="Wivre Mask +1",
		ear1="Brutal Earring",
		ear2="Elusive Earring",
		body="Scp. Harness +1",
		hands="Dusk Gloves +1",
		feet="homam gambieras",
		back="boxer's mantle",
		waist="Velocious Belt",
		legs="koenig diechlings",
		}
	sets.engaged.Evasion = {
		--ammo,
		head="Wivre Mask +1",
		neck="Chivalrous Chain",
		ear1="Brutal Earring",
		ear2="Elusive Earring",
		body="Scp. Harness +1",
		hands="askar manopolas",
		ring1="Rajas Ring",
		ring2="Jelly Ring",
		back="boxer's mantle",
		waist="Velocious Belt",
		legs="koenig diechlings",
		feet="homam gambieras",
	}
	sets.engaged.Defense = {
		--ammo,
		head="Koenig schaller",
		neck="parade gorget",
		ear1="Brutal Earring",
		ear2="Elusive Earring",
		body="blood scale mail",
		hands="koenig handschuhs",
		ring1="Rajas Ring",
		ring2="Jelly Ring",
		back="Shadow Mantle",
		waist="warwolf Belt",
		legs="koenig diechlings",
		feet="koenig schuhs",
	}
	
	--------------------------
	--Defense
	--------------------------
	sets.defense.PDT = {
		--ammo,
		head="Koenig schaller",
		neck="parade gorget",
		ear1="Brutal Earring",
		ear2="Elusive Earring",
		body="blood scale mail",
		hands="koenig handschuhs",
		ring1="jelly Ring",
		ring2="defending Ring",
		back="Shadow Mantle",
		waist="warwolf Belt",
		legs="koenig diechlings",
		feet="koenig schuhs",
	}
	--25% MDT
	sets.defense.MDT = {
		head="iron ram sallet", --2
		ear1="merman's Earring", --2
		ear2="merman's Earring", --2
		body="avalon breastplate", --4
		hands="i.r. dastanas", --2
		ring1="merman's Ring", --4
		ring2="defending ring",
		back="lamia mantle",
		legs="iron ram hose", --3
		feet="iron ram greaves", --2
	}

	-------------------------------------------------------------------------------------
	--NON-ACTION Sets
	--Resting
	--Idle
	sets.idle = {
		--ammo,
		neck="Orochi Nodowa +1",
		ear1="Merman's Earring",
		ear2="Merman's Earring",
		ring1="merman's Ring",
		ring2="defending ring",
		back="Shadow Mantle",
		waist="warwolf belt",
		legs="blood cuisses",
		head="iron ram sallet", --2
		body="avalon breastplate", --4
		hands="i.r. dastanas", --2
		feet="askar gambieras", --2
	}

	--LATENT EFFECT
	sets.lt75 = {
		neck="Orochi Nodowa +1",
		body="dusk jerkin +1",
	}
	sets.lt50 = {
		neck="Orochi Nodowa +1",
		ring2="Hercules' Ring",
		body="dusk jerkin +1",
	}
	sets.gt75 = {neck="parade gorget"}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for casting events.
-------------------------------------------------------------------------------------------------------------------


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
	if (player.equipment.sub == "Kraken Club") then
		meleeSet = set_combine(meleeSet, {ear1="Suppanomimi"})
	end
	if (player.equipment.main == 'Justice Sword' or player.equipment.sub == 'Justice Sword') then
		meleeSet = set_combine(meleeSet, {ammo="Virtue Stone"})
	end
	
	if (player.hpp > 74 and player.mpp < 90) then 
		meleeSet = set_combine(meleeSet, sets.gt75)
	elseif (player.hpp < 51) then
		meleeSet = set_combine(meleeSet, sets.lt50)
	elseif (player.hpp < 75) then
		meleeSet = set_combine(meleeSet, sets.lt75)
	end
	
	return meleeSet
end

function customize_idle_set(idleSet)
	if (player.hpp > 74 and player.mpp < 100) then 
		idleSet = set_combine(idleSet, sets.gt75)
	elseif (player.hpp < 100) then
		idleSet = set_combine(idleSet, {neck="Orochi Nodowa +1"})
	elseif (player.hpp < 51) then
		idleSet = set_combine(idleSet, sets.latent_regen)
	end
	return idleSet
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
    
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1,7)
end
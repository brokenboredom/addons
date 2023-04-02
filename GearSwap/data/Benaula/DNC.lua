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
    state.OffenseMode:options('None', 'Evasion', 'Accuracy')
    state.HybridMode:options('Normal', 'Evasion', 'Accuracy')
	state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
	state.PhysicalDefenseMode:options('None', 'PDT')
	state.MagicalDefenseMode:options('MDT', 'None')
    
    select_default_macro_book()
end


--Begin initializing gear swaps
function init_gear_sets()
	-------------------------------------------------------------------------------------
	--PRECAST Sets
	--------------------------------------
    -- Precast sets to enhance JAs
	sets.precast.Jig = {legs="etoile tights", feet="dancer's shoes"}
	sets.precast.Step = {hands="dancer's bangles", feet="etoile shoes"}
	sets.precast.Samba = {head="dancer's tiara"}
	sets.precast['Violent Flourish'] = {body="etoile casaque"}
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		head="etoile tiara",
		neck="temp. torque",
		body="dancer's casaque",
		hands="etoile bangles",
		ring1="moon ring",
		ring2="moon ring",
		back="etoile cape",
		waist="corsette +1",
		legs="etoile tights",
		feet="dance shoes +1",
	}

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
	--STR/DEX/ATK
    sets.precast.WS = {
		ammo="black tathlum",
		head="etoile tiara",
		neck="fotia gorget",
		ear1="brutal earring",
		ear2="Merman's Earring",
		body="etoile casaque",
		hands="denali wristbands",
		ring1="sniper's Ring +1",
		ring2="Rajas Ring",
		back="Amemet Mantle +1",
		waist="potent Belt",
		legs="dusk trousers +1",
		feet="Rutter Sabatons",
	}

	sets.precast.WS.Mab = {
		head="denali bonnet",
		neck="prudence torque",
		ear1="morion Earring +1",
		ear2="Moldavite Earring",
		body="etoile casaque",
		hands="wood Gloves",
		ring1="omniscient Ring +1",
		ring2="Eremite's Ring +1",
		back="etoile cape",
		waist="scouter's rope",
		legs="denali kecks",
		feet="denali gamashes",
	}
	
	--Shark Bite
	--Very heavy dex wsc, dex is best
    sets.precast.WS['Shark Bite'] = set_combine(sets.precast.WS, {
		ring1="Adroit ring +1",
		ear2="pixie earring",
		waist="Warwolf Belt",
		feet="etoile shoes",
	})
    sets.precast.WS['Shark Bite'].Acc = sets.precast.WS['Shark Bite']
	
	--Evisceration
	--Can crit so heavy dex for crit+
	sets.precast.WS['Evisceration'] = sets.precast.WS
	sets.precast.WS['Evisceration'].Acc = sets.precast.WS.Acc

	--------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FC = {
		head="Walahra Turban",
		body="Rapparee Harness",
		hands="Dusk Gloves +1",
		waist="Velocious Belt",
		legs="etoile tights",
		feet="Dusk Ledelsens +1"
	}

    -- Ranged gear
    sets.midcast.RA = {
		neck="Peacock Amulet",
		ear1="Drone Earring",
		ear2="Drone Earring",
		body="Rapparee Harness",
		ring1="merman's ring",
		ring2="merman's ring",
		back="Amemet Mantle +1",
		waist="scouter's rope",
	}

    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {}


    -- Idle sets
    sets.idle.Normal = {
		head="Wivre Mask +1",
		neck="Orochi Nodowa +1",
		ear1="merman's Earring",
		ear2="merman's Earring",
		body="avalon breastplate",
		ring1="shadow Ring",
		ring2="defending Ring",
		back="Shadow Mantle",
		waist="scouter's rope",
		legs="merman's subligar",
		hands="denali wristbands",
		feet="dance shoes +1",
		}

    -- Defense sets
    sets.defense.PDT = {
		hands="denali wristbands",
		ring1="jelly ring",
		ring2="defending ring",
		back="Shadow Mantle",
	}
    sets.defense.MDT = {
		head="merman's cap",
		ear1="merman's Earring",
		ear2="merman's Earring",
		body="merman's harness",
		ring2="defending Ring",
		ring1="shadow ring",
		back="Lamia Mantle +1",
		legs="merman's subligar",
	}

    --------------------------------------
    -- Melee sets
    --------------------------------------
    -- Normal melee group
    sets.engaged = {
		ammo="white tathlum",
		head="denali bonnet",
		neck="chivalrous chain",
		ear1="brutal Earring",
		ear2="suppanomimi",
		body="rapparee harness",
		hands="dusk gloves +1",
		ring1="rajas Ring",
		ring2="defending Ring",
		back="etoile cape",
		waist="velocious Belt",
		legs="etoile tights",
		feet="Dusk Ledelsens +1"
	}
    sets.engaged.Accuracy = set_combine(sets.engaged, {
		neck="Peacock Amulet",
		body="Scp. Harness +1",
		ring1="lava's Ring",
		ring2="kusha's Ring",
		waist="potent Belt",
	})
    sets.engaged.Evasion = set_combine(sets.engaged, {
		head="Wivre Mask +1",
		neck="evasion torque",
		ear1="elusive Earring",
		ear2="elusive Earring",
		body="Scp. Harness +1",
		hands="denali wristbands",
		waist="scouter's rope",
		legs="denali kecks",
		feet="dance shoes +1"
	})
    sets.engaged.Evasion.Accuracy = {
		head="Wivre Mask +1",
		neck="Peacock Amulet",
		ear1="elusive Earring",
		ear2="elusive Earring",
		body="Scp. Harness +1",
		hands="denali wristbands",
		ring1="lava's Ring",
		ring2="kusha's Ring",
		back="etoile cape",
		waist="scouter's rope",
		legs="denali kecks",
		feet="dance shoes +1"
	}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for casting events.
-------------------------------------------------------------------------------------------------------------------
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
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
-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1,16)
end
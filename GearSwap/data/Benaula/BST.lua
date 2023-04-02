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
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
	state.PhysicalDefenseMode:options('None', 'PDT', 'MDT', 'Water', 'Fire', 'Thunder', 'Stone', 'Dark')
    
    select_default_macro_book()
end


--Begin initializing gear swaps
function init_gear_sets()

-------------------------------------------------------------------------------------
	--PRECAST Sets
	--JA
	sets.precast.JA['Charm'] = {
		head="monser helm",
		body="monster jackcoat",
		hands="monster gloves",
		legs="beast trousers",
		feet="monster gaiters",
		ring1="moon ring",
		ring2="moon ring",
		neck="flower necklace",
		waist="corsette +1",
	}
	--Reward
	--MND/+reward
	sets.precast.JA['Reward'] = {
		ammo="pet food zeta",
		head="bison warbonnet",
		neck="promise badge",
		ear1="Star earring",
		ear2="star earring",
		--body="Monster Jckcoat +1"
		hands="ogre gloves",
		ring1="sapphire ring",
		ring2="sapphire ring",
		feet="monster gaiters"
	}
	
	--Call Beast
	sets.precast.JA['Call Beast'] = {hands="Monster Gloves"}
	
	--Weaponskills
	--Default
	sets.precast.WS = {
		head="Hecatomb Cap +1",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Merman's Earring",
		body="Adaman Hauberk",
		hands="Hct. Mittens +1",
		ring1="Rajas Ring",
		ring2="Harmonius Ring",
		back="Amemet Mantle +1",
		waist="swordbelt",
		legs="Hct. Subligar +1",
		feet="Hct. Leggings +1"
	}
	
	--DECIMATION
	--More ACC
	sets.precast.WS['Decimation'] = set_combine(sets.precast.WS, {
		ear2="pixie earring",
		ring1="lava's ring",
		ring2="kusha's ring",
		waist="potent belt",
	})
	
	--ELEMENTAL
	--STR/INT/MAB
	sets.precast.WS['Dark Harvest'] = set_combine(sets.precast.WS, {
		ear2="Moldavite Earring",
	})
	sets.precast.WS['Shadow of Death'] = sets.precast.WS['Dark Harvest']
	
	--CLOUDSPLITTER
	--INT
	sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS, {
		head="beast helm",
		neck="Prudence Torque",
		ear1="morion earring +1",
		ear2="moldavite earring",
		body="monster jackcoat",
		hands="alkyoneus's brc.",
		ring1="omniscient Ring",
		ring2="zircon ring",
		legs="magic cuisses",
		feet="hct. leggings +1",
	})

-------------------------------------------------------------------------------------
--MIDCAST Sets


--Attributes

-------------------------------------------------------------------------------------
--AFTERCAST
	sets.engaged = {
		head="panther mask +1",
		neck="Chivalrous Chain",
		ear1="Brutal Earring",
		ear2="merman's Earring",
		body="Adaman Hauberk",
		hands="dusk gloves +1",
		ring1="lava's ring",
		ring2="kusha's ring",
		back="Amemet Mantle +1",
		waist="velocious belt",
		waist="velocious belt",
		legs="byakko's haidate",
		feet="dusk ledelsens +1"
	}
	sets.engaged.Accuracy = set_combine(sets.engaged, {
		neck="Peacock Amulet",
		body="Scp. Harness +1",
	})
	sets.engaged.Evasion = {
		head="wivre mask +1",
		neck="evasion torque",
		ear1="elusive earring",
		ear2="elusive earring",
		body="scp. harness +1",
		hands="seiryu's kote",
		ring1="lava's ring",
		ring2="kusha's ring",
		back="boxer's mantle",
		waist="scouter's rope",
		legs="beast trousers",
		feet="dance shoes +1",
	}

	sets.idle = {
		head="wivre mask +1",
		neck="temp. torque",
		ear1="merman's Earring",
		ear2="merman's Earring",
		body="scp. harness +1",
		hands="seiryu's kote",
		ring1="merman's ring",
		ring2="shadow ring",
		back="shadow mantle",
		waist="scouter's rope",
		legs="byakko's haidate",
		feet="suzaku's sune-ate",
	}
	
	sets.defense.PDT = {}
	sets.defense.MDT = {
		head="merman's cap",
		ear1="merman's Earring",
		ear2="merman's Earring",
		body="merman's harness",
		ring1="merman's Ring",
		ring2="shadow ring",
		back="Lamia Mantle +1",
		legs="merman's subligar",
	}
	sets.defense.Water = set_combine(sets.defense.MDT,{
		head="genbu's kabuto",
		neck="Orochi Nodowa +1",
		ear1="Star Earring",
		ear2="Star Earring",
		ring1="Sapphire Ring",
		ring2="Sapphire Ring",
		body="Scp. Harness +1",
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
		neck="Orochi Nodowa +1",
		ring1="lava's Ring",
		ring2="kusha's Ring",
		body="Scp. Harness +1",
	})

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for casting events.
-------------------------------------------------------------------------------------------------------------------
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.


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

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
function customize_melee_set(meleeSet)
	--regen
	if (player.hpp < 51) then
		meleeSet = set_combine(meleeSet, sets.latent_regen)
	end
	
	--weapons
	if player.equipment.main == "Suzaku's Scythe" then
		meleeSet = set_combine(meleeSet, {neck="Prudence Torque"})
	else
		meleeSet = set_combine(meleeSet, {neck="Temp. Torque"})
	end
	if player.equipment.sub == 'Ridill' then
		meleeSet = set_combine(meleeSet, {ear2="Suppanomimi"})
	elseif (player.equipment.sub == 'Temperance Axe') then
		meleeSet = set_combine(meleeSet, {ear2="Suppanomimi", ammo="Virtue Stone"})
	elseif (player.equipment.main == 'Temperance Axe') then
		meleeSet = set_combine(meleeSet, {ammo="Virtue Stone"})
	end
	
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------



-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1,9)
end
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
	state.Buff['Blood Weapon'] = buffactive['Blood Weapon'] or false
    state.Buff['Souleater'] = buffactive.Souleater or false
	state.Buff['Last Resort'] = buffactive['Last Resort'] or false
	state.Buff['Berserk'] = buffactive['Berserk'] or false
	dark_magic_maps = {} 
	dark_magic_maps.Absorb = S{'Absorb-ACC', 'Absorb-AGI', 'Absorb-CHR', 'Absorb-DEX', 'Absorb-INT', 'Absorb-MND', 'Absorb-STR', 'Absorb-TP', 'Absorb-VIT'}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Evasion', 'Accuracy', 'Mod', 'Defense')
    state.HybridMode:options('Normal', 'Evasion', 'Accuracy', 'Mod', 'Defense')
	state.WeaponskillMode:options('Normal')
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
		head="Panther Mask +1",
		neck="Chivalrous Chain",
		ear1="Brutal Earring",
		ear2="Spike Earring",
		body="Unicorn Harness",
		hands="Dusk Gloves +1",
		ring1="Rajas Ring",
		ring2="Harmonius Ring",
		back="Shadow Mantle",
		waist="ninurta's sash",
		legs="Unicorn Subligar",
		feet="Unicorn Leggings",
	}
	--ACC/EVA
	sets.buff['Last Resort'] = {
		head="Ace's Helm",neck="Chivalrous Chain",ear1="Pixie Earring",ear2="Brutal Earring",
		body="Dusk Jerkin +1",hands="Dusk Gloves +1",ring1="Rajas Ring",ring2="Sniper's Ring +1",
		back="Amemet Mantle +1",waist="ninurta's sash",legs="Homam Cosciales",feet="Dusk Ledelsens +1"}
	
	sets.buff.Berserk = sets.buff['Last Resort']
	--PDT/DEF
	sets.buff['Souleater'] = {
		
	}
	--Full Accuracy
	sets.buff['Blood Weapon'] = {
		neck="Peacock Amulet",
		ring2="Sniper's Ring +1",
	}

	-------------------------------------------------------------------------------------
	--PRECAST Sets
	--Job Abilities
	
	--Full Enmity
	
	--Waltz
	--CHR then VIT
	sets.precast.JA.Waltz = {
		head="Panther Mask +1",
		neck="Flower Necklace",
		ring1="Soil Ring",
		ring2="Soil Ring",
		back="Shadow Mantle",
		waist="Corsette +1",
		legs="Prince's Slops",
		feet="Savage Gaiters",
	}
	
	--Weaponskills
	--Default
	sets.precast.WS = {
		head="Hecatomb Cap +1",
		neck="Fotia Gorget",
		ear1="Merman's Earring",
		ear2="Brutal Earring",
		body="Adaman Hauberk",
		hands="Hct. Mittens +1",
		ring1="Rajas Ring",
		ring2="Crimson Ring",
		back="Abyss Cape",
		waist="Potent Belt",
		legs="Black Cuisses",
		feet="Black Sollerets",
	}
	
	--Job Ability
	--Full Atk

	--More Acc

	--No DA
	--Remove Brutal/Relic/AF

	--Magic
	sets.precast.FC = {legs="Homam Cosciales"}
	

	-------------------------------------------------------------------------------------
	--MIDCAST Sets
	sets.midcast.RA = {
		head="Dobson Bandana",
		neck="Peacock Amulet",
		ear1="Drone Earring",
		ear2="Drone Earring",
		body="Scp. Harness +1",
		hands="Irn. Msk. Gauntlets",
		ring1="Rajas Ring",
		ring2="Jaeger Ring",
		back="Bat Cape",
		waist="ninurta's sash",
		legs="Fourth Schoss",
	}

	--Magic
	sets.midcast['Dark Magic'] = {head="Walahra Turban",neck="Dark Torque",ear1="Moldavite Earring",ear2="Phantom Earring",
	body="Abyss Cuirass",hands="Abyss Gauntlets",ring1="Diamond Ring",ring2="Diamond Ring",
	back="Bat Cape",waist="ninurta's sash",legs="Abyss Flanchard",feet="Dusk Ledelsens +1"}
	
	sets.midcast['Dark Magic'].Absorb = set_combine(sets.midcast['Dark Magic'], {legs="Black Cuisses",feet="Black Sollerets"})
	
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Dark Magic'], {neck="Enfeebling Torque",
	legs="Homam Cosciales",feet="Abyss Sollerets"})
	
	sets.midcast['Elemental Magic'] = set_combine(sets.midcast['Dark Magic'], {legs="Homam Cosciales"})
	
	sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {neck="Chivalrous Chain",ear1="novia earring",ear2="Elusive Earring",
	body="Scp. Harness +1",hands="Dusk Gloves +1",
	legs="Homam Cosciales"})
	
	--Attributes

	-------------------------------------------------------------------------------------
	--AFTERCAST
	
	--------------------------
	--Engaged
	--------------------------
	sets.engaged = {
		head="Walahra Turban",neck="Chivalrous Chain",ear1="Pixie Earring",ear2="Brutal Earring",
		body="Adaman Hauberk",hands="Dusk Gloves +1",ring1="Rajas Ring",ring2="Spinel Ring",
		back="Amemet Mantle +1",waist="ninurta's sash",legs="Homam Cosciales",feet="Homam Gambieras"}
	
	sets.engaged.Accuracy = set_combine(sets.engaged, {
		neck="Peacock Amulet",
		body="Abyss Cuirass",
		ring2="Sniper's Ring +1"})
	
	sets.engaged.Accuracy.Evasion = {
		--ammo,
		neck="Peacock Amulet",
		ring1="Rajas Ring",
		ring2="Sniper's Ring +1",
		head="Wivre Mask +1",
		ear1="Elusive Earring",
		ear2="Brutal Earring",
		body="Scp. Harness +1",
		hands="Dusk Gloves +1",
		feet="Dusk Ledelsens +1",
		back="Bat Cape",
		waist="ninurta's sash",
		legs="Fourth Schoss"}
		
	sets.engaged.Haste = {
		head="Ace's Helm",neck="Chivalrous Chain",ear1="Pixie Earring",ear2="Brutal Earring",
		body="Adaman Hauberk",hands="Askar Manopolas",ring1="Rajas Ring",ring2="Spinel Ring",
		back="Amemet Mantle +1",waist="ninurta's sash",legs="Askar Dirs",feet="Homam Gambieras"}
	
	sets.engaged.Evasion = {
		--ammo,
		head="Wivre Mask +1",
		neck="Chivalrous Chain",
		ear1="novia earring",
		ear2="Elusive Earring",
		body="Scp.  Harness +1",
		hands="Dusk Gloves +1",
		ring1="Rajas Ring",
		ring2="Shadow Ring",
		back="Bat Cape",
		waist="ninurta's sash",
		legs="Fourth Schoss",
		feet="Dusk Ledelsens +1"}
	
	sets.engaged.Defense = {
		--ammo,
		head="Unicorn Cap",
		neck="Chivalrous Chain",
		ear1="Brutal Earring",
		ear2="Elusive Earring",
		body="Unicorn Harness",
		hands="Unicorn Mittens",
		ring1="Rajas Ring",
		ring2="Harmonius Ring",
		back="Shadow Mantle",
		waist="ninurta's sash",
		legs="Unicorn Subligar",
		feet="Unicorn Leggings"}
	
	--------------------------
	--Defense
	--------------------------
	sets.defense.PDT = {}
	
	sets.engaged.MDT = {}
	
	-------------------------------------------------------------------------------------
	--NON-ACTION Sets
	--Resting
	--Idle
	sets.idle.Normal = {
		--ammo,
		head="Blood Mask",neck="Orochi Nodowa",ear1="Merman's earring",ear2="Merman's Earring",
		body="Plastron",hands="Askar Manopolas",ring1="Merman's Ring",ring2="Shadow Ring",
		back="Shadow Mantle",waist="ninurta's sash",legs="Blood Cuisses",feet="Askar Gambieras"}

	--LATENT EFFECT
	sets.latent_refresh = {neck="Parade Gorget"}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for casting events.
-------------------------------------------------------------------------------------------------------------------


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
function customize_melee_set(meleeSet)
	if buffactive['Last Resort'] then
		meleeSet = set_combine(meleeSet,sets.buff['Last Resort'])
	elseif buffactive['Berserk'] then
		meleeSet = set_combine(meleeSet,sets.buff['Last Resort'])
	end
	if buffactive['Blood Weapon'] then
		meleeSet = set_combine(meleeSet, sets.buff['Blood Weapon'])
	end
	if buffactive['Souleater'] then
		meleeSet = set_combine(meleeSet, sets.buff['Souleater'])
	end
	return meleeSet
end

function customize_idle_set(idleSet)
	if (player.hpp > 85) then
		idleSet = set_combine(idleSet, sets.latent_refresh)
	end
	return idleSet
end

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.

function job_get_spell_map(spell, default_spell_map)
	if spell.skill == 'Dark Magic' then
		for category,spell_list in pairs(dark_magic_maps) do
			if spell_list:contains(spell.english) then
				return category
			end
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1,15)
end
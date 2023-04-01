-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('TH', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'EXP')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    
	--------------------------------------
    -- Start defining the sets
    --------------------------------------
	-- Precast Sets

    -- Fast cast sets for spells
	
	--Job Ability sets
    sets.precast.JA['Perfect Dodge'] = {hands="Plun. Armlets"}
    sets.precast.JA.Flee = {feet="Rogue's Poulaines"}

    --Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    gear.default.weaponskill_neck = "Fotia Gorget"
    gear.default.weaponskill_waist = "Fotia Belt"
	
    sets.precast.WS.Evisceration = {head="Espial Cap",neck="Fotia Gorget",ear1="Aesir Ear Pendant",ear2="Brutal Earring",
        body="Rawhide Vest",hands="Espial Bracers",ring1="Epona's Ring",ring2="Rajas Ring",
        back="Atheling Mantle",waist="Fotia Belt",legs="Herculean Trousers",feet="Espial Socks"}
    
    sets.precast.WS['Mandalic Stab'] = {head="Espial Cap",neck="Fotia Gorget",ear1="Aesir Ear Pendant",ear2="Brutal Earring",
        body="Rawhide Vest",hands="Espial Bracers",ring1="Epona's Ring",ring2="Rajas Ring",
        back="Atheling Mantle",waist="Fotia Belt",legs="Herculean Trousers",feet="Espial Socks"}
		
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.Evisceration, {ammo="Pemphredo Tathlum",
		head="Wayfarer Circlet",
		body="Wayfarer Robe",
		hands="Pursuer's Cuffs",
		legs="Wayfarer Slops",
		feet="Raider's Poulaines +2",
		neck="Sanctity Necklace",
		ring1="Acumen Ring",
		ear1="Hecate's Earring",
		ear2="Friomisi Earring",
		back="Toro Cape"})

    sets.precast.WS.Exenterator = {head="Espial Cap",neck="Fotia Gorget",ear1="Aesir Ear Pendant",ear2="Brutal Earring",
        body="Rawhide Vest",hands="Espial Bracers",ring1="Epona's Ring",ring2="Rajas Ring",
        back="Atheling Mantle",waist="Fotia Belt",legs="Herculean Trousers",feet="Espial Socks"}
    
	-- Midcast Sets
	
	--Idle sets
    sets.idle.Normal = {head="Espial Cap",neck="Sanctity Necklace",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Rawhide Vest",hands="Espial Bracers",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Atheling Mantle",waist="Cetl Belt",legs="Herculean Trousers",feet="Skadi's Jambeaux +1"}
                
    sets.idle.EXP = {head="Espial Cap",neck="Twilight Torque",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Rawhide Vest",hands="Espial Bracers",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Mecistopins Mantle",waist="Cetl Belt",legs="Herculean Trousers",feet="Skadi's Jambeaux +1"}
    
    -- Resting sets
	
	
	--Emergency sets that override other states
    sets.defense.PDT = {
        neck="Twilight Torque",
        ring1="Defending Ring",
		ring2="Epona's Ring",
	}

    sets.defense.MDT = {
		legs="Taeon Tights",
		feet="Taeon Boots",
        neck="Twilight Torque",
        ring1="Defending Ring",
		ring2="Epona's Ring",
	}
	
	-- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {ammo="Ginsen",head="Espial Cap",neck="Sanctity Necklace",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Rawhide Vest",hands="Plunderer's Armlets",ring1="Epona's Ring",ring2="Rajas Ring",
        back="Atheling Mantle",waist="Cetl Belt",legs="Herculean Trousers",feet="Rawhide Boots"}
		
	sets.engaged.TH = {
		ammo="Ginsen",head="Espial Cap",neck="Sanctity Necklace",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Rawhide Vest",hands="Plunderer's Armlets",ring1="Epona's Ring",ring2="Rajas Ring",
        back="Atheling Mantle",waist="Cetl Belt",legs="Herculean Trousers",feet="Raider's Poulaines +2"}
		
	sets.engaged.Acc = {
		ammo="Ginsen",head="Espial Cap",neck="Sanctity Necklace",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Rawhide Vest",hands="Espial Bracers",ring1="Epona's Ring",ring2="Rajas Ring",
        back="Atheling Mantle",waist="Cetl Belt",legs="Herculean Trousers",feet="Rawhide Boots"}
		
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
		if newValue == 'TH' then
			enable('main','sub','range')
			equip(sets.engaged.TH)
            disable('main','sub','range')
		elseif newValue == 'Normal' then
			enable('main','sub','range')
			equip(sets.engaged.Normal)
			disable('main','sub','range')
        elseif newValue == 'Acc' then
            enable('main','sub','range')
			equip(sets.engaged.Acc)
            disable('main','sub','range')
		else
			enable('main','sub','range')
        end
    end
	if stateField == 'Idle Mode' then
		if newValue == 'EXP' then
			equip(sets.idle.EXP)
			disable('back')
		else
			enable('back')
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(3, 4)
end
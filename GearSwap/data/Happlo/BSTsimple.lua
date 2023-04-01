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
	state.OffenseMode:options('Normal','Accuracy','Pet')
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
	
	-- Job Ability sets
	
	sets.precast.JA['Charm'] = {}
	
	-- Waltz set (chr and vit)
    sets.precast.Waltz = {}
		
	-- Default set for any weaponskill that isn't any more specifically defined
    gear.default.weaponskill_neck = "Fotia Gorget"
    gear.default.weaponskill_waist = "Fotia Belt"
	
	sets.precast.WS = {neck=gear.ElementalGorget,waist=gear.ElementalBelt,ear2="Aesir Ear Pendant"}
		
	-- Midcast Sets
	
	-- Sets to return to when not performing an action.
    
    -- Resting sets
	
	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {head="Valorous Mask",body="Acro Surcoat",hands="Despair Finger Gauntlets",legs="Acro Breeches",feet="Ejekamal boots",neck="Twilight Torque",waist="Nierenschutz",back="Metallon Mantle",ring1="Sheltered Ring", ring2="Paguroidea Ring",ear1="Ethereal Earring"}
	
	sets.idle.EXP = {head="Valorous Mask",body="Acro Surcoat",hands="Despair Finger Gauntlets",legs="Acro Breeches",feet="Ejekamal boots",neck="Twilight Torque",waist="Nierenschutz",back="Mecistopins Mantle",ring1="Sheltered Ring", ring2="Paguroidea Ring",ear1="Ethereal Earring"}
	
	-- Defense sets
	
	-- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
	sets.engaged = {ammo="Ginsen",head="Valorous Mask",body="Acro Surcoat",hands="Despair Finger Gauntlets",legs="Acro Breeches",feet="Ejekamal boots",neck="Agasaya's Collar",waist="Cetl Belt",back="Atheling Mantle",ring1="Epona's Ring",ring2="Rajas Ring",ear1="Brutal Earring",ear2="Suppanomimi"}
	
	sets.engaged.Accuracy = {ammo="Ginsen",head="Valorous Mask",body="Acro Surcoat",hands="Despair Finger Gauntlets",legs="Acro Breeches",feet="Ejekamal boots",neck="Agasaya's Collar",waist="Cetl Belt",back="Sokolski Mantle",ring1="Epona's Ring",ring2="Rajas Ring",ear1="Brutal Earring",ear2="Suppanomimi"}
	
end	

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
		if newValue == 'Normal' then
			equip(sets.engaged.Normal)
			disable('main','sub','range')
		elseif newValue == 'Ninja' then
			enable('main','sub','range')
			equip(sets.engaged.Ninja)
            disable('main','sub','range')
        elseif newValue == 'Accuracy' then
            enable('main','sub','range')
			equip(sets.engaged.Accuracy)
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
    set_macro_page(6, 5)
end
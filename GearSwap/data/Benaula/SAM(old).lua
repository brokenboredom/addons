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
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'Eva')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')

    update_combat_form()
    
    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head="Myochin Kabuto"}
    sets.precast.JA['Warding Circle'] = {head="Myochin Kabuto"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		head="Voyager Sallet",
		neck="Chivalrous Chain",
		ear1="Spike Earring",
		ear2="Spike Earring",
		body="Shm. Hara-Ate",
		hands="Horomusha Kote",
		ring1="Rajas Ring",
		ring2="Courage Ring",
		back="Amemet Mantle +1",
		waist="Potent Belt",
		legs="Shm. Haidate",
		feet="Mtt. Leggings +1",
	}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {neck="Snow Gorget"})

    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {neck="Thunder Gorget"})

    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {neck="Snow Gorget"})


    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {neck="Light Gorget"})

    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {neck="Snow Gorget"})

    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {neck="Snow Gorget"})

    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {neck="Soil Gorget"})

    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {neck="Soil Gorget"})


    -- Midcast Sets
	sets.midcast.RA = {
		head="Wivre Mask +1",
		neck="Peacock Amulet",
		ear1="Elusive Earring",
		ear2="Elusive Earring",
		body="Shm. Hara-Ate",
		hands="Horomusha Kote",
		ring1="Rajas Ring",
		ring2="Courage Ring",
		back="Bat Cape",
		waist="Survival Belt",
		legs="Shm. Haidate",
		feet="Bounding Boots",
	}
    -- Sets to return to when not performing an action.

	--Resting sets

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    
    sets.idle = {
		head="Wivre Mask +1",
		neck="Chivalrous Chain",
		ear1="Elusive Earring",
		ear2="Elusive Earring",
		body="Shm. Hara-Ate",
		hands="Horomusha Kote",
		ring1="Rajas Ring",
		ring2="Courage Ring",
		back="Bat Cape",
		waist="Velocious Belt",
		legs="Shm. Haidate",
		feet="Sarutobi Kyahan",
	}

    
    -- Defense sets
	--Override engaged/idle gears
    sets.defense.PDT = {
		head="Arh. Jinpachi +1",
		body="Arhat's Gi +1",
		hands="Rasetsu Tekko +1",
		ring2="Defending Ring",
		ring1="Jelly Ring",
		back="Shadow Mantle",
		legs="Rst. Hakama +1",
	}

    sets.defense.MDT = sets.defense.PDT

    sets.Kiting = {feet="Danzo Sune-ate"}


    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
		head="Wivre Mask +1",
		neck="Chivalrous Chain",
		ear1="Elusive Earring",
		ear2="Elusive Earring",
		body="Shm. Hara-Ate",
		hands="Horomusha Kote",
		ring1="Rajas Ring",
		ring2="Courage Ring",
		back="Bat Cape",
		waist="Velocious Belt",
		legs="Shm. Haidate",
		feet="Sarutobi Kyahan",
	}
    sets.engaged.Acc = set_combine(sets.engaged, {
		body="Scorpion Harness",
		neck="Peacock Amulet",
	})
    sets.engaged.Eva = set_combine(sets.engaged, {
		head="Wivre Mask +1",
		body="Scorpion Harness",
		back="Bat Cape",
		ear1="Elusive Earring",
		ear2="Elusive Earring",
		hands="Rasetsu Tekko +1",
		waist="Survival Belt",
	})
        
	--Counter/Evasion
	sets.engaged.Seigan = {
		head="Rst. Jinpachi +1",
		body="Rasetsu Samue +1",
		back="Boxer's Mantle",
		ear1="Elusive Earring",
		ear2="Elusive Earring",
		hands="Rasetsu Tekko +1",
		waist="Survival Belt",
		legs="Rst. Hakama +1",
	}
	
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.



-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    state.CombatForm:reset()
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book

        set_macro_page(1, 12)

end


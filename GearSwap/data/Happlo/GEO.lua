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
    state.OffenseMode:options('None', 'Normal', 'Accuracy')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'EXP')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
		head="Merlinic Hood",
		ear1="Loquacious Earring",
        body="Rosette Jaseran",
		hands="Weatherspoon Cuffs +1",
		ring1="Prolix Ring",
        back="Swith Cape",
		waist="Channeler's Stone",
		legs="Geomancy Pants",
		feet="Merlinic Crackows"
		}
		
	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {hands="Bagua Mitaines"})
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {main="Queller Rod",sub="Sors Shield",ammo="Impatiens"})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	--Job Ability sets
	
	sets.precast.JA['Full Circle'] = {body="Geomancy Tunic"}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals"}
	sets.precast.JA['Mending Halation'] = {hands="Bagua Pants"}
	sets.precast.JA['Curative Recantation'] = {hands="Bagua Mitaines"}
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    gear.default.weaponskill_neck = "Fotia Gorget"
    gear.default.weaponskill_waist = "Fotia Belt"
    sets.precast.WS = {
        head="Sukeroku Hachimaki",ear2="Brutal Earring",ear1="Aesir Ear Pendant",
        ring1="Rajas Ring",
        legs="Assiduity Pants +1",feet="Battlecast Gaiters"}
    
	--Myrkr should use a Max MP set
    sets.precast.WS['Myrkr'] = {
        head="Vanya Hood",
		ear2="Loquacious Earring",
        body="Rosette Jaseran",
		hands="Weatherspoon Cuffs +1",
        back="Tempered Cape +1",
		waist="Hierarch Belt",
		legs="Orvail Pants +1",
		feet="Gendewitha Galoshes +1"
		}
		
		
    -- Midcast Sets
    
    sets.midcast.FastRecast = {
        head="Merlinic Hood",
		ear2="Loquacious Earring",
        body="Rosette Jaseran",
		ring1="Prolix Ring",
        back="Swith Cape",
		waist="Channeler's Stone",
		legs="Psycloth Lappas",
		feet="Merlinic Crackows"
		}
		
	--Conserve MP sets for Luopans
	sets.midcast.ConserveMP = {
	}
    
    -- Cure sets
    gear.default.obi_waist = "Hierarch Belt"
    gear.default.obi_back = "Tempered Cape +1"

    sets.midcast.Cure = {
        head="Vanya Hood",
		neck="Nesanica Torque",
		ear1="Mendicant's Earring",
        hands="Weatherspoon Cuffs +1",
		ring1="Ephedra Ring",
		ring2="Ephedra Ring",
        back="Tempered Cape +1",
		legs="Assiduity Pants +1",
		feet="Vanya Clogs"
		}

    sets.midcast.Curaga = {
        head="Vanya Hood",
		neck="Nesanica Torque",
		ear1="Mendicant's Earring",
        hands="Weatherspoon Cuffs +1",
		ring1="Ephedra Ring",
		ring2="Ephedra Ring",
        back="Tempered Cape +1",
		legs="Assiduity Pants +1",
		feet="Vanya Clogs"
		}

    sets.midcast.CureMelee = {
        head="Vanya Hood",
		neck="Nesanica Torque",
		ear1="Mendicant's Earring",
        hands="Weatherspoon Cuffs +1",
		ring1="Ephedra Ring",
		ring2="Ephedra Ring",
        back="Tempered Cape +1",
		legs="Assiduity Pants +1",
		feet="Vanya Clogs"
		}

    sets.midcast.Cursna = {
        neck="Malison Medallion",
        ring1="Ephedra Ring",
		ring2="Ephedra Ring",
        back="Tempered Cape +1",
		feet="Vanya Clogs"
		}

    sets.midcast.Protect = {ring2="Sheltered Ring"}

    sets.midcast.Shell = {ring2="Sheltered Ring"}
	
	sets.midcast['Elemental Magic'] = {
		head="Merlinic Hood",
		body="Azimuth Coat",
		hands="Bagua Mitaines",
		legs="Psycloth Lappas",
        feet="Merlinic Crackows",
		neck="Sanctity Necklace",
		back="Toro Cape",
		waist="Channeler's Stone",
		ear1="Friomisi Earring",
		ear2="Hecate's Earring",
		ring1="Acumen Ring",
		ring2="Mujin Band"
		}

    sets.midcast['Dark Magic'] = {
		head="Merlinic Hood",
		body="Geomancy Tunic",
		legs="Psycloth Lappas",
		neck="Aesir Torque",
        feet="Merlinic Crackows"
		}
		
	sets.midcast['Enfeebling Magic'] = {
		head="Merlinic Hood",
		body="Azimuth Coat",
		hands="Bagua Mitaines",
		legs="Psycloth Lappas",
        feet="Bagua Sandals",
		neck="Sanctity Necklace",
		back="Cheviot Cape",
		waist="Channeler's Stone",
		ear2="Moonshade Earring",
		ring2="Defending Ring"
		}
		
	sets.midcast.Geomancy = {
		ranged="Nepote Bell",
		head="Azimuth Hood",
        body="Bagua Tunic",
		hands="Geomancy Mitaines",
		legs="Geomancy Pants"
		}
		
	sets.midcast.Indi = {legs="Bagua Pants", feet="Azimuth Gaiters"}

    -- Custom spell classes

    -- Sets to return to when not performing an action.
    
    -- Resting sets  

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
		sub="Genmei Shield",
		ranged="Nepote Bell",
		head="Merlinic Hood",
		neck="Twilight Torque",
		ear1="Ethereal Earring",
		ear2="Moonshade Earring",
        body="Azimuth Coat",
		hands="Bagua Mitaines",
		ring1="Paguroidea Ring",
		ring2="Defending Ring",
        back="Cheviot Cape",
		waist="Hierarch Belt",
		legs="Assiduity Pants +1",
		feet="Geomancy Sandals"
		}
		
	sets.idle.Normal = sets.idle
	
	sets.idle.Regen = set_combine(sets.idle, {neck="Sanctity Necklace"})

	sets.idle.EXP = {
		sub="Genmei Shield",
		ranged="Nepote Bell",
		head="Merlinic Hood",
		neck="Twilight Torque",
		ear1="Ethereal Earring",
		ear2="Moonshade Earring",
        body="Rosette Jaseran",
		hands="Geomancy Mitaines",
		ring1="Paguroidea Ring",
		ring2="Defending Ring",
		waist="Hierarch Belt",
		legs="Assiduity Pants +1",
		feet="Merlinic Crackows",
        back="Mecistopins Mantle"
		}
	
	--Equip -dt gear when Luopan is active
	sets.idle.Pet = set_combine(sets.idle, {hands="Geomancy Mitaines", feet="Bagua Sandals"})
		
    sets.idle.Weak = sets.defense.MDT
    
    -- Defense sets

    sets.defense.PDT = {
		sub="Genmei Shield",
		neck="Twilight Torque",
		ring2="Defending Ring",
        back="Cheviot Cape",
		}

    sets.defense.MDT = {
		neck="Twilight Torque",
		ring2="Defending Ring",
		}

    sets.Kiting = {feet="Geomancy Sandals"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
	sets.engaged = {
		head="Merlinic Hood",
		neck="Sanctity Necklace",
		ear1="Ethereal Earring",
		ear2="Brutal Earring",
        body="Rosette Jaseran",
		hands="Geomancy Mitaines",
		ring1="Paguroidea Ring",
		ring2="Defending Ring",
        back="Cheviot Cape",
		waist="Cetl Belt",
		legs="Assiduity Pants +1",
		feet="Battlecast Gaiters"}
	
    sets.engaged.Normal = sets.engaged


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
    
    if spell.skill == 'Healing Magic' then
        gear.default.obi_back = "Tempered Cape +1"
    else
        gear.default.obi_back = "Cheviot Cape"
    end
end

--Custom midcast for Indi spells
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.english:contains('Indi') then
		equip(sets.midcast.Indi)
	end
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
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        end
    end
end


function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end


-- Function to display the current relevant user state when doing an update.
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
    set_macro_page(1, 11)
end
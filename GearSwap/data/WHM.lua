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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'DW')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

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
		ear2="Loquac. Earring"}
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		head="Goliard Chapeau",neck="Temp. Torque",
		back="Prism Cape",legs="Marduk's Shalwar",feet="Goliard Clogs"}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
	
    sets.precast.WS = {
        head="Voyager Sallet",neck="Fotia Gorget",ear1="Cassie Earring",ear2="Brutal Earring",
        body="Reverend Mail",hands="Blessed Mitts +1",ring1="Rajas Ring",ring2="Mars's Ring",
        back="Prism Cape",waist="Potent Belt",legs="Bls. Trousers +1",feet="Marduk's Crackows"}
    
    sets.precast.WS['Flash Nova'] = {
        head="Goliard Chapeau",neck="Fotia Gorget",ear1="Moldavite Earring",ear2="Novio Earring",
        body="Bishop's Robe +1",hands="Goliard Cuffs",ring1="Rajas Ring",ring2="Saintly Ring +1",
        back="Prism Cape",waist="Cleric's Belt",legs="Bls. Trousers +1",feet="Marduk's Crackows"}
    

    -- Midcast Sets
    
    sets.midcast.FastRecast = {}
    
    -- Cure sets

    sets.midcast.Cure = {
        head="Goliard Chapeau",neck="Healing Torque",ear1="Lifestorm Earring",ear2="Orison Earring",
        body="Aristocrat's Coat",hands="Blessed Mitts +1",ring1="Saintly Ring +1",ring2="Saintly Ring +1",
        back="Prism Cape",waist="Cleric's Belt",legs="Clr. Pantaln. +1",feet="Marduk's Crackows"}

    sets.midcast.Curaga = {
        head="Goliard Chapeau",neck="Healing Torque",ear1="Lifestorm Earring",ear2="Orison Earring",
        body="Aristocrat's Coat",hands="Blessed Mitts +1",ring1="Saintly Ring +1",ring2="Saintly Ring +1",
        back="Prism Cape",waist="Cleric's Belt",legs="Clr. Pantaln. +1",feet="Marduk's Crackows"}

    sets.midcast.Cursna = {}

    sets.midcast.StatusRemoval = {}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {
        head="Goliard Chapeau",neck="Enhancing Torque",
        hands="Blessed Mitts +1",ring1="Saintly Ring +1",ring2="Saintly Ring +1",
        back="Prism Cape",waist="Cleric's Belt",legs="Bls. Trousers +1",feet="Clr. Duckbills +1"}

    sets.midcast.Stoneskin = {
        head="Goliard Chapeau",neck="Faith Torque",
        hands="Blessed Mitts +1",ring1="Saintly Ring +1",ring2="Saintly Ring +1",
        back="Prism Cape",waist="Cleric's Belt",legs="Bls. Trousers +1",feet="Clr. Duckbills +1"}

    sets.midcast.Auspice = {}

    sets.midcast.BarElement = {legs="Clr. Pantaln. +1"}

    sets.midcast.Regen = {body="Clr. Briault +1"}

    sets.midcast.Protectra = {}

    sets.midcast.Shellra = {}


    sets.midcast['Divine Magic'] = {
		head="Goliard Chapeau",neck="Temp. Torque",ear1="Moldavite Earring",ear2="Novio Earring",
		body="Goliard Saio",hands="Goliard Cuffs",ring1="Saintly Ring +1",ring2="Saintly Ring +1",
		back="Ixion Cape",waist="Cleric's Belt",legs="Marduk's Shalwar",feet="Goliard Clogs"}

    sets.midcast['Dark Magic'] = {
        head="Zenith Crown +1",neck="Fortitude Torque",ear1="Morion Earring +1",ear2="Morion Earring +1",
        hands="Mahatma Cuffs",ring1="Snow Ring",ring2="Snow Ring",
        back="Ixion Cape",feet="Goliard Clogs"}

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
        head="Goliard Chapeau",neck="Faith Torque",
        body="Bishop's Robe +1",hands="Blessed Mitts +1",ring1="Saintly Ring +1",ring2="Saintly Ring +1",
        back="Ixion Cape",waist="Cleric's Belt",legs="Bls. Trousers +1",feet="Marduk's Crackows"}

    sets.midcast.IntEnfeebles = {
        head="Zenith Crown +1",neck="Fortitude Torque",ear1="Morion Earring +1",ear2="Morion Earring +1",
        hands="Mahatma Cuffs",ring1="Snow Ring",ring2="Snow Ring",
        back="Ixion Cape",feet="Goliard Clogs"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
        head="Destrier Beret",neck="Orochi Nodowa",ear1="Elusive Earring",ear2="Novia Earring",
        body="Dalmatica",hands="Goliard Cuffs",ring1="Merman's Ring",ring2="Shadow Ring",
        back="Shadow Mantle",waist="Scouter's Rope",legs="Goliard Trews",feet="Herald's Gaiters"}
    
    -- Defense sets

    sets.defense.PDT = {
		neck="Orochi Nodowa",
        ring1="Jelly Ring",ring2="Shadow Ring",
        back="Umbra Cape",legs="Goliard Trews"}

    sets.defense.MDT = {
		head="Zenith Crown +1",neck="Prudence Torque",ear1="Merman's Earring",ear2="Merman's Earring",
		body="Dalmatica",hands="Mahatma Cuffs",ring1="Merman's Ring",ring2="Minerva's Ring",
		back="Ixion Cape",feet="Goliard Clogs"}

    sets.latent_refresh = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
        head="Nashira Turban",neck="Chivalrous Chain",ear1="Pixie Earring",ear2="Brutal Earring",
        body="Goliard Saio",hands="Blessed Mitts +1",ring1="Rajas Ring",ring2="Mars's Ring",
        back="Shadow Mantle",waist="Ninurta's Sash",legs="Bls. Trousers +1",feet="Blessed Pumps +1"}

	sets.engaged.DW = {
        head="Nashira Turban",neck="Chivalrous Chain",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Goliard Saio",hands="Blessed Mitts +1",ring1="Rajas Ring",ring2="Mars's Ring",
        back="Shadow Mantle",waist="Ninurta's Sash",legs="Bls. Trousers +1",feet="Blessed Pumps +1"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end


function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.

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
    set_macro_page(1,5)
end


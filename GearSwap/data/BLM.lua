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
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {}

    sets.precast.JA.Manafont = {}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {
		ear2="Loquac. Earring"}

    sets.precast.FC['Enhancing Magic'] = {
		ear2="Loquac. Earring"}

    sets.precast.FC['Elemental Magic'] = {
		ear2="Loquac. Earring"}

    sets.precast.FC.Cure = {
		ear2="Loquac. Earring"}

    sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	sets.precast.FC.Impact = {body="Twilight Cloak",ear2="Loquac. Earring"}

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
	
    sets.precast.WS = {
		head="Morrigan's Coron.",neck="Fotia Gorget",ear1="Moldavite Earring",ear2="Novio Earring",
		body="Morrigan's Robe",hands="Goliard Cuffs",ring1="Snow Ring",ring2="Snow Ring",
		back="Prism Cape",waist="Sorcerer's Belt",legs="Morrigan's Slops",feet="Goliard Clogs"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	
    sets.precast.WS['Shell Crusher'] = {
		head="Morrigan's Coron.",neck="Temp. Torque",ear1="Pixie Earring",ear2="Brutal Earring",
		body="Morrigan's Robe",hands="Goliard Cuffs",ring1="Mars's Ring",ring2="Sniper's Ring +1",
		back="Prism Cape",waist="Potent Belt",legs="Hydra Brais",feet="Goliard Clogs"}
	
	sets.precast.WS['Full Swing'] = {
		head="Morrigan's Coron.",neck="Temp. Torque",ear1="Pixie Earring",ear2="Brutal Earring",
		body="Morrigan's Robe",hands="Goliard Cuffs",ring1="Mars's Ring",ring2="Sniper's Ring +1",
		back="Prism Cape",waist="Potent Belt",legs="Hydra Brais",feet="Goliard Clogs"}
	
	sets.precast.WS['Myrkr'] = {
		head="Morrigan's Coron.",ear1="Phantom Earring",ear2="Loquac. Earring",
		body="Morrigan's Robe",hands="Goliard Cuffs",ring2="Crimson Ring",
		back="Astute Cape",waist="Hierarch Belt",legs="Morrigan's Slops",feet="Sorcerer's Sabots"}
    
    
    ---- Midcast Sets ----
	
    sets.midcast.FastRecast = {}

    sets.midcast.Cure = {}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
		head="Goliard Chapeau",neck="Faith Torque",
		body="Morrigan's Robe",hands="Dvt. Mitts +1",ring1="Saintly Ring +1",ring2="Saintly Ring +1",
		back="Ixion Cape",waist="Volunteer's Belt",legs="Morrigan's Slops",feet="Goliard Clogs"}
    
	sets.midcast.Refresh = {}
	
    sets.midcast.Stoneskin = {
		head="Goliard Chapeau",neck="Faith Torque",
		body="Morrigan's Robe",hands="Dvt. Mitts +1",ring1="Saintly Ring +1",ring2="Saintly Ring +1",
		back="Ixion Cape",waist="Volunteer's Belt",legs="Morrigan's Slops",feet="Goliard Clogs"}

    sets.midcast['Enfeebling Magic'] = {
		head="Sorcerer's Petas.",neck="Faith Torque",ear1="Morion Earring +1",ear2="Morion Earring +1",
		body="Morrigan's Robe",hands="Dvt. Mitts +1",ring1="Saintly Ring +1",ring2="Saintly Ring +1",
		back="Ixion Cape",waist="Sorcerer's Belt",legs="Morrigan's Slops",feet="Goliard Clogs"}

    sets.midcast['Dark Magic'] = {
		head="Morrigan's Coron.",neck="Prudence Torque",ear1="Moldavite Earring",ear2="Novio Earring",
		body="Morrigan's Robe",hands="Goliard Cuffs",ring1="Snow Ring",ring2="Snow Ring",
		back="Ixion Cape",waist="Sorcerer's Belt",legs="Morrigan's Slops",feet="Goliard Clogs"}

    sets.midcast.Drain = {
		head="Morrigan's Coron.",neck="Prudence Torque",ear1="Moldavite Earring",ear2="Novio Earring",
		body="Morrigan's Robe",hands="Sorcerer's Gloves",ring1="Snow Ring",ring2="Snow Ring",
		back="Ixion Cape",waist="Sorcerer's Belt",legs="Morrigan's Slops",feet="Goliard Clogs"}
    
    sets.midcast.Aspir = {
		head="Morrigan's Coron.",neck="Prudence Torque",ear1="Moldavite Earring",ear2="Novio Earring",
		body="Morrigan's Robe",hands="Goliard Cuffs",ring1="Snow Ring",ring2="Snow Ring",
		back="Ixion Cape",waist="Sorcerer's Belt",legs="Morrigan's Slops",feet="Goliard Clogs"}

    sets.midcast.Stun = {
		head="Morrigan's Coron.",neck="Prudence Torque",ear1="Moldavite Earring",ear2="Novio Earring",
		body="Morrigan's Robe",hands="Sorcerer's Gloves",ring1="Snow Ring",ring2="Snow Ring",
		back="Ixion Cape",waist="Sorcerer's Belt",legs="Morrigan's Slops",feet="Goliard Clogs"}

    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {
		head="Morrigan's Coron.",neck="Prudence Torque",ear1="Moldavite Earring",ear2="Novio Earring",
		body="Morrigan's Robe",hands="Goliard Cuffs",ring1="Snow Ring",ring2="Snow Ring",
		back="Ixion Cape",waist="Sorcerer's Belt",legs="Morrigan's Slops",feet="Goliard Clogs"}
	
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    -- Minimal damage gear for procs.
	
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {
		head="Destrier Beret",neck="Orochi Nodowa",ear1="Elusive Earring",ear2="Novia Earring",
		body="Morrigan's Robe",hands="Goliard Cuffs",ring1="Merman's Ring",ring2="Shadow Ring",
		back="Boxer's Mantle",waist="Sorcerer's Belt",legs="Goliard Trews",feet="Herald's Gaiters"}

    -- Defense sets

    sets.defense.PDT = {
		head="Morrigan's Coron.",neck="Orochi Nodowa",ear1="Elusive Earring",ear2="Novia Earring",
		body="Morrigan's Robe",hands="Goliard Cuffs",ring1="Jelly Ring",ring2="Shadow Ring",
		back="Umbra Cape",waist="Sorcerer's Belt",legs="Goliard Trews",feet="Goliard Clogs"}

    sets.defense.MDT = {
		head="Morrigan's Coron.",neck="Prudence Torque",ear1="Merman's Earring",ear2="Merman's Earring",
		body="Morrigan's Robe",hands="Goliard Cuffs",ring1="Merman's Ring",ring2="Minerva's Ring",
		back="Ixion Cape",waist="Sorcerer's Belt",legs="Morrigan's Slops",feet="Goliard Clogs"}

    sets.Kiting = {feet="Herald's Gaiters"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {}
	
	sets.latent_refresh = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
	head="Walahra Turban",neck="Chivalrous Chain",ear1="Pixie Earring",ear2="Brutal Earring",
	body="Goliard Saio",hands="Goliard Cuffs",ring1="Rajas Ring",ring2="Mars's Ring",
	back="Boxer's Mantle",waist="Ninurta's Sash",legs="Hydra Brais",feet="Goliard Clogs"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.

-- Modify the default idle set after it was constructed.
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
    set_macro_page(1, 6)
end

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    
    gs c step
        Uses the currently configured step on the target, with either <t> or <stnpc> depending on setting.

    gs c step t
        Uses the currently configured step on the target, but forces use of <t>.
    
    
    Configuration commands:
    
    gs c cycle mainstep
        Cycles through the available steps to use as the primary step when using one of the above commands.
        
    gs c cycle altstep
        Cycles through the available steps to use for alternating with the configured main step.
        
    gs c toggle usealtstep
        Toggles whether or not to use an alternate step.
        
    gs c toggle selectsteptarget
        Toggles whether or not to use <stnpc> (as opposed to <t>) when using a step.
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal')
    state.PhysicalDefenseMode:options('Evasion', 'PDT', 'MDT')

    -- Additional local binds

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs

    sets.precast.JA['No Foot Rise'] = {}

    sets.precast.JA['Trance'] = {}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        body="Merman's Harness",ring1="Heavens Ring",ring2="Heavens Ring +1",
        waist="Corsette +1",legs="Merman's Subligar"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {body="Dancer's Casaque"}
    
    sets.precast.Samba = {head="Dancer's Tiara"}

    sets.precast.Jig = {legs="Etoile Tights", feet="Dancer's Shoes"}

    sets.precast.Step = {feet="Etoile Shoes"}

    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] = set_combine(sets.engaged.ACC, {
		body="Etoile Casaque",
		feet="Denali Gamashes"})
		
    sets.precast.Flourish1['Desperate Flourish'] = sets.engaged.ACC -- acc gear

    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = {}

    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Striking Flourish'] = {}
    sets.precast.Flourish3['Climactic Flourish'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {}

    sets.precast.FC.Utsusemi = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Wivre Mask +1",neck="Chivalrous Chain",ear1="Merman's Earring",ear2="Intruder Earring",
        body="Antares Harness",hands="Denali Wristbands",ring1="Flame Ring",ring2="Thunder Ring",
        back="Amemet Mantle +1",waist="Swordbelt +1",legs="Dusk Trousers +1",feet="Etoile Shoes"}
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {head="Denali Bonnet",ear1="Suppanomimi",
        body="Denali Jacket",hands="Etoile Bangles",
        legs="Merman's Subligar"})

    sets.precast.WS['Aeolian Edge'] = {
        head="Voyager Sallet",neck="Prudence Torque",ear1="Pixie Earring",ear2="Moldavite Earring",
        body="Scp. Harness +1",hands="Etoile Bangles",ring1="Snow Ring",ring2="Snow Ring",
        back="Amemet Mantle +1",waist="Warwolf Belt",legs="Dusk Trousers +1",feet="Denali Gamashes"}
    
    sets.precast.Skillchain = {}
    
    
    -- Midcast Sets
    
    sets.midcast.FastRecast = {}
        
    -- Specific spells
    sets.midcast.Utsusemi = {}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    sets.ExtraRegen = {}
    

    -- Idle sets

    sets.idle = {
        head="Wivre Mask +1",neck="Orochi Nodowa",ear1="Merman's Earring",ear2="Merman's Earring",
        body="Antares Harness",hands="Denali Wristbands",ring1="Merman's Ring",ring2="Merman's Ring",
        back="Shadow Mantle",waist="Survival Belt",legs="Merman's Subligar",feet="Merman's Leggings"}
    
    -- Defense sets

    sets.defense.Evasion = {
        head="Wivre Mask +1",neck="Evasion Torque",ear1="novia earring",ear2="Elusive Earring",
        body="Scp. Harness +1",hands="Etoile Bangles",ring1="Rajas Ring",ring2="Snow Ring",
        back="Boxer's Mantle",waist="Survival Belt",legs="Dusk Trousers +1",feet="Dance Shoes"}

    sets.defense.PDT = {
        head="Panter Mask +1",neck="Evasion Torque",ear1="novia earring",ear2="Elusive Earring",
        body="Scp. Harness +1",hands="Denali Wristbands",ring1="Rajas Ring",ring2="Jelly Ring",
        back="Shadow Mantle",waist="Survival Belt",legs="Dusk Trousers +1",feet="Dusk Ledelsens +1"}

    sets.defense.MDT = {
		head="Merman's Cap",neck="Prudence Torque",ear1="Merman's Earring",ear2="Merman's Earring",
		body="Merman's Harness",hands="Denali Wristbands",ring1="Merman's Ring",ring2="Merman's Ring",
		back="Lamia Mantle +1",legs="Merman's Subligar"}

    sets.Kiting = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head="Denali Bonnet",neck="Chivalrous Chain",ear1="Merman's Earring",ear2="Merman's Earring",
        body="Denali Jacket",hands="Dusk Gloves +1",ring1="Flame Ring",ring2="Flame Ring",
        back="Amemet Mantle +1",waist="Velocious Belt",legs="Etoile Tights",feet="Dusk Ledelsens +1"}

    sets.engaged.Acc = {
        head="Denali Bonnet",neck="Peacock Amulet",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Antares Harness",hands="Dusk Gloves +1",ring1="Rajas Ring",ring2="Thunder Ring",
        back="Amemet Mantle +1",waist="Velocious Belt",legs="Denali Kecks",feet="Dusk Ledelsens +1"}
		
    sets.engaged.Evasion = {
        head="Wivre Mask +1",neck="Evasion Torque",ear1="novia earring",ear2="Elusive Earring",
        body="Scp. Harness +1",hands="Etoile Bangles",ring1="Rajas Ring",ring2="Snow Ring",
        back="Boxer's Mantle",waist="Survival Belt",legs="Etoile Tights",feet="Dance Shoes"}
		
    sets.engaged.PDT = {
        head="Panter Mask +1",neck="Evasion Torque",ear1="novia earring",ear2="Elusive Earring",
        body="Scp. Harness +1",hands="Denali Wristbands",ring1="Rajas Ring",ring2="Jelly Ring",
        back="Shadow Mantle",waist="Survival Belt",legs="Dusk Trousers +1",feet="Dusk Ledelsens +1"}
		
	sets.engaged.MDT = {
		head="Merman's Cap",neck="Prudence Torque",ear1="Merman's Earring",ear2="Merman's Earring",
		body="Merman's Harness",hands="Denali Wristbands",ring1="Merman's Ring",ring2="Merman's Ring",
		back="Lamia Mantle +1",legs="Merman's Subligar"}

    -- Custom melee group: High Haste (2x March or Haste)
	
    -- Custom melee group: Max Haste (2x March + Haste)
	
    -- Getting Marches+Haste from Trust NPCs, doesn't cap delay.

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the default 'update' self-command.

-- Handle auto-targetting based on local setup.

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.

-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------


-- Automatically use Presto for steps when it's available and we have less than 3 finishing moves

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
        set_macro_page(2, 3)
end


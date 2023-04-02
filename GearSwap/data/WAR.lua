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

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'DW', 'Evasion')
    state.HybridMode:options('Normal')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT', 'MDT')

    -- Additional local binds

    select_default_macro_book(1, 7)
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()

end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Berserk = {}
	sets.precast.JA.Warcry = {}
	sets.precast.JA.Aggressor = {}
    sets.precast.JA['Warrior\'s Charge'] = {}
    sets.precast.JA.Tomahawk = {}
	sets.precast.JA['Mighty Strikes'] = {}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
	}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
	head="Hecatomb Cap +1",neck="Fotai Gorget",ear1="Pixie Earring",ear2="Brutal Earring",
	body="Adaman Hauberk",hands="Hct. Mittens +1",ring1="Rajas Ring",ring2="Crimson Ring",
	back="Amemet Mantle +1",waist="Warwolf Belt",legs="Warrior's Cuisses",feet="Hct. Leggings +1"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	-- Midcast Sets
    sets.midcast.FastRecast = {
	ear2="Loquac. Earring"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
	head="Destrier Beret",neck="Orochi Nodowa",ear1="Merman's Earring",ear2="Merman's Earring",
	body="Cor. Scale Mail +1",hands="Askar Manopolas",ring1="Merman's Ring",ring2="Shadow Ring",
	back="Shadow Mantle",waist="Warwolf Belt",legs="Coral Cuisses +1",feet="Askar Gambieras"}
    
    -- Defense sets
    sets.defense.PDT = {
	head="Destrier Beret",neck="Orochi Nodowa",ear1="Merman's Earring",ear2="Merman's Earring",
	body="Cor. Scale Mail +1",hands="Warrior's Mufflers",ring1="Jelly Ring",ring2="Shadow Ring",
	back="Shadow Mantle",waist="Warwolf Belt",legs="Coral Cuisses +1",feet="Askar Gambieras"}

    sets.defense.MDT = {
	head="Destrier Beret",neck="Orochi Nodowa",ear1="Merman's Earring",ear2="Merman's Earring",
	body="Cor. Scale Mail +1",hands="Warrior's Mufflers",ring1="Minerva's Ring",ring2="Shadow Ring",
	back="Shadow Mantle",waist="Warwolf Belt",legs="Coral Cuisses +1",feet="Askar Gambieras"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {
        head="Askar Zucchetto",neck="Chivalrous Chain",ear1="Pixie Earring",ear2="Brutal Earring",
        body="Adaman Hauberk",hands="Dusk Gloves +1",ring1="Rajas Ring",ring2="Spinel Ring",
        back="Amemet Mantle +1",waist="Ninurta's Sash",legs="Byakko's Haidate",feet="Dusk Ledelsens +1"}
		
	sets.engaged.DW = {
        head="Askar Zucchetto",neck="Chivalrous Chain",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Adaman Hauberk",hands="Dusk Gloves +1",ring1="Rajas Ring",ring2="Spinel Ring",
        back="Amemet Mantle +1",waist="Ninurta's Sash",legs="Byakko's Haidate",feet="Dusk Ledelsens +1"}
		
    sets.engaged.Evasion = {
        head="Wivre Mask +1",neck="Evasion Torque",ear1="Elusive Earring",ear2="Novia Earring",
        body="Scp. Harness +1",hands="Dusk Gloves +1",ring1="Rajas Ring",ring2="Spinel Ring",
        back="Boxer's Mantle",waist="Ninurta's Sash",legs="Fourth Schoss",feet="Dusk Ledelsens +1"}

    sets.buff.Retaliation = {}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(2, 7)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 7)
    end
end


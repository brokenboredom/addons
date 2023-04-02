
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
    
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['Sneak Attack'] or false
    state.Buff['Trick Attack'] = buffactive['Trick Attack'] or false
    state.Buff['Feint'] = buffactive['Feint'] or false
    
    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Accuracy', 'Evasion')
    state.HybridMode:options('Normal', 'Evasion')
    state.RangedMode:options('Normal')
    state.WeaponskillMode:options('Normal')
    state.PhysicalDefenseMode:options('None', 'PDT')
	state.MagicalDefenseMode:options('MDT', 'Fire')


    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()

end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------
    sets.Kiting = {feet="Trotter Boots"}

    sets.buff['Sneak Attack'] = {
		head="hecatomb cap +1",neck="Spike Necklace",ear1="pixie earring",ear2="Brutal Earring",
		body="hct. harness +1",hands="hct. mittens +1",ring1="Rajas Ring",ring2="Spinel Ring",
		back="Assassin's Cape",waist="warwolf belt",legs="hct. subligar +1",feet="hct. leggings +1"}

    sets.buff['Trick Attack'] = {
		head="Denali Bonnet",neck="Hope Torque",ear1="Drone Earring",ear2="Drone Earring",
		body="Denali Jacket",hands="hct. mittens +1",ring1="Rajas Ring",ring2="Crimson Ring",
		back="Assassin's Cape",waist="warwolf belt",legs="hct. subligar +1",feet="hct. leggings +1"}


    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
	--STR/DEX/ATK
    sets.precast.WS = {
		head="Hecatomb Cap +1",neck="Fotia Gorget",ear1="Pixie Earring",ear2="Brutal Earring",
		body="Hct. Harness +1",hands="Hct. Mittens +1",ring2="Rajas Ring",ring1="Crimson Ring",
		back="Amemet Mantle +1",waist="Warwolf Belt",legs="Hct. Subligar +1",feet="hct. leggings +1"}
    
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		ring1="Sniper's Ring +1",
		waist="Potent Belt",})
	
	sets.precast.WS.SA = set_combine(sets.precast.WS, sets.buff['Sneak Attack'], {neck="fotia gorget"})
	sets.precast.WS.TA = set_combine(sets.precast.WS, sets.buff['Trick Attack'], {neck="fotia gorget"})
	sets.precast.WS.SATA = set_combine(sets.precast.WS, sets.buff['Trick Attack'],
		sets.buff['Sneak Attack'], {neck="fotia gorget"})

	--Dancing Edge
	--Standard ws sets is best
    sets.precast.WS['Dancing Edge'] = sets.precast.WS
    sets.precast.WS['Dancing Edge'].Acc = sets.precast.WS.Acc
    sets.precast.WS['Dancing Edge'].SA = sets.precast.WS.SA
    sets.precast.WS['Dancing Edge'].TA = sets.precast.WS.TA
    sets.precast.WS['Dancing Edge'].SATA = sets.precast.WS.SATA

	--Shark Bite
	--Very heavy dex wsc, dex is best
    sets.precast.WS['Shark Bite'] = sets.precast.WS.SA
    sets.precast.WS['Shark Bite'].Acc = sets.precast.WS.SA
    sets.precast.WS['Shark Bite'].SA = sets.precast.WS.SA
    sets.precast.WS['Shark Bite'].TA = sets.precast.WS.SA
    sets.precast.WS['Shark Bite'].SATA = sets.precast.WS.SA
	
	--Evisceration
	--Can crit so heavy dex for crit+ and less atk needed for pDIF
	sets.precast.WS['Evisceration'] = sets.precast.WS.SA
    sets.precast.WS['Evisceration'].Acc = sets.precast.WS.Acc
    sets.precast.WS['Evisceration'].SA = sets.precast.WS.SA
    sets.precast.WS['Evisceration'].TA = sets.precast.WS.TA
    sets.precast.WS['Evisceration'].SATA = sets.precast.WS.SA

	--Mercy Stroke
	--All the str and atk you can get
	sets.precast.WS['Mercy Stroke'] = {
		head="Hecatomb Cap +1",neck="Fotia Gorget",ear1="Merman's Earring",ear2="Brutal Earring",
		body="Hct. Harness +1",hands="Hct. Mittens +1",ring2="Rajas Ring",ring1="Crimson Ring",
		back="Amemet Mantle +1",waist="Warwolf Belt",legs="Hct. Subligar +1",feet="hct. leggings +1"}
		
	--Tailor significant dex pieces instead of str
	sets.precast.WS['Mercy Stroke'].SA = set_combine(sets.precast.WS, {
		ear1="Pixie Earring",
		ring2="Spinel Ring"})

	sets.precast.WS.Mab = {
		head="Hecatomb Cap +1",neck="Prudence Torque",ear1="Phantom Earring",ear2="Moldavite Earring",
		body="hct. harness +1",hands="Assassin's Armlets",ring1="Snow Ring",ring2="Snow ring",
		back="Assassin's Cape",waist="Warwolf Belt",legs="hct. subligar +1",feet="Denali Gamashes"}
		
	sets.precast.WS['Gust Slash'] = sets.precast.WS.Mab
	sets.precast.WS['Cyclone'] = sets.precast.WS.Mab
	sets.precast.WS['Aeolian Edge'] = sets.precast.WS.Mab
	
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FC = {
		head="Acubens Helm",
		hands="Dusk Gloves +1",
		waist="ninurta's sash",legs="Homam Cosciales",feet="Dusk Ledelsens +1"}

    -- Ranged gear
	--Use TH for procs
    sets.midcast.RA = {
		head="Denali Bonnet",neck="Peacock Amulet",ear1="Drone Earring",ear2="Drone Earring",
		body="Denali Jacket",hands="Assassin's Armlets",ring1="Merman's Ring +1",ring2="Merman's Ring +1",
		back="Assassin's Cape",waist="Survival Belt",legs="Dusk Trousers +1",feet="Homam Gambieras"}

	 --------------------------------------
    -- Melee sets
    --------------------------------------
    -- Normal melee group
	--Balanced
    sets.engaged = {
		head="Denali Bonnet",neck="Chivalrous Chain",ear1="Merman's Earring",ear2="Merman's Earring",
		body="Dragon Harness",hands="Dusk Gloves +1",ring1="Mars's Ring",ring2="Spinel Ring",
		back="Cerb. Mantle +1",waist="Ninurta's Sash",legs="Bravo's Subligar",feet="Dusk Ledelsens +1"}
		
    sets.engaged.Accuracy = set_combine(sets.engaged, {
		head="Homam Zucchetto",neck="Peacock Amulet",
		body="Homam Corazza",
		ring2="Sniper's Ring +1",
		waist="potent Belt",feet="Homam Gambieras"})
    
	sets.engaged.Evasion = {
		head="Wivre Mask +1",neck="evasion torque",ear1="novia earring",ear2="Elusive Earring",
		body="Scp. Harness +1",hands="Denali Wristbands",ring1="Rajas Ring",ring2="Snow Ring",
		back="boxer's mantle",waist="Survival Belt",feet="dance shoes +1"}
		
    sets.engaged.Accuracy.Evasion = set_combine(sets.engaged.Evasion, sets.engaged.Accuracy)
	
	
    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------
    -- Idle sets
    sets.idle = {
		head="Wivre Mask +1",neck="Orochi Nodowa",ear1="merman's Earring",ear2="merman's Earring",
		body="Merman's Harness",hands="denali wristbands",ring1="Merman's Ring",ring2="Merman's Ring",
		back="Lamia Mantle +1",waist="Survival Belt",legs="merman's subligar",feet="Trotter Boots"}

    -- Defense sets
    sets.defense.PDT = {
		hands="Denali Wristbands",
		back="Shadow Mantle"}
		
    sets.defense.MDT = {
		head="merman's cap",ear1="merman's Earring",ear2="merman's Earring",
		body="merman's harness",hands="Denali Wristbands",ring1="merman's Ring",ring1="Merman's Ring",
		back="Lamia Mantle +1",legs="merman's subligar"}

	--Latents
	sets.latent_hp75 = {neck="Orochi Nodowa", body="dusk jerkin +1"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

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
	if (player.hpp < 80) then
		meleeSet = set_combine(meleeSet, sets.latent_hp75)
	end
	if (buffactive['Sneak Attack'] and buffactive['Trick Attack']) then
		meleeSet = set_combine(meleeSet, sets.buff['Trick Attack'], sets.buff['Sneak Attack'])
	elseif buffactive['Sneak Attack'] then
		meleeSet = set_combine(meleeSet, sets.buff['Sneak Attack'])
	elseif buffactive['Trick Attack'] then
		meleeSet = set_combine(meleeSet, sets.buff['Trick Attack'])
	end
	return meleeSet
end

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

	if (state.Buff['Sneak Attack'] and state.Buff['Trick Attack']) then
		wsmode = 'SATA'
    elseif state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    elseif state.Buff['Trick Attack'] then
        wsmode = 'TA'
    end

    return wsmode
end

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 2)
end

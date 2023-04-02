-- NOTE: I do not play run, so this will not be maintained for 'active' use. 
-- It is added to the repository to allow people to have a baseline to build from,
-- and make sure it is up-to-date with the library API.


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()
    -- Table of entries
    rune_timers = T{}
    -- entry = rune, index, expires
    
    if player.main_job_level >= 65 then
        max_runes = 3
    elseif player.main_job_level >= 35 then
        max_runes = 2
    elseif player.main_job_level >= 5 then
        max_runes = 1
    else
        max_runes = 0
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'DT', 'Evasion')
    state.WeaponskillMode:options('Normal')
    state.PhysicalDefenseMode:options('DT', 'MDT')
    state.IdleMode:options('Idle')

	select_default_macro_book(1, 20)
end


function init_gear_sets()
    sets.enmity = {waist="Warwolf Belt"}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
    sets.precast.JA['Lunge'] = {ammo="Phantom Tathlum",
		head="Wivre Mask +1",neck="Prudence Torque",ear1="Moldavite Earring",ear2="Novio Earring",
        body="Assault Jerkin",hands="Mahatma Cuffs",ring1="Snow Ring",ring2="Snow Ring",
        back="Cerb. Mantle +1",waist="Warwolf Belt",legs="Denali Kecks",feet="Denali Gamashes"}
    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Provoke'] = sets.enmity


	-- Fast cast sets for spells
    sets.precast.FC = {ear2="Loquacious Earring"}
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
    sets.precast.FC['Utsusemi: Ichi'] = set_combine(sets.precast.FC, {})
    sets.precast.FC['Utsusemi: Ni'] = set_combine(sets.precast.FC['Utsusemi: Ichi'], {})
	sets.precast.FC['Cure'] = set_combine(sets.precast.FC, {})


	-- Weaponskill sets
	sets.precast.WS = {ammo="Black Tathlum",
		head="Wivre Mask +1",neck="Chivalrous Chain",ear1="Merman's Earring",ear2="Merman's Earring",
		body="Assault Jerkin",hands="Alkyoneus's Brc.",ring1="Crimson Ring",ring2="Spinel Ring",
		back="Cerb. Mantle +1",waist="Warwolf Belt",legs="Dusk Trousers +1",feet="Denali Gamashes"}
    sets.precast.WS['Resolution'] = {ammo="Black Tathlum",
		head="Wivre Mask +1",neck="Chivalrous Chain",ear1="Merman's Earring",ear2="Merman's Earring",
		body="Scp. Harness +1",hands="Alkyoneus's Brc.",ring1="Mars's Ring",ring2="Crimson Ring",
		back="Cerb. Mantle +1",waist="Warwolf Belt",legs="Dusk Trousers +1",feet="Denali Gamashes"}
    sets.precast.WS['Herculean Slash'] = sets.precast.JA['Lunge']
	sets.precast.WS['Sanguine Blade'] = sets.precast.JA['Lunge']


	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
    sets.midcast.FastRecast = {}
    sets.midcast['Enhancing Magic'] = {
		head="Denali Bonnet",neck="Enhancing Torque",ear1="Elusive Earring",ear2="Novia Earring",
		body="Scp. Harness +1",hands="Denali Wristbands",ring1="Saintly Ring +1",ring2="Saintly Ring +1",
		back="Bat Cape",waist="Volunteer's Belt",feet="Denali Gamashes"}
    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast['Regen'] = {}
    sets.midcast['Stoneskin'] = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast['Refresh'] = {}
	sets.midcast['Protect'] = {}
	sets.midcast['Shell'] = {}
    sets.midcast.Cure = {}

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.idle = {
        head=empty,neck="Orochi Nodowa", ear1="Velocity Earring", ear2="Elusive Earring",
        body="Royal Cloak",hands="Denali Wristbands",ring1="Merman's Ring", ring2="Merman's Ring",
        back="Lamia Mantle +1",waist="Scouter's Rope",legs="Merman's Subligar",feet="Dance Shoes"}
	sets.defense.DT = {ammo="Homiliary",
		head="Futhark Bandeau +1",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Genmei Earring",
		body="Futhark Coat +1",hands="Denali Wristbands",ring1="Succor Ring",ring2="Defending Ring",
		back="Evasionist's Cape",waist="Kentarch Belt +1",legs=gear.DT_legs,feet="Herculean Boots"}
	sets.defense.MDT = {ammo="Homiliary",
		head="Futhark Bandeau +1",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Genmei Earring",
		body="Futhark Coat +1",hands="Denali Wristbands",ring1="Succor Ring",ring2="Defending Ring",
		back="Evasionist's Cape",waist="Kentarch Belt +1",legs=gear.DT_legs,feet="Herculean Boots"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

    sets.engaged = {ammo="Fire Bomblet",
		head="Denali Bonnet",neck="Chivalrous Chain",ear1="Merman's Earring",ear2="Elusive Earring",
		body="Denali Jacket",hands="Dusk Gloves +1",ring1="Mars's Ring",ring2="Spinel Ring",
		back="Cerb. Mantle +1",waist="Ninurta's Sash",legs="Dusk Trousers +1",feet="Dusk Ledelsens +1"}
	sets.engaged.DT = {ammo="Aqreqaq Bomblet",
        head="Futhark Bandeau +1",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Genmei Earring",
		body="Futhark Coat +1",hands="Denali Wristbands",ring1="Succor Ring",ring2="Defending Ring",
		back="Evasionist's Cape",waist="Kentarch Belt +1",legs=gear.DT_legs,feet="Herculean Boots"}
	sets.engaged.Evasion = {}
	sets.latent_hp75 = {neck="Orochi Nodowa", body="Dusk Jerkin +1"}
end

------------------------------------------------------------------
-- Action events
------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        local obi = get_obi(get_rune_obi_element())
        if obi then
            equip({waist=obi})
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- HP regen function
function customize_melee_set(meleeSet)
	if (player.hpp < 80) then
		meleeSet = set_combine(meleeSet, sets.latent_hp75)
	end
	return meleeSet
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 20)
	elseif player.sub_job == 'NIN' then
		set_macro_page(2, 20)
	elseif player.sub_job == 'SAM' then
		set_macro_page(3, 20)
	else
		set_macro_page(1, 20)
	end
end

function get_rune_obi_element()
    weather_rune = buffactive[elements.rune_of[world.weather_element] or '']
    day_rune = buffactive[elements.rune_of[world.day_element] or '']
    
    local found_rune_element
    
    if weather_rune and day_rune then
        if weather_rune > day_rune then
            found_rune_element = world.weather_element
        else
            found_rune_element = world.day_element
        end
    elseif weather_rune then
        found_rune_element = world.weather_element
    elseif day_rune then
        found_rune_element = world.day_element
    end
    
    return found_rune_element
end

function get_obi(element)
    if element and elements.obi_of[element] then
        return (player.inventory[elements.obi_of[element]] or player.wardrobe[elements.obi_of[element]]) and elements.obi_of[element]
    end
end



-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Also, you'll need the Shortcuts addon to handle the auto-targetting of the custom pact commands.

--[[
    Custom commands:
    
    gs c petweather
        Automatically casts the storm appropriate for the current avatar, if possible.
    
    gs c siphon
        Automatically run the process to: dismiss the current avatar; cast appropriate
        weather; summon the appropriate spirit; Elemental Siphon; release the spirit;
        and re-summon the avatar.
        
        Will not cast weather you do not have access to.
        Will not re-summon the avatar if one was not out in the first place.
        Will not release the spirit if it was out before the command was issued.
        
    gs c pact [PactType]
        Attempts to use the indicated pact type for the current avatar.
        PactType can be one of:
            cure
            curaga
            buffOffense
            buffDefense
            buffSpecial
            debuff1
            debuff2
            sleep
            nuke2
            nuke4
            bp70
            bp75 (merits and lvl 75-80 pacts)
            astralflow
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff["Avatar's Favor"] = buffactive["Avatar's Favor"] or false
    state.Buff["Astral Conduit"] = buffactive["Astral Conduit"] or false

    spirits = S{"LightSpirit", "DarkSpirit", "FireSpirit", "EarthSpirit", "WaterSpirit", "AirSpirit", "IceSpirit", "ThunderSpirit"}
    avatars = S{"Carbuncle", "Fenrir", "Diabolos", "Ifrit", "Titan", "Leviathan", "Garuda", "Shiva", "Ramuh", "Odin", "Alexander", "Cait Sith"}

    magicalRagePacts = S{
        'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Diamond Dust','Judgment Bolt','Searing Light','Howling Moon','Ruinous Omen',
        'Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II',
        'Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV',
        'Thunderspark','Burning Strike','Meteorite','Nether Blast','Flaming Crush',
        'Meteor Strike','Heavenly Strike','Wind Blade','Geocrush','Grand Fall','Thunderstorm',
        'Holy Mist','Lunar Bay','Night Terror','Level ? Holy'}


    pacts = {}
    pacts.cure = {['Carbuncle']='Healing Ruby'}
    pacts.curaga = {['Carbuncle']='Healing Ruby II', ['Garuda']='Whispering Wind', ['Leviathan']='Spring Water'}
    pacts.buffoffense = {['Carbuncle']='Glittering Ruby', ['Ifrit']='Crimson Howl', ['Garuda']='Hastega', ['Ramuh']='Rolling Thunder',
        ['Fenrir']='Ecliptic Growl'}
    pacts.buffdefense = {['Carbuncle']='Shining Ruby', ['Shiva']='Frost Armor', ['Garuda']='Aerial Armor', ['Titan']='Earthen Ward',
        ['Ramuh']='Lightning Armor', ['Fenrir']='Ecliptic Howl', ['Diabolos']='Noctoshield', ['Cait Sith']='Reraise II'}
    pacts.buffspecial = {['Ifrit']='Inferno Howl', ['Garuda']='Fleet Wind', ['Titan']='Earthen Armor', ['Diabolos']='Dream Shroud',
        ['Carbuncle']='Soothing Ruby', ['Fenrir']='Heavenward Howl', ['Cait Sith']='Raise II'}
    pacts.debuff1 = {['Shiva']='Diamond Storm', ['Ramuh']='Shock Squall', ['Leviathan']='Tidal Roar', ['Fenrir']='Lunar Cry',
        ['Diabolos']='Pavor Nocturnus', ['Cait Sith']='Eerie Eye'}
    pacts.debuff2 = {['Shiva']='Sleepga', ['Leviathan']='Slowga', ['Fenrir']='Lunar Roar', ['Diabolos']='Somnolence'}
    pacts.sleep = {['Shiva']='Sleepga', ['Diabolos']='Nightmare', ['Cait Sith']='Mewing Lullaby'}
    pacts.nuke2 = {['Ifrit']='Fire II', ['Shiva']='Blizzard II', ['Garuda']='Aero II', ['Titan']='Stone II',
        ['Ramuh']='Thunder II', ['Leviathan']='Water II'}
    pacts.nuke4 = {['Ifrit']='Fire IV', ['Shiva']='Blizzard IV', ['Garuda']='Aero IV', ['Titan']='Stone IV',
        ['Ramuh']='Thunder IV', ['Leviathan']='Water IV'}
    pacts.bp70 = {['Ifrit']='Flaming Crush', ['Shiva']='Rush', ['Garuda']='Predator Claws', ['Titan']='Mountain Buster',
        ['Ramuh']='Chaotic Strike', ['Leviathan']='Spinning Dive', ['Carbuncle']='Meteorite', ['Fenrir']='Eclipse Bite',
        ['Diabolos']='Nether Blast',['Cait Sith']='Regal Scratch'}
    pacts.bp75 = {['Ifrit']='Meteor Strike', ['Shiva']='Heavenly Strike', ['Garuda']='Wind Blade', ['Titan']='Geocrush',
        ['Ramuh']='Thunderstorm', ['Leviathan']='Grand Fall', ['Carbuncle']='Holy Mist', ['Fenrir']='Lunar Bay',
        ['Diabolos']='Night Terror', ['Cait Sith']='Level ? Holy'}
    pacts.astralflow = {['Ifrit']='Inferno', ['Shiva']='Diamond Dust', ['Garuda']='Aerial Blast', ['Titan']='Earthen Fury',
        ['Ramuh']='Judgment Bolt', ['Leviathan']='Tidal Wave', ['Carbuncle']='Searing Light', ['Fenrir']='Howling Moon',
        ['Diabolos']='Ruinous Omen', ['Cait Sith']="Altana's Favor"}

    -- Wards table for creating custom timers   
    wards = {}
    -- Base duration for ward pacts.
    wards.durations = {
        ['Crimson Howl'] = 60, ['Earthen Armor'] = 60, ['Inferno Howl'] = 60, ['Heavenward Howl'] = 60,
        ['Rolling Thunder'] = 120, ['Fleet Wind'] = 120,
        ['Shining Ruby'] = 180, ['Frost Armor'] = 180, ['Lightning Armor'] = 180, ['Ecliptic Growl'] = 180,
        ['Glittering Ruby'] = 180, ['Hastega'] = 180, ['Noctoshield'] = 180, ['Ecliptic Howl'] = 180,
        ['Dream Shroud'] = 180,
        ['Reraise II'] = 3600
    }
    -- Icons to use when creating the custom timer.
    wards.icons = {
        ['Earthen Armor']   = 'spells/00299.png', -- 00299 for Titan
        ['Shining Ruby']    = 'spells/00043.png', -- 00043 for Protect
        ['Dream Shroud']    = 'spells/00304.png', -- 00304 for Diabolos
        ['Noctoshield']     = 'spells/00106.png', -- 00106 for Phalanx
        ['Inferno Howl']    = 'spells/00298.png', -- 00298 for Ifrit
        ['Hastega']         = 'spells/00358.png', -- 00358 for Hastega
        ['Rolling Thunder'] = 'spells/00104.png', -- 00358 for Enthunder
        ['Frost Armor']     = 'spells/00250.png', -- 00250 for Ice Spikes
        ['Lightning Armor'] = 'spells/00251.png', -- 00251 for Shock Spikes
        ['Reraise II']      = 'spells/00135.png', -- 00135 for Reraise
        ['Fleet Wind']      = 'abilities/00074.png', -- 
    }
    -- Flags for code to get around the issue of slow skill updates.
    wards.flag = false
    wards.spell = ''
    
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Unlocked', 'Locked', 'Acc')
    state.HybridMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
	state.PhysicalDefenseMode:options('None', 'Evasion', 'PDT')
    
	gear.perp_staff = {name="Chatoyant Staff"}
	
    select_default_macro_book()
end


--Begin initializing gear swaps
function init_gear_sets()
	--Template
	sets.mytemplate = {
		--main,
		--sub,
		--ranged,
		--ammo,
		--head,
		--neck,
		--ear1,
		--body,
		--hands,
		--ring1,
		--back,
		--waist,
		--legs,
		--feet,
		--ring2,  --delayed
		--ear2
	}

	--ELEMENTAL STAVES
	sets.ElementalStaff = {main="Chatoyant Staff"}
		sets.ElementalStaff.Fire = {main="Chatoyant Staff"}
		sets.ElementalStaff.Wind = {main="Chatoyant Staff"}
		sets.ElementalStaff.Water = {main="Chatoyant Staff"}
		sets.ElementalStaff.Earth = {main="Chatoyant Staff"}
		sets.ElementalStaff.Lightning = {main="Chatoyant Staff"}
		sets.ElementalStaff.Ice = {main="Chatoyant Staff"}
		sets.ElementalStaff.Light = {main="Chatoyant Staff"}
		sets.ElementalStaff.Dark = {main="Chatoyant Staff"}
	
	-------------------------------------------------------------------------------------
	--PRECAST Sets
	 -- Pact delay reduction gear
    sets.precast.BloodPactWard = {
		head="Smn. Horn +1",
		body="Yinyang Robe",hands="Smn. Bracers +1",
		back="Astute Cape",legs="Smn. Spats +1",feet="Smn. Pigaches +1"}

    sets.precast.BloodPactRage = sets.precast.BloodPactWard

	--Fastcast (cast time reduction)
	sets.precast.FC = {
	ear2="Loquac. Earring"}

	--Weaponskills
	--STR/MND
	sets.precast.WS = {
		ammo="Phtm. Tathlum",
		head="Voyager Sallet",neck="Fotia Gorget",ear1="Moldavite Earring",ear2="Brutal Earring",
		body="Bishop's Robe +1",hands="Dvt. Mitts +1",ring1="Rajas Ring",ring2="Crimson Ring",
		back="Prism Cape",waist="Potent Belt",legs="Hydra Brais",feet="Marduk's Crackows"}
	
	--STR/INT +MAB
	sets.precast.WS['Rock Crusher'] = {
		ammo="Phtm. Tathlum",
		head="Voyager Sallet",neck="Fotia Gorget",ear1="Moldavite Earring",ear2="Phantom Earring",
		body="Goliard Saio",hands="Mahatma Cuffs",ring1="Rajas Ring",ring2="Snow Ring",
		back="Prism Cape",waist="Potent Belt",legs="Smn. Spats +1",feet="Goliard Clogs"}
		
	sets.precast.WS['Earth Crusher'] = sets.precast.WS['Rock Crusher']
	
	--INT/MND
	sets.precast.WS['Spirit Taker'] = {
		ammo="Phtm. Tathlum",
		head="Evk. Horn +1",neck="Peacock Amulet",ear1="Phantom Earring",ear2="Brutal Earring",
		body="Goliard Saio",hands="Mahatma Cuffs",ring1="Snow Ring",ring2="Snow Ring",
		back="Prism Cape",waist="Potent Belt",legs="Hydra Brais",feet="Marduk's Crackows"}
		
	sets.precast.WS['Shattersoul'] = {
		ammo="Phtm. Tathlum",
		head="Evk. Horn +1",neck="Fotia Gorget",ear1="Phantom Earring",ear2="Brutal Earring",
		body="Goliard Saio",hands="Mahatma Cuffs",ring1="Snow Ring",ring2="Snow Ring",
		back="Prism Cape",waist="Potent Belt",legs="Hydra Brais",feet="Goliard Clogs"}
	
	-------------------------------------------------------------------------------------
	--MIDCAST Sets

	--Fastcast (recast reduction, haste)
	sets.midcast.FC = {
	head="Walahra Turban",ear2="Loquac. Earring",
	body="Goliard Saio",
	legs="Smn. Spats +1",feet="Nashira Crackows"}
	

	--Attributes

	sets.midcast.mnd = {
		head="Evk. Horn +1",neck="Faith Torque",
		body="Goliard Saio",hands="Dvt. Mitts +1",ring1="Saintly Ring +1",ring2="Saintly Ring +1",
		back="Prism Cape",legs="Savage Loincloth","Marduk's Crackows"}
	
	sets.midcast.int = {
		ammo="Phtm. Tathlum",
		head="Evk. Horn +1",neck="Prudence Torque",ear1="Phantom Earring",ear2="Morion Earring +1",
		body="Goliard Saio",hands="Mahatma Cuffs",ring1="Snow Ring",ring2="Snow Ring",
		back="Prism Cape",legs="Austere Slops",feet="Goliard Clogs"}

	--Skills
	--Reduced cast time and interrupt% - skill, FC, -%
	sets.midcast['Summoning Magic'] = {
		head="Evk. Horn +1",neck="Smn. Torque",ear2="Loquac. Earring",
		hands="Smn. Bracers +1",ring2="Evoker's Ring",
		back="Astute Cape",feet="Marduk's Crackows"}

	--Summoning
	--looking for ~+30smn skill
	--Summoning Skill, Avatar Enhancements
	sets.midcast.Pet.Skill = {
		head="Evk. Horn +1",neck="Smn. Torque",
		body="Yingyang Robe",hands="Summoner's Brcr.",ring2="Evoker's Ring",
		back="Astute Cape",feet="Summoner's Pgch.",}
    
    sets.midcast.Pet.BloodPactWard = sets.midcast.Pet.Skill

    sets.midcast.Pet.DebuffBloodPactWard = sets.midcast.Pet.Skill
        
    sets.midcast.Pet.DebuffBloodPactWard.Acc = sets.midcast.Pet.Skill
    
    sets.midcast.Pet.PhysicalBloodPactRage = set_combine(sets.midcast.Pet.Skill, 
		{body="Smn. Doublet +1",legs="Evoker's Spats",feet="Smn Pigaches +1"})

    sets.midcast.Pet.PhysicalBloodPactRage.Acc = sets.midcast.Pet.PhysicalBloodPactRage

    sets.midcast.Pet.MagicalBloodPactRage = sets.midcast.Pet.Skill

    sets.midcast.Pet.MagicalBloodPactRage.Acc = sets.midcast.Pet.Skill


	--healing
	sets.midcast['Healing Magic'] = sets.midcast.mnd
	
	--elemental
	sets.midcast['Elemental Magic'] = sets.midcast.int
	
	--enfeebling
	sets.midcast['Enfeebling Magic'] = sets.midcast.mnd

	--Resistant
	--Interrupt%
	sets.midcast.resistant = {}


	-------------------------------------------------------------------------------------
	--AFTERCAST
	--------------------------
	--Engaged
	--------------------------
	--eg: sets.engaged.tpweapon.offense.defense
	sets.engaged = {
		ammo="Hedgehog Bomb",
		head="Walahra Turban",neck="Chivalrous Chain",ear1="Merman's Earring",ear2="Brutal Earring",
		body="Yinyang Robe",hands="Smn. Bracers +1",ring1="Rajas Ring",ring2="Evoker's Ring",
		back="Umbra Cape",waist="Potent Blet",legs="Evoker's Spats",feet="Smn. Pigaches +1"}
    
	sets.engaged.Acc = {}
    
    -- Mod set for trivial mobs (Skadi+1)
    sets.engaged.Mod = sets.engaged

    -- Mod set for trivial mobs (Thaumas)
    sets.engaged.Mod2 = sets.engaged

    sets.engaged.Acc.Evasion = set_combine(sets.engaged, sets.engaged.Acc, sets.engaged.Evasion)
	sets.engaged.Avatar = sets.engaged
	--------------------------
	--Defense
	--------------------------
	--EVA overwrites other sets
	sets.defense.Evasion = {
		head="Dobson Bandana",neck="Evasion Torque",ear1="Dodge Earring",ear2="Dodge Earring",
		back="Boxer's Mantle",legs="Evoker's Spats",feet="Goliard Clogs"}
	
	--DEF/PDT overwrites other sets
	sets.defense.PDT = {
		back="Umbra Cape"}
	
	-------------------------------------------------------------------------------------
	--NON-ACTION Sets
	--Refresh
	--(only refresh gear)
	sets.refresh = {body="Yinyang Robe"}
	--Resting
	sets.resting = {
		ammo="Hedgehog Bomb",
		body="Yinyang Robe",
		hands="Smn. Bracers +1",
		ring1="Rajas Ring",
		ring2="Evoker's Ring",
		back="Prism Cape",
		waist="Hierarch Belt",
		legs="Smn. Spats +1",
		feet="Smn. Pigaches +1"}
	
	--------------------------
	--Idle
	--------------------------
	--Normal set for basic refresh
	sets.idle = {
		ammo="Hedgehog Bomb",
		head="Walahra Turban",neck="Orochi Nodowa",ear1="Astral Earring",ear2="Loquac. Earring",
		body="Yinyang Robe",hands="Smn. Bracers +1",ring1="Rajas Ring",ring2="Evoker's Ring",
		back="Astute Cape",waist="Hierarch Belt",legs="Smn. Spats +1",feet="Herald's Gaiters"}
	
	--PDT/DEF
	sets.idle.PDT = set_combine(sets.idle, {
		back="Umbra Cape"})
		
	sets.idle.MDT = {
		ring1="Shadow Ring"}

	 -- perp costs:
    -- spirits: 7
    -- carby: 11 (5 with mitts)
    -- fenrir: 13
    -- others: 15
    -- avatar's favor: -4/tick
    
    -- Max useful -perp gear is 1 less than the perp cost (can't be reduced below 1)
    -- Aim for -14 perp, and refresh in other slots.
    
    -- -perp gear:
    -- Chatoyant: -3
    -- Glyphic Horn:
    -- Caller's Doublet +2/Glyphic Doublet:
    -- Evoker's Ring: -1
    -- Evoker's Pigaches +1:
    -- total: -4
    
    -- Can make due without either the head or the body, and use +refresh items in those slots.
    
    sets.idle.Avatar = set_combine(sets.idle, {
		ring1="Evoker's Ring"})
		
    sets.idle.PDT.Avatar = sets.idle.Avatar
    sets.idle.Spirit = sets.idle.Avatar
    sets.idle.Avatar.Melee = sets.idle.Avatar
        
    sets.perp = set_combine(sets.idle, {
		ring1="Evoker's Ring"})
	
    -- Caller's Bracer's halve the perp cost after other costs are accounted for.
    -- Using -10 (Gridavor, ring, Conv.feet), standard avatars would then cost 5, halved to 2.
    -- We can then use Hagondes Coat and end up with the same net MP cost, but significantly better defense.
    -- Weather is the same, but we can also use the latent on the pendant to negate the last point lost.
    sets.perp.Day = {body="Yingyang Robe"}
    sets.perp.Weather = {head="Smn. Horn +1"}
    -- Carby: Mitts+Conv.feet = 1/tick perp.  Everything else should be +refresh
    sets.perp.Carbuncle = {hands="Carbuncle Mitts"}
    -- Diabolos's Rope doesn't gain us anything at this time
    --sets.perp.Diabolos = {waist="Diabolos's Rope"}
    --sets.perp.Alexander = sets.midcast.Pet.BloodPactWard

    sets.perp.staff_and_grip = {}


end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for casting events.
-------------------------------------------------------------------------------------------------------------------
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if state.CastingMode.value == 'Resistant' then
		equip(sets.midcast.resistant)
	end
end

function job_pet_midcast (spell, action, spellMap, eventArgs)
	equip(sets.midcast.Pet.Skill)
end

-- Runs when pet completes an action.
function job_pet_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.type == 'BloodPactWard' and spellMap ~= 'DebuffBloodPactWard' then
        wards.flag = true
        wards.spell = spell.english
        send_command('wait 4; gs c reset_ward_flag')
    end
	handle_equipping_gear(player.status)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------


-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    elseif storms:contains(buff) then
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' and newValue == 'Unlocked' then
		enable('main','sub','range')
	else
		disable('main','sub','range')
	end
end

-- Called when the player's pet's status changes.
-- This is also called after pet_change after a pet is released.  Check for pet validity.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
        handle_equipping_gear(player.status)
    end
end


-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
    classes.CustomIdleGroups:clear()
    if gain then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    else
        select_default_macro_book('reset')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
function customize_melee_set(meleeSet)
	if pet.isvalid then
        if pet.element == world.day_element then
            meleeSet = set_combine(meleeSet, sets.perp.Day)
        end
        if pet.element == world.weather_element then
            meleeSet = set_combine(meleeSet, sets.perp.Weather)
        end
        if sets.perp[pet.name] then
            meleeSet = set_combine(meleeSet, sets.perp[pet.name])
        end
	end
	return meleeSet
end

-- Custom spell mapping.
function job_get_spell_map(spell)
    if spell.type == 'BloodPactRage' then
        if magicalRagePacts:contains(spell.english) then
            return 'MagicalBloodPactRage'
        else
            return 'PhysicalBloodPactRage'
        end
    elseif spell.type == 'BloodPactWard' and spell.target.type == 'MONSTER' then
        return 'DebuffBloodPactWard'
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if pet.isvalid then
        if pet.element == world.day_element then
            idleSet = set_combine(idleSet, sets.perp.Day)
        end
        if pet.element == world.weather_element then
            idleSet = set_combine(idleSet, sets.perp.Weather)
        end
        if sets.perp[pet.name] then
            idleSet = set_combine(idleSet, sets.perp[pet.name])
        end
    end 
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'petweather' then
        handle_petweather()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'siphon' then
        handle_siphoning()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'pact' then
        handle_pacts(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1] == 'reset_ward_flag' then
        wards.flag = false
        wards.spell = ''
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Cast the appopriate storm for the currently summoned avatar, if possible.
function handle_petweather()
    if player.sub_job ~= 'SCH' then
        add_to_chat(122, "You can not cast storm spells")
        return
    end
        
    if not pet.isvalid then
        add_to_chat(122, "You do not have an active avatar.")
        return
    end
    
    local element = pet.element
    if element == 'Thunder' then
        element = 'Lightning'
    end
    
    if S{'Light','Dark','Lightning'}:contains(element) then
        add_to_chat(122, 'You do not have access to '..elements.storm_of[element]..'.')
        return
    end 
    
    local storm = elements.storm_of[element]
    
    if storm then
        send_command('@input /ma "'..elements.storm_of[element]..'" <me>')
    else
        add_to_chat(123, 'Error: Unknown element ('..tostring(element)..')')
    end
end

-- Custom uber-handling of Elemental Siphon
function handle_siphoning()
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'Cannot use Elemental Siphon in a city area.')
        return
    end

    local siphonElement
    local stormElementToUse
    local releasedAvatar
    local dontRelease
    
    -- If we already have a spirit out, just use that.
    if pet.isvalid and spirits:contains(pet.name) then
        siphonElement = pet.element
        dontRelease = true
        -- If current weather doesn't match the spirit, but the spirit matches the day, try to cast the storm.
        if player.sub_job == 'SCH' and pet.element == world.day_element and pet.element ~= world.weather_element then
            if not S{'Light','Dark','Lightning'}:contains(pet.element) then
                stormElementToUse = pet.element
            end
        end
    -- If we're subbing /sch, there are some conditions where we want to make sure specific weather is up.
    -- If current (single) weather is opposed by the current day, we want to change the weather to match
    -- the current day, if possible.
    elseif player.sub_job == 'SCH' and world.weather_element ~= 'None' then
        -- We can override single-intensity weather; leave double weather alone, since even if
        -- it's partially countered by the day, it's not worth changing.
        if get_weather_intensity() == 1 then
            -- If current weather is weak to the current day, it cancels the benefits for
            -- siphon.  Change it to the day's weather if possible (+0 to +20%), or any non-weak
            -- weather if not.
            -- If the current weather matches the current avatar's element (being used to reduce
            -- perpetuation), don't change it; just accept the penalty on Siphon.
            if world.weather_element == elements.weak_to[world.day_element] and
                (not pet.isvalid or world.weather_element ~= pet.element) then
                -- We can't cast lightning/dark/light weather, so use a neutral element
                if S{'Light','Dark','Lightning'}:contains(world.day_element) then
                    stormElementToUse = 'Wind'
                else
                    stormElementToUse = world.day_element
                end
            end
        end
    end
    
    -- If we decided to use a storm, set that as the spirit element to cast.
    if stormElementToUse then
        siphonElement = stormElementToUse
    elseif world.weather_element ~= 'None' and (get_weather_intensity() == 2 or world.weather_element ~= elements.weak_to[world.day_element]) then
        siphonElement = world.weather_element
    else
        siphonElement = world.day_element
    end
    
    local command = ''
    local releaseWait = 0
    
    if pet.isvalid and avatars:contains(pet.name) then
        command = command..'input /pet "Release" <me>;wait 1.1;'
        releasedAvatar = pet.name
        releaseWait = 10
    end
    
    if stormElementToUse then
        command = command..'input /ma "'..elements.storm_of[stormElementToUse]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end
    
    if not (pet.isvalid and spirits:contains(pet.name)) then
        command = command..'input /ma "'..elements.spirit_of[siphonElement]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end
    
    command = command..'input /ja "Elemental Siphon" <me>;'
    releaseWait = releaseWait - 1
    releaseWait = releaseWait + 0.1
    
    if not dontRelease then
        if releaseWait > 0 then
            command = command..'wait '..tostring(releaseWait)..';'
        else
            command = command..'wait 1.1;'
        end
        
        command = command..'input /pet "Release" <me>;'
    end
    
    if releasedAvatar then
        command = command..'wait 1.1;input /ma "'..releasedAvatar..'" <me>'
    end
    
    send_command(command)
end


-- Handles executing blood pacts in a generic, avatar-agnostic way.
-- cmdParams is the split of the self-command.
-- gs c [pact] [pacttype]
function handle_pacts(cmdParams)
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'You cannot use pacts in town.')
        return
    end

    if not pet.isvalid then
        add_to_chat(122,'No avatar currently available. Returning to default macro set.')
        select_default_macro_book('reset')
        return
    end

    if spirits:contains(pet.name) then
        add_to_chat(122,'Cannot use pacts with spirits.')
        return
    end

    if not cmdParams[2] then
        add_to_chat(123,'No pact type given.')
        return
    end
    
    local pact = cmdParams[2]:lower()
    
    if not pacts[pact] then
        add_to_chat(123,'Unknown pact type: '..tostring(pact))
        return
    end
    
    if pacts[pact][pet.name] then
        if pact == 'astralflow' and not buffactive['astral flow'] then
            add_to_chat(122,'Cannot use Astral Flow pacts at this time.')
            return
        end
        
        -- Leave out target; let Shortcuts auto-determine it.
        send_command('@input /pet "'..pacts[pact][pet.name]..'"')
    else
        add_to_chat(122,pet.name..' does not have a pact of type ['..pact..'].')
    end
end


-- Event handler for updates to player skill, since we can't rely on skill being
-- correct at pet_aftercast for the creation of custom timers.
windower.raw_register_event('incoming chunk',
    function (id)
        if id == 0x62 then
            if wards.flag then
                create_pact_timer(wards.spell)
                wards.flag = false
                wards.spell = ''
            end
        end
    end)

-- Function to create custom timers using the Timers addon.  Calculates ward duration
-- based on player skill and base pact duration (defined in job_setup).
function create_pact_timer(spell_name)
    -- Create custom timers for ward pacts.
    if wards.durations[spell_name] then
        local ward_duration = wards.durations[spell_name]
        if ward_duration < 181 then
            local skill = player.skills.summoning_magic
            if skill > 300 then
                skill = skill - 300
                if skill > 200 then skill = 200 end
                ward_duration = ward_duration + skill
            end
        end
        
        local timer_cmd = 'timers c "'..spell_name..'" '..tostring(ward_duration)..' down'
        
        if wards.icons[spell_name] then
            timer_cmd = timer_cmd..' '..wards.icons[spell_name]
        end

        send_command(timer_cmd)
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book(reset)
    if reset == 'reset' then
        -- lost pet, or tried to use pact when pet is gone
    end
	
    -- Default macro set/book
    set_macro_page(1,17)
end
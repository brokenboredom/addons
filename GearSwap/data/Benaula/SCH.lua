-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
        Custom commands:

        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.

                                        Light Arts              Dark Arts

        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
--]]



-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
	state.Buff['Sandstorm'] = buffactive['Sandstorm'] or false
	state.Buff['Tabula Rasa'] = buffactive['Tabula Rasa'] or false
    
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Locked')
    state.CastingMode:options('Normal', 'Acc', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
	state.PhysicalDefenseMode:options('None', 'Evasion', 'PDT')

	info.helix = S{"Luminohelix", "Noctohelix", "Pyrohelix", "Cryohelix", "Ionohelix", "Geohelix", "Anemohelix", "Hydrohelix"}
    info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder"}
    info.mid_nukes = S{"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
                       "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
                       "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",}
    info.high_nukes = S{"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    select_default_macro_book()

end

function user_unload()

end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
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
		
	
    -- Precast Sets

    -- Precast sets to enhance JAs

    -- Fast cast sets for spells
	-- Casting time -%
	sets.precast.FC = {
		head="argute m.board",
		feet="Scholar's Loafers",
		ear2="locquac. earring"
	}
	sets.precast.FC.weather = {feet="argute loafers"}
	
    -- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
	--INT/MND +MAB
		head="Sinister Mask",
		neck="enlightened chain",
		ear1="Morion Earring",
		ear2="Moldavite Earring",
		body="Magna bodice",
		hands="magna gloves",
		ring1="saintly Ring +1",
		ring2="eremite's Ring +1",
		back="prism cape",
		waist="Friar's Rope",
		legs="Magna f chausses",
		feet="mgn. f ledelsens",
	}
	
	sets.precast.WS['Shell Crusher'] = {
	--STR
		ammo="Attar Sachet",
		head="Voyager Sallet",
		neck="Spike Necklace",
		ear1="merman's Earring",
		ear2="merman's Earring",
		body="Magna Bodice",
		hands="Prt. Bangles",
		ring1="Puissance Ring",
		ring2="Rajas Ring",
		back="Bellicose Mantle",
		waist="Friar's Rope",
		legs="Magic Slacks",
		feet="Desert Boots",
	}
	sets.precast.WS['Full Swing'] = sets.precast.WS['Shell Crusher']
    
	sets.precast.WS['Spirit Taker'] = {
	--INT/MND
		--ammo,
		head="errant Hat",
		neck="peacock amulet",
		ear1="morion Earring +1",
		ear2="Moldavite Earring",
		body="errant hpl.",
		hands="argute bracers",
		ring1="omniscient Ring",
		ring2="Sniper's Ring +1",
		back="prism cape",
		waist="potent belt",
		legs="argute pants",
		feet="mgn. f ledelsens",
	}
-------------------------------------------------------------
    -- Midcast Sets
	--Job Related
	
	--Fast Cast
	--Haste, recast -%
	sets.midcast.FC = {head="argute m.board", feet="scholar's loafers", ear2="locquac. earring"}
	sets.midcast.FC.weather = {feet="agute loafers"}
	
	-- Attribute
	sets.midcast.mnd = {
		head="errant Hat",
		neck="promise badge",
		ear1="Star Earring",
		ear2="Star Earring",
		body="errant hpl.",
		hands="Dvt. Mitts +1",
		ring1="saintly Ring +1",
		ring2="saintly Ring +1",
		back="prism cape",
		waist="argute belt",
		legs="errant slops",
		feet="goliard clogs"
	}
	sets.midcast.int = {
		head="scholar's mortarboard",
		neck="enlightened chain",
		ear1="Morion Earring +1",
		--ear2="Morion Earring +1",
		body="errant hpl.",
		hands="goliard cuffs",
		ring1="omniscient Ring",
		ring2="Eremite's Ring +1",
		back="prism cape",
		waist="argute belt",
		legs="errant slops",
		feet="goliard clogs",
	}
	sets.midcast.mab = {
		ear2="Moldavite Earring",
		hands="goliard cuffs",
	}
	
	--Healing
	sets.midcast['Healing Magic'] = set_combine(sets.midcast.mnd, {
		neck="healing torque",
		legs="Scholar's Pants",
		feet="argute loafers",
	})
	
    --Enhancing
    sets.midcast['Enhancing Magic'] = {
		neck="enhancing torque",
		body="argute gown",
		legs="Scholar's Pants",
	}
	--Embrava
	--Enhancing skill
	sets.midcast['Embrava'] = sets.midcast['Enhancing Magic']
    sets.midcast.Stoneskin = set_combine(sets.midcast.mnd, sets.midcast.resistant, 
		sets.midcast['Enhancing Magic'])
    sets.midcast.BarElement = sets.midcast['Enhancing Magic']
    sets.midcast.Regen = sets.midcast.resistant
	
	--Dark
    sets.midcast['Dark Magic'] = set_combine(sets.midcast.int,{
		body="Scholar's Gown",
		neck="Dark Torque",
		legs="argute pants",
	})
	--Kaustra
	--dark magic/INT
	sets.midcast['Kaustra'] = sets.midcast['Dark Magic']
	sets.midcast.Drain = sets.midcast['Dark Magic']
    sets.midcast.Aspir = sets.midcast.Drain
    sets.midcast.Stun = sets.midcast.Drain
    sets.midcast.Stun.resistant = sets.midcast.Stun
	
	--Enfeebling
	sets.midcast['Enfeebling Magic'] = {
		neck="Enfeebling Torque",
		hands="Argute bracers",
	}
	sets.midcast['Enfeebling Magic'].mnd = set_combine(sets.midcast.mnd,
		sets.midcast['Enfeebling Magic'], {
		legs="Scholar's Pants",
	})
	sets.midcast['Enfeebling Magic'].int = set_combine(sets.midcast.int,
		sets.midcast['Enfeebling Magic'], {
		body="Scholar's Gown",
	})
	
	--Elemental
	--Default set is Full MAB
    sets.midcast['Elemental Magic'] = set_combine(sets.midcast.int, sets.midcast.mab, {
		neck="Elemental Torque",
		body="Scholar's Gown",
	})
	
	--Resistant
	sets.midcast.resistant = {
		hands="Scholar's Bracers",
		waist="volunteer's belt",
	}

---------------------------------------------------------------------
	--Aftercast
    -- Resting sets
    sets.resting = sets.idle
    -- Idle sets
    sets.idle = {
		--main="Terra's Staff",
		--head="Seer's Crown +1",
		neck="Orochi Nodowa +1",
		ear1="elusive earring",
		ear2="elusive earring",
		body="Royal Cloak",
		hands="errant cuffs",
		ring1="merman's Ring",
		ring2="defending ring",
		back="umbra cape",
		waist="hierarch belt",
		legs="errant slops",
		feet="dance shoes +1",	
	}

    -- Defense sets
    sets.defense.PDT = {
		
	}
    sets.defense.MDT = {}
	--Kiting
    sets.Kiting = {feet="Herald's Gaiters"}
    -- Engaged sets
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    -- Basic set for if no TP weapon is defined.
	sets.engaged = {
		--head="sinister mask",
		neck="Peacock Amulet",
		ear1="brutal earring",
		ear2="elusive earring",
		body="royal cloak",
		hands="goliard cuffs",
		ring1="kusha's Ring",
		ring2="lava's Ring",
		back="umbra cape",
		waist="potent belt",
		legs="prince's slops",
		feet="scholar's loafers",	
	}
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff.FullSublimation = {head="Scholar's Mortarboard", body="argute Gown"}

    sets.buff['Sandstorm'] = {feet="Desert Boots"}
	
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
        if not midaction() then handle_equipping_gear(player.status) end
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' and newValue == 'Locked' then
		disable('main','sub','range')
	else
		enable('main','sub','range')
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_post_midcast(spell, action, spellMap, eventArgs)
	equip(sets.ElementalStaff[spell.element])
	if spell.skill == 'Enfeebling Magic' then
		if spell.type == 'WhiteMagic' then equip(sets.midcast['Enfeebling Magic'].mnd)
		elseif spell.type == 'BlackMagic' then equip(sets.midcast['Enfeebling Magic'].int) end
	end
	if state.CastingMode.value == 'Resistant' then
		equip(sets.midcast.resistant)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
function customize_idle_set(idleSet)
	if state.Buff['Sandstorm'] or (world.weather_element == 'Earth') then
		idleSet = set_combine(idleSet, sets.buff['Sandstorm'])
	end
    if state.Buff['Sublimation: Activated'] then
			idleSet = set_combine(idleSet, sets.buff.FullSublimation)
	end
    return idleSet
end
function customize_melee_set(meleeSet)
	if state.Buff['Sublimation: Activated'] then
			meleeSet = set_combine(meleeSet, sets.buff.FullSublimation)
	end
	return meleeSet
end
-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------


function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 4*60

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 17)
end

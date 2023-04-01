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
    
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'EXP')


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

    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Tabula Rasa'] = {legs="Pedagogy Pants"}


    -- Fast cast sets for spells

	sets.precast.FC = {ammo="Incantor Stone",
        head="Merlinic Hat",ear1="Loquacious Earring",ring1="Prolix Ring",
        body="Rosette Jaseran",hands="Gendewitha Gages",
        back="Swith Cape",waist="Channeler's Stone",legs="Psycloth Lappas",feet="Merlinic Crackows"}
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {hands="Carapacho cuffs"})

    sets.precast.FC['Healing Magic'] = sets.precast.FC

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = sets.precast.FC['Healing Magic']
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
	
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
        head="Vanya Hood",neck=gear.ElementalGorget,ear2="Loquacious Earring",
        body="Rosette Jaseran",hands="Weatherspoon Cuffs +1",
        back="Tempered Cape +1",waist="Hierarch Belt",legs="Orvail Pants +1",feet="Gendewitha Galoshes +1"}

    -- Midcast Sets

	sets.midcast.FastRecast = {
        head="Nahtirah Hat",ear2="Loquacious Earring",
        body="Vanir Cotehardie",hands="Dynasty Mitts",ring1="Prolix Ring",
        back="Swith Cape",waist="Channeler's Stone",legs="Gendewitha Spats",feet="Gendewitha Galoshes +1"}
    
    -- Cure sets
    gear.default.obi_waist = "Channeler's Stone"
    gear.default.obi_back = "Tempered Cape +1"

    sets.midcast.Cure = {ammo="Incantor Stone",
        head="Vanya Hood",neck="Nesanica Torque",ear2="Mendi. Earring",
        body="Rosette Jaseran",hands="Weatherspoon Cuffs +1",ring1="Ephedra Ring",ring2="Ephedra Ring",
        legs="Assiduity Pants +1",feet="Vanya Clogs"}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.CureMelee = sets.midcast.Cure

    sets.midcast.Cursna = {ammo="Incantor Stone",
        neck="Malison Medallion",
        ring1="Ephedra Ring",ring2="Ephedra Ring",
        back="Disperser's Cape",legs="Assiduity Pants +1",feet="Gendewitha Galoshes +1"}

    sets.midcast.StatusRemoval = {back="Disperser's Cape"}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {head="Vanya Hood",neck="Twilight Torque",
        hands="Chironic Gloves",
        back="Cheviot Cape",waist="Chaneller's Stone"}

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {hands="Carapacho Cuffs"})

    sets.midcast.BarElement = sets.midcast['Enhancing Magic']

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],{head="Arbatel Bonnet"})

    sets.midcast['Divine Magic'] = {head="Vanya Hood",hands="Chironic Gloves"}

    sets.midcast['Dark Magic'] = {main="Akademos", sub="Niobid Strap",ammo="Pemphredo Tathlum",head="Merlinic Hood",neck="Twilight Torque",
        body="Rosette Jaseran",hands="Chironic Gloves",
        back="Cheviot Cape",legs="Assiduity Pants +1",feet="Merlinic Crackows",waist=gear.ElementalBelt,ring1="Acumen Ring",ring2="Defending Ring",ear1="Ethereal Earring",ear2="Moonshade Earring"}

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {main="Akademos", sub="Niobid Strap",ammo="Pemphredo Tathlum",head="Vanya Hood",neck="Twilight Torque",
        body="Rosette Jaseran",hands="Chironic Gloves",
        back="Cheviot Cape",waist="Chaneller's Stone",legs="Assiduity Pants +1",feet="Merlinic Crackows"}

    sets.midcast.IntEnfeebles = {main="Akademos", sub="Niobid Strap",ammo="Pemphredo Tathlum",head="Merlinic Hood",neck="Twilight Torque",
        body="Academic's Gown +1",hands="Chironic Gloves",
        back="Cheviot Cape",waist="Chaneller's Stone",legs="Assiduity Pants +1",feet="Merlinic Crackows"}
		
	sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles

    sets.midcast.CureWithLightWeather = sets.midcast.Cure

    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {feet="Pedagogy Loafers"})

    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = {ring1="Sheltered Ring"}
    sets.midcast.Shellra = sets.midcast.Shell

    sets.midcast.Kaustra = {main="Akademos", sub="Niobid Strap",ammo="Pemphredo Tathlum",head="Merlinic Hood",neck="Twilight Torque",
        body="Academic's Gown +1",hands="Chironic Gloves",
        back="Cheviot Cape",waist="Chaneller's Stone",legs="Assiduity Pants +1",feet="Merlinic Crackows"}

    sets.midcast.Drain = sets.midcast['Dark Magic']

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = sets.midcast.Drain

    sets.midcast.Stun.Resistant = sets.midcast.Stun


    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {main="Akademos", sub="Niobid Strap",ammo="Pemphredo Tathlum",head="Merlinic Hood",neck="Sanctity Necklace",
        body="Academic's Gown +1",hands="Chironic Gloves",
        back="Cheviot Cape",legs="Assiduity Pants +1",feet="Merlinic Crackows",waist=gear.ElementalObi,ring1="Acumen Ring",ring2="Defending Ring",ear1="Hecate's Earring",ear2="Friomisi Earring"}

    -- Custom refinements for certain nuke tiers
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {ring1="Mujin Band"})
	
	sets.midcast['Elemental Magic'].Helix = set_combine(sets.midcast['Elemental Magic'], {ring1="Mujin Band"})

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {main="Akademos",sub="Niobid Strap",ammo="Homiliary",head="Academic's Mortarboard +1",neck="Twilight Torque",
        body="Academic's Gown +1",hands="Chironic Gloves",
        legs="Assiduity Pants +1",feet="Battlecast Gaiters",waist="Hierarch Belt",ring1="Sheltered Ring",ring2="Defending Ring",ear1="Ethereal Earring",ear2="Moonshade Earring",
        back="Cheviot Cape"}
		
	sets.idle.Paralyze = {main="Akademos",sub="Niobid Strap",ammo="Homiliary",head="Academic's Mortarboard +1",neck="Twilight Torque",
        body="Academic's Gown +1",hands="Chironic Gloves",
        legs="Assiduity Pants +1",feet="Battlecast Gaiters",waist="Hierarch Belt",ring1="Sheltered Ring",ring2="Defending Ring",ear1="Ethereal Earring",ear2="Moonshade Earring",
        back="Disperser's Cape"}

    sets.idle.PDT = {main="Earth Staff",sub="Niobid Strap",ammo="Homiliary",head="Academic's Mortarboard +1",neck="Twilight Torque",
        body="Academic's Gown +1",hands="Chironic Gloves",
        legs="Assiduity Pants +1",feet="Battlecast Gaiters",waist="Hierarch Belt",ring1="Sheltered Ring",back="Cheviot Cape",ring2="Defending Ring",ear1="Ethereal Earring",ear2="Moonshade Earring",
        }

	sets.idle.EXP = {main="Akademos",sub="Niobid Strap",ammo="Homiliary",head="Academic's Mortarboard +1",neck="Twilight Torque",
        body="Academic's Gown +1",hands="Chironic Gloves",
        legs="Assiduity Pants +1",feet="Battlecast Gaiters",waist="Hierarch Belt",ring1="Sheltered Ring",ring2="Defending Ring",ear1="Ethereal Earring",ear2="Moonshade Earring",
        back="Mecistopins Mantle"}
		
    sets.idle.Town = {main="Akademos",sub="Niobid Strap",ammo="Homiliary",head="Midras's Helm +1",neck="Smithy's Torque",
        body="Blacksmith's Apron",hands="Smithy's Mitts",
        legs="Assiduity Pants +1",feet="Battlecast Gaiters",waist="Hierarch Belt",ear1="Ethereal Earring",ear2="Moonshade Earring",
        back="Cheviot Cape",ring1="Orvail Ring",ring2="Craftmaster's Ring"}
		
    
    sets.idle.Weak = {main="Earth Staff",sub="Niobid Strap",ammo="Homiliary",head="Vanya Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Academic's Gown +1",hands="Chironic Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Battlecast Gaiters"}
    
    -- Defense sets

    sets.defense.PDT = {main="Earth Staff",head="Vanya Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Academic's Gown +1",hands="Chironic Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Battlecast Gaiters"}

    sets.defense.MDT = {head="Vanya Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Academic's Gown +1",hands="Chironic Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Gendewitha Galoshes +1"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets
	sets.engaged = sets.precast.WS['Myrkr']
	
	sets.engaged.Normal = sets.engaged

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
	sets.engaged = sets.idle

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.

    sets.buff.FullSublimation = {head="Academic's Mortarboard +1",ear1="Savant's Earring",body="Pedagogy Gown"}
    sets.buff.PDTSublimation = {head="Academic's Mortarboard +1",ear1="Savant's Earring"}

    --sets.buff['Sandstorm'] = {feet="Desert Boots"}
	sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
	sets.buff['Immanence'] = {hands="Arbatel Bracers +1"}
	
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    
	end
end

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

function job_post_midcast(spell, action, spellMap, eventArgs)
	if buffactive['Perpetuance'] or buffactive['Immanence'] then
		equip(sets.buff['Perpetuance'])
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Elemental Magic' then
            if info.low_nukes:contains(spell.english) then
                return 'LowTierNuke'
			elseif info.helix:contains(spell.english) then
				return 'Helix'
            elseif info.mid_nukes:contains(spell.english) then
                return 'MidTierNuke'
            elseif info.high_nukes:contains(spell.english) then
                return 'HighTierNuke'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' or state.IdleMode.value == "EXP" then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
        elseif state.IdleMode.value == 'PDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
        end
    end

    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not (buffactive['light arts']      or buffactive['dark arts'] or
                       buffactive['addendum: white'] or buffactive['addendum: black']) then
        if state.IdleMode.value == 'Stun' then
            send_command('@input /ja "Dark Arts" <me>')
        else
            send_command('@input /ja "Light Arts" <me>')
        end
    end

    
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
    set_macro_page(1, 12)
end

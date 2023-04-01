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
    state.OffenseMode:options('None', 'Normal', 'Ninja', 'Accuracy')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'Paralyze', 'PDT', 'EXP')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {ammo="Incantor Stone",
        neck="Orison Locket",ear1="Loquacious Earring",
        body="Rosette Jaseran",hands="Gendewitha Gages",ring1="Prolix Ring",
        back="Swith Cape",waist="Channeler's Stone",legs="Orvail Pants +1"}
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {head="Umuthi Hat",hands="Carapacho cuffs"})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {main="Queller Rod", sub="Genmei Shield",
	head="Piety Cap", ear2="Nourishing Earring",legs="Ebers Pantaloons",feet="Hygieia Clogs +1"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {main="Queller Rod",sub="Genmei Shield"})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault"}
	sets.precast.JA.Devotion = {head ="Piety Cap"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Nahtirah Hat",ear1="Roundel Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",
        back="Refraction Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes +1"}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    gear.default.weaponskill_neck = "Fotia Gorget"
    gear.default.weaponskill_waist = "Fotia Belt"
    sets.precast.WS = {
        head="Sukeroku Hachimaki",neck=gear.ElementalGorget,ear2="Brutal Earring",ear1="Aesir Ear Pendant",
        body="Ebers Bliaud",hands="Chironic Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Swith Cape",waist=gear.ElementalBelt,legs="Assiduity Pants +1",feet="Battlecast Gaiters"}
    
    sets.precast.WS['Flash Nova'] = {
        head="Sukeroku Hachimaki",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Strendu Ring",
        back="Toro Cape",waist="Thunder Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes +1"}
    

    -- Midcast Sets
    
    sets.midcast.FastRecast = {
        head="Nahtirah Hat",ear2="Loquacious Earring",
        body="Vanir Cotehardie",hands="Dynasty Mitts",ring1="Prolix Ring",
        back="Swith Cape",waist="Channeler's Stone",legs="Gendewitha Spats",feet="Gendewitha Galoshes +1"}
    
    -- Cure sets
    gear.default.obi_waist = "Hachirin-no-Obi"
    gear.default.obi_back = "Mending Cape"

    sets.midcast.CureSolace = {main="Queller Rod",sub="Genmei Shield",ammo="Incantor Stone",
        head="Vanya Hood",neck="Nesanica Torque",ear1="Mendi. Earring",ear2="Nourishing Earring",
        body="Ebers Bliaud",hands="Chironic Gloves",ring1="Ephedra Ring",ring2="Ephedra Ring",
        back="Tempered Cape +1",waist=gear.ElementalObi,legs="Ebers Pantaloons",feet="Vanya Clogs"}

    sets.midcast.Cure = {main="Queller Rod",sub="Genmei Shield",ammo="Incantor Stone",
        head="Vanya Hood",neck="Nesanica Torque",ear1="Mendi. Earring",ear2="Nourishing Earring",
        body="Rosette Jaseran",hands="Chironic Gloves",ring1="Ephedra Ring",ring2="Ephedra Ring",
        back="Tempered Cape +1",waist=gear.ElementalObi,legs="Ebers Pantaloons",feet="Vanya Clogs"}
		
	sets.midcast.Cure.Resistant = set_combine(sets.midcast.Cure, {hands="Chironic Gloves",body="Rosette Jaseran"})

    sets.midcast.Curaga = {main="Queller Rod",sub="Genmei Shield",ammo="Incantor Stone",
        head="Vanya Hood",neck="Nesanica Torque",ear1="Mendi. Earring",ear2="Nourishing Earring",
        body="Noble's Tunic",hands="Chironic Gloves",ring1="Ephedra Ring",ring2="Ephedra Ring",
        back="Tempered Cape +1",waist=gear.ElementalObi,legs="Ebers Pantaloons",feet="Vanya Clogs"}

    sets.midcast.CureMelee = {ammo="Incantor Stone",
        head="Vanya Hood",neck="Nesanica Torque",ear1="Mendi. Earring",ear2="Nourishing Earring",
        body="Ebers Bliaud",hands="Chironic Gloves",ring1="Ephedra Ring",ring2="Ephedra Ring",
        back="Tempered Cape +1",waist=gear.ElementalObi,legs="Ebers Pantaloons",feet="Vanya Clogs"}

    sets.midcast.Cursna = {main="Queller Rod",sub="Genbu's Shield",
        ammo="Incantor Stone",
        head="Ebers Cap",neck="Malison Medallion",ear1="Lifestorm Earring",ear2="Nourishing Earring",
        body="Ebers Bliaud",hands="Ebers Mitts",ring1="Ephedra Ring",ring2="Ephedra Ring",
        back="Tempered Cape +1",waist=gear.ElementalObi,legs="Ebers Pantaloons",feet="Gendewitha Galoshes +1"}

    sets.midcast.StatusRemoval = {
        head="Ebers Cap",legs="Ebers Pantaloons",back="Disperser's Cape"}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {head="Vanya Hood",neck="Twilight Torque",
        body="Ebers Bliaud",hands="Chironic Gloves",
        back="Cheviot Cape",waist="Chaneller's Stone",legs="Piety Pantaloons",feet="Ebers Duckbills"}

    sets.midcast.Stoneskin = {
        head="Nahtirah Hat",neck="Orison Locket",ear2="Loquacious Earring",
        body="Vanir Cotehardie",hands="Dynasty Mitts",
        back="Swith Cape",waist="Siegel Sash",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

    sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'],{hands="Dynasty Mitts",feet="Ebers Duckbills"})

    sets.midcast.BarElement = {main="Beneficus",sub="Genbu's Shield",
        head="Ebers Cap",neck="Colossus's Torque",
        body="Ebers Bliaud",hands="Ebers Mitts",
        back="Mending Cape",waist="Olympus Sash",legs="Piety Pantaloons",feet="Ebers Duckbills"}

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],{main="Bolelabunga",sub="Genbu's Shield",
        body="Piety Briault",hands="Ebers Mitts",
        legs="Theophany Pantaloons +1"})

    sets.midcast.Protectra = {ring2="Sheltered Ring",feet="Piety Duckbills"}

    sets.midcast.Shellra = {ring2="Sheltered Ring",legs="Piety Pantaloons"}


    sets.midcast['Divine Magic'] = {head="Vanya Hood",hands="Chironic Gloves",legs="Theophany Pantaloons +1"}

    sets.midcast['Dark Magic'] = {head="Vanya Hood",neck="Twilight Torque",
        body="Ebers Bliaud",hands="Chironic Gloves",
        back="Cheviot Cape",waist="Chaneller's Stone",legs="Assiduity Pants +1",feet="Gendewitha Galoshes +1"}

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {head="Vanya Hood",neck="Twilight Torque",
        body="Ebers Bliaud",hands="Chironic Gloves",
        back="Cheviot Cape",waist="Chaneller's Stone",legs="Assiduity Pants +1",feet="Gendewitha Galoshes +1"}

    sets.midcast.IntEnfeebles = {head="Vanya Hood",neck="Twilight Torque",
        body="Ebers Bliaud",hands="Chironic Gloves",
        back="Cheviot Cape",waist="Chaneller's Stone",legs="Assiduity Pants +1",feet="Gendewitha Galoshes +1"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Iridal Staff",head="Vanya Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Ebers Bliaud",hands="Chironic Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Gendewitha Galoshes +1"}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {ammo="Homiliary",main="Queller Rod",sub="Genmei Shield",head="Vanya Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Ebers Bliaud",hands="Chironic Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Battlecast Gaiters"}
		
	sets.idle.Paralyze = {ammo="Homiliary",main="Queller Rod",sub="Genmei Shield",head="Vanya Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Ebers Bliaud",hands="Chironic Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Disperser's Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Battlecast Gaiters"}

    sets.idle.PDT = {main="Earth Staff",ammo="Homiliary",head="Vanya Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Ebers Bliaud",hands="Chironic Gloves",ring1="Paguroidea Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Battlecast Gaiters"}

	sets.idle.EXP = {ammo="Homiliary",main="Queller Rod",sub="Genmei Shield",head="Vanya Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Ebers Bliaud",hands="Chironic Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Battlecast Gaiters",
        back="Mecistopins Mantle"}
		
    sets.idle.Town = set_combine(sets.idle, {ammo="Homiliary",head="Midras's Helm +1",body="Blacksmith's Apron",hands="Smithy's Mitts",ring1="Craftmaster's Ring",ring2="Orvail Ring"})
		
    
    sets.idle.Weak = {main="Earth Staff",ammo="Homiliary",head="Vanya Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Ebers Bliaud",hands="Chironic Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Battlecast Gaiters"}
    
    -- Defense sets

    sets.defense.PDT = {main="Earth Staff",head="Vanya Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Ebers Bliaud",hands="Chironic Gloves",ring1="Paguroidea Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Battlecast Gaiters"}

    sets.defense.MDT = {main="Queller Rod",sub="Genmei Shield",head="Vanya Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Ebers Bliaud",hands="Chironic Gloves",ring1="Paguroidea Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Gendewitha Galoshes +1"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
	sets.engaged = {ammo="Homiliary",
        head="Vanya Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Brutal Earring",
        body="Ebers Bliaud",hands="Chironic Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Cetl Belt",legs="Assiduity Pants +1",feet="Battlecast Gaiters"}
	
    sets.engaged.Normal = {main="Nehushtan",sub="Genbu's Shield",ammo="Homiliary",
        head="Vanya Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Brutal Earring",
        body="Ebers Bliaud",hands="Chironic Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Cetl Belt",legs="Assiduity Pants +1",feet="Battlecast Gaiters"}
		
	sets.engaged.Accuracy = {main="Nehushtan",sub="Genbu's Shield",ammo="Homiliary", head="Alhazen Hat",neck="Twilight Torque",ear2="Brutal Earring" ,ear1="Ethereal Earring",
        hands="Chironic Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Cetl Belt",
        body="Rosette Jaseran",legs="Assiduity Pants",feet="Battlecast Gaiters"}
	
	sets.engaged.Ninja = {main="Nehushtan",sub="Queller Rod",ammo="Homiliary",
        head="Vanya Hood",neck="Twilight Torque",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Ebers Bliaud",hands="Chironic Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Cetl Belt",legs="Assiduity Pants +1",feet="Battlecast Gaiters"}
	
	sets.engaged.Ninja.PDT = {main="Nehushtan",sub="Queller Rod",ammo="Homiliary",
        head="Vanya Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Brutal Earring",
        body="Ebers Bliaud",hands="Chironic Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Cetl Belt",legs="Assiduity Pants +1",feet="Battlecast Gaiters"}


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts",back="Mending Cape"}
	
	--Item lvl / stats for summoning Trusts
	sets.Trust = {main="Queller Rod",sub="Genmei Shield",head="Vanya Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Rosette Jaseran",hands="Chironic Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Battlecast Gaiters"}
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
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
	elseif spell.action_type == "Trust" then
		equip(sets.Trust)
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
		elseif newValue == 'Ninja' then
			enable('main','sub','range')
			equip(sets.engaged.Ninja)
            disable('main','sub','range')
        elseif newValue == 'Accuracy' then
            enable('main','sub','range')
			equip(sets.engaged.Accuracy)
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
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
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
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
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
    set_macro_page(3, 10)
end
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
    state.Buff.Saboteur = buffactive.saboteur or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

    gear.default.obi_waist = "Sekhmet Corset"
    
    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
    sets.precast.FC = {
        head="Wlk. Chapeau +1",ear2="Loquacious Earring",
        body="Dls. Tabard +1"}

    sets.precast.FC.Impact = {}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Morrigan's Coron.",neck="Fotia Gorget",ear1="Merman's Earring",ear2="Brutal Earring",
        body="Morrigan's Robe",hands="Alkyoneus's Brc.",ring1="Rajas Ring",ring2="Crimson Ring",
        back="Amemet Mantle +1",waist="Warwolf Belt",legs="Morrigan's Slops",feet="Savage Gaiters"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Aeolian Edge'] = {ammo="Phantom Tathlum",
		head="Morrigan's Coron.",neck="Fotia Gorget",ear1="Pixie Earring",ear2="Moldavit Earring",
        body="Morrigan's Robe",hands="Goliard Cuffs",ring1="Rajas Ring",ring2="Spinel Ring",
		back="Prism Cape",waist="Warwolf Belt",legs="Morrigan's Slops",feet="Duelist's Boots +1"}

    sets.precast.WS['Sanguine Blade'] = {
        head="Wlk. Chapeau +1",neck="Prudence Torque",ear1="Phantom Earring",ear2="Moldavite Earring",
        body="Morrigan's Robe",hands="Duelist's Gloves +1",ring1="Snow Ring",ring2="Snow Ring",
        back="Prism Cape",waist="Warwolf Belt",legs="Jet Seraweels",feet="Duelist's Boots +1"}

    
    -- Midcast Sets
    
    sets.midcast.FastRecast = {
        head="Wlk. Chapeau +1",ear2="Loquacious Earring",
        body="Dls. Tabard +1",hands="Gendewitha Gages",ring1="Prolix Ring",
        back="Swith Cape +1",waist="ninurta's sash",legs="Hagondes Pants",feet="Hagondes Sabots"}

    sets.midcast.Cure = {
        head="Morrigan's Coron.",neck="Healing Torque",ear1="Roundel Earring",ear2="Loquacious Earring",
        body="Dls. Tabard +1",hands="Dvt. Mitts +1",ring1="Saintly Ring +1",ring2="Saintly Ring +1",
        back="Prism Cape",waist="ninurta's sash",legs="Wlk. Tights +1",feet="Duelist's Boots +1"}
        
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {ring1="Kunaji Ring",ring2="Asklepian Ring"}

    sets.midcast['Enhancing Magic'] = {
        head="Morrigan's Coron.",neck="Enhancing Torque",
        body="Morrigan's Robe",hands="Duelist's Gloves +1",ring1="Saintly Ring +1",ring2="Saintly Ring +1",
        back="Prism Cape",waist="Olympus Sash",legs="Wlk. Tights +1",feet="Goliard Clogs"}

    sets.midcast.Refresh = {legs="Estoqueur's Fuseau +2"}

    sets.midcast.Stoneskin = sets.midcast['Enhancing Magic']
	
	sets.midcast.Haste = sets.midcast['Enhancing Magic']
    
    sets.midcast.MndEnfeebles = {
        head="Dls. Chapeau +1",neck="Enfeebling Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Wlk. Tabard +1",hands="Dvt. Mitts +1",ring1="Saintly Ring +1",ring2="Saintly Ring +1",
        back="Prism Cape",waist="ninurta's sash",legs="Wlk. Tights +1",feet="Goliard Clogs"}
		
	sets.midcast.IntEnfeebles = {
        head="Dls. Chapeau +1",neck="Enfeebling Torque",ear1="Lifestorm Earring",ear2="Phantom Earring",
        body="Wlk. Tabard +1",hands="Mahatma Cuffs",ring1="Snow Ring",ring2="Snow Ring",
        back="Prism Cape",waist="ninurta's sash",legs="Jet Seraweels",feet="Goliard Clogs"}	

    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau"})

    sets.midcast['Slow II'] = {
        head="Dls. Chapeau +1",neck="Enfeebling Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Wlk. Tabard +1",hands="Dvt. Mitts +1",ring1="Saintly Ring +1",ring2="Saintly Ring +1",
        back="Prism Cape",waist="ninurta's sash",legs="Wlk. Tights +1",feet="Goliard Clogs"}
    
    sets.midcast['Elemental Magic'] = {
        head="Wlk. Chapeau +1",neck="Elemental Torque",ear1="Moldavite Earring",ear2="Morion Earring +1",
        body="Morrigan's Robe",hands="Mahatma Cuffs",ring1="Snow Ring",ring2="Snow Ring",
        back="Prism Cape",waist="Duelist's Belt",legs="Dls. Tights +1",feet="Duelist's Boots +1"}
        
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.midcast['Dark Magic'] = {
        head="Wlk. Chapeau +1",neck="Dark Torque",ear1="Moldavite Earring",ear2="Morion Earring +1",
        body="Morrigan's Robe",hands="Blood Fng. Gnt.",ring1="Snow Ring",ring2="Snow Ring",
        back="Prism Cape",waist="Duelist's Belt",legs="Morrigan's Slops",feet="Goliard Clogs"}

    --sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {ring1="Excelsis Ring", waist="Fucho-no-Obi"})

    sets.midcast.Aspir = sets.midcast.Drain


    -- Sets for special buff conditions on spells.

    sets.midcast.EnhancingDuration = {}
        
    sets.buff.ComposureOther = {}

    sets.buff.Saboteur = {}
    

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
        head="Vitivation Chapeau",neck="Wiglen Gorget",
        body="Atrophy Tabard +1",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt",legs="Nares Trews",feet="Chelona Boots +1"}
    

    -- Idle sets
    sets.idle = {
        head="Dls. Chapeau +1",neck="Orochi Nodowa",ear1="novia earring",ear2="Elusive Earring",
        body="Dalmatica",hands="Dls. Gloves +1",ring1="Volunteer's Ring",ring2="Shadow Ring",
        back="Lamia Mantle +1",waist="Survival Belt",legs="Blood Cuisses",feet="Duelist's Boots +1"}

    sets.idle.Town = {
		head="Dls. Chapeau +1",
		body="Morrigan's Robe",
		legs="Blood Cuisses"}
    
    sets.idle.Weak = {}

    sets.idle.PDT = {}

    sets.idle.MDT = {
		head="Coral Visor +1",neck="Prudence Torque",ear1="Merman's Earring",ear2="Merman's Earring",
		body="Dalmatica",hands="Dls. Gloves +1",ring1="Merman's Ring",ring2="Merman's Ring",
		back="Lamia Mantle +1",waist="Duelist's Belt",legs="Coral Cuisses +1",feet="Coral Greaves +1"}
    
    
    -- Defense sets
    sets.defense.PDT = {
		head="Dls. Chapeau +1",neck="Orochi Nodowa",ear1="novia earring",ear2="Elusive Earring",
        body="Dalmatica",hands="Dusk Gloves +1",ring1="Jelly Ring",ring2="Shadow Ring",
        back="Umbra Cape",waist="ninurta's sash",legs="Goliard Trews",feet="Dusk Boots +1"}

    sets.defense.MDT = {
		head="Coral Visor +1",neck="Prudence Torque",ear1="Merman's Earring",ear2="Merman's Earring",
		body="Dalmatica",hands="Dls. Gloves +1",ring1="Merman's Ring",ring2="Merman's Ring",
		back="Lamia Mantle +1",waist="Duelist's Belt",legs="Coral Cuisses +1",feet="Coral Greaves +1"}

    sets.Kiting = {legs="Blood Cuisses"}

    sets.latent_refresh = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head="Dls. Chapeau +1",neck="Chivalrous Chain",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Morrigan's Robe",hands="Dusk Gloves +1",ring1="Rajas Ring",ring2="Shadow Ring",
        back="Amemet Mantle +1",waist="ninurta's sash",legs="Duelist's Tights +1",feet="Dusk Ledelsens +1"}

    sets.engaged.Defense = {
        head="Dls. Chapeau +1",neck="Orochi Nodowa",ear1="novia earring",ear2="Elusive Earring",
        body="Scp. Harness +1",hands="Dusk Gloves +1",ring1="Rajas Ring",ring2="Shadow Ring",
        back="Umbra Cape",waist="ninurta's sash",legs="Dusk Trousers +1",feet="Dusk Boots +1"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingDuration)
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther)
        end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
end

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

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
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
    if player.sub_job == 'DNC' then
        set_macro_page(1, 10)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 10)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 10)
    else
        set_macro_page(1, 10)
    end
end


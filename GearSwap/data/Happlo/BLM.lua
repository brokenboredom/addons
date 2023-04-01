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
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant', 'Burst', 'Death')
    state.IdleMode:options('Normal', 'PDT')
    
    state.MagicBurst = M(false, 'Magic Burst')

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

    gear.macc_hagondes = {name="Smithy's Mitts"}
    
    -- Additional local binds
    send_command('bind ^` input /ma Stun <t>')
    send_command('bind @` gs c activate MagicBurst')

    select_default_macro_book()
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
    sets.precast.JA['Mana Wall'] = {feet="Goetia Sabots +2"}

    sets.precast.JA.Manafont = {body="Sorcerer's Coat +2"}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {ammo="Impatiens",
        head="Merlinic Hood",ear2="Loquacious Earring",
        body="Rosette Jaseran",ring1="Prolix Ring",
        back="Swith Cape",waist="Channeler's Stone",legs="Orvail Pants +1",feet="Merlinic Crackows"}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {neck="Stoicheion Medal"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="Heka's Kalasiris", back="Pahtli Cape"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Supay Weskit",hands="Wayfarer Cuffs",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Merlinic Crackows"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck=gear.ElementalGorget,ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Supay Weskit",hands="Wayfarer Cuffs",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist=gear.ElementalBelt,legs="Assiduity Pants +1",feet="Merlinic Crackows"}
    
    
    ---- Midcast Sets ----
	gear.default.casting_waist = "Hierarch Belt"
	
    sets.midcast.FastRecast = {
        head="Nahtirah Hat",ear2="Loquacious Earring",
        body="Vanir Cotehardie",hands="Bokwus Gloves",ring1="Prolix Ring",
        back="Swith Cape +1",waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

    sets.midcast.Cure = {
        head="Vanya Hood",
		neck="Nesanica Torque",
		ear2="Mendi. Earring",
        body="Rosette Jaseran",
		hands="Weatherspoon Cuffs +1",
		ring1="Ephedra Ring",
		ring2="Ephedra Ring",
        legs="Assiduity Pants +1",
		feet="Vanya Clogs"
		}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
        neck="Colossus's Torque",
        body="Manasa Chasuble",hands="Ayao's Gages",
        legs="Portent Pants"}
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast['Enfeebling Magic'] = {ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Supay Weskit",hands="Wayfarer Cuffs",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Merlinic Crackows"}
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Supay Weskit",hands="Wayfarer Cuffs",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist=gear.ElementalObi,legs="Assiduity Pants +1",feet="Merlinic Crackows"}

    sets.midcast.Drain = {
		ammo="Pemphredo Tathlum",
        head="Merlinic Hood",
		neck="Sanctity Necklace",
		ear1="Ethereal Earring",
		ear2="Moonshade Earring",
        body="Rosette Jaseran",
		hands="Wayfarer Cuffs",
		ring1="Sheltered Ring",
		ring2="Defending Ring",
        back="Cheviot Cape",
		waist="Hierarch Belt",
		legs="Assiduity Pants +1",
		feet="Merlinic Crackows"
		}
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Supay Weskit",hands="Wayfarer Cuffs",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Merlinic Crackows"}


    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Spae. Coat +1",hands="Wayfarer Cuffs",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist=gear.ElementalObi,legs="Assiduity Pants +1",feet="Merlinic Crackows"}
		
	sets.midcast['Elemental Magic'].Burst = {ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Spae. Coat +1",hands="Wayfarer Cuffs",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist=gear.ElementalObi,legs="Assiduity Pants +1",feet="Merlinic Crackows"}
	
	sets.midcast['Elemental Magic'].Death = {ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Spae. Coat +1",hands="Wayfarer Cuffs",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist=gear.ElementalObi,legs="Assiduity Pants +1",feet="Merlinic Crackows"}
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Supay Weskit",hands="Wayfarer Cuffs",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Merlinic Crackows"}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Supay Weskit",hands="Wayfarer Cuffs",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Merlinic Crackows"}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {main="Earth Staff",ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Supay Weskit",hands="Wayfarer Cuffs",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Merlinic Crackows"}

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = {ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Supay Weskit",hands="Wayfarer Cuffs",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Merlinic Crackows"}
    
    -- Town gear.
    sets.idle.Town = {ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Supay Weskit",hands="Wayfarer Cuffs",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Merlinic Crackows"}
        
    -- Defense sets

    sets.defense.PDT = {ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Supay Weskit",hands="Wayfarer Cuffs",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Merlinic Crackows"}

    sets.defense.MDT = {ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Supay Weskit",hands="Wayfarer Cuffs",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Cheviot Cape",waist="Hierarch Belt",legs="Assiduity Pants +1",feet="Merlinic Crackows"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {feet="Goetia Sabots +2"}

    sets.magic_burst = {neck="Mizukage-no-Kubikazari"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
		head="Merlinic Hood",
		neck="Sanctity Necklace",
		ear1="Ethereal Earring",
		ear2="Brutal Earring",
        body="Rosette Jaseran",
		hands="Weatherspoon Cuffs +1",
		ring1="Paguroidea Ring",
		ring2="Defending Ring",
        back="Cheviot Cape",
		waist="Cetl Belt",
		legs="Assiduity Pants +1",
		feet="Battlecast Gaiters"}
	
    sets.engaged.Normal = sets.engaged
	
	sets.engaged.Acc = set_combine(sets.engaged, {head="Alhazen Hat"})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Goading Belt"
    elseif spell.skill == 'Elemental Magic' then
        gear.default.obi_waist = "Sekhmet Corset"
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
    end
end



function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        elseif spell.skill == 'Elemental Magic' then
            state.MagicBurst:reset()
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('feet')
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        --[[ No real need to differentiate with current gear.
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
        --]]
    end
end

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
    set_macro_page(4, 3)
end

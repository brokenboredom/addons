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
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('None', 'PDT')
    state.MagicalDefenseMode:options('None', 'MDT')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')

    update_defense_mode()
    
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')

    select_default_macro_book(1, 16)
end

function user_unload()
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = {}
    sets.precast.JA['Holy Circle'] = {}
    sets.precast.JA['Shield Bash'] = {hands="Valor Gauntlets"}
    sets.precast.JA['Sentinel'] = {feet="Valor Leggings"}
    sets.precast.JA['Rampart'] = {head="Valor Coronet"}
    sets.precast.JA['Fealty'] = {}
    sets.precast.JA['Divine Emblem'] = {}
    sets.precast.JA['Cover'] = {head="Valor Surcoat"}

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
        head="Valor Coronet",neck="Faith Torque",
        body="Valor Surcoat",hands="Dvt. Mitts +1",ring1="Saintly Ring +1",ring2="Saintly Ring +1",
        back="Weard Mantle",feet="Valor Leggings"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		head="Wivre Mask +1",neck="Temp. Torque",
        body="Dusk Jerkin +1",hands="Valor Gauntlets",ring1="Bastokan Ring",
		waist="Warwolf Belt",legs="Beak Trousers"}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {}
    sets.precast.Flourish1 = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Askar Zucchetto",neck="Chivalrous Chain",ear1="Merman's Earring",ear2="Merman's Earring",
        body="Haubergeon +1",hands="Dusk Gloves +1",ring1="Flame Ring",ring2="Flame Ring",
        back="Cerb. Mantle +1",waist="Potent Belt",legs="Valor Breeches",feet="Askar Gambieras"}

    sets.precast.WS.Acc = {
        head="Askar Zucchetto",neck="Chivalrous Chain",ear1="Merman's Earring",ear2="Merman's Earring",
        body="Haubergeon +1",hands="Dusk Gloves +1",ring1="Flame Ring",ring2="Thunder Ring",
        back="Cerb. Mantle +1",waist="Potent Belt",legs="Valor Breeches",feet="Askar Gambieras"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ring2="Saintly Ring +1",feet="Valor Leggings"})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {ring2="Saintly Ring +1",feet="Valor Leggings"})

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {ammo="Phantom Tathlum",
		neck="Prudence Torque",ear1="Moldavite Earring",ear2="Novio Earring",
		body="Corselet",hands="Dvt. Mitts +1",ring2="Saintly Ring +1",
		legs="Askar Dirs",feet="Valor Leggings"})
    
    sets.precast.WS['Atonement'] = {}
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {}
        
    sets.midcast.Enmity = {
        head="Valor Coronet",
        body="Valor Surcoat",hands="Askar Manopolas",ring1="Hercules' Ring",
        back="Cerb. Mantle +1",waist="Warwolf Belt",legs="Valor Breeches",feet="Askar Gambieras"}

    sets.midcast.Flash = set_combine(sets.midcast.Enmity, {})
    
    sets.midcast.Stun = sets.midcast.Flash
    
    sets.midcast.Cure = {
		head="Valor Coronet",neck="Healing Torque",ear1="Velocity Earring",ear2="Elusive Earring",
		body="Scp. Harness +1",hands="Dvt. Mitts +1",ring1="Saintly Ring+1",ring2="Saintly Ring +1",
		back="Bat Cape",waist="Volunteer's Belt",legs="Valor Breeches",feet="Valor Leggings"}

    sets.midcast['Enhancing Magic'] = {
		head="Valor Coronet",neck="Healing Torque",ear1="Velocity Earring",ear2="Elusive Earring",
		body="Scp. Harness +1",hands="Dvt. Mitts +1",ring1="Saintly Ring+1",ring2="Saintly Ring +1",
		back="Bat Cape",waist="Volunteer's Belt",legs="Valor Breeches",feet="Valor Leggings"}
    
    sets.midcast.Protect = {}
    sets.midcast.Shell = {}
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {
		head="Destrier Beret"}
    
    sets.resting = {
		waist="Hierarch Belt"}
    

    -- Idle sets
    sets.idle = {
        head="Wivre Mask +1",neck="Orochi Nodowa",ear1="Merman's Earring",ear2="Merman's Earring",
        body="Valor Surcoat",hands="Gallant Gauntlets",ring1="Merman's Ring",ring2="Merman's Ring",
        back="Lamia Mantle +1",waist="Warwolf Belt",legs="Valor Breeches",feet="Gallant Leggings"}

    --------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {main="Excalibur",sub="Ochain"} -- Ochain
    sets.MagicalShield = {main="Excalibur",sub="Aegis"} -- Aegis

    -- Basic defense sets.
        
    sets.defense.PDT = {
        head="Askar Zucchetto",neck="Orochi Nodowa",ear1="Velocity Earring",ear2="Elusive Earring",
        body="Dusk Jerkin +1",hands="Heavy Gauntlets",ring1="Crimson Ring",ring2="Spinel Ring",
        back="Cerb. Mantle +1",waist="Ninurta's Sash",legs="Dusk Trousers +1",feet="Askar Gambieras"}

    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.MDT = {
        head="Coral Visor +1",neck="Prudence Torque",ear1="Merman's Earring",ear2="Merman's Earring",
        body="Cor. Scale Mail +1",hands="Dusk Gloves +1",ring1="Minerva's Ring",ring2="Merman's Ring",
        back="Lamia Mantle +1",waist="Ninurta's Sash",legs="Coral Cuisses +1",feet="Askar Gambieras"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    sets.engaged = {
        head="Askar Zucchetto",neck="Chivalrous Chain",ear1="Merman's Earring",ear2="Merman's Earring",
        body="Assault Jerkin",hands="Dusk Gloves +1",ring1="Flame Ring",ring2="Thunder Ring",
        back="Amemet Mantle +1",waist="Velocious Belt",legs="Valor Breeches",feet="Dusk Ledelsens +1"}

    sets.engaged.Acc = {}

    sets.engaged.DW = {
        head="Askar Zucchetto",neck="Chivalrous Chain",ear1="Merman's Earring",ear2="Merman's Earring",
        body="Assault Jerkin",hands="Dusk Gloves +1",ring1="Flame Ring",ring2="Thunder Ring",
        back="Amemet Mantle +1",waist="Velocious Belt",legs="Valor Breeches",feet="Dusk Ledelsens +1"}

    sets.engaged.DW.Acc = {}
	
	sets.latent_refresh = {neck="Parade Gorget"}

	sets.latent_hp75 = {body="Dusk Jerkin"}
	
	sets.latent_hp50 = {body="Dusk Jerkin",neck="Orochi Nodowa",ring2="Hercules' Ring"}
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

function customize_melee_set(meleeSet)
	if (player.hpp < 50) then
		meleeSet = set_combine(meleeSet, sets.latent_hp50)
	elseif (player.hpp < 75) then
		meleeSet = set_combine(meleeSet, sets.latent_hp75)
	end
	return meleeSet
end
	
-- Modify the default melee set after it was constructed.

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
       
    return defenseSet
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        classes.CustomDefenseGroups:append('Kheshig Blade')
    end
    
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 16)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 16)
    elseif player.sub_job == 'RDM' then
        set_macro_page(1, 16)
    else
        set_macro_page(1, 16)
    end
end


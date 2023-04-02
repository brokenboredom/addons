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
    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Doom = buffactive.doom or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false

    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Evasion')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')

    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Sange'] = {legs="Mochizuki Chainmail"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Panther Mask",neck="Flower Necklace",
        body="Custom Vest",
        back="Rep. Army Mantle",waist="Warwolf Belt",legs="Luna Subligar",feet="Koga Kyahan"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {
        neck="Peacock Amulet",
        body="Scp. Harness +1",hands="Federation Tekko",ring1="Sniper's Ring +1",ring2="Sniper's Ring +1"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {}
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

    -- Snapshot for ranged
    sets.precast.RA = {ammo="Manji Shuriken"}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Bomb Core",
        head="Voyager Sallet",neck="Spike Necklace",ear1="Pixie Earring",ear2="Spike Earring",
        body="Haubergeon +1",hands="Custom F Gloves",ring1="Rajas Ring",ring2="Deft Ring +1",
        back="Amemet Mantle +1",waist="Warwolf Belt",legs="Byakko's Haidate",feet="Bounding Boots"}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {neck="Peacock Amulet"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Blade: Yu'] = set_combine(sets.precast.WS,
        {ammo="Mille. Sachet",
		ear2="Morion Earring +1",
		ring2="Diamond Ring",
		back="Rep. Army Mantle"})


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head="Panter Mask",
        hands="Dusk Gloves",
        waist="Velocious Belt",legs="Byakko's Haidate",feet="Fuma Sune-Ate"}

    sets.midcast.ElementalNinjutsu = {
        head="Kog. Hatsuburi +1",neck="Mohbwa Scarf +1",ear1="Moldavite Earring",ear2="Morion Earring +1",
        body="Scp. Harness +1",hands="Kog. Tekko +1",ring1="Diamond Ring",ring2="Diamond Ring",
        back="Bat Cape",waist="Koga Sarashi",legs="Byakko's Haidate",feet="Custom F Boots"}

    sets.midcast.NinjutsuDebuff = {ammo="Mille. Sachet",
        head="Ninja Hatsuburi",neck="Mohbwa Scarf +1",ear2="Morion Earring +1",
        hands="Kog. Tekko +1",ring1="Diamond Ring",ring2="Diamond Ring",
        waist="Koga Sarashi",feet="Koga Kyahan"}

    sets.midcast.NinjutsuBuff = {
	head="Panther Mask",ear1="Velocity Earring",ear2="Elusive Earring",
	body="Scp. Harness +1",hands="Dusk Gloves",
	back="Bat Cape",waist="Velocious Belt",legs="Byakko's Haidate",feet="Fuma Sune-Ate"}

    sets.midcast.RA = {
        head="Dobson Bandana",neck="Peacock Amulet",ear1="Drone Earring",ear2="Drone Earring",
        hands="Ninja Tekko",ring1="Sniper's Ring +1",ring2="Sniper's Ring +1",
        back="Amemet Mantle +1",legs="Ninja Hakama",feet="Ninja Kyahan"}

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {}
    
    -- Idle sets
    sets.idle = {ammo="Manji Shuriken",
        head="Panther Mask",neck="Peacock Amulet",ear1="Suppanomimi",ear2="Elusive Earring",
        body="Ninja Chainmail",hands="Kog. Tekko +1",ring1="Rajas Ring",ring2="Sniper's Ring +1",
        back="Amemet Mantle +1",waist="Velocious Belt",legs="Byakko's Haidate",feet="Ninja Kyahan"}
    
    -- Defense sets
    sets.defense.Evasion = {
        head="Wivre Mask +1",ear1="Velocity Earring",ear2="Elusive Earrring",
        body="Scp. Harness +1",hands="Rasetsu Tekko",ring1="Defending Ring",ring2="Beeline Ring",
        back="Bat Cape",waist="Koga Sarashi",legs="Fourth Schoss",feet="Arh. Sune-Ate +1"}

    sets.defense.MDT = {
        back="Lamia Mantle +1"}

    sets.Kiting = {feet=gear.MovementFeet}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Bomb Core",
        head="Panther Mask",neck="Peacock Amulet",ear1="Suppanomimi",ear2="Elusive Earring",
        body="Ninja Chainmail",hands="Dusk Gloves",ring1="Rajas Ring",ring2="Sniper's Ring +1",
        back="Amemet Mantle +1",waist="Velocious Belt",legs="Byakko's Haidate",feet="Fuma Sune-Ate"}
    sets.engaged.Acc = {ammo="Bomb Core",
        head="Panther Mask",neck="Peacock Amulet",ear1="Suppanomimi",ear2="Pixie Earring",
        body="Scp. Harness +1",hands="Federation Tekko",ring1="Rajas Ring",ring2="Sniper's Ring +1",
        back="Amemet Mantle +1",waist="Velocious Belt",legs="Byakko's Haidate",feet="Fuma Sune-Ate"}
    sets.engaged.Evasion = {ammo="Bomb Core",
        head="Wivre Mask +1",neck="Peacock Amulet",ear1="Velocity Earring",ear2="Elusive Earring",
        body="Scp. Harness +1",hands="Rasetsu Tekko",ring1="Rajas Ring",ring2="Sniper's Ring +1",
        back="Bat Cape",waist="Koga Sarashi",legs="Fourth Schoss",feet="Arh. Sune-Ate +1"}
		
    -- Custom melee group: High Haste (~20% DW)
    sets.engaged.HighHaste = {ammo="Qirmiz Tathlum",
        head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist="Patentia Sash",legs="Hachiya Hakama",feet="Manibozho Boots"}
    sets.engaged.Acc.HighHaste = {ammo="Qirmiz Tathlum",
        head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Mochizuki Chainmail",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Manibozho Boots"}
    sets.engaged.Evasion.HighHaste = {ammo="Qirmiz Tathlum",
        head="Whirlpool Mask",neck="Ej Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
        back="Yokaze Mantle",waist="Patentia Sash",legs="Hachiya Hakama",feet="Otronif Boots +1"}

    -- Custom melee group: Embrava Haste (7% DW)
    sets.engaged.EmbravaHaste = {ammo="Qirmiz Tathlum",
        head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Qaaxo Harness",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Manibozho Boots"}
    sets.engaged.Acc.EmbravaHaste = {ammo="Qirmiz Tathlum",
        head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Mochizuki Chainmail",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Manibozho Boots"}
    sets.engaged.Evasion.EmbravaHaste = {ammo="Qirmiz Tathlum",
        head="Whirlpool Mask",neck="Ej Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
        back="Yokaze Mantle",waist="Windbuffet Belt",legs="Hachiya Hakama",feet="Otronif Boots +1"}

    -- Custom melee group: Max Haste (0% DW)
    sets.engaged.MaxHaste = {ammo="Qirmiz Tathlum",
        head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Qaaxo Harness",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Manibozho Boots"}
    sets.engaged.Acc.MaxHaste = {ammo="Qirmiz Tathlum",
        head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Manibozho Boots"}
    sets.engaged.Evasion.MaxHaste = {ammo="Qirmiz Tathlum",
        head="Whirlpool Mask",neck="Ej Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
        back="Yokaze Mantle",waist="Windbuffet Belt",legs="Hachiya Hakama",feet="Otronif Boots +1"}

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {body="Iga Ningi +2"}
    sets.buff.Doom = {ring2="Saida Ring"}
    sets.buff.Yonin = {}
    sets.buff.Innin = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.Buff.Doom then
        equip(sets.buff.Doom)
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Buff.Migawari then
        idleSet = set_combine(idleSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    -- We have three groups of DW in gear: Hachiya body/legs, Iga head + Patentia Sash, and DW earrings
    
    -- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

    -- For high haste, we want to be able to drop one of the 10% groups.
    -- Basic gear hits capped delay (roughly) with:
    -- 1 March + Haste
    -- 2 March
    -- Haste + Haste Samba
    -- 1 March + Haste Samba
    -- Embrava
    
    -- High haste buffs:
    -- 2x Marches + Haste Samba == 19% DW in gear
    -- 1x March + Haste + Haste Samba == 22% DW in gear
    -- Embrava + Haste or 1x March == 7% DW in gear
    
    -- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste+March or 2x March
    -- 2x Marches + Haste
    
    -- So we want four tiers:
    -- Normal DW
    -- 20% DW -- High Haste
    -- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
    -- 0 DW - Max Haste
    
    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
        classes.CustomMeleeGroups:append('EmbravaHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end

			
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 20)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 20)
    else
        set_macro_page(1, 20)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
--Ionis Zones
--Anahera Blade (4 hit): 52
--Tsurumaru (4 hit): 49
--Kogarasumaru (or generic 450 G.katana) (5 hit): 40
--Amanomurakumo/Masamune 437 (5 hit): 46
--
--Non Ionis Zones:
--Anahera Blade (4 hit): 52
--Tsurumaru (5 hit): 24
--Kogarasumaru (5 hit): 40
--Amanomurakumo/Masamune 437 (5 hit): 46
--
--Aftermath sets
-- Koga AM1/AM2 = sets.engaged.Kogarasumaru.AM
-- Koga AM3 = sets.engaged.Kogarasumaru.AM3
-- Amano AM = sets.engaged.Amanomurakumo.AM
-- Using Namas Arrow while using Amano will cancel STPAM set

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
    mote_include_version = 2
	include('Mote-Include.lua')
	include('organizer-lib')
end


-- Setup vars that are user-independent.
function job_setup()

    update_melee_groups()


    state.YoichiAM = M(false, 'Cancel Yoichi AM Mode')
    -- list of weaponskills that make better use of otomi helm in low acc situations
    --wsList = S{'Tachi: Fudo', 'Tachi: Shoha'}

    gear.RAarrow = {name="Platinum Arrow"}
    --LugraWSList = S{'Tachi: Fudo', 'Tachi: Shoha', 'Namas Arrow'}

	state.Buff['Seigan'] = buffactive.seigan or false
    state.Buff.Sekkanoki = buffactive.sekkanoki or false
    state.Buff['Third Eye'] = buffactive['Third Eye'] or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Evasion', 'Riceball', 'StoreTP', 'Counter', 'Acc')
    state.HybridMode:options('Normal', 'Evasion')
    state.WeaponskillMode:options('Normal', 'StoreTP', 'Riceball')
    state.IdleMode:options('Normal')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('Normal', 'PDT')
    state.MagicalDefenseMode:options('MDT', 'Water', 'Fire', 'Thunder', 'Dark')
    
    -- Additional local binds
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
	send_command('bind !f9 gs c cycle WeaponskillMode')
    
    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
    
end

--[[
-- SC's
Rana > Shoha > Fudo > Kasha > Shoha > Fudo - light
Rana > Shoha > Fudo > Kasha > Rana > Fudo - dark

Kasha > Shoha > Fudo
Fudo > Kasha > Shoha > fudo
Shoha > Fudo > Kasha > Shoha > Fudo

--]]
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {
        head="myn. kabuto +1",
        hands="Saotome Kote",
    }
    sets.precast.JA['Warding Circle'] = {head="myn. kabuto +1"}
    sets.precast.JA['Third Eye'] = {legs="Saotome Haidate"}
    --sets.precast.JA['Blade Bash'] = {hands="Saotome Kote +2"}
    
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		head="genbu's kabuto",
		neck="temp. torque",
		body="kirin's osode",
		hands="myn. kote +1",
		ring1="moon ring",
		ring2="moon ring",
		back="shadow mantle",
		waist="corsette +1",
		feet="rutter sabatons",
	}

    	
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
	--base 31 storetp
    sets.precast.WS = {
        head="ace's helm",
		neck="Fotia Gorget",
		ear1="Brutal Earring", --1
		ear2="fowling Earring",
		body="hmn. domaru +1", --7
		hands="hachiman kote +1", --9
		ring1="Rajas Ring", --5
		ring2="sniper's Ring +1",
		back="Amemet Mantle +1",
		waist="Potent Belt",
		legs="hmn. hakama +1", --4
		feet="hmn. sune-ate +1", --5
    }
	--Riceball
	--+50-150 ATK and +2-9% Double Attack
	--22 storetp
	sets.precast.WS.Riceball = set_combine(sets.precast.WS, {
        head="Roshi Jinpachi",
		hands="myn. kote +1",
    })
	--base 31 storetp
    sets.precast.WS.StoreTP = sets.precast.WS
	
    sets.precast.WS.Acc = sets.precast.WS
	
	--RANA
	--3hits Acc varies so wear Acc
	sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {
		body="Haubergeon +1",
	})
	sets.precast.WS['Tachi: Rana'].StoreTP = set_combine(sets.precast.WS['Tachi: Rana'], {
		hands="hachiman kote +1", --9
		legs="hmn. hakama +1", --4
		feet="hmn. Sune-ate +1", --6
	})
	sets.precast.WS['Tachi: Rana'].Riceball = set_combine(sets.precast.WS['Tachi: Rana'], sets.precast.WS.Riceball)
	
	--NAMAS
	--STR/AGI/StoreTP
    sets.precast.WS['Namas Arrow'] = {
        ammo=gear.RAarrow,
        head="Saotome kabuto",
		neck="Fotia Gorget",
		ear1="Drone Earring",
		ear2="Drone Earring",
		body="hmn. domaru +1",
		hands="hachiman kote +1",
		ring1="Rajas Ring",
		ring2="Harmonius Ring",
		back="Amemet Mantle +1",
		waist="Warwolf Belt",
		legs="Hmn. Hakama +1",
		feet="hmn. sune-ate +1",
    }
	--Called during macros
	sets.precast.WS['Namas Arrow'].StoreTP = set_combine(sets.precast.WS['Namas Arrow'], sets.precast.WS.StoreTP)
    sets.precast.WS['Namas Arrow'].Acc = set_combine(sets.precast.WS['Namas Arrow'], {
		ring1="merman's ring",
		ring2="merman's ring",
	})
	
	--SIDEWINDER
	--4x DMG: Acc pls
	sets.precast.WS['Sidewinder'] = sets.precast.WS['Namas Arrow'].Acc
	sets.precast.WS['Sidewinder'].StoreTp = sets.precast.WS['Sidewinder'].Acc
	sets.precast.WS['Sidewinder'].Acc = sets.precast.WS['Sidewinder'].Acc
    
	--APEX
	--4x DMG: Acc pls
    sets.precast.WS['Apex Arrow'] = sets.precast.WS['Sidewinder']
	sets.precast.WS['Apex Arrow'].StoreTP = sets.precast.WS['Apex Arrow']
	sets.precast.WS['Apex Arrow'].Acc = sets.precast.WS['Apex Arrow']
	
	--JINPU
	--All other ws are physical despite their description
	--STR/MAB
    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS,{ear2="Moldavite Earring"})
    
	--PENTA
	sets.precast.WS['Penta Thrust'] = sets.precast.WS.acc
	
    -- Midcast Sets
    sets.midcast.FastRecast = {}
	
	--RA
	--Lets add some storeTP for good measure
	sets.midcast.RA = {
		head="Wivre Mask +1",
		neck="Peacock Amulet",
		ear1="Brutal Earring", --StoreTP +1
		ear2="Elusive Earring",
		body="Shm. hara-ate",
		hands="seiryu's kote",
		ring1="merman's ring",
		ring2="merman's ring",
		back="Shadow Mantle",
		waist="scouter's rope",
		legs="hmn. hakama +1",
		feet="hmn. sune-ate +1",
	}
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
    }
    
    sets.idle = {
		head="genbu's kabuto",
		neck="Orochi Nodowa +1",
		ear1="merman's Earring",
		ear2="merman's Earring",
		body="avalon breastplate",
		hands="Rasetsu Tekko +1",
		ring2="defending ring",
		ring1="merman's Ring",
		back="Shadow Mantle",
		waist="scouter's rope",
		legs="Byakko's Haidate",
		feet="suzaku's sune-ate",
	}

    sets.idle.Yoichi = set_combine(sets.idle, {
    	ammo=gear.RAarrow
    })
    
    -- Engaged sets
    sets.engaged = {
		head="ace's helm",
		neck="justice torque",
		ear1="Brutal Earring",
		ear2="fowling Earring",
		body="haubergeon +1",
		hands="Dusk Gloves +1",
		ring1="Rajas Ring",
		ring2="defending ring",
		back="shadow Mantle",
		waist="Velocious Belt",
		legs="Byakko's Haidate",
		feet="Dusk Ledelsens +1",
	}
    sets.engaged.Evasion = {
		head="Wivre Mask +1",
		neck="evasion torque",
		ear1="Elusive Earring",
		ear2="Elusive Earring",
		body="Scp. Harness +1",
		hands="Rasetsu Tekko +1",
		ring1="Rajas Ring",
		ring2="defending ring",
		back="shadow mantle",
		waist="scouter's rope",
		legs="Byakko's Haidate",
		feet="Rst. Sune-Ate +1",
	}
	--4-hit
	sets.engaged.Riceball = {
		--sub="rose strap", --4
		head="Roshi Jinpachi",
		neck="Chivalrous Chain", --1
		ear1="Brutal Earring", --1
		ear2="fowling Earring",
		body="hmn. domaru +1", --7
		hands="myn. kote +1",
		ring1="Rajas Ring", --5
		ring2="defending ring",
		back="Shadow Mantle",
		waist="Velocious Belt",
		legs="hmn. hakama +1", --4
		feet="hmn. sune-ate +1", --5
	}
	sets.engaged.Riceball.Evasion = set_combine(sets.engaged.Riceball, {
		neck="Evasion Torque",
		body="Scp. Harness +1",
		feet="Rst. Sune-Ate +1",
	})
	sets.engaged.Counter = {
		head="Rst. Jinpachi +1",
		neck="Chivalrous Chain",
		ear1="Brutal Earring",
		ear2="Avenger's Earring",
		body="Rasetsu Samue +1",
		hands="Rasetsu Tekko +1",
		ring1="Rajas Ring",
		ring2="defending ring",
		back="Shadow Mantle",
		waist="Velocious Belt",
		legs="Rst. Hakama +1",
		feet="Rst. Sune-Ate +1",
	}
	----3-hit
	sets.engaged.StoreTP = {
		--sub="rose strap", --4
		head="ace's helm",
		neck="Chivalrous Chain", --1
		ear1="Brutal Earring", --1
		ear2="fowling Earring",
		body="hmn. domaru +1", --7
		hands="hachiman Kote +1",
		ring1="Rajas Ring", --5
		ring2="defending ring",
		back="Shadow Mantle",
		waist="Velocious Belt",
		legs="byakko's haidate", --4
		feet="hmn. sune-ate +1", --5
	}
    sets.engaged.Acc = set_combine(sets.engaged, {
		body="haubergeon +1",
		waist="potent belt",
		hands="noritsune kote",
	})
    
    sets.engaged.Yoichi = set_combine(sets.engaged, { 
        ammo=gear.RAarrow
    })
	sets.engaged.Yoichi.Evasion = set_combine(sets.engaged.Yoichi, { 
        head="Wivre Mask +1",
		ear1="Elusive Earring",
		ear2="Elusive Earring",
		body="Scp. Harness +1",
		hands="Rasetsu Tekko +1",
		back="boxer's mantle",
		waist="scouter's rope",
		feet="Rst. Sune-Ate +1",
    })
    sets.engaged.Yoichi.StoreTP = set_combine(sets.engaged.Yoichi, {
		legs="Hmn. Hakama +1",
		feet="hmn. sune-ate +1",
		hands="hachiman kote +1",
		body="Shm. Hara-ate",
		ear1="Brutal Earring",
		neck="Chivalrous Chain",
	})
    sets.engaged.Yoichi.Acc = set_combine(sets.engaged.Yoichi.StoreTP, {
		head="Dusk Mask",
		neck="Peacock Amulet",
		body="Scp. Harness +1",
		waist="Potent Belt",
	})
    
    sets.engaged.Amanomurakumo = set_combine(sets.engaged, {
    })
    sets.engaged.Amanomurakumo.AM = set_combine(sets.engaged, {
    })
    
    sets.engaged.Kogarasumaru = set_combine(sets.engaged, {
    })
    sets.engaged.Kogarasumaru.AM = set_combine(sets.engaged, {
    })
    sets.engaged.Kogarasumaru.AM3 = set_combine(sets.engaged, {
    })
    
	-- Defense sets
    sets.defense.PDT = {
		head="Arh. Jinpachi +1",
		body="Arhat's Gi +1",
		ring1="jelly ring",
		ring2="defending ring",
		back="Shadow Mantle",
	}
    --25% MDT
	sets.defense.MDT = {
		head="coral visor +1", --2
		ear1="merman's Earring", --2
		ear2="merman's Earring", --2
		body="avalon breastplate", --4
		hands="coral fng. gnt. +1", --2
		ring1="merman's Ring", --4
		ring2="defending ring",
		back="lamia mantle +1",
		legs="coral cuisses +1", --3
		feet="coral greaves +1", --2
	}
	sets.defense.Water = set_combine(sets.defense.MDT,{
		head="genbu's kabuto",
		neck="Orochi Nodowa +1",
		ear1="Star Earring",
		ear2="Star Earring",
		ring1="Sapphire Ring",
		ring2="Sapphire Ring",
		body="Scp. Harness +1",
		back="Lamia's Mantle +1",
	})
	sets.defense.Fire = set_combine(sets.defense.MDT,{
		head="Black Ribbon",
		neck="Orochi Nodowa +1",
		ear1="Star Earring",
		ear2="Star Earring",
		ring1="crimson ring",
		ring2="Harmonius Ring",
		feet="suzaku's sune-ate",
		back="Lamia's Mantle +1",
	})
	sets.defense.Thunder = set_combine(sets.defense.MDT, {
		legs="byakko's haidate",
		ring1="adroit Ring +1",
		neck="Orochi Nodowa +1",
		head="black ribbon",
	})
	sets.defense.Dark = set_combine(sets.defense.MDT,{
		neck="Orochi Nodowa +1",
		ring1="lava's Ring",
		ring2="kusha's Ring",
		body="Scp. Harness +1",
		back="Lamia's Mantle +1",
	})
    
    sets.Kiting = {feet="Danzo Sune-ate"}
	
	--Used for PDT Seigan
    sets.thirdeye = {
		head="Arh. Jinpachi +1",
		body="Arhat's Gi +1",
		ring1="jelly ring",
		ring2="defending ring",
		back="Shadow Mantle",
		legs="Saotome Haidate",
		feet="Rst. Sune-Ate +1",
	}
	--All other Seigan
	--Counter/Evasion
    sets.seigan = {
		legs="Saotome Haidate",
	}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = true
    end
end

function job_precast(spell, action, spellMap, eventArgs)

end
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Seigan" then
        -- Third Eye gearset is only called if we're in PDT mode
        if state.HybridMode.value == 'PDT' or state.PhysicalDefenseMode.value == 'PDT' then
            equip(sets.thirdeye)
        else
            equip(sets.seigan)
        end
    end
    update_am_type(spell)
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
	end
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff['Seigan'] then
        if state.PhysicalDefenseMode.value == 'PDT' then
    	    meleeSet = set_combine(meleeSet, sets.thirdeye)
        else
            meleeSet = set_combine(meleeSet, sets.seigan)
        end
    end
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_status_change(newStatus, oldStatus, eventArgs)
    if ( newStatus == 'Engaged' ) then
        if player.inventory['Kabura Arrow'] then
            gear.RAarrow.name = 'Kabura Arrow'
        elseif player.equipment.ammo == 'empty' then
            add_to_chat(122, 'No more Arrows!')
        end
	end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
    	state.Buff[buff] = gain
        handle_equipping_gear(player.status)
    end

    if S{'aftermath'}:contains(buff:lower()) then
        classes.CustomMeleeGroups:clear()
       
        if player.equipment.main == 'Amanomurakumo' and state.YoichiAM.value then
            classes.CustomMeleeGroups:clear()
        elseif player.equipment.main == 'Kogarasumaru'  then
            if buff == "Aftermath: Lv.3" and gain or buffactive['Aftermath: Lv.3'] then
                classes.CustomMeleeGroups:append('AM3')
            end
        elseif buff == "Aftermath" and gain or buffactive.Aftermath then
            classes.CustomMeleeGroups:append('AM')
        end
    end
    
    if not midaction() then
        handle_equipping_gear(player.status)
    end

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_melee_groups()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function update_melee_groups()
    classes.CustomMeleeGroups:clear()

    if player.equipment.main == 'Amanomurakumo' and state.YoichiAM.value then
        -- prevents using Amano AM while overriding it with Yoichi AM
        classes.CustomMeleeGroups:clear()
    elseif player.equipment.main == 'Kogarasumaru' then
        if buffactive['Aftermath: Lv.3'] then
            classes.CustomMeleeGroups:append('AM3')
        end
    else
        if buffactive['Aftermath'] then
            classes.CustomMeleeGroups:append('AM')
        end
    end
end
-- call this in job_post_precast() 
function update_am_type(spell)
    if spell.type == 'WeaponSkill' and spell.skill == 'Archery' and spell.english == 'Namas Arrow' then
        if player.equipment.main == 'Amanomurakumo' then
            -- Yoichi AM overwrites Amano AM
            state.YoichiAM:set(true)
        end
    else
        state.YoichiAM:set(false)
    end
end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    	set_macro_page(1, 12)
end

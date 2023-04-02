-- Owner: AlanWarren, aka ~ Orestes 
-- current file resides @ https://github.com/AlanWarren/gearswap
--[[ 

 === Notes ===
 -- Set format is as follows:
    sets.midcast.RA.[CustomClass][CombatForm][CombatWeapon][RangedMode][CustomRangedGroup]
    ex: sets.midcast.RA.SAM.Bow.Mid.SamRoll = {}
    you can also append CustomRangedGroups to each other
 
 -- These are the available sets per category
 -- CustomClass = SAM
 -- CombatForm = DW
 -- CombatWeapon = weapon name, ex: Yoichinoyumi  (you can make new sets for any ranged weapon)
 -- RangedMode = Normal, Mid, Acc
 -- CustomRangedGroup = SamRoll

 -- SamRoll is applied automatically whenever you have the roll on you. 
 -- SAM is used when you're RNG/SAM 

 * Auto RA
 - You can use the built in hotkey (CTRL -) or create a macro. (like below) Note "AutoRA" is case sensitive
   /console gs c toggle AutoRA
 - You have to shoot once after toggling autora for it to begin.
 - AutoRA will use weaponskills @ 1000TP, depending on which weapon you're using. However, this will only
   work if you set gear.Gun or gear.Bow to the weapon you're using. You also have to specify the desired
   ws it should use, with the settings auto_gun_ws and auto_bow_ws. 
 
 === Helpful Commands ===
    //gs validate
    //gs showswaps
    //gs debugmode

--]]
 
function get_sets()
        mote_include_version = 2
        -- Load and initialize the include file.
        include('Mote-Include.lua')
        include('organizer-lib')
end

-- setup vars that are user-independent.
function job_setup()

	

end
 
-- setup vars that are user-dependent. 
function user_setup()
        -- Options: Override default values
        state.OffenseMode:options('Normal', 'Evasion', 'Kraken')
        state.RangedMode:options('Normal', 'Atk', 'Acc')
        state.HybridMode:options('Normal', 'PDT')
        state.IdleMode:options('Normal', 'PDT')
        state.WeaponskillMode:options('Normal', 'Atk', 'Acc')
        state.PhysicalDefenseMode:options('PDT')
        state.MagicalDefenseMode:options('MDT')
 
        state.Buff.Barrage = buffactive.Barrage or false
        state.Buff.Camouflage = buffactive.Camouflage or false
        state.Buff.Overkill = buffactive.Overkill or false
		state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
		state.Buff.Sharpshot = buffactive.Sharpshot or false


        state.AutoRA = M{['description']='Auto RA', 'Normal', 'Shoot', 'WS' }
        auto_gun_ws = "Split Shot"
        auto_bow_ws = "Sidewinder"


        gear.Gun = "Culverin"
        gear.Bow = "Yoichinoyumi"
        --gear.Bow = "Hangaku-no-Yumi"
       
	   --offhand weapon checks to return true
        rng_sub_weapons = S{}
        
        sam_sj = player.sub_job == 'SAM' or false

      	DefaultAmmo = {[gear.Bow] = "Kabura Arrow", [gear.Gun] = "Cannon shell"}
	    U_Shot_Ammo = {[gear.Bow] = "Cmb.Cst. Arrow", [gear.Gun] = "Heavy shell"} 

        get_combat_form()
        get_custom_ranged_groups()
        select_default_macro_book()

        send_command('bind f9 gs c cycle RangedMode')
        send_command('bind !f9 gs c cycle OffenseMode')
        send_command('bind ^f9 gs c cycle HybridMode')
        send_command('bind ^] gs c cycle WeaponskillMode')
        send_command('bind ^- gs c cycle AutoRA')
        send_command('bind ^[ input /lockstyle on')
        send_command('bind ![ input /lockstyle off')
        
        -- Testing 
        --windower.register_event('incoming text', detect_cor_rolls)
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind f9')
    send_command('unbind ^f9')
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind !=')
    send_command('unbind ^=')
    send_command('unbind @=')
    send_command('unbind ^-')
end
 
function init_gear_sets()
        -- Augmented gear

        sets.Organizer = {
            main="Culverin",
            range="Yoichinoyumi",
        }
        -- Misc. Job Ability precasts
        sets.precast.JA['Bounty Shot'] = {}
        sets.precast.JA['Double Shot'] = {}
        sets.precast.JA['Camouflage'] = {body="Hunter's Jerkin",}
        sets.precast.JA['Sharpshot'] = {legs="Hunter's Braccae",}
        sets.precast.JA['Velocity Shot'] = {}
        sets.precast.JA['Scavenge'] = {feet="Hunter's Socks"}
		sets.precast.JA['Shadowbind'] = {hands="Hunter's Bracers"}
		
		--STR/RATK
        sets.precast.JA['Eagle Eye Shot'] = set_combine(sets.midcast.RA.Yoichinoyumi, {})
        sets.precast.JA['Eagle Eye Shot'].Atk = set_combine(sets.precast.JA['Eagle Eye Shot'], {})
        sets.precast.JA['Eagle Eye Shot'].Acc = set_combine(sets.precast.JA['Eagle Eye Shot'].Atk, {})

        sets.precast.FC = {}
        sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})
        
        sets.idle = {
            head="Hunter's Beret",
			neck="Jeweled Collar",
			ear1="Star Earring",
			ear2="Star Earring",
			body="Kyudogi",
			hands="Prt. Bangles",
			ring1="Adroit Ring +1",
			ring2="Omniscient Ring",
			back="Shadow Mantle",
			waist="Survival Belt",
			legs="Prince's Slops",
			feet="Trotter Boots",
		}
        sets.idle.Regen = set_combine(sets.idle, {})
        sets.idle.PDT = set_combine(sets.idle, {})
 
        -- Engaged sets
        sets.engaged =  {
            head="Walahra Turban",
			neck="Peacock Amulet",
			ear1="Brutal Earring",
			ear2="Elusive Earring",
			body="Kyudogi",
			hands="Dusk Gloves",
			ring1="Harmonius Ring",
			ring2="Rajas Ring",
			back="Shadow Mantle",
			waist="Velocious Belt",
			legs="Prince's Slops",
			feet="Dusk Ledelsens",
        }
        sets.engaged.Evasion =  {
            head="Dusk Mask",
			neck="Peacock Amulet",
			ear1="Elusive Earring",
			ear2="Elusive Earring",
			body="Kyudogi",
			hands="Scout's bracers",
			ring1="Harmonius Ring",
			ring2="Rajas Ring",
			back="Shadow Mantle",
			waist="Survival Belt",
			legs="Prince's Slops",
			feet="Dance Shoes +1",
        }

        sets.engaged.Kraken = {
            head="Dusk Mask",
			neck="Peacock Amulet",
			ear1="Elusive Earring",
			ear2="Elusive Earring",
			body="Narasimha's Vest",
			hands="Dusk Gloves",
			ring1="Sniper's Ring +1",
			ring2="Rajas Ring",
			back="Shadow Mantle",
			waist="Potent Belt",
			legs="Prince's Slops",
			feet="Dusk Ledelsens",
        }
        sets.engaged.Kraken.PDT = set_combine(sets.engaged.Kraken, { })

        sets.engaged.DW = set_combine(sets.engaged, {})
		sets.engaged.DW.Evasion = set_combine(sets.engaged.Evasion, {})
		sets.engaged.DW.Kraken = set_combine(sets.engaged.Kraken, {})


        ------------------------------------------------------------------
        -- Preshot / Snapshot sets
        ------------------------------------------------------------------
        sets.precast.RA = {
			head="Hunter's Beret",
		}
        
        ------------------------------------------------------------------
        -- Default Base Gear Sets for Ranged Attacks. Geared for Gun
        ------------------------------------------------------------------
		
        sets.midcast.RA = { 
            head="Hunter's Beret",
			neck="Peacock Amulet",
			ear1="Drone Earring",
			ear2="Drone Earring",
			body="Kyudogi",
			hands="Scout's bracers",
			ring1="Dragon Ring",
			ring2="Dragon Ring",
			back="Amemet Mantle +1",
			waist="Potent Belt",
			legs="Magna F Chausses",
			feet="Hunter's Socks",
        }
        sets.midcast.RA.Acc =  {
			head="Hunter's Beret",
			neck="Peacock amulet",
			ear1="Drone Earring",
			ear2="Drone Earring",
			body="Hunter's Jerkin",
			hands="Scout's bracers",
			ring1="Dragon Ring",
			ring2="Dragon Ring",
			back="Amemet Mantle +1",
			waist="Potent Belt",
			legs="Magna F Chausses",
			feet="Hunter's Socks",
		}
		sets.midcast.RA.Atk = sets.midcast.RA
    
        -- Samurai Roll sets 
        sets.midcast.RA.SamRoll = set_combine(sets.midcast.RA, {})
        sets.midcast.RA.Atk.SamRoll = set_combine(sets.midcast.RA.SamRoll, {})
        sets.midcast.RA.Acc.SamRoll = set_combine(sets.midcast.RA.Atk.SamRoll, {})
        
        -- SAM Subjob
        sets.midcast.RA.SAM = sets.midcast.RA
        sets.midcast.RA.SAM.Atk = set_combine(sets.midcast.RA.SAM, {})
        sets.midcast.RA.SAM.Acc = set_combine(sets.midcast.RA.SAM.Atk, {})

        -- Samurai Roll for /sam, assume we're using a staff
        sets.midcast.RA.SAM.SamRoll = set_combine(sets.midcast.RA.SAM, {})
        sets.midcast.RA.SAM.Atk.SamRoll = set_combine(sets.midcast.RA.SAM.Atk, {})
        sets.midcast.RA.SAM.Acc.SamRoll = set_combine(sets.midcast.RA.SAM.Acc, {})

        -- Bow base set. Only works with autoRA
        sets.midcast.RA.Yoichinoyumi = {
            head="Hunter's Beret",
			neck="Ranger's Necklace",
			ear1="Drone Earring",
			ear2="Drone Earring",
			body="Kyudogi",
			hands="Jaridah Bazubands",
			ring1="Harmonius Ring",
			ring2="Rajas Ring",
			back="Amemet Mantle +1",
			waist="Potent Belt",
			legs="Magna F Chausses",
			feet="Hunter's Socks",
        }
        sets.midcast.RA.Yoichinoyumi.Atk = set_combine(sets.midcast.RA.Yoichinoyumi, {})
        sets.midcast.RA.Yoichinoyumi.Acc = set_combine(sets.midcast.RA.Yoichinoyumi, {
			neck="Peacock amulet",
			body="Hunter's Jerkin",
			ring1="Dragon Ring",
			ring2="Dragon Ring",
		})
       
        -- Bow Sam roll
        sets.midcast.RA.Yoichinoyumi.SamRoll = set_combine(sets.midcast.RA.Yoichinoyumi, {})
        sets.midcast.RA.Yoichinoyumi.Atk.SamRoll = set_combine(sets.midcast.RA.Yoichinoyumi.SamRoll, {})
        sets.midcast.RA.Yoichinoyumi.Acc.SamRoll = set_combine(sets.midcast.RA.Yoichinoyumi.Atk.SamRoll, {})
        
        -- Sam SJ / Bow 
        sets.midcast.RA.SAM.Yoichinoyumi = set_combine(sets.midcast.RA.SAM, {})
        sets.midcast.RA.SAM.Yoichinoyumi.Atk = set_combine(sets.midcast.RA.SAM.Atk, {})
        sets.midcast.RA.SAM.Yoichinoyumi.Acc = set_combine(sets.midcast.RA.SAM.Acc, {})

        -- Sam SJ / Bow / Sam's Roll
        sets.midcast.RA.SAM.Yoichinoyumi.SamRoll = set_combine(sets.midcast.RA.SAM.Yoichinoyumi, {})

        sets.midcast.RA.SAM.Yoichinoyumi.Atk.SamRoll = set_combine(sets.midcast.RA.SAM.Yoichinoyumi.Atk, {})
        sets.midcast.RA.SAM.Yoichinoyumi.Acc.SamRoll = set_combine(sets.midcast.RA.SAM.Yoichinoyumi.Acc, {})


        -- Weaponskill sets 
		--Default is Marksmanship (All AGI)
        sets.precast.WS = {
            head="Empress Hairpin",
			neck="Ranger's Necklace",
			ear1="Drone Earring",
			ear2="Drone Earring",
			body="Kyudogi",
			hands="Jaridah Bazubands",
			ring1="Harmonius Ring",
			ring2="Rajas Ring",
			back="Amemet Mantle +1",
			waist="Survival Belt",
			legs="Mgn. F Chausses",
			feet="Bounding Boots",
        }
		sets.precast.WS.Bow = {
			head="Hunter's Beret",
			neck="Ranger's Necklace",
			ear1="Drone Earring",
			ear2="Drone Earring",
			body="Kyudogi",
			hands="Alkyoneus's Brc.",
			ring1="Harmonius Ring",
			ring2="Rajas Ring",
			back="Amemet Mantle +1",
			waist="Potent Belt",
			legs="Magna F Chausses",
			feet="Hunter's Socks",
		}
        sets.precast.WS.Atk = set_combine(sets.precast.WS, {})
        sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
        sets.precast.WS.Bow.Atk = set_combine(sets.precast.WS, {})
		
		sets.precast.WS.Mab = {
			head="Sinister Mask",
			neck="Mohbwa Scarf +1",
			ear1="Morion Earring +1",
			ear2="Moldavite Earring",
			body="Black Cotehardie",
			hands="Wood Gloves",
			ring1="Omniscient Ring",
			ring2="Rajas Ring",
			legs="Magic Cuisses",
			feet="Mgn. F Ledelsens",
		}
		S{"Cyclone", "Gust Slash",}
        
        -- SLUG SHOT
        sets.SlugShot = {}
        sets.precast.WS['Slug Shot'] = set_combine(sets.precast.WS, sets.SlugShot)
        sets.precast.WS['Slug Shot'].Atk = set_combine(sets.precast.WS.Atk, sets.SlugShot)
        sets.precast.WS['Slug Shot'].Acc = set_combine(sets.precast.WS.Acc, sets.SlugShot)

        -- SIDEWINDER
        sets.Sidewinder = {}
        sets.precast.WS['Sidewinder'] = set_combine(sets.precast.WS.Bow, sets.Sidewinder)
        sets.precast.WS['Sidewinder'].Atk = set_combine(sets.precast.WS.Bow.Atk, sets.Sidewinder)
        sets.precast.WS['Sidewinder'].Acc = set_combine(sets.precast.WS.Acc, sets.Sidewinder)
		
		--NAMAS
        sets.precast.WS['Namas Arrow'] = {}
        sets.precast.WS['Namas Arrow'] = set_combine(sets.precast.WS.Bow, sets.Sidewinder)
        sets.precast.WS['Namas Arrow'].Atk = set_combine(sets.precast.WS.Bow.Atk, sets.Sidewinder)
        sets.precast.WS['Namas Arrow'].Acc = set_combine(sets.precast.WS.Acc, sets.Sidewinder)
		
        -- Resting sets
        sets.resting = {}
       
        -- Defense sets
        sets.defense.PDT = set_combine(sets.idle, {})
        sets.defense.MDT = set_combine(sets.idle, {})
        sets.Kiting = {feet="Trotter Boots"}
       
        sets.buff.Barrage = sets.midcast.RA.Acc
        -- placeholder until I can get to it
        sets.buff.Barrage.Atk = sets.buff.Barrage
        sets.buff.Barrage.Acc = sets.buff.Barrage

        sets.buff.Camouflage =  {body="Hunter's Jerkin"}

end

function job_pretarget(spell, action, spellMap, eventArgs)
    -- If autora enabled, use WS automatically at 100+ TP
    if spell.action_type == 'Ranged Attack' then
        if player.tp >= 1000 and state.AutoRA.value == 'WS' and not buffactive.amnesia then
            cancel_spell()
            use_weaponskill()
        end
    end
end 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
 
function job_precast(spell, action, spellMap, eventArgs)
        
        if state.Buff[spell.english] ~= nil then
            state.Buff[spell.english] = true
        end
        --add_to_chat(8, state.CombatForm)
        if sam_sj then
            classes.CustomClass = 'SAM'
        end

        if spell.action_type == 'Ranged Attack' and player.equipment.range == gear.Bow then
            state.CombatWeapon:set('Bow')
        end
        -- add support for RangedMode toggles to EES
        if spell.english == 'Eagle Eye Shot' then
            classes.JAMode = state.RangedMode.value
        end
        -- Safety checks for weaponskills 
        if spell.type:lower() == 'weaponskill' then
            if player.tp < 1000 then
                    eventArgs.cancel = true
                    return
            end
            if ((spell.target.distance >8 and spell.skill ~= 'Archery' and spell.skill ~= 'Marksmanship') or (spell.target.distance >21)) then
                -- Cancel Action if distance is too great, saving TP
                add_to_chat(122,"Outside WS Range! /Canceling")
                eventArgs.cancel = true
                return
            
            elseif state.DefenseMode.value ~= 'None' then
                -- Don't gearswap for weaponskills when Defense is on.
                eventArgs.handled = true
            end
        end
        -- Ammo checks
        check_ammo(spell, action, spellMap, eventArgs)

end
 
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
-- This is where you place gear swaps you want in precast but applied on top of the precast sets
function job_post_precast(spell, action, spellMap, eventArgs)
    if state.Buff.Camouflage then
        equip(sets.buff.Camouflage)
	end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, action, spellMap, eventArgs)

end

 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- autora
    --if state.AutoRA.value ~= 'Normal' then
    --    use_ra(spell)
    --end

    if state.Buff[spell.name] ~= nil then
        state.Buff[spell.name] = not spell.interrupted or buffactive[spell.english]
    end

end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    --if S{"courser's roll"}:contains(buff:lower()) then
    --if string.find(buff:lower(), 'samba') then

    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
        handle_equipping_gear(player.status)
    end
    if buff == 'Velocity Shot' and gain then
        windower.send_command('wait 290;input /echo **VELOCITY SHOT** Wearing off in 10 Sec.')
    elseif buff == 'Double Shot' and gain then
        windower.send_command('wait 90;input /echo **DOUBLE SHOT OFF**;wait 90;input /echo **DOUBLE SHOT READY**')
    elseif buff == 'Decoy Shot' and gain then
        windower.send_command('wait 170;input /echo **DECOY SHOT** Wearing off in 10 Sec.];wait 120;input /echo **DECOY SHOT READY**')
    end

    if  buff == "Samurai Roll" or buff == "Courser's Roll" or string.find(buff:lower(), 'flurry') then
        classes.CustomRangedGroups:clear()

        if (buff == "Samurai Roll" and gain) or buffactive['Samurai Roll'] then
            classes.CustomRangedGroups:append('SamRoll')
        end
       
    end

    if buff == "Camouflage" then
        if gain then
            equip(sets.buff.Camouflage)
            disable('body')
        else
            enable('body')
        end
    end

    if buff == "Camouflage" or buff == "Overkill" or buff == "Samurai Roll" or buff == "Courser's Roll" then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end
 
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
    --select_earring()
end
 
function customize_idle_set(idleSet)
    if state.HybridMode.value == 'PDT' then
        state.IdleMode.value = 'PDT'
    elseif state.HybridMode.value ~= 'PDT' then
        state.IdleMode.value = 'Normal'
    end
	if state.Buff.Camouflage then
		idleSet = set_combine(idleSet, sets.buff.Camouflage)
	end
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    return idleSet
end
 
function customize_melee_set(meleeSet)
    if state.Buff.Camouflage then
    	meleeSet = set_combine(meleeSet, sets.buff.Camouflage)
    end
    return meleeSet
end
 
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == "Engaged" and player.equipment.range == gear.Bow then
         state.CombatWeapon:set('Bow')
    end

    if camo_active() then
        disable('body')
    else
        enable('body')
    end
end
 

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
end
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    get_combat_form()
    get_custom_ranged_groups()
    sam_sj = player.sub_job == 'SAM' or false
    -- called here incase buff_change failed to update value
    state.Buff.Camouflage = buffactive.camouflage or false

    if camo_active() then
        disable('body')
    else
        enable('body')
    end
end
 
---- Job-specific toggles.
--function job_toggle_state(field)
--    if field:lower() == 'autora' then
--        state.AutoRA = not state.AutoRA
--        return state.AutoRA
--    end
--end
 
---- Request job-specific mode lists.
---- Return the list, and the current value for the requested field.
--function job_get_option_modes(field)
--    if field:lower() == 'autora' then
--        return state.AutoRA
--    end
--end
-- 
---- Set job-specific mode values.
---- Return true if we recognize and set the requested field.
--function job_set_option_mode(field, val)
--    if field:lower() == 'autora' then
--        state.AutoRA = val
--        return true
--    end
--end
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    if state.AutoRA.value ~= 'Normal' then
        msg = '[Auto RA: ON]['..state.AutoRA.value..']'
    else
        msg = '[Auto RA: OFF]'
    end

    add_to_chat(122, 'Ranged: '..state.RangedMode.value..'/'..state.HybridMode.value..', WS: '..state.WeaponskillMode.value..', '..msg)
    
    eventArgs.handled = true
 
end
-- Special WS mode for Sam subjob
function get_custom_wsmode(spell, spellMap, ws_mode)
    if spell.skill == 'Archery' or spell.skill == 'Marksmanship' then
        if player.sub_job == 'SAM' then
            return 'SAM'
        end
		if state.Buff['Unlimited Shot'] or state.Buff.Sharpshot then
			return 'Atk'
		end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()
    if S{'NIN', 'DNC'}:contains(player.sub_job) and rng_sub_weapons:contains(player.equipment.sub) then
        state.CombatForm:set("DW")
    else
        state.CombatForm:reset()
    end
end

function get_custom_ranged_groups()
	classes.CustomRangedGroups:clear()
    
    if buffactive['Samurai Roll'] then
        classes.CustomRangedGroups:append('SamRoll')
    end

end

function use_weaponskill()
    if player.equipment.range == gear.Bow then
        send_command('input /ws "'..auto_bow_ws..'" <t>')
    elseif player.equipment.range == gear.Gun then
        send_command('input /ws "'..auto_gun_ws..'" <t>')
    end
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Auto RA' then
        if newValue ~= 'Normal' then
            send_command('@wait 2.5; input /ra <t>')
        end
    end
end

function use_ra(spell)
    
    local delay = '2.2'
    -- BOW
    if player.equipment.range == gear.Bow then
        if spell.type:lower() == 'weaponskill' then
            delay = '2.25'
         else
             if buffactive["Courser's Roll"] then
                 delay = '0.7' -- MAKE ADJUSTMENT HERE
             elseif buffactive["Flurry II"] or buffactive.Overkill then
                 delay = '0.5'
             else
                delay = '1.05' -- MAKE ADJUSTMENT HERE
            end
        end
    else
    -- GUN 
        if spell.type:lower() == 'weaponskill' then
            delay = '2.25' 
        else
            if buffactive["Courser's Roll"] then
                delay = '0.7' -- MAKE ADJUSTMENT HERE
            elseif buffactive.Overkill or buffactive['Flurry II'] then
                delay = '0.5'
            else
                delay = '1.05' -- MAKE ADJUSTMENT HERE
            end
        end
    end
    send_command('@wait '..delay..'; input /ra <t>')
end

function camo_active()
    return state.Buff['Camouflage']
end
-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
	-- Filter ammo checks depending on Unlimited Shot
	if state.Buff['Unlimited Shot'] then
		if player.equipment.ammo ~= U_Shot_Ammo[player.equipment.range] then
			if player.inventory[U_Shot_Ammo[player.equipment.range]] or player.wardrobe[U_Shot_Ammo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active. Using custom ammo.")
				equip({ammo=U_Shot_Ammo[player.equipment.range]})
			elseif player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active but no custom ammo available. Using default ammo.")
				equip({ammo=DefaultAmmo[player.equipment.range]})
			else
				add_to_chat(122,"Unlimited Shot active but unable to find any custom or default ammo.")
			end
		end
	else
		if player.equipment.ammo == U_Shot_Ammo[player.equipment.Bow] then
			if DefaultAmmo[player.equipment.Bow] then
				if player.inventory[DefaultAmmo[player.equipment.Bow]] then
					add_to_chat(122,"Unlimited Shot not active. Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.Bow]})
				else
					add_to_chat(122,"Default ammo unavailable.  Removing Unlimited Shot ammo.")
					equip({ammo=empty})
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Removing Unlimited Shot ammo.")
				equip({ammo=empty})
			end
		elseif player.equipment.ammo == 'empty' then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Leaving empty.")
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Leaving empty.")
				--equip({ammo="Darksteel Bolt"})
			end
		elseif player.inventory[player.equipment.ammo].count < 15 then
			add_to_chat(122,"Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low ("..player.inventory[player.equipment.ammo].count..")")
		end
	end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book

		set_macro_page(1, 11)

end



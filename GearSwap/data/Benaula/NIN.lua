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
	--Used for time-related gear updates
    event_list = L{}
    event_list:append(windower.register_event('time change', time_change))

    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Evasion', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')
    
    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {}
    sets.precast.JA['Futae'] = {}
    sets.precast.JA['Sange'] = {}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    
    sets.precast.FC = {}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {hands="Gigas Bracelets"}
	sets.precast.WS.Nighttime = {hands="Ryl.Sqr. Mufflers"}
    -- Specific weaponskill sets.
    sets.precast.WS['Blade: Jin'] = {}
	sets.precast.WS['Blade: Jin'].Nighttime = {}



    
    --------------------------------------
    -- Midcast sets
    --------------------------------------
	
	--Haste and Fastcast
    sets.midcast.FC = {}

    sets.midcast.ElementalNinjutsu = {}

    sets.midcast.NinjutsuDebuff = {}

    sets.midcast.NinjutsuBuff = {}

	
	--------------------------------------
	--Ranged
	--------------------------------------

    sets.precast.RA = {}

    sets.midcast.RA = {}
	sets.midcast.RA.Nighttime = {}


    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {feet="Mgn. F Ledelsens"}
    
    -- Idle sets
    sets.idle = {feet="Mtt. Leggings +1"}
	sets.idle.Nighttime = {feet="Bounding Boots"}
    
    -- Defense sets
	sets.defense.Evasion = {feet="Mtt. Leggings +1"}
	sets.defense.Evasion.Nighttime = {feet="Mgn. F Ledelsens"}
	
    sets.defense.PDT = {}

    sets.defense.MDT = {}



    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {hands="Magna Gloves", feet="Mtt. Leggings +1"}
	sets.engaged.Nighttime = {feet="Mtt. Leggings +1"}
    sets.engaged.Acc = {}	


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Yonin = {}
    sets.buff.Innin = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'WeaponSkill' then
		if classes.DuskToDawn then
			equip(sets.precast.WS[spell.english] or sets.precast.WS.Nighttime)
		end
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
function job_time_change(new_time, old_time)
    classes.CustomMeleeGroups:clear()
	classes.CustomIdleGroups:clear()
	classes.CustomRangedGroups:clear()
	classes.CustomDefenseGroups:clear()
    if classes.DuskToDawn then
		classes.CustomIdleGroups:append('Nighttime')
        classes.CustomMeleeGroups:append('Nighttime')
		classes.CustomRangedGroups:append('Nighttime')
		classes.CustomDefenseGroups:append('Nighttime')
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


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(4, 3)
    elseif player.sub_job == 'THF' then
        set_macro_page(5, 3)
    else
        set_macro_page(1, 3)
    end
end

function file_unload()
    event_list:map(windower.unregister_event)
end

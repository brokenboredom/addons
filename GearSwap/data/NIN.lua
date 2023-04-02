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
    sets.precast.JA['Mijin Gakure'] = {ammo="Phantom Tathlum",
	head="Koga Hatsuburi",neck="Prudence Torque",ear1="Modavite Earring",ear2="Phantom Earring",
	body="Kirin's Osode",ring1="Snow Ring",ring2="Snow Ring",
	legs="Yasha Hakama",feet="Nin. Kyahan +1"}
    sets.precast.JA['Futae'] = {}
    sets.precast.JA['Sange'] = {}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Genbu's Kabuto",
        body="Kirin's Osode",
        back="Shadow Mantle",waist="Warwolf Belt",feet="Koga Kyahan"}
		
	sets.precast.Step = {
        head="Voyager Sallet",neck="Peacock Amulet",ear2="Pixie Earring",
        body="Koga Chainmail",hands="Nin. Tekko +1",ring1="Jaeger Ring",ring2="Sniper's Ring +1",
		back="Agile Mantle",waist="Potent Belt",legs="Byakko's Haidate"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    
    sets.precast.FC = {}
       
    
	-- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Fire Bomblet",
        head="Voyager Sallet",neck="Fotia Gorget",ear1="Pixie Earring",ear2="Brutal Earring",
        body="Haubergeon +1",hands="Nin. Tekko +1",ring1="Rajas Ring",ring2="Spinel Ring",
        back="Amemet Mantle +1",waist="Warwolf Belt",legs="Byakko's Haidate",feet="Savage Gaiters"}
	sets.precast.WS.Nighttime = {ammo="Fire Bomblet",
        head="Voyager Sallet",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Vampire Earring",
        body="Haubergeon +1",hands="Koga Tekko +1",ring1="Rajas Ring",ring2="Spinel Ring",
        back="Amemet Mantle +1",waist="Warwolf Belt",legs="Byakko's Haidate",feet="Koga Kyahan"}
	
    -- Specific weaponskill sets.
    sets.precast.WS['Blade: Yu'] = {ammo="Phantom Tathlum",
        head="Voyager Sallet",neck="Fotia Gorget",ear1="Pixie Earring",ear2="Phantom Earring",
        body="Kirin's Osode",hands="Nin. Tekko +1",ring1="Rajas Ring",ring2="Snow Ring",
        back="Amemet Mantle +1",waist="Warwolf Belt",legs="Byakko's Haidate",feet="Savage Gaiters"}
	sets.precast.WS['Blade: Yu'].Nighttime = {ammo="Phantom Tathlum",
        head="Voyager Sallet",neck="Fotia Gorget",ear1="Pixie Earring",ear2="Morion Earring +1",
        body="Haubergeon +1",hands="Koga Tekko +1",ring1="Rajas Ring",ring2="Diamond Ring",
        back="Amemet Mantle +1",waist="Warwolf Belt",legs="Byakko's Haidate",feet="Koga Kyahan"}
	sets.precast.WS['Blade: Metsu'] = {ammo="Fire Bomblet",
        head="Voyager Sallet",neck="Fotia Gorget",ear1="Pixie Earring",ear2="Brutal Earring",
        body="Haubergeon +1",hands="Nin. Tekko +1",ring1="Rajas Ring",ring2="Spinel Ring",
        back="Amemet Mantle +1",waist="Warwolf Belt",legs="Byakko's Haidate",feet="Bounding Boots"}
	sets.precast.WS['Blade: Metsu'].Nighttime = {ammo="Fire Bomblet",
        head="Voyager Sallet",neck="Fotia Gorget",ear1="Pixie Earring",ear2="Brutal Earring",
        body="Haubergeon +1",hands="Koga Tekko +1",ring1="Rajas Ring",ring2="Deft Ring +1",
        back="Amemet Mantle +1",waist="Warwolf Belt",legs="Byakko's Haidate",feet="Koga Kyahan"}
	sets.precast.WS['Blade: Hi']= {}



    
    --------------------------------------
    -- Midcast sets
    --------------------------------------
	
	--Haste and Fastcast
    sets.midcast.FC = {
        head="Acubens Helm",
        hands="Dusk Gloves +1",
        waist="ninurta's sash",legs="Byakko's Haidate",feet="Dusk Ledelsens +1"}

    sets.midcast.ElementalNinjutsu = {ammo="Phantom Tathlum",
        head="Koga Hatsuburi",neck="Prudence Torque",ear1="Moldavite Earring",ear2="Phantom Earring",
        body="Kirin's Osode",hands="Koga Tekko",ring1="Snow Ring",ring2="Snow Ring",
        back="Astute Cape",legs="Yasha Hakama",feet="Koga Kyahan"}

    sets.midcast.NinjutsuDebuff = {ammo="Phantom Tathlum",
        head="Nin. Hatsuburi +1",neck="Prudence Torque",ear2="Phantom Earring",
        body="Kirin's Osode",hands="Koga Tekko",ring1="Snow Ring",ring2="Snow Ring",
        back="Astute Cape",lets="Yasha Hakama",feet="Koga Kyahan"}

    sets.midcast.NinjutsuBuff = {
	head="Acubens Helm",ear1="novia earring",ear2="Elusive Earring",
	body="Scp. Harness +1",hands="Dusk Gloves +1",
	back="Bat Cape",waist="ninurta's sash",legs="Byakko's Haidate",feet="Dusk Ledelsens +1"}

	
	--------------------------------------
	--Ranged
	--------------------------------------

    sets.precast.RA = {ammo="Manji Shuriken"}

    sets.midcast.RA = {
        head="Nin. Hatsuburi +1",neck="Peacock Amulet",ear1="Drone Earring",ear2="Drone Earring",
        body="War Shinobi Gi +1",hands="Nin. Tekko +1",ring1="Merman's Ring",ring2="Merman's Ring",
        back="Amemet Mantle +1",legs="Dusk Trousers +1",feet="Nin. Kyahan +1"}
	sets.midcast.RA.Nighttime = {}


    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {}
    
    -- Idle sets
    sets.idle = {ammo="Nokizaru Shuriken",
        head="Walahra Turban",neck="Orochi Nodowa",ear1="Suppanomimi",ear2="Elusive Earring",
        body="War Shinobi Gi +1",hands="Horomusha Kote",ring1="Rajas Ring",ring2="Shadow Ring",
        back="Amemet Mantle +1",waist="ninurta's sash",legs="Byakko's Haidate",feet="Nin. Kyahan +1"}
	sets.idle.Nighttime = {ammo="Nokizaru Shuriken",
        head="Walahra Turban",neck="Orochi Nodowa",ear1="Suppanomimi",ear2="Elusive Earring",
        body="War Shinobi Gi +1",hands="Koga Tekko +1",ring1="Rajas Ring",ring2="Shadow Ring",
        back="Amemet Mantle +1",waist="ninurta's sash",legs="Byakko's Haidate",feet="Nin. Kyahan +1"}
    
    -- Defense sets
	sets.defense.Evasion = {
        head="Nin. Hatsuburi +1",ear1="novia earring",ear2="Elusive Earrring",
        body="Scp. Harness +1",hands="Rasetsu Tekko +1",ring1="Snow Ring",ring2="Snow Ring",
        back="Boxer's Mantle",waist="Survival Belt",legs="Fourth Schoss",feet="Rst. Sune-Ate +1"}
	sets.defense.Evasion.Nighttime = {
        head="Nin. Hatsuburi +1",ear1="novia earring",ear2="Elusive Earrring",
        body="Scp. Harness +1",hands="Rasetsu Tekko +1",ring1="Snow Ring",ring2="Snow Ring",
        back="Boxer's Mantle",waist="Survival Belt",legs="Koga Hakama",feet="Rst. Sune-Ate +1"}
	
    sets.defense.PDT = {
		head="Arh. Jinpachi +1",
		body="Arhat's Gi +1",hands="Denali Wristbands",ring2="Jelly Ring",
		back="Shadow Mantle"}

    sets.defense.MDT = {ammo="Phantom Tathlum",
		head="Genbu's Kabuto",neck="Enlightened Chain",ear1="Merman's Earring",ear2="Merman's Earring",
        body="Kirin's Osode",hands="Denali Wristbands",ring1="Merman's Ring",ring2="Merman's Ring",
		back="Lamia Mantle +1",legs="Byakko's Haidate",feet="Suzaku's Sunae-Ate"}



    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Nokizaru Shuriken",
        head="Acubens Helm",neck="Hope Torque",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Nin. Chainmail +1",hands="Dusk Gloves +1",ring1="Rajas Ring",ring2="Mars's Ring",
        back="Amemet Mantle +1",waist="ninurta's sash",legs="Byakko's Haidate",feet="Dusk Ledelsens +1"}
	sets.engaged.Nighttime = {ammo="Nokizaru Shuriken",
        head="Acubens Helm",neck="Hope Torque",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Nin. Chainmail +1",hands="Koga Tekko +1",ring1="Rajas Ring",ring2="Mars's Ring",
        back="Amemet Mantle +1",waist="ninurta's sash",legs="Byakko's Haidate",feet="Dusk Ledelsens +1"}
    sets.engaged.Acc = {ammo="Nokizaru Shuriken",
        head="Walahra Turban",neck="Peacock Amulet",ear1="Suppanomimi",ear2="Pixie Earring",
        body="Scp. Harness +1",hands="Dusk Gloves +1",ring1="Rajas Ring",ring2="Mars's Ring",
        back="Amemet Mantle +1",waist="ninurta's sash",legs="Byakko's Haidate",feet="Dusk Ledelsens +1"}	


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
        set_macro_page(1, 20)
    elseif player.sub_job == 'THF' then
        set_macro_page(2, 20)
    else
        set_macro_page(1, 20)
    end
end

function file_unload()
    event_list:map(windower.unregister_event)
end

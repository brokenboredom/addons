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
    state.Buff.Focus = buffactive.Focus or false
	state.Buff.Dodge = buffactive.Dodge or false
	state.Buff.Footwork = buffactive.Footwork or false
	state.Buff['Counterstance'] = buffactive.Counterstance or false
	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Haste', 'Evasion', 'Accuracy', 'Defense', 'Counter')
    state.HybridMode:options('Normal', 'Evasion', 'Accuracy', 'Defense')
	state.WeaponskillMode:options('Normal', 'Accuracy')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
	state.PhysicalDefenseMode:options('None', 'PDT')
	state.MagicalDefenseMode:options('None', 'MDT', 'Water', 'Fire')
	
	send_command('bind !f9 gs c cycle WeaponskillMode')

    update_combat_form()
	
    select_default_macro_book()
	
	gear.default.weaponskill_neck = "Fotia Gorget"
	
end


--Begin initializing gear swaps
function init_gear_sets()

	--BUFF SPECIFIC
	--All attack

	-------------------------------------------------------------------------------------
	--PRECAST Sets
	--Job Abilities
	--Dodge
	sets.precast.JA['Dodge'] = {feet="Temple Gaiters"}
	--Focus
	sets.precast.JA['Focus'] = {head="Temple Crown"}
	--Chakra
	--VIT
	sets.precast.JA['Chakra'] = {
		head="genbu's kabuto",neck="Fortitude Torque",ear1="Cassie Earring",
		body="Kirin's Osode",hands="Mel. Gloves +1",ring2="Bastokan Ring",
		back="Shadow Mantle",waist="Warwolf Belt"}
		
	--Boost
	sets.precast.JA['Boost'] = {hands="Temple Gloves"}
	
	--Counterstance
	sets.precast.JA['Counterstance'] = {feet="Mel. Gaiters +1"}
	
	--Chi Blast
	--MND and ATK
	sets.precast.JA['Chi Blast'] = {
		head="Denali Bonnet",neck="Faith Torque",
		body="kirin's osode",hands="Dvt. Mitts +1",ring1="Saintly Ring +1",ring2="Saintly Ring +1",
		legs="Savage Loincloth",feet="suzaku's sune-ate"}
		
	--Waltz
	--CHR then VIT
	sets.precast.JA.Waltz = {
		head="Panther Mask +1",neck="temp. torque",ear1="Cassie Earring",
		body="kirin's osode",hands="Savage Gauntlets",ring2="Bastokan Ring",
		back="Shadow Mantle",waist="Warwolf Belt",feet="Dance Shoes"}
	
	--Weaponskills
	--Default
	sets.precast.WS = {ammo="Black Tathlum",
		head="mel. crown +1",neck="Fotia Gorget",ear1="Merman's Earring",ear2="Brutal Earring",
		body="kirin's osode",hands="Denali Wristbands",ring1="Rajas ring",ring2="Crimson Ring",
		back="Amemet Mantle +1",waist="Warwolf Belt",legs="Byakko's Haidate",feet="Denali Gamashes"}
		
	sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {
		head="Denali Bonnet",neck="Faith Torque",ear2="Merman's Earring",
		body="Denali Jacket",hands="Bandomusha Kote",ring2="Assailant's Ring",
		feet="Denali Gamashes"})


	-------------------------------------------------------------------------------------
	--MIDCAST Sets
	
	-------------------------------------------------------------------------------------
	--AFTERCAST
	
	--------------------------
	--Engaged
	--------------------------
	--well rounded
	sets.engaged = {ammo="Black Tathlum",
		head="Walahra Turban",neck="Chivalrous Chain",ear1="Merman's Earring",ear2="Brutal Earring",
		body="Scp. Harness +1",hands="Horomusha Kote",ring1="Rajas ring",ring2="Crimson Ring",
		back="Amemet Mantle +1",waist="Black Belt",legs="Byakko's Haidate",feet="Sarutobi Kyahan"}
	
	sets.engaged.Accuracy = {ammo="Black Tathlum",
		head="Denali Bonnet",neck="Peacock Amulet",ear1="Elusive Earring",ear2="Brutal Earring",
		body="Scp. Harness +1",hands="Denali Wristbands",ring1="rajas ring",ring2="Sniper's Ring +1",
		back="Shadow Mantle",waist="Potent Belt",legs="Byakko's Haidate",feet="Denali Gamashes"}
		
	sets.engaged.Accuracy.Evasion = set_combine(sets.engaged.Accuracy, {
		head="Wivre Mask +1",ear1="novia earring",ear2="Elusive Earring",
		body="Scp. Harness +1",hands="Rasetsu Tekko +1",
		feet="Rst. Sune-Ate +1"})
	
	sets.engaged.Accuracy.Defense = set_combine(sets.engaged.Accuracy, {
		head="Arh. Jinpachi +1",
		body="arhat's gi +1",
		back="Shadow Mantle",waist="black belt"})
	
	sets.engaged.Evasion = {
		ammo="Attar Sachet",
		head="Wivre Mask +1",
		neck="evasion torque",
		ear1="Elusive Earring",
		ear2="Elusive Earring",
		body="Scp. Harness +1",
		hands="Rasetsu Tekko +1",
		ring2="defending Ring",
		ring1="Rajas ring",
		back="boxer's mantle",
		waist="Black Belt",
		legs="Byakko's Haidate",
		feet="Rst. Sune-Ate +1"}
	
	sets.engaged.Defense = {
		ammo="Attar Sachet",
		head="Arh. Jinpachi +1",
		neck="Chivalrous Chain",
		ear1="Brutal Earring",
		ear2="Elusive Earring",
		body="Arhat's Gi +1",
		hands="Rasetsu Tekko +1",
		ring2="defending Ring",
		ring1="Rajas Ring",
		back="Shadow Mantle",
		waist="Black Belt",
		legs="Byakko's Haidate",
		feet="Rst. Sune-Ate +1"}
	
	sets.engaged.Counter = set_combine(sets.engaged,{
		head="Rst. Jinpachi +1",
		ear2="Avenger's Earring",
		hands="Rasetsu Tekko +1",
		legs="Tpl. Hose +1",
		feet="Rst. Sune-Ate +1"})
	
	sets.buff['Counterstance'] = {
		head="Rst. Jinpachi +1",ear2="Avenger's Earring",
		hands="Rasetsu Tekko +1",
		back="Shadow Mantle",waist="Black Belt",legs="Tpl. Hose +1",feet="Rst. Sune-Ate +1"}
	
	
	sets.engaged.Footwork = set_combine(sets.engaged,{feet="Seihanshi Habaki"})
	sets.engaged.Footwork.Evasion = set_combine(sets.engaged.Evasion,{feet="Seihanshi Habaki"})
	sets.engaged.Footwork.Accuracy = set_combine(sets.engaged.Accuracy,{feet="Seihanshi Habaki"})
	sets.engaged.Footwork.Haste = set_combine(sets.engaged.Haste,{feet="Seihanshi Habaki"})
	sets.engaged.Footwork.Defense = set_combine(sets.engaged.Defense,{feet="Seihanshi Habaki"})
	
	--------------------------
	--Defense
	--------------------------
	sets.defense.PDT = {
		head="Arh. Jinpachi +1",
		body="Arhat's Gi +1",hands="Denali Wristbands",
		back="Shadow Mantle"}
	
	sets.defense.MDT = {
		ear1="merman's Earring",ear2="merman's Earring",
		ring1="merman's Ring",ring2="Merman's Ring",
		back="lamia mantle +1"}
	
	-------------------------------------------------------------------------------------
	--NON-ACTION Sets
	--Resting
	--Idle
	sets.idle = {
		head="Arh. Jinpachi +1",neck="Orochi Nodowa",ear1="merman's Earring",ear2="merman's Earring",
		body="Mel. Cyclas +1",hands="Denali Wristbands",ring1="Rajas Ring",ring2="Shadow Ring",
		back="Shadow Mantle",waist="Black Belt",legs="Byakko's Haidate",feet="Herald's Gaiters"}

    -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
    sets.footwork_kick_feet = {feet="Seihanshi Habaki"}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for casting events.
-------------------------------------------------------------------------------------------------------------------
-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if state.Buff.Footwork and (spell.english == "Dragon Kick" or spell.english == "Tornado Kick") then
            equip(sets.footwork_kick_feet)
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
    -- Set Footwork as combat form any time it's active and Counterstance is not.
	if buff == 'Footwork' and gain then
		state.CombatForm:set('Footwork')
    elseif buff == 'Footwork' and not gain then
        state.CombatForm:reset()
    end
	-- Update gear if any of the above changed
	if buff == 'Footwork' then
		handle_equipping_gear(player.status)
	end
end

function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
		if player.equipment.main == "Faith Baghnakhs" then
			if player.equipment.ammo == 'empty' then
				add_to_chat(122, 'No more Ammo!')
			end
		end
	end
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff['Counterstance'] then
        meleeSet = set_combine(meleeSet, sets.buff['Counterstance'])
    end
	if player.equipment.main == 'Faith Baghnakhs' then
		meleeSet = set_combine(meleeSet, {ammo="Virtue Stone"})
	end
    return meleeSet
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function update_combat_form()
    if buffactive.Footwork then
        state.CombatForm:set('Footwork')
	else
        state.CombatForm:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1,11)
end
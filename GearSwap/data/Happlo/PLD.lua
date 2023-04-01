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

	state.Buff['Asleep']    = buffactive['Sleep']   or false
	state.Buff['Paralyzed'] = buffactive['Sleep']   or false
	state.Buff['Silenced']  = buffactive['Silence'] or false
	state.Buff['Cursed']    = buffactive['Curse']   or false

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Accuracy')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'Paralyze', 'EXP')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	-- Precast Sets

	--Maximum Enmity set (caps at +200)
	sets.precast.Enmity = {}
	
    -- Fast cast sets for spells
    sets.precast.FC = {
		ammo="Incantor Stone",
        ear2="Loquacious Earring",
        ring1="Prolix Ring"
		}
	
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = sets.precast.FC['Enhancing Magic']
	
	sets.precast.FC.Cure = {ear1="Mendicant's Earring"}
    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
	
	--Job Abilities
	sets.precast.JA['Sentinel'] = {feet="Cab. Leggings"}
	sets.precast.JA['Fealty'] = {body="Cab. Surcoat"}
	sets.precast.JA['Rampart'] = {head="Cab. Coronet"}

    -- WEAPONSKILLS
    -- Default weaponskill set.
	gear.default.weaponskill_neck = "Fotia Gorget"
    gear.default.weaponskill_waist = "Fotia Belt"
    sets.precast.WS = {
		ammo="Ginsen",
		head="Valorous Mask",
		body="Acro Surcoat",
		hands="Despair Finger Gauntlets",
		legs="Valorous Hose",
		feet="Despair Greaves",
		back="Atheling Mantle",
		ring2="Rajas Ring",
		ear1="Brutal Earring",
		ear2="Aesir Ear Pendant"
		}

    -- Specific weaponskill sets.
	
	--Multi-hit set because Savage Blade has very high base fTP
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {neck="Clotharius Torque", waist="Windbuffet Belt"})
	
	--Circle Blade - WSA 100% STR, fTP 1.0
	sets.precast.WS['Circle Blade'] = {
		ammo="Ginsen",
		head="Valorous Mask",
		body="Acro Surcoat",
		hands="Despair Finger Gauntlets",
		legs="Valorous Hose",
		feet="Despair Greaves",
		back="Atheling Mantle",
		ring2="Rajas Ring",
		ear1="Brutal Earring",
		ear2="Aesir Ear Pendant"
	}

    sets.precast.WS.MAB = {
		ammo="Pemphredo Tathlum",
		head="Valorous Mask",
		body="Acro Surcoat",
		hands="Despair Finger Gauntlets",
		legs="Valarous Hose",
		neck="Sanctity Necklace",
		ring1="Acumen Ring",
		ring2="Epona's Ring",
		ear1="Hecate's Earring",
		ear2="Friomisi Earring",
		waist="Cetl Belt",
		back="Toro Cape"
		}
		
	sets.precast.WS['Aeolian Edge'] = sets.precast.WS.MAB
		
	sets.precast.WS['Sanguine Blade'] = sets.precast.WS.MAB
	
	sets.precast.WS['Cataclysm'] = sets.precast.WS.MAB
	
	sets.precast.WS['Flash Nova'] = sets.precast.WS.MAB
	
    --------------------------------------
    -- Midcast sets
    --------------------------------------
    
	--Maximum Haste and default midcast set
    sets.midcast.FastRecast = {
		head="Valorous Mask",
		body="Acro Surcoat",
		hands="Despair Finger Gauntlets",
		legs="Valarous Hose",
		feet="Despair Greaves"
		}
	
	--Mitigation over Healing
	sets.midcast.Cure = set_combine(sets.midcast.FastRecast, {
		ammo="Incantor Stone",
        neck="Twilight Torque",
		ear1="Mendi. Earring",
		ear2="Nourishing Earring",
        ring1="Defending Ring",
		ring2="Ephedra Ring",
        back="Metallon Mantle",
		waist="Nierenschutz",
		})
	
	--Mitigation over Healing	
	sets.midcast.CureMelee = {
		ammo="Incantor Stone",
        neck="Twilight Torque",
		ear1="Mendi. Earring",
		ear2="Nourishing Earring",
        ring1="Defending Ring",
		ring2="Ephedra Ring",
        back="Metallon Mantle",
		waist="Nierenschutz",
		}
		
	sets.midcast['Enhancing Magic'] = sets.midcast.FastRecast
	
	--Also used as Cursna recieved
	sets.midcast.Cursna = {}

    sets.midcast.Utsusemi = sets.midcast.FastRecast
	
	--------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- RESTING

    -- IDLE SETS
    sets.idle = {
		ammo="Homiliary",
		head="Valorous Mask",
		body="Acro Surcoat",
		hands="Despair Finger Gauntlets",
		legs="Valorous Hose",
		feet="Despair Greaves",
		neck="Sanctity Necklace",
		waist="Nierenschutz",
		back="Metallon Mantle",
		ring1="Defending Ring",
		ring2="Paguroidea Ring",
		ear1="Brutal Earring",
		ear2="Ethereal Earring"
		}
	
	sets.idle.Normal = sets.idle
	
	sets.idle.EXP = {ammo="Ginsen",head="Valorous Mask",body="Acro Surcoat",hands="Despair Finger Gauntlets",legs="Valorous Hose",feet="Despair Greaves",neck="Twilight Torque",waist="Nierenschutz",back="Mecistopins Mantle",ring1="Defending Ring", ring2="Paguroidea Ring",ear1="Brutal Earring",ear2="Ethereal Earring"}
	
	sets.idle.Town = set_combine(sets.idle, {head="Midras's Helm +1",neck="Smithy's Torque",body="Blacksmith's Apron",hands="Smithy's Mitts",ring1="Craftmaster's Ring",ring2="Orvail Ring"})

    -- DEFENSE SETS
	--Emergency sets that override other states
    sets.defense.PDT = {
		body="Caballarius Surcoat",
        neck="Twilight Torque",
        ring1="Defending Ring",
        back="Metallon Mantle",
		waist="Nierenschutz"
	}

    sets.defense.MDT = {
		body="Caballarius Surcoat",
        neck="Twilight Torque",
        ring1="Defending Ring",
        waist="Nierenschutz"
	}

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    sets.engaged = {
		ammo="Ginsen",
		head="Valorous Mask",
		body="Acro Surcoat",
		hands="Despair Finger Gauntlets",
		legs="Valorous Hose",
		feet="Despair Greaves",
		neck="Sanctity Necklace",
		waist="Cetl Belt",
		back="Atheling Mantle",
		ring1="Rajas Ring",
		ring2="Defending Ring",
		ear1="Brutal Earring",
		ear2="Ethereal Earring"
	}
	
	sets.engaged.Normal = sets.engaged
	
	sets.engaged.Acc = {ammo="Ginsen",head="Valorous Mask",body="Acro Surcoat",hands="Despair Finger Gauntlets",legs="Valorous Hose",feet="Despair Greaves",neck="Sanctity Necklace",waist="Cetl Belt",back="Grounded Mantle",ring1="Defending Ring",ring2="Rajas Ring",ear1="Brutal Earring",ear2="Ethereal Earring"}
    
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'WeaponSkill' and spell.type == 'Magical' then
		equip(sets.precast.WS.MAB)
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
	if stateField == 'Offense Mode' then
		if newValue == 'Normal' then
			enable('main', 'sub', 'range')
			equip(sets.engaged.Normal)
			disable('main', 'sub', 'range')
		elseif newValue == 'Acc' then
			enable('main', 'sub', 'range')
			equip(sets.engaged.Normal.Acc)
			disable('main', 'sub', 'range')
		else
			enable('main', 'sub', 'range')
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
        end
    end
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)

end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(3, 2)
end
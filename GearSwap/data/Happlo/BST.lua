-- NOTE: I do not play bst, so this will not be maintained for 'active' use. 
-- It is added to the repository to allow people to have a baseline to build from,
-- and make sure it is up-to-date with the library API.

-- Credit to Quetzalcoatl.Falkirk for most of the original work.

--[[
    Custom commands:
    
    Ctrl-F8 : Cycle through available pet food options.
    Alt-F8 : Cycle through correlation modes for pet attacks.
]]

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

function job_setup()
    -- Set up Reward Modes and keybind Ctrl-F8
    state.RewardMode = M{['description']='Reward Mode', 'Theta', 'Zeta', 'Eta'}
    RewardFood = {name="Pet Food Theta"}
    send_command('bind ^f8 gs c cycle RewardMode')
		
		-- Complete list of Ready moves
	Physical_Ready_Moves = S{'Sic','Foot Kick','Whirl Claws','Wild Carrot','Sheep Charge','Lamb Chop','Head Butt',
		'Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang','Nimble Snap','Cyclotail','Rhino Attack','Power Attack',
		'Mandibular Bite','Big Scissors','Grapple','Spinning Top','Double Claw','Frogkick','Blockhead','Brain Crush',
		'Tail Blow','??? Needles','Needleshot','Scythe Tail','Ripper Fang','Chomp Rush','Recoil Dive','Sudden Lunge',
		'Spiral Spin','Wing Slap','Beak Lunge','Suction','Back Heel','Choke Breath','Fantod','Tortoise Stomp',
		'Harden Shell','Sensilla Blades','Tegmina Buffet','Swooping Frenzy','Pentapeck','Sweeping Gouge',
		'Zealous Snort','Somersault','Tickling Tendrils','Pecking Flurry','Sickle Slash'}
 
	Magical_Ready_Moves = S{'Dust Cloud','Cursed Sphere','Venom','Toxic Spit','Bubble Shower','Drainkiss',
		'Silence Gas','Dark Spore','Fireball','Plague Breath','Snow Cloud','Charged Whisker','Purulent Ooze',
		'Corrosive Ooze','Aqua Breath','Stink Bomb','Nectarous Deluge','Nepenthic Plunge','Pestilent Plume',
		'Foul Waters','Infected Leech','Gloom Spray'}
 
	Macc_Ready_Moves = S{'Sheep Song','Scream','Dream Flower','Roar','Gloeosuccus','Palsy Pollen',
		'Soporific','Geist Wall','Toxic Spit','Numbing Noise','Spoil','Hi-Freq Field','Sandpit','Sandblast',
		'Venom Spray','Filamented Hold','Queasyshroom','Numbshroom','Spore','Shakeshroom','Infrasonics',
		'Chaotic Eye','Blaster','Intimidate','Noisome Powder','Acid Mist','TP Drainkiss','Jettatura',
		'Molting Plumage','Spider Web'}
 
	tp_based_ready_moves = S{'Sic','Foot Kick','Dust Cloud','Snow Cloud','Wild Carrot','Sheep Song','Sheep Charge',
		'Lamb Chop','Rage','Head Butt','Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang',
		'Roar','Gloeosuccus','Palsy Pollen','Soporific','Cursed Sphere','Somersault','Geist Wall','Numbing Noise',
		'Frogkick','Nimble Snap','Cyclotail','Spoil','Rhino Guard','Rhino Attack','Hi-Freq Field','Sandpit','Sandblast',
		'Mandibular Bite','Metallic Body','Bubble Shower','Bubble Curtain','Scissor Guard','Grapple','Spinning Top',
		'Double Claw','Filamented Hold','Spore','Blockhead','Secretion','Fireball','Tail Blow','Plague Breath',
		'Brain Crush','Infrasonics','Needleshot','Chaotic Eye','Blaster','Ripper Fang','Intimidate','Recoil Dive',
		'Water Wall','Sudden Lunge','Noisome Powder','Wing Slap','Beak Lunge','Suction','Drainkiss','Acid Mist',
		'TP Drainkiss','Back Heel','Jettatura','Choke Breath','Fantod','Charged Whisker','Purulent Ooze',
		'Corrosive Ooze','Tortoise Stomp','Harden Shell','Aqua Breath','Sensilla Blades','Tegmina Buffet',
		'Sweeping Gouge','Zealous Snort','Tickling Tendrils','Pecking Flurry','Pestilent Plume','Foul Waters',
		'Spider Web','Gloom Spray'}--]
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Free','Hybrid', 'Locked', 'Acc')
    state.IdleMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT')

	select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    -- Unbinds the Reward and Correlation hotkeys.
    send_command('unbind ^f8')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

	--JOB ABILITIES
    sets.precast.JA['Call Beast'] = {main="Kumbhakarna",hands="Monster Gloves +2"}
	sets.precast.JA['Bestial Loyalty'] = {main="Kumbhakarna",hands="Monster Gloves +2"}
    sets.precast.JA['Reward'] = {ammo=RewardFood}

    -- CURING WALTZ
    sets.precast.Waltz = {legs="Desultor Tassets"}

    -- HEALING WALTZ
    sets.precast.Waltz['Healing Waltz'] = sets.precast.Waltz

    sets.precast.FC = {ear1="Loquacious Earring",ring1="Prolix Ring"}
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    -- WEAPONSKILLS
    -- Default weaponskill set.
	gear.default.weaponskill_neck = "Fotia Gorget"
    gear.default.weaponskill_waist = "Fotia Belt"
    sets.precast.WS = {
		ear1="Brutal Earring",
        ring1="Epona's Ring",
        back="Atheling Mantle",
		}

    -- Specific weaponskill sets.
    sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS)

    sets.precast.WS['Primal Rend'] = {ammo="Pemphredo Tathlum",
		head="Valorous Mask",
		body="Acro Surcoat",
		hands="Despair Finger Gauntlets",
		legs="Valarous Hose",
		neck="Sanctity Necklace",
		ring1="Acumen Ring",
		ring2="Epona's Ring",
		ear1="Hecate's Earring",
		ear2="Friomisi Earring",
		back="Toro Cape"}
		
	sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Primal Rend']

    sets.precast.WS['Cloudsplitter'] = sets.precast.WS['Primal Rend']


    --------------------------------------
    -- Midcast sets
    --------------------------------------
    
    sets.midcast.FastRecast = {
		head="Valorous Mask",
		body="Acro Surcoat",
		hands="Despair Finger Gauntlets",
		legs="Valorous Hose"
		}

    sets.midcast.Utsusemi = sets.midcast.FastRecast


    -- PET SIC & READY MOVES
	
	--THIS IS EQUIPPING FOR MAGIC DAMAGE
    sets.midcast.Pet.MA = {
		head="Valorous Mask",
		body="Acro Surcoat",
		hands="Nukumi Manoplas",
		legs="Valorous Hose",
		feet="Despair Greaves"
	}
	
	sets.midcast.Pet.WS = {
		head="Valorous Mask",
		body="Acro Surcoat",
		hands="Nukumi Manoplas",
		legs="Valorous Hose",
		feet="Despair Greaves"
		}
	
	--[[ 
	sets.midcast.Pet.TP = {
	}
	
	sets.micast.Pet.Macc = {
	}
	--]]

	--THIS IS EQUIPPING FOR PRECAST TIMER
	sets.midcast.Pet.Recast = {sub="Charmer's Merlin",legs="Desultor Tassets"}


    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- RESTING
    sets.resting = {ammo="Demonry Core",
        head="Twilight Helm",neck="Wiglen Gorget",ear1="Domesticator's Earring",ear2="Sabong Earring",
        body="Twilight Mail",hands="Totemic Gloves +1",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Pastoralist's Mantle",waist="Muscle Belt +1",legs="Ferine Quijotes +2",feet="Skadi's Jambeaux +1"}

    -- IDLE SETS
    sets.idle = {
		ammo="Ginsen",
		head="Valorous Mask",
		body="Acro Surcoat",
		hands="Despair Finger Gauntlets",
		legs="Taeon Tights",
		feet="Skadi's Jambeaux +1",
		neck="Sanctity Necklace",
		waist="Nierenschutz",
		back="Metallon Mantle",
		ring1="Defending Ring",
		ring2="Paguroidea Ring",
		ear1="Brutal Earring",
		ear2="Ethereal Earring"
		}
	
	sets.idle.Normal = sets.idle
	
	sets.idle.EXP = {ammo="Ginsen",head="Valorous Mask",body="Acro Surcoat",hands="Despair Finger Gauntlets",legs="Valorous Hose",feet="Skadi's Jambeaux +1",neck="Twilight Torque",waist="Nierenschutz",back="Mecistopins Mantle",ring1="Defending Ring", ring2="Sheltered Ring",ear1="Brutal Earring",ear2="Ethereal Earring"}
	
	sets.idle.Pet = sets.idle

    sets.idle.Pet.Engaged = set_combine(sets.idle, sets.defense.MDT, {legs="Valorous Hose",feet="Skadi's Jambeaux +1"})
	
	sets.idle.Town = set_combine(sets.idle, {head="Midras's Helm +1",neck="Smithy's Torque",body="Blacksmith's Apron",hands="Smithy's Mitts",ring1="Craftmaster's Ring",ring2="Orvail Ring"})

    -- DEFENSE SETS
	--Emergency sets that override other states
    sets.defense.PDT = {
        neck="Twilight Torque",
        ring1="Defending Ring",
		ring2="Epona's Ring",
        back="Metallon Mantle",
		waist="Nierenschutz"
	}

    sets.defense.MDT = {
		legs="Taeon Tights",
		feet="Taeon Boots",
        neck="Twilight Torque",
        ring1="Defending Ring",
		ring2="Epona's Ring",
        waist="Nierenschutz"
	}
	
	sets.defense.Hybrid = {
		legs="Taeon Tights",
		feet="Taeon Boots",
        neck="Twilight Torque",
        ring1="Defending Ring",
		ring2="Epona's Ring",
		}



    --------------------------------------
    -- Engaged sets
    --------------------------------------

    sets.engaged = {
		sub="Beatific Shield +1",
		ammo="Ginsen",
		head="Valorous Mask",
		body="Acro Surcoat",
		hands="Despair Finger Gauntlets",
		legs="Taeon Tights",
		feet="Taeon Boots",
		neck="Sanctity Necklace",
		waist="Cetl Belt",
		back="Atheling Mantle",
		ring1="Rajas Ring",
		ring2="Epona's Ring",
		ear1="Brutal Earring",
		ear2="Aesir Ear Pendant"
	}
	
	sets.engaged.Normal = sets.engaged
	
	sets.engaged.Hybrid = set_combine(sets.engaged, sets.defense.Hybrid)
	
	sets.engaged.Acc = {ammo="Ginsen",head="Valorous Mask",body="Acro Surcoat",hands="Despair Finger Gauntlets",legs="Valorous Hose",feet="Despair Greaves",neck="Sanctity Necklace",waist="Kentarch Belt",back="Grounded Mantle",ring1="Epona's Ring",ring2="Rajas Ring",ear1="Brutal Earring",ear2="Aesir Ear Pendant"}
    
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
    
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
--TIME REDUCTION IS WORKING HERE
function job_precast(spell, action, spellMap, eventArgs)
    -- Define class for Sic and Ready moves.
    if ( Physical_Ready_Moves:contains(spell.english) or Magical_Ready_Moves:contains(spell.english) ) and pet.status == 'Engaged' then
        equip(sets.midcast.Pet.Recast)
    end
end

function job_pet_midcast(spell, action, spellMap, eventArgs)
	if Physical_Ready_Moves:contains(spell.english) and pet.status == 'Engaged' then
        equip(sets.midcast.Pet.WS)

	elseif Magical_Ready_Moves:contains(spell.english) and pet.status == 'Engaged' then
		equip(sets.midcast.Pet.MA)

    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Reward Mode' then
        -- Thena, Zeta or Eta
        RewardFood.name = "Pet Food " .. newValue
    elseif stateField == 'Pet Mode' then
        state.CombatWeapon:set(newValue)
	elseif stateField == 'Offense Mode' then
		if newValue == 'Hybrid' then
			enable('main', 'sub', 'range')
			equip(sets.engaged.Normal)
			disable('main', 'sub', 'range')
		elseif newValue == 'Locked' then
			enable('main', 'sub', 'range')
			equip(sets.engaged.Normal)
			disable('main', 'sub', 'range')
		elseif newValue == 'Acc' then
			enable('main', 'sub', 'range')
			equip(sets.engaged.Normal.Acc)
			disable('main', 'sub', 'range')
		elseif newValue == 'Free' then
			enable('main', 'sub', 'range')
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

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

    msg = msg .. ', Reward: ' ..state.RewardMode.value..

    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(6, 5)
end
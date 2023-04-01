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

    -- Set up Monster Correlation Modes and keybind Alt-F8

    
    -- Custom pet modes for engaged gear
    state.PetMode = M{['description']='Pet Mode', 'Normal', 'PetStance', 'PetTank'}
		
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
    state.OffenseMode:options('Free', 'Locked', 'Acc')
    state.WeaponskillMode:options('Normal')
    state.IdleMode:options('Normal', 'Refresh', 'Reraise')
    state.PhysicalDefenseMode:options('None', 'PDT', 'Hybrid', 'Killer')



end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    -- Unbinds the Reward and Correlation hotkeys.
    send_command('unbind ^f8')
    send_command('unbind !f8')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------




    -- PET SIC & READY MOVES
	
	--THIS IS EQUIPPING FOR MAGIC DAMAGE
    sets.midcast.Pet.MA = {
		head="Valorous Mask",
		body="Acro Surcoat",
		hands="Frn. Manoplas +1",
		legs="Valorous Hose",
		feet="Despair Greaves"
	}
	
	sets.midcast.Pet.WS = {
		head="Valorous Mask",
		body="Acro Surcoat",
		hands="Frn. Manoplas +1",
		legs="Valorous Hose",
		feet="Despair Greaves"
		}
	
	--THIS IS EQUIPPING FOR PRECAST TIMER
	sets.midcast.Pet.Recast = {main="Kumbhakarna",sub="Charmer's Merlin",legs="Desultor Tassets"}


    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------


    -- IDLE SETS
    sets.idle = {
	head=empty,
	body=empty,
	hands=empty,
	legs=empty,
	feet=empty
	}

	
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


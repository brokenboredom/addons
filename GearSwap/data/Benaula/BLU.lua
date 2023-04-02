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
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
    
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false

    blue_magic_maps = {}
    
    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.
    
    -- Physical Spells --
    
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{
        'Bilgestorm'
    }

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{
        'Heavy Strike',
    }

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Goblin Rush','Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
        'Quad. Continuum','Frypan','Uppercut','Vertical Cleave'
    }
        
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Merman','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
        'Vanity Dive'
    }
        
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Sprout Smack','Sub-zero Smash'
    }
	blue_magic_maps.PhysicalDef = S{
        'Cannonball',
    }
        
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'
    }

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        '1000 Needles','Mandibular Bite','Queasyshroom'
    }

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver','Tourbillion'
    }

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{
        'Bludgeon'
    }

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{
        'Final Sting'
    }

    -- Magical Spells --

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Corrosive Ooze','Blitzstrahl','Blastbomb','Bomb Toss','Cold Wave',
		'Blazing Bound','Cursed Sphere','Dark Orb','Death Ray',
        'Diffusion Ray','Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
        'Ice Break','Leafstorm','Maelstrom','Rail Cannon','Regurgitation','Rending Deluge',
        'Retinal Glare','Sandspin','Subduction','Tem. Upheaval','Water Bomb'
    }
	blue_magic_maps.MagicalStr = S{
		
	}

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{
        'Mind Blast','Hecatomb Wave','Heat Breath','Acrid Stream','Evryone. Grudge',
		'Magic Hammer','Radiant Breath'
    }

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Eyes On Me','Mysterious Light'
    }

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{
        'Thermal Pulse'
    }

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{
        'Charged Whisker','Gates of Hades'
    }
            
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        'Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Chaotic Eye',
        'Cimicine Discharge','Demoralizing Roar',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'
    }
        
    -- Breath-based spells
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath',
        'Magnetite Cloud','Poison Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'
    }

    -- Stun spells
    blue_magic_maps.Stun = S{
        'Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage','Head Butt',
    }
        
    -- Healing spells
    blue_magic_maps.Healing = S{
        'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
        'Wild Carrot'
    }
    
    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{
        'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Plasma Charge',
        'Pyric Bulwark','Reactor Cool',
    }

    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
        'Memento Mori','Nat. Meditation','Occultation','Orcish Counterstance','Refueling',
        'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
        'Zephyr Mantle','Blood Drain','Blood Saber','Digest',
    }
    
    
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
        'Crashing Thunder','Droning Whirlwind','Gates of Hades','Harden Shell','Polar Roar',
        'Pyric Bulwark','Thunderbolt','Tourbillion','Uproot'
    }
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Haste', 'Evasion', 'Refresh', 'Acc', 'Unlocked')
    state.HybridMode:options('Normal', 'Haste', 'Evasion')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
	state.PhysicalDefenseMode:options('None', 'PDT')
	state.MagicalDefenseMode:options('None', 'MDT', 'Water', 'Fire')
	disable('main','sub','range')
	
    select_default_macro_book()
end


-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    sets.buff['Burst Affinity'] = {}
    sets.buff['Chain Affinity'] = {}
    sets.buff.Convergence = {}
    sets.buff.Diffusion = {}
    sets.buff.Enchainment = {}
    sets.buff.Efflux = {}

    
    -- Precast Sets

	-- Waltz set (chr) then vit
    sets.precast.Waltz = {
		head="errant hat",
		neck="temp. torque",
		body="errant hpl.",
		ring1="Moon Ring",
		ring2="Moon Ring",
		back="Prism Cape",
		waist="Corsette +1",
		legs="errant slops",
		feet="dance shoes +1"
	}
	
    -- Fast cast sets for spells

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		head="dusk mask",
		body="scp. harness +1",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Merman's Earring",
		hands="Alkyoneus's Brc.",
		ring1="Rajas Ring",
		ring2="sniper's Ring +1",
		back="Amemet Mantle +1",
		waist="Potent Belt",
		legs="dusk trousers +1",
		feet="rutter sabatons",
	}

	--INT
	sets.precast.WS['Sanguine Blade'] = {
		head="magus keffiyeh",
		body="blood scale mail",
		neck="Prudence Torque",
		ear1="morion Earring +1",
		ear2="moldavite Earring",
		hands="errant cuffs",
		ring1="omniscient Ring",
		ring2="zircon ring",
		back="Prism Cape",
		waist="al zahbi sash",
		legs="errant slops",
		feet="mirage charuqs",
	}
    
    --ELEMENTAL STAVES
	sets.ElementalStaff = {main="Chatoyant Staff"}
		sets.ElementalStaff.Fire = {main="Chatoyant Staff"}
		sets.ElementalStaff.Wind = {main="Chatoyant Staff"}
		sets.ElementalStaff.Water = {main="Chatoyant Staff"}
		sets.ElementalStaff.Earth = {main="Terra's Staff"}
		sets.ElementalStaff.Lightning = {main="Chatoyant Staff"}
		sets.ElementalStaff.Ice = {main="Chatoyant Staff"}
		sets.ElementalStaff.Light = {main="Chatoyant Staff"}
		sets.ElementalStaff.Dark = {main="Chatoyant Staff"}
		
    sets.midcast['Blue Magic'] = {}
    	--Interrupt% applied post_midcast
    sets.midcast.Resistant = {
		legs="Magus Shalwar",
		waist="volunteer's belt",
	}
    -- Physical Spells --
    
    sets.midcast['Blue Magic'].Physical = {
		head="mirage keffiyeh",
		body="Magus Jubbah",
		neck="fortitude torque",
		ear1="Merman's Earring",
		ear2="Merman's Earring",
		hands="Alkyoneus's Brc.",
		ring1="Rajas Ring",
		ring2="sniper's Ring +1",
		back="Amemet Mantle +1",
		waist="potent Belt",
		legs="mirage shalwar",
		feet="mirage charuqs",
	}

    sets.midcast['Blue Magic'].PhysicalAcc = sets.midcast['Blue Magic'].Physical

    sets.midcast['Blue Magic'].PhysicalStr = sets.midcast['Blue Magic'].Physical

    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {
		hands="mirage bazubands",
		waist="warwolf Belt",
		legs="dusk trousers +1",
		feet="blood greaves",
	})

    sets.midcast['Blue Magic'].PhysicalVit = sets.midcast['Blue Magic'].Physical
	sets.midcast['Blue Magic'].PhysicalDef = set_combine(sets.midcast['Blue Magic'].Physical, {
		head="blood mask",
		neck="chivalrous chain",
		ear1="elusive earring",
		ear2="elusive earring",
		body="blood scale mail",
		hands="blood fng. gnt.",
		ring1="lava's ring",
		ring2="kusha's ring",
		back="shadow mantle",
		waist="potent belt",
		legs="blood cuisses",
		feet="blood greaves",
	})
    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {
		hands="mirage bazubands",
		legs="dusk trousers +1",
		feet="blood greaves",
	})

    sets.midcast['Blue Magic'].PhysicalInt = sets.midcast['Blue Magic'].Physical

    sets.midcast['Blue Magic'].PhysicalMnd = sets.midcast['Blue Magic'].Physical

    sets.midcast['Blue Magic'].PhysicalChr = sets.midcast['Blue Magic'].Physical

    sets.midcast['Blue Magic'].PhysicalHP = sets.midcast['Blue Magic'].Physical


    -- Magical Spells --
    --WSC As if you used a EleWS
	--As well as dStat bonus
    sets.midcast['Blue Magic'].Magical = {
		head="Errant Hat",
		body="blood scale mail",
		neck="prudence torque",
		ear2="Moldavite Earring",
		ear1="Morion Earring +1",
		hands="Errant Cuffs",
		ring1="Rajas Ring",
		ring2="Omniscient Ring",
		back="Prism Cape",
		waist="Al Zahbi Sash",
		legs="Mirage Shalwar",
		feet="Mirage Charuqs",
	}
    
	sets.midcast['Blue Magic'].MagicalStr = sets.midcast['Blue Magic'].Magical
	
    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {
		neck="Enlightened Chain",
		ear1="Star Earring",
		hands="Mirage Bazubands",
		ring1="Aqua Ring",
		ring2="Aqua Ring",
	})

    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {
		neck="temp. torque",
		hands="Errant Cuffs",
		ring1="Omniscient Ring",
		ring2="Moon Ring",
		waist="Corsette +1",
		feet="dance shoes +1",
	})

    sets.midcast['Blue Magic'].MagicalVit = sets.midcast['Blue Magic'].Magical

    sets.midcast['Blue Magic'].MagicalDex = sets.midcast['Blue Magic'].Magical

	--Skill, Int, Mag. Acc
	--Evasion and Interrupt% for good measure
    sets.midcast['Blue Magic'].MagicAccuracy = {
		head="mirage keffiyeh",
		body="magus jubbah",
		neck="prudence torque",
		ear1="Morion Earring +1",
		hands="Errant Cuffs",
		ring1="zircon Ring",
		ring2="Omniscient Ring",
		back="Prism Cape",
		waist="Al Zahbi Sash",
		legs="Mirage Shalwar",
		feet="Mirage Charuqs",
	}

    -- Breath Spells --
    
    sets.midcast['Blue Magic'].Breath = sets.midcast['Blue Magic'].MagicalMnd

    -- Other Types --
    
    sets.midcast['Blue Magic'].Stun = {
		head="mirage keffiyeh",
		body="Magus Jubbah", --15 skill
		neck="Peacock Amulet",
		ear2="Elusive Earring",
		ear1="Elusive Earring",
		hands="dusk gloves +1",
		ring1="lava's Ring",
		ring2="kusha's Ring",
		back="Shadow Mantle",
		waist="potent Belt",
		legs="Mirage Shalwar",
		feet="magus charuqa",
	}

    sets.midcast['Blue Magic'].Healing = set_combine(sets.midcast['Blue Magic'].MagicalMnd, sets.midcast.Resistant)

    sets.midcast['Blue Magic'].SkillBasedBuff = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, sets.midcast.Resistant)

    sets.midcast['Blue Magic'].Buff = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, sets.midcast.Resistant)
    

    
    -- Sets to return to when not performing an action.


    
    
    -- Idle sets
    sets.idle = {
		head="blood mask",
		body="mirage jubbah",
		neck="Orochi Nodowa +1",
		ear1="merman's Earring",
		ear2="merman's Earring",
		hands="blood fng. gnt.",
		ring1="merman's Ring",
		ring2="defending Ring",
		back="umbra cape",
		waist="scouter's rope",
		legs="blood cuisses",
		feet="blood greaves",
	}

    sets.idle.PDT = sets.idle
	
	-- Resting sets
    sets.resting = set_combine(sets.idle, {
		main="Dark Staff",
		body="errant hpl.",
		waist="hierarch belt",
	})
    
    -- Defense sets
    sets.defense.PDT = {
		ring1="jelly ring",
		ring2="defending ring",
		back="umbra cape",
	}

    --25% MDT
	sets.defense.MDT = {
		head="coral visor +1", --2
		ear1="merman's Earring", --2
		ear2="merman's Earring", --2
		body="cor. scale mail +1", --4
		hands="coral fng. gnt. +1", --2
		ring1="merman's Ring", --4
		ring2="defending ring", --10
		back="lamia mantle +1",
		legs="coral cuisses +1", --3
		feet="coral greaves +1", --2
	}
	sets.defense.Water = set_combine(sets.defense.MDT, {
		neck="Orochi Nodowa +1",
		ear1="Star Earring",
		ear2="Star Earring",
		body="Scp. Harness +1",
	})
	sets.defense.Fire = {
		head="black ribbon",
		neck="Orochi Nodowa +1",
		ear1="Star Earring",
		ear2="Star Earring",
	}

    sets.Kiting = {legs="Blood Cuisses"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
	--haste
    sets.engaged = {
		head="homam zucchetto",
		body="mirage jubbah",
		neck="fortitude torque",
		ear1="Brutal Earring",
		ear2="Elusive Earring",
		hands="Dusk Gloves +1",
		ring1="rajas Ring",
		ring2="defending Ring",
		back="umbra cape",
		waist="Velocious Belt",
		legs="mirage shalwar",
		feet="homam gambieras",
	}
	sets.engaged.Evasion = {
		head="Wivre Mask +1",
		body="Scp. Harness +1",
		neck="evasion torque",
		ear1="Elusive Earring",
		ear2="Elusive Earring",
		hands="Mirage Bazubands",
		ring1="rajas Ring",
		ring2="defending Ring",
		back="boxer's mantle",
		waist="scouter's rope",
		legs="mirage shalwar",
		feet="Magus Charuqs",
	}

    sets.engaged.Refresh = set_combine(sets.engaged, {
		body="mirage jubbah",
	})
	sets.engaged.Refresh.Evasion = set_combine(sets.engaged.Evasion, {body="mirage jubbah"})

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
		equip(sets.ElementalStaff[spell.element])
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
				equip(sets.ElementalStaff[spell.element])
            end
        end
	end
	if state.CastingMode == 'Resistant' then
		equip(sets.midcast.Resistant)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' and newValue == 'Unlocked' then
		enable('main','sub','range')
	else
		enable('main','sub','range')
		equip({main="martial anelace"})
		equip({sub="Demon Slayer"})
		disable('main','sub','range')
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

function customize_melee_set(meleeSet)
	if player.equipment.sub == "Demon Slayer" then
		meleeSet = set_combine(meleeSet, {ear2="Suppanomimi"})
	end
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
------------------------------------------------------------------------------------------------------------------
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 18)
end

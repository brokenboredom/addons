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

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Death', 'Burst')
    state.IdleMode:options('Normal', 'PDT','Death')
    
    state.MagicBurst = M(false, 'Magic Burst')

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga'}

	gear.burst_ammo = {name="Pemphredo Tathlum"}
    gear.burst_hat = {name="Merlinic Hood", augments={'INT+3','Mag. Acc.+15','"Mag. Atk. Bns."+10','Magic burst mdg. +9%'}}
	gear.burst_neck = {name="Mizu. Kubikazari"}
	gear.burst_ear1 = {name="Friomisi Earring"}
	gear.burst_ear2 = {name="Barkaro. Earring"}
	gear.burst_body = {name="Spaekona's Coat +1"}
	gear.burst_hands = {name="Amalric Gages"}
	gear.burst_ring1 = {name="Acumen Ring"}
	gear.burst_ring2 = {name="Mujin Band"}
	gear.burst_waist = {name="Eschan Stone"}
	gear.burst_legs = {name="Merlinic Shalwar", augments={'INT+6','Mag. Acc.+6','"Mag. Atk. Bns."+13','Magic burst mdg. +11%'}}
	gear.burst_feet = {name="Merlinic Crackows", augments={'Mag. Acc.+15','"Mag. Atk. Bns."+19','Magic burst mdg. +11%'}}
	gear.FC_hat = {name="Merlinic Hood", augments={'MND+2','"Fast Cast"+7'}}
	gear.FC_feet = {name="Merlinic Crackows", augments={'MND+2','"Mag. Atk. Bns."+14','"Fast Cast"+5'}}
    
    -- Additional local binds
    send_command('bind ^` input /ma Stun <t>')
    send_command('bind @` gs c activate MagicBurst')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {feet="Goetia Sabots +2"}

    sets.precast.JA.Manafont = {body="Sorcerer's Coat +2"}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {head="Merlinic Hood", augments={'MND+2','"Fast Cast"+7'},ear2="Loquacious Earring",
        waist="Channeler's Stone",legs="Psycloth Lappas",
		feet="Merlinic Crackows", augments={'MND+2','"Mag. Atk. Bns."+14','"Fast Cast"+5'}}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {neck="Stoicheion Medal"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="Heka's Kalasiris", back="Pahtli Cape",
		ear1="Mendi. Earring",feet="Vanya Clogs"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	sets.precast.FC.Death = sets.precast.FC
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {body="Twilight Cloak"})

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Hagondes Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Icesoul Ring",
        back="Refraction Cape",waist="Cognition Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {ammo="Dosis Tathlum",
        head="Hagondes Hat",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Acumen Ring",
        back="Toro Cape",waist="Thunder Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}
	
	sets.precast.WS['Myrkr'] = {head="Oneiros Headgear",neck="Sanctity Necklace",ear1="Moonshade Earring",ear2="Evans Earring",
		body="Revealer's Tunic",ring1="Mephitas's Ring",ring2="Zodiac Ring",
		legs="Psycloth Lappas"}
    
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {
        head="Nahtirah Hat",ear2="Loquacious Earring",
        body="Vanir Cotehardie",hands="Bokwus Gloves",ring1="Prolix Ring",
        back="Swith Cape +1",waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

    sets.midcast.Cure = {
        head="Vanya Hood",neck="Colossus's Torque",ear1="Mendi. Earring",ear2="Loquacious Earring",
        body="Vanya Robe",hands="Telchine Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Tampered Cape +1",waist=gear.ElementalObi,legs="Hagondes Pants",feet="Vanya Clogs"}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
        neck="Colossus's Torque",
        body="Manasa Chasuble",hands="Ayao's Gages",
        legs="Portent Pants",feet="Inspirited Boots"}
    
	sets.midcast.Refresh = {feet="Inspirited Boots"}
	
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast['Enfeebling Magic'] = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Sturm's Report",
        head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Vanya Robe",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Eschan Stone",legs="Psycloth Lappas",feet="Bokwus Boots"}
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Sturm's Report",
        head="Nahtirah Hat",neck="Aesir Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Goading Belt",legs="Bokwus Slops",feet="Bokwus Boots"}

    sets.midcast.Drain = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Sturm's Report",
        head="Nahtirah Hat",neck="Aesir Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Excelsis Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Fucho-no-Obi",legs="Bokwus Slops",feet="Goetia Sabots +2"}
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Sturm's Report",
        head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Witful Belt",legs="Orvail Pants +1",feet="Bokwus Boots"}

    sets.midcast.BardSong = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Sturm's Report",
        head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Sangoma Ring",
        back="Refraction Cape",legs="Bokwus Slops",feet="Bokwus Boots"}


    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {sub="Niobid Strap",ammo="Pemphredo Tathlum",
        head=gear.burst_hat,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Barkaro. Earring",
        body="Spae. Coat +1",hands="Amalric Gages",ring1="Acumen Ring",ring2="Strendu Ring",
        waist="Eschan Stone",legs=gear.burst_legs,feet=gear.burst_feet}
	
	sets.midcast.Death = {head=gear.burst_hat,neck=gear.burst_neck,ear1="Evans Earring",ear2=gear.burst_ear2,
		body="Revealer's Tunic",hands=gear.burst_hands,ring1="Mephitas's Ring",ring2=gear.burst_ring2,
		waist=gear.burst_waist,legs=gear.burst_legs,feet=gear.burst_feet}
	
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})
	
	sets.midcast['Elemental Magic'].Burst = {head=gear.burst_hat,neck=gear.burst_neck,ear1=gear.burst_ear1,ear2=gear.burst_ear2,
		body=gear.burst_body,hands=gear.burst_hands,ring1=gear.burst_ring1,ring2=gear.burst_ring2,
		waist=gear.burst_waist,legs=gear.burst_legs,feet=gear.burst_feet}

    sets.midcast['Elemental Magic'].Resistant = {main="Lehbrailg +2",sub="Zuuxowu Grip",ammo="Dosis Tathlum",
        head="Hagondes Hat",neck="Eddy Necklace",ear1="Hecate's Earring",ear2="Friomisi Earring",
        body="Hagondes Coat",hands=gear.macc_hagondes,ring1="Icesoul Ring",ring2="Acumen Ring",
        back="Toro Cape",waist=gear.ElementalObi,legs="Hagondes Pants",feet="Bokwus Boots"}

    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {sub="Wizzan Grip"})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {sub="Wizzan Grip"})


    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = {main="Earth Staff", sub="Mephitis Grip",ammo="Impatiens",
        head="Nahtirah Hat",neck="Twiligh Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Manasa Chasuble",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Nares Trews",feet="Chelona Boots +1"}


    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Chatoyant Staff",ammo="Clarus Stone",
        head="Nefer Khat +1",neck="Grandiose Chain",
        body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt",legs="Nares Trews",feet="Serpentes Sabots"}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {head=gear.burst_hat,neck="Sanctity Necklace",ear1="Ethereal Earring",ear2="Barkaro. Earring",
        body="Revealer's Tunic",ring1="Acumen Ring",ring2="Strendu Ring",
        legs="Assid. Pants +1",feet="Inspirited Boots"}
		
	--Death Idle set to prevent MP loss
	sets.idle.Death = {neck="Sanctity Necklace",ear2="Gifted Earring",ring2="Zodiac Ring",legs="Assid. Pants +1",
		feet="Inspirited Boots"}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {main="Earth Staff", sub="Zuuxowu Grip",ammo="Impatiens",
        head="Nahtirah Hat",neck="Twiligh Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Umbr Cape",waist="Hierarch Belt",legs="Hagondes Pants",feet="Herald's Gaiters"}

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",ammo="Impatiens",
        head="Hagondes Hat",neck="Twiligh Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Umbr Cape",waist="Hierarch Belt",legs="Nares Trews",feet="Hagondes Sabots"}
    
    -- Town gear.
    sets.idle.Town = {main="Lehbrailg +2", sub="Zuuxowu Grip",ammo="Impatiens",
        head="Hagondes Hat",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Umbr Cape",waist="Hierarch Belt",legs="Hagondes Pants",feet="Herald's Gaiters"}
        
    -- Defense sets

    sets.defense.PDT = {main="Earth Staff",sub="Zuuxowu Grip",
        head="Nahtirah Hat",neck="Twiligh Torque",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Umbr Cape",waist="Hierarch Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Nahtirah Hat",neck="Twiligh Torque",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Tuilha Cape",waist="Hierarch Belt",legs="Bokwus Slops",feet="Hagondes Sabots"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {feet="Goetia Sabots +2"}

    sets.magic_burst = {neck="Mizukage-no-Kubikazari"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head="Zelus Tiara",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Hagondes Coat",hands="Bokwus Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Umbr Cape",waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Goading Belt"
    elseif spell.skill == 'Elemental Magic' then
        gear.default.obi_waist = "Sekhmet Corset"
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.english == 'Death' then
		equip(sets.midcast.Death)
	end
	if state.CastingMode.current == 'Burst' then
		equip(sets.midcast['Elemental Magic'].Burst)
	end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        elseif spell.skill == 'Elemental Magic' then
            state.MagicBurst:reset()
		elseif spell.english == 'Death' then
			equip(sets.idle.Death)
			eventArgs.handled = true
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
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('feet')
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        --[[ No real need to differentiate with current gear.
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
        --]]
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 5)
end

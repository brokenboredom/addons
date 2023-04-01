function user_setup()
    select_default_macro_book()
end

function get_sets()
    TP_Index = 1
    Idle_Index = 1

	sets.JA = {}
	sets.JA.Waltz = {legs="Desultor Tassets"}
    
	sets.WS = {}
    sets.WS.Evisceration = {head="Espial Cap",neck="Fotia Gorget",ear1="Aesir Ear Pendant",ear2="Brutal Earring",
        body="Rawhide Vest",hands="Espial Bracers",ring1="Epona's Ring",ring2="Rajas Ring",
        back="Atheling Mantle",waist="Fotia Belt",legs="Herculean Trousers",feet="Espial Socks"}
    
    sets.WS["Mandalic Stab"] = {head="Espial Cap",neck="Fotia Gorget",ear1="Aesir Ear Pendant",ear2="Brutal Earring",
        body="Rawhide Vest",hands="Espial Bracers",ring1="Epona's Ring",ring2="Rajas Ring",
        back="Atheling Mantle",waist="Fotia Belt",legs="Herculean Trousers",feet="Espial Socks"}
		
	sets.WS["Aeolian Edge"] = set_combine(sets.WS.Evisceration, {ammo="Pemphredo Tathlum",
		head="Wayfarer Circlet",
		body="Wayfarer Robe",
		hands="Pursuer's Cuffs",
		legs="Wayfarer Slops",
		feet="Raider's Poulaines +2",
		neck="Sanctity Necklace",
		ring1="Acumen Ring",
		ear1="Hecate's Earring",
		ear2="Friomisi Earring",
		back="Toro Cape"})

    sets.WS.Exenterator = {head="Espial Cap",neck="Fotia Gorget",ear1="Aesir Ear Pendant",ear2="Brutal Earring",
        body="Rawhide Vest",hands="Espial Bracers",ring1="Epona's Ring",ring2="Rajas Ring",
        back="Atheling Mantle",waist="Fotia Belt",legs="Herculean Trousers",feet="Espial Socks"}
		
	sets.WS['Pyrrhic Kleos'] = {head="Espial Cap",neck="Fotia Gorget",ear1="Aesir Ear Pendant",ear2="Brutal Earring",
        body="Rawhide Vest",hands="Espial Bracers",ring1="Epona's Ring",ring2="Rajas Ring",
        back="Atheling Mantle",waist="Fotia Belt",legs="Herculean Trousers",feet="Espial Socks"}
    
    TP_Set_Names = {"Acc","EXP"}
    sets.TP = {ammo="Ginsen",head="Espial Cap",neck="Sanctity Necklace",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Rawhide Vest",hands="Plunderer's Armlets",ring1="Epona's Ring",ring2="Rajas Ring",
        back="Atheling Mantle",waist="Cetl Belt",legs="Herculean Trousers",feet="Rawhide Boots"}
		
	sets.TP.Acc = {ammo="Ginsen",head="Espial Cap",neck="Sanctity Necklace",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Rawhide Vest",hands="Espial Bracers",ring1="Epona's Ring",ring2="Rajas Ring",
        back="Atheling Mantle",waist="Cetl Belt",legs="Herculean Trousers",feet="Rawhide Boots"}

    
    Idle_Set_Names = {'Normal','EXP'}
    sets.Idle = {}
    sets.Idle.Normal = {head="Espial Cap",neck="Twilight Torque",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Rawhide Vest",hands="Espial Bracers",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Atheling Mantle",waist="Cetl Belt",legs="Herculean Trousers",feet="Skadi's Jambeaux +1"}
                
    sets.Idle.EXP = {head="Espial Cap",neck="Twilight Torque",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Rawhide Vest",hands="Espial Bracers",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Aptitude Mantle",waist="Cetl Belt",legs="Herculean Trousers",feet="Skadi's Jambeaux +1"}
end

function precast(spell)
    if sets.JA[spell.english] then
        equip(sets.JA[spell.english])
	elseif string.find(spell.english,'Utsu') then
		equip(sets.Spell.Utsu)
    elseif spell.type=="WeaponSkill" then
        if sets.WS[spell.english] then
			equip(sets.WS[spell.english])
		end
    elseif string.find(spell.english,'Waltz') then
        equip(sets.JA.Waltz)
    end
end

function aftercast(spell)
    if player.status=='Engaged' then
        equip(sets.TP[TP_Set_Names[TP_Index]])
    else
        equip(sets.Idle[Idle_Set_Names[Idle_Index]])
    end
end

function status_change(new,old)
    if T{'Idle','Resting'}:contains(new) then
        equip(sets.Idle[Idle_Set_Names[Idle_Index]])
    elseif new == 'Engaged' then
        equip(sets.TP[TP_Set_Names[TP_Index]])
    end
end

function self_command(command)
    if command == 'toggle TP set' then
        TP_Index = TP_Index +1
        if TP_Index > #TP_Set_Names then TP_Index = 1 end
        send_command('@input /echo ----- TP Set changed to '..TP_Set_Names[TP_Index]..' -----')
        equip(sets.TP[TP_Set_Names[TP_Index]])
    elseif command == 'toggle Idle set' then
        Idle_Index = Idle_Index +1
        if Idle_Index > #Idle_Set_Names then Idle_Index = 1 end
        send_command('@input /echo ----- Idle Set changed to '..Idle_Set_Names[Idle_Index]..' -----')
        equip(sets.Idle[Idle_Set_Names[Idle_Index]])
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(7, 3)
end
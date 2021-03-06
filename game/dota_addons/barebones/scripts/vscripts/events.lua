require("libraries/playertables")
require("libraries/selection")

-- Cleanup a player when they leave
function GameMode:OnDisconnect(keys)
local name = keys.name
local networkid = keys.networkid
local reason = keys.reason
local userid = keys.userid

	CloseLane(userid)
end

function GameMode:OnSettingVote(keys)
local pid = keys.PlayerID
local mode = GameMode

	-- VoteTable is initialised in InitGameMode()
	if not mode.VoteTable[keys.category] then
		mode.VoteTable[keys.category] = {}
	end
	mode.VoteTable[keys.category][pid] = keys.vote

	--PrintTable(mode.VoteTable)
end

-- An NPC has spawned somewhere in game. This includes heroes
function GameMode:OnNPCSpawned(keys)
local difficulty = GameRules:GetCustomGameDifficulty()
local npc = EntIndexToHScript(keys.entindex)
local normal_bounty = npc:GetGoldBounty()
local normal_xp = npc:GetDeathXP()
local normal_min_damage = npc:GetBaseDamageMin()
local normal_max_damage = npc:GetBaseDamageMax()
local hero_level = npc:GetLevel()
local too_ez = 1.1 -- The mod is way too ez, to modify damage very easily i just silenly add + 10% everywhere
local too_ez_gold = 0.9 -- The mod is way too ez, to modify gold very easily i just silenly remove 10% of it

	if difficulty == 1 and not npc:IsHero() and npc:GetTeam() == DOTA_TEAM_BADGUYS then
		npc:SetMinimumGoldBounty( normal_bounty*1.5*too_ez_gold )
		npc:SetMaximumGoldBounty( normal_bounty*1.5*too_ez_gold )
		npc:SetDeathXP( normal_xp*1.25 )
		npc:SetBaseDamageMin( normal_min_damage*0.75*too_ez )
		npc:SetBaseDamageMax( normal_max_damage*0.75*too_ez )
	elseif difficulty == 2 and not npc:IsHero() and npc:GetTeam() == DOTA_TEAM_BADGUYS then
		npc:SetMinimumGoldBounty( normal_bounty*1.1*too_ez_gold )
		npc:SetMaximumGoldBounty( normal_bounty*1.1*too_ez_gold )
		npc:SetDeathXP( normal_xp )
		npc:SetBaseDamageMin( normal_min_damage*too_ez )
		npc:SetBaseDamageMax( normal_max_damage*too_ez )
	elseif difficulty == 3 and not npc:IsHero() and npc:GetTeam() == DOTA_TEAM_BADGUYS then
		npc:SetMinimumGoldBounty( normal_bounty*too_ez_gold )
		npc:SetMaximumGoldBounty( normal_bounty*too_ez_gold )
		npc:SetDeathXP( normal_xp*0.9 )
		npc:SetBaseDamageMin( normal_min_damage*1.25*too_ez )
		npc:SetBaseDamageMax( normal_max_damage*1.25*too_ez )
	elseif difficulty == 4 and not npc:IsHero() and npc:GetTeam() == DOTA_TEAM_BADGUYS then
		npc:SetMinimumGoldBounty( normal_bounty*too_ez_gold )
		npc:SetMaximumGoldBounty( normal_bounty*too_ez_gold )
		npc:SetDeathXP( normal_xp*0.75 )
		npc:SetBaseDamageMin( normal_min_damage*1.5*too_ez )
		npc:SetBaseDamageMax( normal_max_damage*1.5*too_ez )
	end

	if npc:GetUnitName() == "npc_dota_hero_tiny" then
		npc:AddAbility("tiny_grow")
		grow = npc:FindAbilityByName("tiny_grow")
		grow:SetLevel(1)
		npc:SetModelScale( 1.1 )
		Timers:CreateTimer(0.35, function()
			npc:RemoveAbility("tiny_grow")
		end)
	end

	--debug
	if npc:GetUnitName() == "npc_dota_hero_tiny" and hero_level >= 20 then
		local ability = npc:FindAbilityByName("holdout_war_club_20")
		npc:RemoveModifierByName("modifier_item_ultimate_scepter_consumed")
		npc:RemoveModifierByName("modifier_item_ultimate_scepter_consumed")
		npc:AddNewModifier(npc, ability, "modifier_item_ultimate_scepter_consumed", {})
	end

	if npc:GetUnitName() == "npc_dota_hero_chaos_knight" then
		npc:SetAbilityPoints(0)
	end

	if npc:GetUnitName() == "npc_dota_hero_keeper_of_the_light" then
		npc:SetAbilityPoints(0)
	end

	-- List of innate abilities
	local innate_abilities = {
		"dummy_passive_vulnerable_wisp",
		"serpent_splash_arrows",
		"neutral_spell_immunity",
		"holdout_innate_lunar_glaive",
		"holdout_innate_great_cleave",
		"holdout_blink",
		"holdout_poison_attack",
		"forest_troll_high_priest_heal",
		"holdout_mana_shield",
		"holdout_berserkers_rage",
		"holdout_rejuvenation",
		"holdout_resistant_skin",
		"holdout_roar",
		"shadow_shaman_shackles",
		"holdout_command_aura_innate",
		"holdout_frost_frenzy",
		"holdout_sleep",
		"juggernaut_healing_ward",
		"holdout_thunder_spirit",
		"holdout_cripple",
		"blood_mage_orbs",
		"holdout_taunt",
		"holdout_banish",
		"holdout_magic_shield",
		"holdout_anubarak_claw",
		"undead_burrow",
		"ogre_magi_bloodlust",
		"holdout_beastmaster_misc",
		"holdout_frostmourne_hungers",
		"holdout_battlecry_alt2",
		"holdout_rabid_alt2",
		"lone_druid_spirit_bear_demolish",
		"lone_druid_spirit_bear_entangle",
		"holdout_divided_we_stand_hidden",
		"holdout_frostmourne_innate",
		"holdout_strength_of_the_wild",
		"holdout_reincarnation",
		"holdout_power_mount_str",
		"holdout_power_mount_int",
		"holdout_power_mount_agi",
		"holdout_mechanism",
		"holdout_dark_cleave",
		"holdout_skin_changer_caster",
		"holdout_skin_changer_warrior",
		"holdout_health_buff",
		"pugna_decrepify",
		"holdout_giant_form",
		"holdout_monkey_king_bar",
		"holdout_stitch",
		"troll_warlord_berserkers_rage",
		"holdout_random_hero",
		"holdout_spellsteal",
		"bristleback_warpath",
		"iron_man_misc",
		"holdout_spirit_int",
		"holdout_spirit_str",
		"holdout_spirit_agi",
		"holdout_yellow_effect",	--Desert Wyrm Ultimate effect
		"holdout_blue_effect",		--Lich King boss + hero effect
		"holdout_green_effect",		--Banehallow boss + hero effect
		"holdout_red_effect"		--Abaddon boss
	}

	-- Cycle through any innate abilities found, then upgrade them
	for i = 1, #innate_abilities do
		local current_ability = npc:FindAbilityByName(innate_abilities[i])
		if current_ability then
			current_ability:SetLevel(1)
		end
	end

	-- List of innate abilities
	local difficulty_abilities = {
		"huskar_berserkers_blood",
		"weaver_geminate_attack",
		"dragon_knight_dragon_blood",
		"undead_disease_cloud",
		"antimage_mana_break",
		"nevermore_dark_lord",
		"juggernaut_blade_dance",
		"viper_corrosive_skin",
		"creature_thunder_clap_low",
		"creature_death_pulse",
		"endurance_aura",
		"unholy_aura",
		"creature_thunder_clap",
		"command_aura",
		"grom_hellscream_mirror_image",
		"grom_hellscream_bladefury",
		"devotion_aura",
		"divine_aura",
		"proudmoore_divine_shield",
		"arthas_holy_light",
		"arthas_knights_armor",
		"arthas_light_roar",
		"roshan_stormbolt",
		"creature_starfall",
		"creature_firestorm",
		"demonhunter_evasion",
		"demonhunter_immolation",
		"demonhunter_immolation_small",
		"demonhunter_negative_energy",
		"demonhunter_negative_energy_small",
		"demonhunter_roar",
		"demonhunter_vampiric_aura",
		"howl_of_terror",
		"balanar_rain_of_chaos",
		"balanar_sleep",
		"banehallow_stampede",
		"creature_chronosphere",
		"venomancer_poison_sting",
		"lich_frost_armor",
		"holdout_lich_king_effects",
		"monkey_king_boundless_strike",
		"ursa_fury_swipes"
	}

	-- Cycle through any innate abilities found, then upgrade them
	for i = 1, #difficulty_abilities do
		local current_ability = npc:FindAbilityByName(difficulty_abilities[i])
		local difficulty = GameRules:GetCustomGameDifficulty()
		if current_ability and npc:GetTeam() == DOTA_TEAM_BADGUYS then
			current_ability:SetLevel(difficulty)
		elseif current_ability and npc:GetTeam() == DOTA_TEAM_CUSTOM_1 then
			current_ability:SetLevel(difficulty)
		end
	end

	if npc:GetTeam() == DOTA_TEAM_GOODGUYS and npc:IsRealHero() then
		for i = 1, #golden_vip_members do
			if npc:IsRealHero() then
				-- Cookies or X Hero Siege Official
				if PlayerResource:GetSteamAccountID(npc:GetPlayerID()) == mod_creator[i] then
					npc:SetCustomHealthLabel("Mod Creator", 200, 45, 45)
					if not npc:HasAbility("holdout_vip") then
						local vip_ability = npc:AddAbility("holdout_vip")
						vip_ability:SetLevel(1)
					end
				end
				-- Baumi
				if PlayerResource:GetSteamAccountID(npc:GetPlayerID()) == captain_baumi[i] then
					npc:SetCustomHealthLabel("Baumi Nation is real!", 55, 55, 200)
					if not npc:HasAbility("holdout_vip") then
						local vip_ability = npc:AddAbility("holdout_vip")
						vip_ability:SetLevel(1)
					end
				end
				-- Mugiwara or Flotos
				if PlayerResource:GetSteamAccountID(npc:GetPlayerID()) == mod_graphist[i] then
					npc:SetCustomHealthLabel("Mod Graphist", 55, 55, 200)
					if not npc:HasAbility("holdout_vip") then
						local vip_ability = npc:AddAbility("holdout_vip")
						vip_ability:SetLevel(1)
					end
				end
				-- See VIP List on Top
				if PlayerResource:GetSteamAccountID(npc:GetPlayerID()) == vip_members[i] then
					npc:SetCustomHealthLabel("VIP Member", 45, 200, 45)
					if not npc:HasAbility("holdout_vip") then
						local vip_ability = npc:AddAbility("holdout_vip")
						vip_ability:SetLevel(1)
					end
				end
				if PlayerResource:GetSteamAccountID(npc:GetPlayerID()) == golden_vip_members[i] then
					npc:SetCustomHealthLabel("Golden VIP Member", 218, 165, 32)
					if not npc:HasAbility("holdout_vip") then
						local vip_ability = npc:AddAbility("holdout_vip")
						vip_ability:SetLevel(1)
					end
				end
			end
		end
	end

	-- This internal handling is used to set up main barebones functions
	GameMode:_OnNPCSpawned(keys)
end

-- An entity somewhere has been hurt.  This event fires very often with many units so don't do too many expensive
-- operations here
function GameMode:OnEntityHurt(keys)
	local damagebits = keys.damagebits -- This might always be 0 and therefore useless
	if keys.entindex_attacker ~= nil and keys.entindex_killed ~= nil then
	local entCause = EntIndexToHScript(keys.entindex_attacker)
	local entVictim = EntIndexToHScript(keys.entindex_killed)

	-- The ability/item used to damage, or nil if not damaged by an item/ability
	local damagingAbility = nil

		if keys.entindex_inflictor ~= nil then
			damagingAbility = EntIndexToHScript( keys.entindex_inflictor )
		end
	end
end

-- An item was picked up off the ground
function GameMode:OnItemPickedUp(keys)
local heroEntity = EntIndexToHScript(keys.HeroEntityIndex)
local itemEntity = EntIndexToHScript(keys.ItemEntityIndex)
local player = PlayerResource:GetPlayer(keys.PlayerID)
local itemname = keys.itemname

end

-- A player has reconnected to the game. This function can be used to repaint Player-based particles or change
-- state as necessary
function GameMode:OnPlayerReconnect(keys)
local player_id = keys.PlayerID
	OpenLane(player_id)
end

-- An item was purchased by a player
function GameMode:OnItemPurchased( keys )
	-- The playerID of the hero who is buying something
	local plyID = keys.PlayerID
	if not plyID then return end

	-- The name of the item purchased
	local itemName = keys.itemname 
	
	-- The cost of the item purchased
	local itemcost = keys.itemcost
end

function GameMode:OnAbilityUsed(keys)
	local player = PlayerResource:GetPlayer(keys.PlayerID)
	local abilityname = keys.abilityname
end

function GameMode:OnNonPlayerUsedAbility(keys)
	local abilityname = keys.abilityname
end

function GameMode:OnPlayerChangedName(keys)
	local newName = keys.newname
	local oldName = keys.oldName
end

function GameMode:OnPlayerLearnedAbility(keys)
	local player = EntIndexToHScript(keys.player)
	local abilityname = keys.abilityname
end

function GameMode:OnAbilityChannelFinished(keys)
	local abilityname = keys.abilityname
	local interrupted = keys.interrupted == 1
end

function GameMode:OnPlayerLevelUp(keys)
local player = EntIndexToHScript(keys.player)
local level = keys.level
local hero = player:GetAssignedHero()
local hero_level = hero:GetLevel()

local AbilitiesHeroes_XX = {
		npc_dota_hero_abyssal_underlord = {{"lion_finger_of_death", 2}},
		npc_dota_hero_brewmaster = {{"enraged_wildkin_tornado", 4}},
		npc_dota_hero_chen = {{"holdout_frost_shield", 2}},
		npc_dota_hero_crystal_maiden = {{"holdout_rain_of_ice", 2}},
		npc_dota_hero_dragon_knight = {{"holdout_knights_armor", 6}},
		npc_dota_hero_elder_titan = {{"holdout_shockwave_20", 0}, {"holdout_war_stomp_20", 1}, {"holdout_roar_20", 4}, {"holdout_reincarnation", 6}},
		npc_dota_hero_enchantress = {{"neutral_spell_immunity", 6}},
		npc_dota_hero_invoker = {{"holdout_rain_of_fire", 2}},
		npc_dota_hero_juggernaut = {{"brewmaster_primal_split", 2}},
		npc_dota_hero_lich = {{"holdout_frost_chaos", 4}},
		npc_dota_hero_luna = {{"holdout_neutralization", 2}},
		npc_dota_hero_nevermore = {{"holdout_rain_of_chaos_20", 6}},
		npc_dota_hero_nyx_assassin = {{"holdout_burrow_impale", 2}},
		npc_dota_hero_omniknight = {{"holdout_light_frenzy", 2}},
		npc_dota_hero_phantom_assassin = {{"holdout_morph", 2}},
		npc_dota_hero_pugna = {{"holdout_rain_of_chaos_20", 2}},
		npc_dota_hero_rattletrap = {{"holdout_cluster_rockets", 2}},
		npc_dota_hero_shadow_shaman = {{"holdout_hex", 2}},
		npc_dota_hero_skeleton_king = {{"holdout_lordaeron_smash", 3}},
		npc_dota_hero_slardar = {{"holdout_dark_dimension", 2}},
		npc_dota_hero_sniper ={{"holdout_laser", 0}, {"holdout_plasma_rifle_20", 1}},
		npc_dota_hero_sven = {{"holdout_storm_bolt_20", 0}, {"holdout_thunder_clap_20", 1}},
		npc_dota_hero_terrorblade = {{"holdout_resistant_skin", 6}},
		npc_dota_hero_tiny = {{"holdout_war_club_20", 0}},
		npc_dota_hero_windrunner = {{"holdout_rocket_hail", 2}}
	}

	if hero_level == 17 then -- Debug because 7.0
		hero:SetAbilityPoints( hero:GetAbilityPoints() + 1 )
	elseif hero_level > 19 then
		hero:SetAbilityPoints( hero:GetAbilityPoints() - 1 )
	end

	if hero:GetUnitName() == "npc_dota_hero_lich" then
		if hero_level == 20 then
			hero:RemoveAbility("holdout_frost_frenzy")
		end
	end

	if hero:GetUnitName() == "npc_dota_hero_tiny" then
		if hero_level == 20 then
			local ability = hero:FindAbilityByName("holdout_war_club_20")
			hero:RemoveAbility("holdout_war_club")
			hero:AddNewModifier(hero, ability, "modifier_item_ultimate_scepter_consumed", {})
		end
	end

	if hero:GetUnitName() == "npc_dota_hero_elder_titan" then
		if hero_level == 20 then
			hero:RemoveAbility("holdout_shockwave")
			hero:RemoveAbility("holdout_war_stomp")
			hero:RemoveAbility("holdout_roar")
		end
	end

	if hero:GetUnitName() == "npc_dota_hero_sven" then
		if hero_level == 20 then
			hero:RemoveAbility("holdout_storm_bolt")
			hero:RemoveAbility("holdout_thunder_clap")
		end
	end

	if hero:GetUnitName() == "npc_dota_hero_sniper" then
		if hero_level == 20 then
			hero:RemoveAbility("holdout_rocket_launcher")
			hero:RemoveAbility("holdout_plasma_rifle")
		end
	end

	if hero:GetUnitName() == "npc_dota_hero_brewmaster" then
		if hero_level == 20 then
			hero:RemoveAbility("shadow_shaman_shackles")
		end
	end

	if hero:GetUnitName() == "npc_dota_hero_omniknight" then
		if hero_level == 20 then
			hero:RemoveAbility("holdout_taunt")
		end
	end

	if hero:GetUnitName() == "npc_dota_hero_chaos_knight" then
		local stacks = hero:GetLevel()
		hero:SetModifierStackCount("modifier_power_mount_str", caster, stacks) -- Power Mount(STR) Level Up
		hero:SetModifierStackCount("modifier_power_mount_agi", caster, stacks) -- Power Mount(AGI) Level Up
		hero:SetModifierStackCount("modifier_power_mount_int", caster, stacks) -- Power Mount(INT) Level Up
		hero:SetModifierStackCount("modifier_dark_cleave_dummy", caster, stacks) -- Dark Cleave Level Up
		hero:SetAbilityPoints( hero:GetAbilityPoints() - 1 )

		if hero_level == 5 then
			hero:UpgradeAbility(hero:FindAbilityByName("holdout_instakill"))
		end
		if hero_level >= 8 then
			hero:UpgradeAbility(hero:FindAbilityByName("holdout_requiem"))
			hero:SetModifierStackCount("modifier_requiem_dummy", caster, stacks * 2)
		end
		if hero_level == 10 then
			hero:UpgradeAbility(hero:FindAbilityByName("holdout_odin"))
		end
		if hero_level == 15 then
			hero:UpgradeAbility(hero:FindAbilityByName("holdout_odin"))
		end
	end

	if hero:GetUnitName() == "npc_dota_hero_keeper_of_the_light" then
		local stacks = hero:GetLevel()
		hero:SetModifierStackCount("modifier_power_mount_str", caster, stacks) -- Power Mount(STR) Level Up
		hero:SetModifierStackCount("modifier_power_mount_agi", caster, stacks) -- Power Mount(AGI) Level Up
		hero:SetModifierStackCount("modifier_power_mount_int", caster, stacks) -- Power Mount(INT) Level Up
		hero:SetAbilityPoints( hero:GetAbilityPoints() - 1 )

		if hero_level >= 5 then
			hero:UpgradeAbility(hero:FindAbilityByName("holdout_light_stand"))
			hero:SetModifierStackCount("modifier_light_stand_dummy", caster, stacks)
		end
		if hero_level == 8 then
			hero:UpgradeAbility(hero:FindAbilityByName("holdout_sacred_pool"))
		end
		if hero_level == 10 then
			hero:UpgradeAbility(hero:FindAbilityByName("holdout_guardian_angel"))
		end
		if hero_level == 15 then
			hero:UpgradeAbility(hero:FindAbilityByName("holdout_guardian_angel"))
		end
	end

	if hero_level == 20 then
		for i = 0, 17 do 
		local ability = hero:GetAbilityByIndex(i)
			if IsValidEntity(ability) then
				if ability:GetLevel() < ability:GetMaxLevel() then
					for j = 1, ability:GetMaxLevel() - ability:GetLevel() do
					hero:UpgradeAbility(ability)
					end
				end
			end
		end

		if hero:GetUnitName() == "npc_dota_hero_storm_spirit" or hero:GetUnitName() == "npc_dota_hero_earth_spirit" or hero:GetUnitName() == "npc_dota_hero_ember_spirit" or hero:GetUnitName() == "npc_dota_hero_ursa" or hero:GetUnitName() == "npc_dota_hero_troll_warlord" or hero:GetUnitName() == "npc_dota_hero_mirana" or hero:GetUnitName() == "npc_dota_hero_lina" or hero:GetUnitName() == "npc_dota_hero_monkey_king" then
			print("No Level 20 Ability")
		else
			print("Whisper Level 20 Ability")
			hero.lvl_20 = true
			Notifications:Bottom(hero:GetPlayerOwnerID(), {text="You've reached level 20. Check out your new abilities! ",duration = 10})
			for _, ability in pairs(AbilitiesHeroes_XX[hero:GetUnitName()]) do
				if ability ~= nil then
					Notifications:Bottom(hero:GetPlayerOwnerID(), {ability=ability[1] ,continue=true})
					hero:AddAbility(ability[1])
					hero:UpgradeAbility(hero:FindAbilityByName(ability[1]))
					local oldab = hero:GetAbilityByIndex(ability[2])
					if oldab:GetAutoCastState() then 
						oldab:ToggleAutoCast()
					end
					hero:SwapAbilities(oldab:GetName(),ability[1],true,true)
				end
			end
		end
	end
end

function GameMode:OnLastHit(keys)
local isFirstBlood = keys.FirstBlood == 1
local isHeroKill = keys.HeroKill == 1
local isTowerKill = keys.TowerKill == 1
local player = PlayerResource:GetPlayer(keys.PlayerID)
local killedEnt = EntIndexToHScript(keys.EntKilled)

end

function GameMode:OnTreeCut(keys)
local treeX = keys.tree_x
local treeY = keys.tree_y

end

function GameMode:OnRuneActivated (keys)
local player = PlayerResource:GetPlayer(keys.PlayerID)
local rune = keys.rune

	--[[ Rune Can be one of the following types
	DOTA_RUNE_DOUBLEDAMAGE
	DOTA_RUNE_HASTE
	DOTA_RUNE_HAUNTED
	DOTA_RUNE_ILLUSION
	DOTA_RUNE_INVISIBILITY
	DOTA_RUNE_BOUNTY
	DOTA_RUNE_MYSTERY
	DOTA_RUNE_RAPIER
	DOTA_RUNE_REGENERATION
	DOTA_RUNE_SPOOKY
	DOTA_RUNE_TURBO
	]]
end

function GameMode:OnPlayerTakeTowerDamage(keys)
local player = PlayerResource:GetPlayer(keys.PlayerID)
local damage = keys.damage

end

function GameMode:OnPlayerPickHero(keys)
local heroClass = keys.hero
local heroEntity = EntIndexToHScript(keys.heroindex)
local player = EntIndexToHScript(keys.player)
local heroes = HeroList:GetAllHeroes()

	-- modifies the name/label of a player
--	GameMode:setPlayerHealthLabel(player)
end

function GameMode:OnTeamKillCredit(keys)
local killerPlayer = PlayerResource:GetPlayer(keys.killer_userid)
local victimPlayer = PlayerResource:GetPlayer(keys.victim_userid)
local numKills = keys.herokills
local killerTeamNumber = keys.teamnumber

end

function GameMode:OnEntityKilled( keys )
GameMode:_OnEntityKilled( keys )

local killedUnit = EntIndexToHScript( keys.entindex_killed )
local hero = nil

if keys.entindex_attacker ~= nil then
	hero = EntIndexToHScript( keys.entindex_attacker )
end

local killerAbility = nil

if keys.entindex_inflictor ~= nil then
	killerAbility = EntIndexToHScript( keys.entindex_inflictor )
end

	-- Tiny Debug, but will work with all other new heroes using aghanim modifiers
	killedUnit:RemoveModifierByName("modifier_item_ultimate_scepter_consumed")
	killedUnit:RemoveModifierByName("modifier_animation_translate")

local damagebits = keys.damagebits -- This might always be 0 and therefore useless
local KillerID = hero:GetPlayerOwnerID()
local playerKills = PlayerResource:GetKills(KillerID)

	if IsValidEntity(hero:GetPlayerOwner()) then
		hero = hero:GetPlayerOwner():GetAssignedHero()
	end

	if hero:IsIllusion() and hero:GetTeamNumber() == 2 then
		hero = PlayerResource:GetPlayer(hero:GetPlayerID()):GetAssignedHero()
	end

	if hero:IsRealHero() then
		if hero:GetKills() == 99 then
			Notifications:Bottom(hero:GetPlayerOwnerID(), {text="100 kills. You get 7500 gold.", duration=5.0, style={color="yellow"}})
			PlayerResource:ModifyGold( hero:GetPlayerOwnerID(), 7500, false,  DOTA_ModifyGold_Unspecified )
		elseif hero:GetKills() == 199 then
			Notifications:Bottom(hero:GetPlayerOwnerID(), {text="200 kills. You get 25000 gold.", duration=5.0, style={color="yellow"}})
			PlayerResource:ModifyGold( hero:GetPlayerOwnerID(), 25000, false,  DOTA_ModifyGold_Unspecified )
		elseif hero:GetKills() == 399 then
			Notifications:Bottom(hero:GetPlayerOwnerID(), {text="400 kills. You get 50000 gold.", duration=5.0, style={color="yellow"}})
			PlayerResource:ModifyGold( hero:GetPlayerOwnerID(), 50000, false,  DOTA_ModifyGold_Unspecified )
		elseif hero:GetKills() >= 499 and RAMERO == 0 then --500
		local point = Entities:FindByName(nil, "npc_dota_muradin_player_1"):GetAbsOrigin()
			hero:AddNewModifier( nil, nil, "modifier_animation_freeze_stun", nil)
			hero:AddNewModifier( nil, nil, "modifier_invulnerable", nil)
			Notifications:TopToAll({text="A hero has reached 500 kills and will fight Ramero and Baristol!", style={color="white"}, duration=5.0})
			PauseCreeps()
			Timers:CreateTimer(5.0, function()
				FindClearSpaceForUnit(hero, point, true)
				PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(), hero)
				RameroAndBaristolEvent()
				hero:RemoveModifierByName("modifier_animation_freeze_stun")
				hero:RemoveModifierByName("modifier_invulnerable")
				Timers:CreateTimer(0.1, function()
					PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(), nil)
				end)
			end)
			RAMERO = 1
			hero.old_pos = hero:GetAbsOrigin()
		elseif hero:GetKills() >= 749 and RAMERO == 1 then --750
		local point = Entities:FindByName(nil, "npc_dota_muradin_player_1"):GetAbsOrigin()
			hero:AddNewModifier( nil, nil, "modifier_animation_freeze_stun", nil)
			hero:AddNewModifier( nil, nil, "modifier_invulnerable", nil)
			Notifications:TopToAll({text="A hero has reached 750 kills and will fight Ramero!", style={color="white"}, duration=5.0})
			PauseCreeps()
			Timers:CreateTimer(5.0, function()
				FindClearSpaceForUnit(hero, point, true)
				PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(), hero)
				RameroEvent()
				hero:RemoveModifierByName("modifier_animation_freeze_stun")
				hero:RemoveModifierByName("modifier_invulnerable")
				Timers:CreateTimer(0.1, function()
					PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(), nil)
				end)
			end)
			RAMERO = 2
			local hero = hero
			hero.old_pos = hero:GetAbsOrigin()
		end
	end

	if hero:IsRealHero() and killedUnit:IsRealHero() and killedUnit:GetTeam() == DOTA_TEAM_CUSTOM_4 then
		if PlayerResource:HasSelectedHero(KillerID) then
			PlayerNumberRadiant = PlayerNumberRadiant - 1
			print("Radiant Team: "..PlayerNumberRadiant)
		end
	elseif hero:IsRealHero() and killedUnit:IsRealHero() and killedUnit:GetTeam() == DOTA_TEAM_CUSTOM_3 then
		if PlayerResource:HasSelectedHero(KillerID) then
			PlayerNumberDire = PlayerNumberDire - 1
			print("Dire Team: "..PlayerNumberDire)
		end
	elseif hero:IsRealHero() and killedUnit:IsCreep() and killedUnit:GetTeam() == DOTA_TEAM_BADGUYS then
		if PlayerResource:HasSelectedHero(KillerID) then
			hero:IncrementKills(1)
		end
	end

	if killedUnit:IsRealHero() then
		if PHASE_3 == 1 then
			if not killedUnit:HasItemInInventory("item_ankh_of_reincarnation") then
				local newItem = CreateItem("item_tombstone", killedUnit, killedUnit)
				newItem:SetPurchaseTime(0)
				newItem:SetPurchaser(killedUnit)
				local tombstone = SpawnEntityFromTableSynchronous("dota_item_tombstone_drop", {})
				tombstone:SetContainedItem(newItem)
				tombstone:SetAngles(0, RandomFloat(0, 360), 0)
				FindClearSpaceForUnit(tombstone, killedUnit:GetAbsOrigin(), true)
			end

		--	local time_elapsed = 0
		--	Timers:CreateTimer(0.0, function()
		--		time_elapsed = time_elapsed + 0.5
		--		local heroes = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, Vector(0, 0, 0), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE , FIND_ANY_ORDER, false)
		--		local HeroesCheckNumber = 0
		--		for _, v in pairs(heroes) do
		--			HeroesCheckNumber = HeroesCheckNumber +1
		--		end
		--		if time_elapsed < 7.5 then
		--			local allHeroes = HeroList:GetAllHeroes()
		--			if HeroesCheckNumber > 1 then
		--			elseif HeroesCheckNumber <= 1 then
		--				return 0.5
		--			end
		--		elseif time_elapsed >= 7.5 then
		--			GameRules:MakeTeamLose(DOTA_TEAM_GOODGUYS)
		--		end
		--	end)
		end
	end

	for c = 1, 8 do
		if killedUnit:GetUnitName() == "dota_badguys_barracks_"..c then
			CREEP_LANES[c][1] = 0
			CREEP_LANES[c][3] = 0
		elseif hero:IsIllusion() and killedUnit:GetUnitName() == "dota_badguys_barracks_"..c then
			CREEP_LANES[c][1] = 0
			CREEP_LANES[c][3] = 0
		end
	end

	if killedUnit:GetUnitName() == "npc_ramero" then
		local item = CreateItem("item_lightning_sword", nil, nil)
		local pos = killedUnit:GetAbsOrigin()
		local drop = CreateItemOnPositionSync( pos, item )
		item:LaunchLoot(false, 300, 0.5, pos)
	elseif killedUnit:GetUnitName() == "npc_baristol" then
		local item = CreateItem("item_tome_big", nil, nil)
		local pos = killedUnit:GetAbsOrigin()
		local drop = CreateItemOnPositionSync( pos, item )
		item:LaunchLoot(false, 300, 0.5, pos)
	elseif killedUnit:GetUnitName() == "npc_ramero_2" then
		local item = CreateItem("item_ring_of_superiority", nil, nil)
		local pos = killedUnit:GetAbsOrigin()
		local drop = CreateItemOnPositionSync( pos, item )
		item:LaunchLoot(false, 300, 0.5, pos)
		doom_first_time = true
	elseif killedUnit:GetUnitName() == "npc_dota_hero_secret" then
		local item = CreateItem("item_orb_of_frost", nil, nil)
		local pos = killedUnit:GetAbsOrigin()
		local drop = CreateItemOnPositionSync( pos, item )
		item:LaunchLoot(false, 300, 0.5, pos)
		frost_first_time = true
	end

	if killedUnit:GetUnitName() == "npc_dota_hero_magtheridon" then
	local teleporters2 = Entities:FindAllByName("trigger_teleport2")
	local difficulty = GameRules:GetCustomGameDifficulty()

		MAGTHERIDON = MAGTHERIDON + 1

		if MAGTHERIDON > 0 and difficulty == 1 then
			EndMagtheridonArena()
		elseif MAGTHERIDON > 1 and difficulty == 2 then
			EndMagtheridonArena()
		elseif MAGTHERIDON > 3 and difficulty == 3 then
			EndMagtheridonArena()
		elseif MAGTHERIDON > 3 and difficulty == 4 then
			EndMagtheridonArena()
		end
	end
	Corpses:CreateFromUnit(killedUnit)
end

function GameMode:PlayerConnect(keys)
end

function GameMode:OnConnectFull(keys)
GameMode:_OnConnectFull(keys)
local entIndex = keys.index+1
local ply = EntIndexToHScript(entIndex)
local playerID = ply:GetPlayerID()

	-- If this is Mohammad Mehdi Akhondi, end the game. Dota Imba ban system.
	for i = 1, #banned_players do
		if PlayerResource:GetSteamAccountID(ply:GetPlayerID()) == banned_players[i] then
			Timers:CreateTimer(5.0, function()
				GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
			end)
			GameRules:SetHeroSelectionTime(1.0)
			GameRules:SetPreGameTime(1.0)
			GameRules:SetPostGameTime(5.0)
			GameRules:SetCustomGameSetupAutoLaunchDelay(0.0)
			Say(nil, "<font color='#FF0000'>Mohammad Mehdi Akhondi</font> detected, game will not start. Please disconnect.", false)
		end
	end
end

function GameMode:OnIllusionsCreated(keys)
	local originalEntity = EntIndexToHScript(keys.original_entindex)
end

function GameMode:OnItemCombined(keys)
local plyID = keys.PlayerID
if not plyID then return end
local player = PlayerResource:GetPlayer(plyID)
local itemName = keys.itemname 
local itemcost = keys.itemcost
end

function GameMode:OnAbilityCastBegins(keys)
local player = PlayerResource:GetPlayer(keys.PlayerID)
local abilityName = keys.abilityname
end

function GameMode:OnTowerKill(keys)
local gold = keys.gold
local killerPlayer = PlayerResource:GetPlayer(keys.killer_userid)
local team = keys.teamnumber
end

function GameMode:OnPlayerSelectedCustomTeam(keys)
local player = PlayerResource:GetPlayer(keys.player_id)
local success = (keys.success == 1)
local team = keys.team_id
end

-- This function is called whenever an NPC reaches its goal position/target
function GameMode:OnNPCGoalReached(keys)
local goalEntity = EntIndexToHScript(keys.goal_entindex)
local nextGoalEntity = EntIndexToHScript(keys.next_goal_entindex)
local npc = EntIndexToHScript(keys.npc_entindex)
end

function GameMode:OnPlayerChat(keys)
local teamonly = keys.teamonly
local userID = keys.userid
local playerID = self.vUserIds[userID]:GetPlayerID()
local text = keys.text
local player = PlayerResource:GetPlayer(playerID)

	for str in string.gmatch(text, "%S+") do
		for i = 1, #mod_creator do
			if PlayerResource:GetSteamAccountID(player:GetPlayerID()) == mod_creator[i] then
				for Frozen = 0, DOTA_MAX_TEAM_PLAYERS -1 do
					local PlayerNames = {"Red", "Blue", "Cyan", "Purple", "Yellow", "Orange", "Green", "Pink"}
					if PlayerResource:IsValidPlayer(Frozen) then
						if str == "-freeze_"..Frozen +1 then
							local hero = PlayerResource:GetPlayer(Frozen):GetAssignedHero()
							hero:AddNewModifier(nil, nil, "modifier_animation_freeze_stun", {})
							hero:AddNewModifier(nil, nil, "modifier_invulnerable", {})
							Notifications:TopToAll({text="[ADMIN MOD]: ", duration=6.0, style={color="red", ["font-size"]="30px"}})
							Notifications:TopToAll({text=PlayerNames[Frozen +1].." ", style={color=PlayerNames[Frozen +1], ["font-size"]="25px"}, continue=true})
							Notifications:TopToAll({text="player has been jailed!", style={color="white", ["font-size"]="25px"}, continue=true})
						end
						if str == "-unfreeze_"..Frozen +1 then
							local hero = PlayerResource:GetPlayer(Frozen):GetAssignedHero()
							hero:RemoveModifierByName("modifier_animation_freeze_stun")
							hero:RemoveModifierByName("modifier_boss_stun")
							hero:RemoveModifierByName("modifier_invulnerable")
							Notifications:TopToAll({text="[ADMIN MOD]: ", duration=6.0, style={color="red", ["font-size"]="30px"}})
							Notifications:TopToAll({text=PlayerNames[Frozen +1].." ", style={color=PlayerNames[Frozen +1], ["font-size"]="25px"}, continue=true})
							Notifications:TopToAll({text="player has been released!", style={color="white", ["font-size"]="25px"}, continue=true})
						end
						if str == "-kill_"..Frozen +1 then
							local hero = PlayerResource:GetPlayer(Frozen):GetAssignedHero()
							hero:ForceKill(true)
							Notifications:TopToAll({text="[ADMIN MOD]: ", duration=6.0, style={color="red", ["font-size"]="30px"}})
							Notifications:TopToAll({text=PlayerNames[Frozen +1].." ", style={color=PlayerNames[Frozen +1], ["font-size"]="25px"}, continue=true})
							Notifications:TopToAll({text="player has been slayed!", style={color="white", ["font-size"]="25px"}, continue=true})
						end
						if str == "-revive_"..Frozen +1 then
							local hero = PlayerResource:GetPlayer(Frozen):GetAssignedHero()
							hero:RespawnHero(false, false, false)
							Notifications:TopToAll({text="[ADMIN MOD]: ", duration=6.0, style={color="red", ["font-size"]="30px"}})
							Notifications:TopToAll({text=PlayerNames[Frozen +1].." ", style={color=PlayerNames[Frozen +1], ["font-size"]="25px"}, continue=true})
							Notifications:TopToAll({text="player has been revived!", style={color="white", ["font-size"]="25px"}, continue=true})
						end
						if str == "-yolo_"..Frozen +1 then
							local hero = PlayerResource:GetPlayer(Frozen):GetAssignedHero()
							hero:SetMoveCapability(DOTA_UNIT_CAP_MOVE_FLY)
							StartAnimation(hero, {duration = 9999.0, activity = ACT_DOTA_FLAIL, rate = 0.9})
							yolo = ParticleManager:CreateParticle("particles/units/heroes/hero_batrider/batrider_firefly_ember.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero)
							ParticleManager:SetParticleControl(yolo, 0, hero:GetAbsOrigin() + Vector(0, 0, 100))
							yolo2 = ParticleManager:CreateParticle("particles/units/heroes/hero_ember_spirit/ember_spirit_flameguard.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero)
							hero:EmitSound("Hero_Batrider.Firefly.Cast")
							hero:EmitSound("Hero_Batrider.Firefly.Loop")
							Notifications:TopToAll({text="[ADMIN MOD]: ", duration=6.0, style={color="red", ["font-size"]="30px"}})
							Notifications:TopToAll({text=PlayerNames[Frozen +1].." ", style={color=PlayerNames[Frozen +1], ["font-size"]="25px"}, continue=true})
							Notifications:TopToAll({text="player is in YOLO state!", style={color="white", ["font-size"]="25px"}, continue=true})
						end
						if str == "-unyolo_"..Frozen +1 then
							local hero = PlayerResource:GetPlayer(Frozen):GetAssignedHero()
							hero:SetMoveCapability(DOTA_UNIT_CAP_MOVE_GROUND)
							EndAnimation(hero)
							hero:StopSound("Hero_Batrider.Firefly.Loop")
							ParticleManager:DestroyParticle(yolo, true)
							ParticleManager:DestroyParticle(yolo2, true)
							Notifications:TopToAll({text="[ADMIN MOD]: ", duration=6.0, style={color="red", ["font-size"]="30px"}})
							Notifications:TopToAll({text=PlayerNames[Frozen +1].." ", style={color=PlayerNames[Frozen +1], ["font-size"]="25px"}, continue=true})
							Notifications:TopToAll({text="player is not in YOLO state anymore.", style={color="white", ["font-size"]="25px"}, continue=true})
						end
					end
				end
			elseif not PlayerResource:GetSteamAccountID(player:GetPlayerID()) == mod_creator[i] then
				Notifications:Bottom(player:GetPlayerID(), {text="You are not allowed to use this command!", duration=6.0, style={color="white"}})
			end
		end

		local newState = GameRules:State_Get()
		if str == "-bt" then
		local hero = PlayerResource:GetPlayer(playerID):GetAssignedHero()
		local gold = hero:GetGold()
		local cost = 10000
		local numberOfTomes = math.floor(gold / cost)
			if numberOfTomes >= 1 and BT_ENABLED == 1 then
				PlayerResource:SpendGold(playerID, (numberOfTomes) * cost, DOTA_ModifyGold_PurchaseItem)
				hero:ModifyAgility(numberOfTomes * 50)
				hero:ModifyStrength(numberOfTomes * 50)
				hero:ModifyIntellect(numberOfTomes * 50)
				hero:EmitSound("ui.trophy_levelup")
				local particle1 = ParticleManager:CreateParticle("particles/econ/events/ti6/hero_levelup_ti6.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero)
				ParticleManager:SetParticleControl(particle1, 0, hero:GetAbsOrigin())
				Notifications:Bottom(player, {text="You've bought "..numberOfTomes.." Tomes!", duration=5.0, style={color="white"}})
			elseif numberOfTomes < 1 then
				Notifications:Bottom(player, {text="You don't have enough gold to afford tomes!", duration=5.0, style={color="white"}})
			elseif BT_ENABLED == 0 then
				Notifications:Bottom(player, {text="You are not allowed to buy tomes in this arena!", duration=5.0, style={color="white"}})
			end
		end

		if str == "-info" then
			local diff = {"Easy", "Normal", "Hard", "Extreme"}
			local lanes = {"Simple", "Double", "Full"}
			local dual = {"Normal", "Dual"}
			Notifications:Bottom(player, {text="DIFFICULTY: "..diff[GameRules:GetCustomGameDifficulty()], duration=10.0})
			Notifications:Bottom(player, {text="CREEP LANES: "..lanes[CREEP_LANES_TYPE], duration=10.0})
			Notifications:Bottom(player, {text="DUAL HERO: "..dual[DUAL_HERO], duration=10.0})
		end
	end
end

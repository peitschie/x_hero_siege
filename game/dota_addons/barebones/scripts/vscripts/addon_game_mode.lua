require("statcollection/init")
require('internal/util')
require('gamemode')

function Precache( context )
-- Custom Effects Precache
	PrecacheResource("particle_folder", "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith", context)
	PrecacheResource("particle_folder", "particles/econ/items/luna/luna_crescent_moon", context)
	PrecacheResource("particle_folder", "particles/econ/items/gyrocopter/hero_gyrocopter_atomic_gold", context)
	PrecacheResource("particle_folder", "particles/econ/items/clockwerk/clockwerk_paraflare", context)
	PrecacheResource("particle_folder", "particles/econ/items/puck/puck_alliance_set", context)
	PrecacheResource("particle_folder", "particles/econ/items/shadow_fiend/sf_desolation", context)
	PrecacheResource("particle_folder", "particles/status_fx", context)
	PrecacheResource("particle_folder", "particles/econ/items/gyrocopter/hero_gyrocopter_gyrotechnics", context)
	PrecacheResource("particle_folder", "particles/econ/courier/courier_wyvern_hatchling", context)
	PrecacheResource("particle_folder", "particles/econ/items/wraith_king/wraith_king_ti6_bracer", context)
	PrecacheResource("particle_folder", "particles/econ/items/tinker/tinker_motm_rollermaw", context)
	PrecacheResource("particle_folder", "particles/econ/items/abaddon/abaddon_alliance", context)
	PrecacheResource("particle_folder", "particles/econ/items/razor/razor_ti6", context)
	PrecacheResource("particle_folder", "particles/items2_fx", context)
	PrecacheResource("particle_folder", "particles/custom", context)
	PrecacheResource("particle_folder", "particles/econ/events/ti6", context)
	PrecacheResource("particle_folder", "particles/units/heroes/hero_dragon_knight", context)
	PrecacheResource("particle_folder", "particles/custom/items/orb", context)
	PrecacheResource("particle_folder", "models/items/lone_druid/true_form/form_of_the_atniw", context)
	PrecacheResource("particle_folder", "models/items/lone_druid/bear/spirit_of_the_atniw", context)
	PrecacheResource("particle_folder", "particles/econ/events/ti6", context)
	PrecacheResource("particle_folder", "particles/econ/items/magnataur/shock_of_the_anvil", context)
	PrecacheResource("particle_folder", "particles/econ/items/rubick/rubick_staff_wandering", context)
	PrecacheResource("particle_folder", "particles/units/heroes/hero_monkey_king", context)
	PrecacheResource("particle_folder", "particles/econ/courier/courier_roshan_frost", context)
	PrecacheResource("particle_folder", "models/items/ancient_apparition/shatterblast_crown", context)
	PrecacheResource("particle_folder", "particles/econ/items/nyx_assassin/nyx_assassin_ti6_witness", context)
	PrecacheResource("particle_folder", "particles/econ/courier/courier_axolotl_ambient", context)
	PrecacheResource("particle_folder", "particles/units/heroes/hero_earth_spirit/", context)
	PrecacheResource("particle_folder", "particles/econ/items/effigies/status_fx_effigies", context)
	PrecacheResource("particle_folder", "particles/econ/items/shadow_fiend/sf_fire_arcana", context)
	PrecacheResource("particle_folder", "particles/econ/items/abaddon/abaddon_alliance", context)
	PrecacheResource("particle_folder", "particles/units/heroes/hero_abaddon", context)
	PrecacheResource("particle_folder", "particles/units/heroes/hero_desert_wyrm", context)
	PrecacheResource("particle_folder", "particles/econ/items/phoenix/phoenix_solar_forge/phoenix_sunray_solar_forge", context)
	PrecacheResource("particle_folder", "particles/units/heroes/heroes_underlord", context)
	PrecacheResource("particle_folder", "particles/frostivus_gameplay", context)

	PrecacheResource("soundfile", "soundevents/game_sounds_custom.vsndevts", context)

	PrecacheResource("model_folder", "models/heroes/skeleton_king", context) --Lich King Boss
	PrecacheResource("model_folder", "models/heroes/monkey_king", context) --Spirit Master Boss
	PrecacheResource("model_folder", "models/items/monkey_king/monkey_king_arcana_head", context) --Spirit Master Boss

	PrecacheResource("model_folder", "models/items/dragon_knight/ascension_weapon", context) --Arthas Boss Set
	PrecacheResource("model_folder", "models/items/dragon_knight/ascension_back", context) 
	PrecacheResource("model_folder", "models/items/dragon_knight/ascension_offhand", context) 
	PrecacheResource("model_folder", "models/items/dragon_knight/ascension_arms", context) 
	PrecacheResource("model_folder", "models/items/dragon_knight/ascension_shoulder", context) 
	PrecacheResource("model_folder", "models/items/dragon_knight/ascension_head", context)

	PrecacheResource("model_folder", "models/items/chaos_knight/ck_esp_blade", context) --Dark Fundamental Boss Set
	PrecacheResource("model_folder", "models/items/chaos_knight/ck_esp_helm", context)
	PrecacheResource("model_folder", "models/items/chaos_knight/ck_esp_mount", context)
	PrecacheResource("model_folder", "models/items/chaos_knight/ck_esp_shield", context)
	PrecacheResource("model_folder", "models/items/chaos_knight/ck_esp_shoulder", context)
	PrecacheResource("model_folder", "particles/units/heroes/hero_nyx_assassin", context)
	PrecacheResource("model_folder", "models/items/furion/treant/the_ancient_guardian_the_ancient_treants", context)

	-- PRECACHE HEROES
	PrecacheUnitByNameSync( "npc_dota_hero_abyssal_underlord", context)
	PrecacheUnitByNameSync( "npc_dota_hero_abaddon", context)
	PrecacheUnitByNameSync( "npc_dota_hero_ancient_apparition", context)
	PrecacheUnitByNameSync( "npc_dota_hero_antimage", context)
	PrecacheUnitByNameSync( "npc_dota_hero_arc_warden", context)
	PrecacheUnitByNameSync( "npc_dota_hero_axe", context)
	PrecacheUnitByNameSync( "npc_dota_hero_batrider", context)
	PrecacheUnitByNameSync( "npc_dota_hero_beastmaster", context)
	PrecacheUnitByNameSync( "npc_dota_hero_bounty_hunter", context)
	PrecacheUnitByNameSync( "npc_dota_hero_brewmaster", context)
	PrecacheUnitByNameSync( "npc_dota_hero_bristleback", context)
	PrecacheUnitByNameSync( "npc_dota_hero_centaur", context)
	PrecacheUnitByNameSync( "npc_dota_hero_chaos_knight", context)
	PrecacheUnitByNameSync( "npc_dota_hero_chen", context)
	PrecacheUnitByNameSync( "npc_dota_hero_clinkz", context)
	PrecacheUnitByNameSync( "npc_dota_hero_crystal_maiden", context)
	PrecacheUnitByNameSync( "npc_dota_hero_death_prophet", context)
	PrecacheUnitByNameSync( "npc_dota_hero_doom_bringer", context)
	PrecacheUnitByNameSync( "npc_dota_hero_dark_seer", context)
	PrecacheUnitByNameSync( "npc_dota_hero_disruptor", context)
	PrecacheUnitByNameSync( "npc_dota_hero_dragon_knight", context)
	PrecacheUnitByNameSync( "npc_dota_hero_drow_ranger", context)
	PrecacheUnitByNameSync( "npc_dota_hero_earthshaker", context)
	PrecacheUnitByNameSync( "npc_dota_hero_earth_spirit", context)
	PrecacheUnitByNameSync( "npc_dota_hero_elder_titan", context)
	PrecacheUnitByNameSync( "npc_dota_hero_ember_spirit", context)
	PrecacheUnitByNameSync( "npc_dota_hero_enchantress", context)
	PrecacheUnitByNameSync( "npc_dota_hero_enigma", context)
	PrecacheUnitByNameSync( "npc_dota_hero_faceless_void", context)
	PrecacheUnitByNameSync( "npc_dota_hero_furion", context)
	PrecacheUnitByNameSync( "npc_dota_hero_gyrocopter", context)
	PrecacheUnitByNameSync( "npc_dota_hero_huskar", context)
	PrecacheUnitByNameSync( "npc_dota_hero_invoker", context)
	PrecacheUnitByNameSync( "npc_dota_hero_jakiro", context)
	PrecacheUnitByNameSync( "npc_dota_hero_juggernaut", context)
	PrecacheUnitByNameSync( "npc_dota_hero_keeper_of_the_light", context)
	PrecacheUnitByNameSync( "npc_dota_hero_kunkka", context)
	PrecacheUnitByNameSync( "npc_dota_hero_leshrac", context)
	PrecacheUnitByNameSync( "npc_dota_hero_lich", context)
	PrecacheUnitByNameSync( "npc_dota_hero_life_stealer", context)
	PrecacheUnitByNameSync( "npc_dota_hero_lina", context)
	PrecacheUnitByNameSync( "npc_dota_hero_lion", context)
	PrecacheUnitByNameSync( "npc_dota_hero_lone_druid", context)
	PrecacheUnitByNameSync( "npc_dota_hero_luna", context)
	PrecacheUnitByNameSync( "npc_dota_hero_magnataur", context)
	PrecacheUnitByNameSync( "npc_dota_hero_meepo", context)
	PrecacheUnitByNameSync( "npc_dota_hero_mirana", context)
	PrecacheUnitByNameSync( "npc_dota_hero_monkey_king", context)
	PrecacheUnitByNameSync( "npc_dota_hero_morphling", context)
	PrecacheUnitByNameSync( "npc_dota_hero_naga_siren", context)
	PrecacheUnitByNameSync( "npc_dota_hero_necrolyte", context)
	PrecacheUnitByNameSync( "npc_dota_hero_nevermore", context)
	PrecacheUnitByNameSync( "npc_dota_hero_night_stalker", context)
	PrecacheUnitByNameSync( "npc_dota_hero_nyx_assassin", context)
	PrecacheUnitByNameSync( "npc_dota_hero_obsidian_destroyer", context)
	PrecacheUnitByNameSync( "npc_dota_hero_omniknight", context)
	PrecacheUnitByNameSync( "npc_dota_hero_phantom_assassin", context)
	PrecacheUnitByNameSync( "npc_dota_hero_phantom_lancer", context)
	PrecacheUnitByNameSync( "npc_dota_hero_phoenix", context)
	PrecacheUnitByNameSync( "npc_dota_hero_pudge", context)
	PrecacheUnitByNameSync( "npc_dota_hero_pugna", context)
	PrecacheUnitByNameSync( "npc_dota_hero_rattletrap", context)
	PrecacheUnitByNameSync( "npc_dota_hero_razor", context)
	PrecacheUnitByNameSync( "npc_dota_hero_riki", context)
	PrecacheUnitByNameSync( "npc_dota_hero_sand_king", context)
	PrecacheUnitByNameSync( "npc_dota_hero_silencer", context)
	PrecacheUnitByNameSync( "npc_dota_hero_shadow_demon", context)
	PrecacheUnitByNameSync( "npc_dota_hero_shadow_shaman", context)
	PrecacheUnitByNameSync( "npc_dota_hero_skeleton_king", context)
	PrecacheUnitByNameSync( "npc_dota_hero_skywrath_mage", context)
	PrecacheUnitByNameSync( "npc_dota_hero_slardar", context)
	PrecacheUnitByNameSync( "npc_dota_hero_slark", context)
	PrecacheUnitByNameSync( "npc_dota_hero_sniper", context)
	PrecacheUnitByNameSync( "npc_dota_hero_storm_spirit", context)
	PrecacheUnitByNameSync( "npc_dota_hero_sven", context)
	PrecacheUnitByNameSync( "npc_dota_hero_templar_assassin", context)
	PrecacheUnitByNameSync( "npc_dota_hero_terrorblade", context)
	PrecacheUnitByNameSync( "npc_dota_hero_tinker", context)
	PrecacheUnitByNameSync( "npc_dota_hero_tiny", context)
	PrecacheUnitByNameSync( "npc_dota_hero_treant", context)
	PrecacheUnitByNameSync( "npc_dota_hero_troll_warlord", context)
	PrecacheUnitByNameSync( "npc_dota_hero_tusk", context)
	PrecacheUnitByNameSync( "npc_dota_hero_undying", context)
	PrecacheUnitByNameSync( "npc_dota_hero_ursa", context)
	PrecacheUnitByNameSync( "npc_dota_hero_vengefulspirit", context)
	PrecacheUnitByNameSync( "npc_dota_hero_venomancer", context)
	PrecacheUnitByNameSync( "npc_dota_hero_viper", context)
	PrecacheUnitByNameSync( "npc_dota_hero_warlock", context)
	PrecacheUnitByNameSync( "npc_dota_hero_weaver", context)
	PrecacheUnitByNameSync( "npc_dota_hero_windrunner", context)
	PrecacheUnitByNameSync( "npc_dota_hero_winter_wyvern", context)
	PrecacheUnitByNameSync( "npc_dota_hero_wisp", context)

	PrecacheUnitByNameSync( "npc_dota_hero_skeleton_king_bis", context)
	PrecacheUnitByNameSync( "npc_dota_hero_slardar_bis", context)
	PrecacheUnitByNameSync( "npc_dota_hero_meepo_bis", context)

	PrecacheUnitByNameSync( "npc_spirit_beast", context)
	PrecacheUnitByNameSync( "npc_frost_infernal", context)
	PrecacheUnitByNameSync( "npc_spirit_beast_bis", context)
	PrecacheUnitByNameSync( "npc_frost_infernal_bis", context)

--	-- PRECACHE SOUNDS
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_elder_titan.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_leshrac.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_lycan.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_medusa.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_monkey_king.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_obsidian_destroyer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_ogre_magi.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_queenofpain.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_sywrath_mage.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_spectre.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_techies.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_tinker.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_ursa.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts", context )

--	-- Units Precache
	PrecacheUnitByNameSync( "npc_dota_hero_wisp", context) -- For Connecting bug
	PrecacheUnitByNameSync( "npc_dota_lycan_wolf1", context)
	PrecacheUnitByNameSync( "npc_dota_shadowshaman_serpentward", context)
	PrecacheUnitByNameSync( "npc_dota_furbolg", context)
	PrecacheUnitByNameSync( "npc_dota_creature_muradin_bronzebeard", context)

	-- Final Wave
	PrecacheUnitByNameSync( "npc_druid_final_wave", context)
	PrecacheItemByNameSync( "item_tombstone", context )
end

-- Create the game mode when we activate
function Activate()
	GameRules.GameMode = GameMode()
	GameRules.GameMode:InitGameMode()
end

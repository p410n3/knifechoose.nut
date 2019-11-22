Knives <- 
{
	def = "weapon_knife",
	flip = "weapon_knife_flip",
	gut = "weapon_knife_gut",
	falchion = "weapon_knife_falchion",
	huntsman = "weapon_knife_tactical",
	karambit = "weapon_knife_karambit",
	m9 = "weapon_knife_m9_bayonet",
	bayonet = "weapon_bayonet",
	daggers = "weapon_knife_push",
	bowie = "weapon_knife_survival_bowie",
	butterfly = "weapon_knife_butterfly",
	stiletto = "weapon_knife_stiletto",
	ursus = "weapon_knife_ursus",
	talon = "weapon_knife_widowmaker",
	navaja = "weapon_knife_gypsy_jackknife",
	ghost = "weapon_knife_ghost",
	css = "weapon_knife_css",
	survival = "weapon_knife_canis",
	paracord = "weapon_knife_cord",
	gungame = "weapon_knifegg",
	nomad = "weapon_knife_outdoor",
	skeleton = "weapon_knife_skeleton"
}

function equip_knife(knife)
{
	local equip = Entities.CreateByClassname("game_player_equip");
	EntFireByHandle(equip, "addoutput", knife + " 1", 0, null, null);
	EntFire("weapon_knife*", "kill");
	EntFireByHandle(equip, "TriggerForAllPlayers", "", 0, null, null);
	EntFire("weapon_knife", "addoutput", "classname weapon_knifegg");
}

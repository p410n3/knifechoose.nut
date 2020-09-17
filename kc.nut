 /* 
 * Knife Changer
 * by Ciren and p410n3
 * 
 * Github: https://github.com/p410n3/knifechoose.nut
 * License: LGPLv3
 *
 * Intended only for listen servers
 *
 * USAGE:
 * Put the script in /csgo/scripts/vscripts/
 * Type in the console "script_execute kc"
 * Type in a knife's name preceded by "kc_":
 *      Example: "kc_flip"
 * 
 * Press 'HOME' to regive the latest knife after losing it, e.g. after death
 * 
 * More info on the Github page
 */

const KC_VERSION = "3.0.1"

function printd(message)
{
	if(GetDeveloperLevel() > 0) printl("[KC Debug] " + message);
}

function kc_welcome_message()
{
	printd("In kc_welcome_message()");

	ScriptPrintMessageChatAll("[KC] Knife Changer " + KC_VERSION + " loaded. Check your admin console!");
	printl("[KC] knifechoose.nut");
	printl("[KC] Knife Changer " + KC_VERSION);
	printl("[KC] by Ciren and p410n3, site: https://github.com/p410n3/knifechoose.nut");
	printl("[KC] Usage:");
	printl("[KC] Type in a knife's name preceded by \"kc_\" in the console:");
	printl("[KC] All available knives: default, bayonet, bowie, butterfly, css, daggers, falchion, flip, ghost, gungame, gut, huntsman, karambit, m9, navaja, nomad, paracord, skeleton, stiletto, survival, talon, ursus");
	printl("[KC] Example: kc_daggers");
	printl("[KC] Note: Because of some game limitations you have to press 'HOME' key to reload the script every round");
	printl("[KC]                    You may take a look on the github repo's discription for details");
}

function kc_admin_aliases()
{
	printd("In kc_admin_aliases()");
	SendToConsole("alias kc_bayonet \"script equip_knife(knife.bayonet)\"");
	SendToConsole("alias kc_bowie \"script equip_knife(knife.bowie)\"");
	SendToConsole("alias kc_butterfly \"script equip_knife(knife.butterfly)\"");
	SendToConsole("alias kc_css \"script equip_knife(knife.css)\"");
	SendToConsole("alias kc_daggers \"script equip_knife(knife.daggers)\"");
	SendToConsole("alias kc_default \"script equip_knife(knife.default)\"");
	SendToConsole("alias kc_falchion \"script equip_knife(knife.falchion)\"");
	SendToConsole("alias kc_flip \"script equip_knife(knife.flip)\"");
	SendToConsole("alias kc_ghost \"script equip_knife(knife.ghost)\"");
	SendToConsole("alias kc_gungame \"script equip_knife(knife.gungame)\"");
	SendToConsole("alias kc_gut \"script equip_knife(knife.gut)\"");
	SendToConsole("alias kc_huntsman \"script equip_knife(knife.huntsman)\"");
	SendToConsole("alias kc_karambit \"script equip_knife(knife.karambit)\"");
	SendToConsole("alias kc_m9 \"script equip_knife(knife.m9)\"");
	SendToConsole("alias kc_navaja \"script equip_knife(knife.navaja)\"");
	SendToConsole("alias kc_nomad \"script equip_knife(knife.nomad)\"");
	SendToConsole("alias kc_paracord \"script equip_knife(knife.paracord)\"");
	SendToConsole("alias kc_skeleton \"script equip_knife(knife.skeleton)\"");
	SendToConsole("alias kc_stiletto \"script equip_knife(knife.stiletto)\"");
	SendToConsole("alias kc_survival \"script equip_knife(knife.survival)\"");
	SendToConsole("alias kc_talon \"script equip_knife(knife.talon)\"");
	SendToConsole("alias kc_ursus \"script equip_knife(knife.ursus)\"");
	SendToConsole("bind HOME \"script equip_knife(KC_LAST_KNIFE)\"")
}

printd("Initial loading");
kc_welcome_message();
kc_admin_aliases();

knife <- 
{
	def = "weapon_knife",
	bayonet = "weapon_bayonet",
	bowie = "weapon_knife_survival_bowie",
	butterfly = "weapon_knife_butterfly",
	css = "weapon_knife_css",
	daggers = "weapon_knife_push",
	falchion = "weapon_knife_falchion",
	flip = "weapon_knife_flip",
	ghost = "weapon_knife_ghost",
	gungame = "weapon_knifegg",
	gut = "weapon_knife_gut",
	huntsman = "weapon_knife_tactical",
	karambit = "weapon_knife_karambit",
	m9 = "weapon_knife_m9_bayonet",
	navaja = "weapon_knife_gypsy_jackknife",
	nomad = "weapon_knife_outdoor",
	paracord = "weapon_knife_cord",
	skeleton = "weapon_knife_skeleton"
	stiletto = "weapon_knife_stiletto",
	survival = "weapon_knife_canis",
	talon = "weapon_knife_widowmaker",
	ursus = "weapon_knife_ursus"
}
KC_LAST_KNIFE <- knife;


function equip_knife(knife)
{
	printd("In equip_knife(" + knife + ")");

	KC_LAST_KNIFE = knife;
	printd("KC_LAST_KNIFE is set to " + knife);

	local equip = Entities.CreateByClassname("game_player_equip");
	printd("Created a game_player_equip entity with id " + equip);
	
	EntFireByHandle(equip, "addoutput", knife + " 1", 0, null, null);
	printd("Added " + knife + " to the game_player_equip");

	EntFire("weapon_knife*", "kill");
	printd("Killed all knife entities");

	EntFireByHandle(equip, "TriggerForAllPlayers", "", 0, null, null);
	printd("Triggered game_player_equip for all players");

	EntFire("weapon_knife", "addoutput", "classname weapon_knifegg");
	printd("Changed class of all knives to weapon_knifegg");
}

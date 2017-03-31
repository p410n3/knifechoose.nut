/* knifechoose.nut v2.3-finalbeta
 * Firstperson Knife Model Changer
 * by Gray
 * github: https://github.com/serkas001/knifechoose.nut/
 *
 * Things used:
 * nadetraining.nut by S0lll0s, Bidj and Rurre is used as a very base of the script
 * p410n3's fork as a base for some functions and a place to get new ideas :)
 * https://developer.valvesoftware.com/ as a place to find description to what different functions do
 * Valve's own vscripts for their maps from the vscripts folder as a place to get inspiration
 *
 * goes into /csgo/scripts/vscripts/kc.nut
 *
 * USAGE, in console:
 *  	script_execute kc
 * Write the knife's name in your console
 * 	 kc_<m9, flip, bayonet, butterfly, falchion, gut, huntsman, karambit, daggers, bowie>
 * Or press 'INS'(auto-binded) to scroll through all the knives available
 * You also have to press 'HOME' on every roundstart to reload the script.
 *	Info about why you have to do this can be found in the github repo's README file
 * Done!
 * More features and optimization will be included in future updates! Stay turned!
 * Also the butterfly knife's very buggy, even unusable, but there's nothing I can do about it, at least yet.
 */

//Current script's version. Used in messages, so it is not hard-coded.
kc_version			 <- "v2.3-finalbeta";

/*
		Every knife ad their corresponding number

		flip - 1
		gut - 2
		falchion - 3
		huntsman - 4
		karambit - 5
		m9 - 6
		bayonet - 7
		daggers - 8
		bowie - 9
		butterfly - 10
		no knife selected = default knife - 0
*/

//Tracks which knife is currently selected
//Flip knife is enabled by default
kc_current_knife <- 1;

//Displays messages on first startup both to chat and console.
function knifeWelcomeMessage()
{
	ScriptPrintMessageChatAll("[KC] Firstperson Knife Model Changer " + kc_version + " loaded. Check your admin console!");
	printl("[KC] knifechoose.nut");
	printl("[KC] Firstperson Knife Model Changer " + kc_version);
	printl("[KC] by Gray and PalOne, site: https://github.com/serkas001/knifechoose.nut");
	printl("[KC] Usage:");
	printl("[KC] Press 'INS' to switch between knifes or");
	printl("[KC] Type the knife's name in your console to force-set it:");
	printl("[KC] 	 kc_<m9, flip, bayonet, butterfly, falchion, gut, huntsman, karambit, daggers, bowie>");
	printl("[KC] Example: kc_daggers");
	printl("[KC] Note: Cause of some game limitations you have to press 'HOME' key to reload the script")
	printl("[KC]			You may take a look on the github repo's discription for details");
}

//
function knifeSetup()
{
	ScriptPrintMessageChatAll("[KC] Script loaded for this round!");

	SendToConsole("alias kc_flip script flip()");
	SendToConsole("alias kc_gut script gut()");
	SendToConsole("alias kc_falchion script falchion()");
	SendToConsole("alias kc_huntsman script huntsman()");
	SendToConsole("alias kc_karambit script karambit()");
	SendToConsole("alias kc_m9 script m9()");
	SendToConsole("alias kc_bayonet script bayonet()");
	SendToConsole("alias kc_daggers script daggers()");
	SendToConsole("alias kc_bowie script bowie()");
	SendToConsole("alias kc_butterfly script butterfly()");
	SendToConsole("alias kc_reset script knifeReset()");


	//Not neccesary anymore
	//SendToConsole("sv_cheats 1" );

	if (!Entities.FindByName(null, "knifeTimer"))
	{
		local v_knifeTimer = null;
		v_knifeTimer = Entities.CreateByClassname("logic_timer");
		EntFireByHandle(v_knifeTimer, "addoutput", "targetname knifeTimer", 0.0, null, null);
	}

	EntFire("knifeTimer", "enable");
	EntFire("knifeTimer", "addoutput", "refiretime 0.05");
	EntFire("knifeTimer", "addoutput", "UseRandomTime 0");
	EntFire("knifeTimer", "addoutput", "ontimer knifeTimer,RunScriptCode,knifeSet()");

}

//---------------------------------------------------------------------
//These 3 commands launch on script execute
SendToConsole("bind home \"script knifeSetup()\"");		//Binds home to recreating logic_timer
SendToConsole("bind ins \"script knifeSelect()\"");		//Binds ins to selecting knife
knifeWelcomeMessage();
knifeSetup();

//Debug menu. Can be seen by typing "script knifeDebug()" in console
function knifeDebug()
{
	printl("kc_knives[\"flip\"]	= " + kc_knives["flip"]);
	printl("kc_knives[\"gut\"]	= " + kc_knives["gut"]);
	printl("kc_knives[\"falchion\"]	= " + kc_knives["falchion"]);
	printl("kc_knives[\"huntsman\"]	= " + kc_knives["huntsman"]);
	printl("kc_knives[\"karambit\"]	= " + kc_knives["karambit"]);
	printl("kc_knives[\"m9\"]	= " + kc_knives["m9"]);
	printl("kc_knives[\"bayonet\"]	= " + kc_knives["bayonet"]);
	printl("kc_knives[\"daggers\"]	= " + kc_knives["daggers"]);
	printl("kc_knives[\"bowie\"]	= " + kc_knives["bowie"]);
	printl("kc_knives[\"butterfly\"]	= " + kc_knives["butterfly"]);
}

function knifeSelect()
{
	switch(kc_current_knife)
	{
		case 0: flip(); break;					//current knife = default -> change to flip
		case 1: gut(); break;						//current knife = flip -> change to gut
		case 2: falchion(); break;			//current knife = gut -> change to falchion
		case 3: huntsman(); break;			//current knife = falchion -> change to huntsman
		case 4: karambit(); break;			//current knife = huntsman -> change to karambit
		case 5: m9(); break;						//current knife = karambit -> change to m9
		case 6: bayonet(); break;				//current knife = m9 -> change to bayonet
		case 7: daggers(); break;				//current knife = bayonet -> change to daggers
		case 8: bowie(); break;					//current knife = daggers -> change to bowie
		//case 9: butterfly(); break;			//current knife = bowie -> change to butterfly
		default: knifeReset(); break;		//current knife = any other knife -> change to default
	}
}

//Every function below enables its knife-status var and disables others + shows "xxx knife choosen" message

function flip()
{
	kc_current_knife = 1;

	ScriptPrintMessageChatAll("[KC] Flip Knife equiped.");
	printl("[KC] Flip Knife equiped.");
}

function gut()
{
	kc_current_knife = 2;

	ScriptPrintMessageChatAll("[KC] Gut Knife equiped.");
	printl("[KC] Gut Knife equiped.");
}

function falchion()
{
	kc_current_knife = 3;

	ScriptPrintMessageChatAll("[KC] Falchion Knife equiped.");
	printl("[KC] Falchion Knife equiped.");
}

function huntsman()
{
	kc_current_knife = 4;

	ScriptPrintMessageChatAll("[KC] Huntsman Knife equiped.");
	printl("[KC] Huntsman Knife equiped.");
}

function karambit()
{
	kc_current_knife = 5;

	ScriptPrintMessageChatAll("[KC] Karambit equiped.");
	printl("[KC] Karambit equiped.");
}

function m9()
{
	kc_current_knife = 6;

	ScriptPrintMessageChatAll("[KC] M9 Bayonet equiped.");
	printl("[KC] M9 Bayonet equiped.");
}

function bayonet()
{
	kc_current_knife = 7;

	ScriptPrintMessageChatAll("[KC] Bayonet equiped.");
	printl("[KC] Bayonet equiped.");
}

function daggers()
{
	kc_current_knife = 8;

	ScriptPrintMessageChatAll("[KC] Shadow Daggers equiped.");
	printl("[KC] Shadow Daggers equiped.");
}

function bowie()
{
	kc_current_knife = 9;

	ScriptPrintMessageChatAll("[KC] Bowie Knife equiped.");
	printl("[KC] Bowie Knife equiped.");
}

function butterfly()
{
	kc_current_knife = 10;

	ScriptPrintMessageChatAll("[KC] Butterfly Knife equiped. (Buggy!)");
	printl("[KC] Butterfly Knife equiped. (Buggy!)");
}

//Sets all knife-status vars to false
function knifeReset()
{
	kc_current_knife = 0;

	ScriptPrintMessageChatAll("[KC] Standart Knife equiped.");
	printl("[KC] Standart Knife equiped.");
}

//Runs on every logic_timer call, checks which knife-status var is true and changes all found default knives models
function knifeSet()
{
	switch(kc_current_knife)		//Case x knife is selected
	{
		case 1:
		{	//Flip
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_flip.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_flip.mdl");

			break;
		}

		case 2:
		{	//Gut
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_gut.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_gut.mdl");

			break;
		}

		case 3:
		{	//Falchion
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_falchion_advanced.mdl");

			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_falchion_advanced.mdl");

			break;
		}

		case 4:
		{	//Huntsman
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_tactical.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_tactical.mdl");

			break;
		}

		case 5:
		{	//Karambit
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_karam.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_karam.mdl");

			break;
		}

		case 6:
		{	//M9
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_m9_bay.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_m9_bay.mdl");

			break;
		}

		case 7:
		{	//Bayonet
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_bayonet.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_bayonet.mdl");

			break;
		}

		case 8:
		{	//Daggers
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_push.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_push.mdl");

			break;
		}

		case 9:
		{	//Bowie
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_survival_bowie.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_survival_bowie.mdl");

			break;
		}

		case 10:
		{	//Butterfly
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_butterfly.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_butterfly.mdl");

			break;
		}
	}
}

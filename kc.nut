/* knifechoose.nut v2.3-beta3
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
kc_version			 <- "v2.3-beta3";

//Variables that represent every knife's status(activated or not).
//More than 1 var should not be enabled at the same time!
//Flip knife is enabled by default
kc_knives <- {
	flip 			= true,
	gut 			= false,
	falchion	= false,
	huntsman 	= false,
	karambit 	= false,
	m9 				= false,
	bayonet 	= false,
	daggers 	= false,
	bowie 		= false,
	butterfly	= false
}

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
SendToConsole("bind home \"script knifeSetup()\"");		//Binds home to recreate logic_timer
//TODO add a function to scroll through knives and a bind for it
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

//Every function below enables its knife-status var and disables others + shows "xxx knife choosen" message

function flip()
{
	kc_knives["flip"] = true;

	kc_knives["gut"] = false;
	kc_knives["falchion"] = false;
	kc_knives["huntsman"] = false;
	kc_knives["karambit"] = false;
	kc_knives["m9"] = false;
	kc_knives["bayonet"] = false;
	kc_knives["daggers"] = false;
	kc_knives["bowie"] = false;
	kc_knives["butterfly"] = false;

	ScriptPrintMessageChatAll("[KC] Flip Knife equiped.");
	printl("[KC] Flip Knife equiped.");
}

function gut()
{
	kc_knives["flip"] = false;

	kc_knives["gut"] = true;

	kc_knives["falchion"] = false;
	kc_knives["huntsman"] = false;
	kc_knives["karambit"] = false;
	kc_knives["m9"] = false;
	kc_knives["bayonet"] = false;
	kc_knives["daggers"] = false;
	kc_knives["bowie"] = false;
	kc_knives["butterfly"] = false;


	ScriptPrintMessageChatAll("[KC] Gut Knife equiped.");
	printl("[KC] Gut Knife equiped.");
}

function falchion()
{
	kc_knives["flip"] = false;
	kc_knives["gut"] = false;

	kc_knives["falchion"] = true;

	kc_knives["huntsman"] = false;
	kc_knives["karambit"] = false;
	kc_knives["m9"] = false;
	kc_knives["bayonet"] = false;
	kc_knives["daggers"] = false;
	kc_knives["bowie"] = false;
	kc_knives["butterfly"] = false;


	ScriptPrintMessageChatAll("[KC] Falchion Knife equiped.");
	printl("[KC] Falchion Knife equiped.");
}

function huntsman()
{
	kc_knives["flip"] = false;
	kc_knives["gut"] = false;
	kc_knives["falchion"] = false;

	kc_knives["huntsman"] = true;

	kc_knives["karambit"] = false;
	kc_knives["m9"] = false;
	kc_knives["bayonet"] = false;
	kc_knives["daggers"] = false;
	kc_knives["bowie"] = false;
	kc_knives["butterfly"] = false;


	ScriptPrintMessageChatAll("[KC] Huntsman Knife equiped.");
	printl("[KC] Huntsman Knife equiped.");
}

function karambit()
{
	kc_knives["flip"] = false;
	kc_knives["gut"] = false;
	kc_knives["falchion"] = false;
	kc_knives["huntsman"] = false;

	kc_knives["karambit"] = true;

	kc_knives["m9"] = false;
	kc_knives["bayonet"] = false;
	kc_knives["daggers"] = false;
	kc_knives["bowie"] = false;
	kc_knives["butterfly"] = false;


	ScriptPrintMessageChatAll("[KC] Karambit equiped.");
	printl("[KC] Karambit equiped.");
}

function m9()
{
	kc_knives["flip"] = false;
	kc_knives["gut"] = false;
	kc_knives["falchion"] = false;
	kc_knives["huntsman"] = false;
	kc_knives["karambit"] = false;

	kc_knives["m9"] = true;

	kc_knives["bayonet"] = false;
	kc_knives["daggers"] = false;
	kc_knives["bowie"] = false;
	kc_knives["butterfly"] = false;


	ScriptPrintMessageChatAll("[KC] M9 Bayonet equiped.");
	printl("[KC] M9 Bayonet equiped.");
}

function bayonet()
{
	kc_knives["flip"] = false;
	kc_knives["gut"] = false;
	kc_knives["falchion"] = false;
	kc_knives["huntsman"] = false;
	kc_knives["karambit"] = false;
	kc_knives["m9"] = false;

	kc_knives["bayonet"] = true;

	kc_knives["daggers"] = false;
	kc_knives["bowie"] = false;
	kc_knives["butterfly"] = false;


	ScriptPrintMessageChatAll("[KC] Bayonet equiped.");
	printl("[KC] Bayonet equiped.");
}

function daggers()
{
	kc_knives["flip"] = false;
	kc_knives["gut"] = false;
	kc_knives["falchion"] = false;
	kc_knives["huntsman"] = false;
	kc_knives["karambit"] = false;
	kc_knives["m9"] = false;
	kc_knives["bayonet"] = false;

	kc_knives["daggers"] = true;

	kc_knives["bowie"] = false;
	kc_knives["butterfly"] = false;


	ScriptPrintMessageChatAll("[KC] Shadow Daggers equiped.");
	printl("[KC] Shadow Daggers equiped.");
}

function bowie()
{
	kc_knives["flip"] = false;
	kc_knives["gut"] = false;
	kc_knives["falchion"] = false;
	kc_knives["huntsman"] = false;
	kc_knives["karambit"] = false;
	kc_knives["m9"] = false;
	kc_knives["bayonet"] = false;
	kc_knives["daggers"] = false;

	kc_knives["bowie"] = true;

	kc_knives["butterfly"] = false;


	ScriptPrintMessageChatAll("[KC] Bowie Knife equiped.");
	printl("[KC] Bowie Knife equiped.");
}

function butterfly()
{
	kc_knives["flip"] = false;
	kc_knives["gut"] = false;
	kc_knives["falchion"] = false;
	kc_knives["huntsman"] = false;
	kc_knives["karambit"] = false;
	kc_knives["m9"] = false;
	kc_knives["bayonet"] = false;
	kc_knives["daggers"] = false;
	kc_knives["bowie"] = false;

	kc_knives["butterfly"] = true;


	ScriptPrintMessageChatAll("[KC] Butterfly Knife equiped. (Buggy!)");
	printl("[KC] Butterfly Knife equiped. (Buggy!)");
}

//Sets all knife-status vars to false
function knifeReset()
{
	kc_knives["flip"] = false;
	kc_knives["gut"] = false;
	kc_knives["falchion"] = false;
	kc_knives["huntsman"] = false;
	kc_knives["karambit"] = false;
	kc_knives["m9"] = false;
	kc_knives["bayonet"] = false;
	kc_knives["daggers"] = false;
	kc_knives["bowie"] = false;
	kc_knives["butterfly"] = false;


	ScriptPrintMessageChatAll("[KC] Standart Knife equiped.");
	printl("[KC] Standart Knife equiped.");
}

//Runs on every logic_timer call, checks whcih knife-status var is true and changes all found default knives models
function knifeSet()
{
	if (kc_knives["flip"])
	{
		local knife = null;
		while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
		{
			knife.SetModel("models/weapons/v_knife_flip.mdl");
		}

		local knife = null;
		while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
		{
			knife.SetModel("models/weapons/v_knife_flip.mdl");
		}
	}
	if (kc_knives["gut"])
	{
		local knife = null;
		while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
		{
			knife.SetModel("models/weapons/v_knife_gut.mdl");
		}

		local knife = null;
		while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
		{
			knife.SetModel("models/weapons/v_knife_gut.mdl");
		}
	}
	if (kc_knives["falchion"])
	{
		local knife = null;
		while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
		{
			knife.SetModel("models/weapons/v_knife_falchion_advanced.mdl");
		}

		local knife = null;
		while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
		{
			knife.SetModel("models/weapons/v_knife_falchion_advanced.mdl");
		}
	}
	if (kc_knives["huntsman"])
	{
		local knife = null;
		while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
		{
			knife.SetModel("models/weapons/v_knife_tactical.mdl");
		}

		local knife = null;
		while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
		{
			knife.SetModel("models/weapons/v_knife_tactical.mdl");
		}
	}
	if (kc_knives["karambit"])
	{
		local knife = null;
		while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
		{
			knife.SetModel("models/weapons/v_knife_karam.mdl");
		}

		local knife = null;
		while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
		{
			knife.SetModel("models/weapons/v_knife_karam.mdl");
		}
	}
	if (kc_knives["m9"])
	{
		local knife = null;
		while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
		{
			knife.SetModel("models/weapons/v_knife_m9_bay.mdl");
		}

		local knife = null;
		while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
		{
			knife.SetModel("models/weapons/v_knife_m9_bay.mdl");
		}
	}
	if(kc_knives["bayonet"])
	{
		local knife = null;
		while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
		{
			knife.SetModel("models/weapons/v_knife_bayonet.mdl");
		}

		local knife = null;
		while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
		{
			knife.SetModel("models/weapons/v_knife_bayonet.mdl");
		}
	}
	if (kc_knives["daggers"])
	{
		local knife = null;
		while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
		{
			knife.SetModel("models/weapons/v_knife_push.mdl");
		}

		local knife = null;
		while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
		{
			knife.SetModel("models/weapons/v_knife_push.mdl");
		}
	}
	if (kc_knives["bowie"])
	{
		local knife = null;
		while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
		{
			knife.SetModel("models/weapons/v_knife_survival_bowie.mdl");
		}

		local knife = null;
		while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
		{
			knife.SetModel("models/weapons/v_knife_survival_bowie.mdl");
		}
	}
	if (kc_knives["butterfly"])
	{
		local knife = null;
		while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
		{
			knife.SetModel("models/weapons/v_knife_butterfly.mdl");
		}

		local knife = null;
		while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
		{
			knife.SetModel("models/weapons/v_knife_butterfly.mdl");
		}
	}
}

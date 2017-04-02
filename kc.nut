/* knifechoose.nut v2.3.1-beta1
 * Firstperson Knife Model Changer
 * by Gray and p410n3
 * github: https://github.com/serkas001/knifechoose.nut/
 *
 * Things used:
 * nadetraining.nut by S0lll0s, Bidj and Rurre is used as a very base of the script
 * https://developer.valvesoftware.com/ as a place to find description to what different functions do
 * Valve's own vscripts for their maps from the vscripts folder as a place to get inspiration
 *
 * goes into /csgo/scripts/vscripts/kc.nut
 *
 * USAGE, in console:
 *  	script_execute kc
 * Press 'ins' to select a knife or use the corresponding console command:
 *	Just add "kc_" to a knife's name from the list below the description
 * 	Example: kc_flip
 * Or press 'INS'(auto-binded) to scroll through all the knives available
 * You also have to press 'HOME' on every roundstart to reload the script.
 *	Info about why you have to do this can be found in the github repo's README file
 * Done!
 * More features and optimizations will be included in future updates! Stay tuned!
 * Also the butterfly knife's very buggy, even unusable, but there's nothing I can do about it, at least yet.
 */

//Current script's version. Used in messages, so it is not hard-coded.
const kc_version = "v2.3.1-beta1";

enum Knife
{
	standard,
	flip,
	gut,
	falchion,
	huntsman,
	karambit,
	m9,
	bayonet,
	daggers,
	bowie,
	butterfly
}

//Tracks which knife is currently selected
//Flip knife is enabled by default
kc_current_knife <- Knife.flip;

//Displays messages on first startup both to chat and console.
function knifeWelcomeMessage()
{
	ScriptPrintMessageChatAll("[KC] Firstperson Knife Model Changer " + kc_version + " loaded. Check your admin console!");
	printl("[KC] knifechoose.nut");
	printl("[KC] Firstperson Knife Model Changer " + kc_version);
	printl("[KC] by Gray and PalOne, site: https://github.com/serkas001/knifechoose.nut");
	printl("[KC] Usage:");
	printl("[KC] Press 'INS' to switch between knives or");
	printl("[KC] Type the knife's name in your console with \"kc_\" prefix to force-set it:");
	printl("[KC] All available knives: flip, gut, falchion, huntsman, karambit, m9, bayonet, daggers, bowie, butterfly, default");
	printl("[KC] Example: kc_daggers");
	printl("[KC] Note: Cause of some game limitations you have to press 'HOME' key to reload the script every round")
	printl("[KC]			You may take a look on the github repo's discription for details");
}

//Creates aliases for every knife available
function knifeAliases()
{
	SendToConsole("alias kc_flip \"script knifeSet(Knife.flip)\"");
	SendToConsole("alias kc_gut \"script knifeSet(Knife.gut)\"");
	SendToConsole("alias kc_falchion \"script knifeSet(Knife.falchion)\"");
	SendToConsole("alias kc_huntsman \"script knifeSet(Knife.huntsman)\"");
	SendToConsole("alias kc_karambit \"script knifeSet(Knife.karambit)\"");
	SendToConsole("alias kc_m9 \"script knifeSet(Knife.m9)\"");
	SendToConsole("alias kc_bayonet \"script knifeSet(Knife.bayonet)\"");
	SendToConsole("alias kc_daggers \"script knifeSet(Knife.daggers)\"");
	SendToConsole("alias kc_bowie \"script knifeSet(Knife.bowie)\"");
	SendToConsole("alias kc_butterfly \"script knifeSet(Knife.butterfly)\"");
	SendToConsole("alias kc_standard \"script knifeSet(Knife.standard)\"");
}

//Creates a new logic_timer entity(if there is not one)
function knifeSetup()
{
	ScriptPrintMessageChatAll("[KC] Script loaded for this round!");

	if (!Entities.FindByName(null, "knifeTimer"))
	{
		local v_knifeTimer = null;
		v_knifeTimer = Entities.CreateByClassname("logic_timer");
		EntFireByHandle(v_knifeTimer, "addoutput", "targetname knifeTimer", 0.0, null, null);
	}

	EntFire("knifeTimer", "enable");
	EntFire("knifeTimer", "addoutput", "refiretime 0.05");
	EntFire("knifeTimer", "addoutput", "UseRandomTime 0");
	EntFire("knifeTimer", "addoutput", "ontimer knifeTimer,RunScriptCode,knifeModelSet()");

}

//---------------------------------------------------------------------
//These 3 commands launch on script execute
SendToConsole("bind home \"script knifeSetup()\"");		//Binds home to recreating logic_timer
SendToConsole("bind ins \"script knifeSelectNext()\"");		//Binds ins to selecting next knife
SendToConsole("bind del \"script knifeSelectPrev()\"");		//Binds del to selecting previous knife
knifeWelcomeMessage();
knifeAliases();
knifeSetup();

//Debug menu. Can be seen by typing "script knifeDebug()" in console
//ToDo Add more debug options
function knifeDebug()
{
	printl("kc_current_knife = " + kc_current_knife);
}

//Goes through the list of knives one-by-one(auto-binded to 'ins')
function knifeSelectNext()
{
	switch(kc_current_knife)
	{
		case Knife.standard:
			knifeSet(Knife.flip); break;
		case Knife.flip:
			knifeSet(Knife.gut); break;
		case Knife.gut:
			knifeSet(Knife.falchion); break;
		case Knife.falchion:
			knifeSet(Knife.huntsman); break;
		case Knife.huntsman:
			knifeSet(Knife.karambit); break;
		case Knife.karambit:
			knifeSet(Knife.m9); break;
		case Knife.m9:
			knifeSet(Knife.bayonet); break;
		case Knife.bayonet:
			knifeSet(Knife.daggers); break;
		case Knife.daggers:
			knifeSet(Knife.bowie); break;
		/*case Knife.bowie:
			knifeSet(Knife.butterfly); break;*/
		default:
			knifeSet(Knife.standard);
	}
}

//Goes through the list of knives backwards one-by-one(auto-binded to 'del')
function knifeSelectPrev()
{
	//Not working! To rewrite
	switch(kc_current_knife)
	{
		case Knife.standard:
			knifeSet(Knife.flip); break;
		case Knife.flip:
			knifeSet(Knife.gut); break;
		case Knife.gut:
			knifeSet(Knife.falchion); break;
		case Knife.falchion:
			knifeSet(Knife.huntsman); break;
		case Knife.huntsman:
			knifeSet(Knife.karambit); break;
		case Knife.karambit:
			knifeSet(Knife.m9); break;
		case Knife.m9:
			knifeSet(Knife.bayonet); break;
		case Knife.bayonet:
			knifeSet(Knife.daggers); break;
		case Knife.daggers:
			knifeSet(Knife.bowie); break;
		/*case Knife.bowie:
			knifeSet(Knife.butterfly); break;*/
		default:
			knifeSet(Knife.standard);
	}
}

//Changes knife to the selected one(by its number as a parameter)
function knifeSet(knife_number)
{
	local display_message = null;

	switch(knife_number)		//Case x knife is selected
	{
		case Knife.flip:
		{	//Flip
			kc_current_knife = Knife.flip;
			display_message = "[KC] Flip Knife equiped.";
			break;
		}

		case Knife.gut:
		{	//Gut
			kc_current_knife = Knife.gut;
			display_message = "[KC] Gut Knife equiped.";
			break;
		}

		case Knife.falchion:
		{	//Falchion
			kc_current_knife = Knife.falchion;
			display_message = "[KC] Falchion Knife equiped.";
			break;
		}

		case Knife.huntsman:
		{	//Huntsman
			kc_current_knife = Knife.huntsman;
			display_message = "[KC] Huntsman Knife equiped.";
			break;
		}

		case Knife.karambit:
		{	//Karambit
			kc_current_knife = Knife.karambit;
			display_message = "[KC] Karambit equiped.";
			break;
		}

		case Knife.m9:
		{	//M9
			kc_current_knife = Knife.m9;
			display_message = "[KC] M9 Bayonet equiped.";
			break;
		}

		case Knife.bayonet:
		{	//Bayonet
			kc_current_knife = Knife.bayonet;
			display_message = "[KC] Bayonet equiped.";
			break;
		}

		case Knife.daggers:
		{	//Daggers
			kc_current_knife = Knife.daggers;
			display_message = "[KC] Shadow Daggers equiped.";
			break;
		}

		case Knife.bowie:
		{	//Bowie
			kc_current_knife = Knife.bowie;
			display_message = "[KC] Bowie equiped.";
			break;
		}

		case Knife.butterfly:
		{	//Butterfly
			kc_current_knife = Knife.butterfly;
			display_message = "[KC] Butterfly Knife equiped.";
			break;
		}

		default:
		{	//Any other
			kc_current_knife = Knife.standard;
			display_message = "[KC] Default Knife equiped.";
		}
	}

	ScriptPrintMessageChatAll(display_message);
	printl(display_message);
}

//Runs on every logic_timer call, checks which knife-status var is true and changes all found default knives models
function knifeModelSet()
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

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

/*
		Every knife name and its corresponding number
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
		default - 0
*/

//Current script's version. Used in messages, so it is not hard-coded.
const kc_version = "v2.3.1-beta1";

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
	SendToConsole("alias kc_flip \"script knifeSet(1)\"");
	SendToConsole("alias kc_gut \"script knifeSet(2)\"");
	SendToConsole("alias kc_falchion \"script knifeSet(3)\"");
	SendToConsole("alias kc_huntsman \"script knifeSet(4)\"");
	SendToConsole("alias kc_karambit \"script knifeSet(5)\"");
	SendToConsole("alias kc_m9 \"script knifeSet(6)\"");
	SendToConsole("alias kc_bayonet \"script knifeSet(7)\"");
	SendToConsole("alias kc_daggers \"script knifeSet(8)\"");
	SendToConsole("alias kc_bowie \"script knifeSet(9)\"");
	SendToConsole("alias kc_butterfly \"script knifeSet(10)\"");
	SendToConsole("alias kc_default \"script knifeSet(0)\"");
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
		case 0: knifeSet(1); break;						//current knife = default -> change to flip
		case 1: knifeSet(2); break;						//current knife = flip -> change to gut
		case 2: knifeSet(3); break;						//current knife = gut -> change to falchion
		case 3: knifeSet(4); break;						//current knife = falchion -> change to huntsman
		case 4: knifeSet(5); break;						//current knife = huntsman -> change to karambit
		case 5: knifeSet(6); break;						//current knife = karambit -> change to m9
		case 6: knifeSet(7); break;						//current knife = m9 -> change to bayonet
		case 7: knifeSet(8); break;						//current knife = bayonet -> change to daggers
		case 8: knifeSet(9); break;						//current knife = daggers -> change to bowie
		//case 9: knifeSet(10); break;				//current knife = bowie -> change to butterfly
		default: knifeSet(0); break;					//current knife = any other knife -> change to default
	}
}

//Goes through the list of knives backwards one-by-one(auto-binded to 'del')
function knifeSelectPrev()
{
	switch(kc_current_knife)
	{
		case 0: knifeSet(9); break;						//current knife = default -> change to flip
		case 1: knifeSet(0); break;						//current knife = flip -> change to gut
		case 2: knifeSet(1); break;						//current knife = gut -> change to falchion
		case 3: knifeSet(2); break;						//current knife = falchion -> change to huntsman
		case 4: knifeSet(3); break;						//current knife = huntsman -> change to karambit
		case 5: knifeSet(4); break;						//current knife = karambit -> change to m9
		case 6: knifeSet(5); break;						//current knife = m9 -> change to bayonet
		case 7: knifeSet(6); break;						//current knife = bayonet -> change to daggers
		case 8: knifeSet(7); break;						//current knife = daggers -> change to bowie
		case 9: knifeSet(8); break;				//current knife = bowie -> change to butterfly
		default: knifeSet(0); break;					//current knife = any other knife -> change to default
	}
}

//Changes knife to the selected one(by its number as a parameter)
function knifeSet(knife_number)
{
	local display_message = null;

	switch(knife_number)		//Case x knife is selected
	{
		case 1:
		{	//Flip
			kc_current_knife = 1;
			display_message = "[KC] Flip Knife equiped.";
			break;
		}

		case 2:
		{	//Gut
			kc_current_knife = 2;
			display_message = "[KC] Gut Knife equiped.";
			break;
		}

		case 3:
		{	//Falchion
			kc_current_knife = 3;
			display_message = "[KC] Falchion Knife equiped.";
			break;
		}

		case 4:
		{	//Huntsman
			kc_current_knife = 4;
			display_message = "[KC] Huntsman Knife equiped.";
			break;
		}

		case 5:
		{	//Karambit
			kc_current_knife = 5;
			display_message = "[KC] Karambit equiped.";
			break;
		}

		case 6:
		{	//M9
			kc_current_knife = 6;
			display_message = "[KC] M9 Bayonet equiped.";
			break;
		}

		case 7:
		{	//Bayonet
			kc_current_knife = 7;
			display_message = "[KC] Bayonet equiped.";
			break;
		}

		case 8:
		{	//Daggers
			kc_current_knife = 8;
			display_message = "[KC] Shadow Daggers equiped.";
			break;
		}

		case 9:
		{	//Bowie
			kc_current_knife = 9;
			display_message = "[KC] Bowie equiped.";
			break;
		}

		case 10:
		{	//Butterfly
			kc_current_knife = 10;
			display_message = "[KC] Butterfly Knife equiped.";
			break;
		}

		default:
		{	//Any other
			kc_current_knife = 0;
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

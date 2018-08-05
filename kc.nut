/* knifechoose.nut v2.5.0
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
const kc_version = "v2.5.0";

enum Knife
{
	standard,	    //0		//We have to use "standard" instead of "default", 'cause "default" is a prereserved key-word :c
	flip,		    //1
	gut,		    //2
	falchion,	    //3
	huntsman,	    //4
	karambit,	    //5
    m9,			    //6
	bayonet,	    //7
	daggers,	    //8
	bowie,		    //9
    butterfly,     	//10
    stiletto,       //11
    ursus,          //12
    widowmaker,     //13 aka talon
    gypsy_jackknife //14 aka navaja
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
	printl("[KC] All available knives: flip, gut, falchion, huntsman, karambit, m9, bayonet, daggers, bowie, butterfly, stiletto, ursus, talon, navaja, default");
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
	SendToConsole("alias kc_stiletto \"script knifeSet(Knife.stiletto)\"");
	SendToConsole("alias kc_ursus \"script knifeSet(Knife.ursus)\"");
	SendToConsole("alias kc_talon \"script knifeSet(Knife.widowmaker)\"");
	SendToConsole("alias kc_navaja \"script knifeSet(Knife.gypsy_jackknife)\"");
	SendToConsole("alias kc_default \"script knifeSet(Knife.standard)\"");
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
	EntFire("knifeTimer", "addoutput", "refiretime 0.001"); //random attempt to minimize glitching on clients
	EntFire("knifeTimer", "addoutput", "UseRandomTime 0");
	EntFire("knifeTimer", "addoutput", "ontimer knifeTimer,RunScriptCode,knifeModelSet()");

}

//---------------------------------------------------------------------
//Bind the keys to selecting knives and reloading the script(works only if executed from listen server console)
SendToConsole("bind home \"script knifeSetup()\"");		//Binds home to recreating logic_timer
SendToConsole("bind ins \"script knifeSelectNext()\"");		//Binds ins to selecting next knife
SendToConsole("bind del \"script knifeSelectPrev()\"");		//Binds del to selecting previous knife
//These 3 commands launch on script execute
knifeWelcomeMessage();
knifeAliases();
knifeSetup();

//Debug menu. Can be seen by typing "script knifeDebug()" in console
//ToDo Add more debug options
function knifeDebug()
{
	printl("kc_current_knife = " + kc_current_knife);
}

//Goes through the list of knives(-butterfly cause of bugginess) one-by-one(auto-binded to 'ins')
function knifeSelectNext()
{
	knifeSet(++kc_current_knife);
		//Adds 1 to kc_current_knife thus changing the knife to the next one
		//If the next knife == Knife.butterfly (10) then set it to Knife.standard (0)
		//Note: if butterfly wasn't so buggy, we could just use knifeSet(++kc_current_knife),
		//	'cause knifeSet() already sets every value > 10(buttefly) && < 0 to 0(standard)

		//Note from palonE:

		//I decided to include the butterfly, I think its not too buggy 
}

//Goes through the list of knives(-butterfly cause of bugginess) backwards one-by-one(auto-binded to 'del')
function knifeSelectPrev()
{
	knifeSet(--kc_current_knife < Knife.standard ? Knife.gypsy_jackknife:kc_current_knife);
		//Substacts 1 from kc_current_knife thus changing the knife to the previous one
		//If the previous knife < Knife.standard (0) then set it to Knife.bowie (9)
		//	thus skipping out butterfly

		//Note from palonE:

		//I decided to include the butterfly, I think its not too buggy 
}

//Changes knife to the selected one(by its number as a parameter)
function knifeSet(knife_change_to)
{
	local display_message = null;

	switch(knife_change_to)
	{
		case Knife.flip:
		{
			kc_current_knife = Knife.flip;
			display_message = "[KC] Flip Knife equiped.";
			break;
		}

		case Knife.gut:
		{
			kc_current_knife = Knife.gut;
			display_message = "[KC] Gut Knife equiped.";
			break;
		}

		case Knife.falchion:
		{
			kc_current_knife = Knife.falchion;
			display_message = "[KC] Falchion Knife equiped.";
			break;
		}

		case Knife.huntsman:
		{
			kc_current_knife = Knife.huntsman;
			display_message = "[KC] Huntsman Knife equiped.";
			break;
		}

		case Knife.karambit:
		{
			kc_current_knife = Knife.karambit;
			display_message = "[KC] Karambit equiped.";
			break;
		}

		case Knife.m9:
		{
			kc_current_knife = Knife.m9;
			display_message = "[KC] M9 Bayonet equiped.";
			break;
		}

		case Knife.bayonet:
		{
			kc_current_knife = Knife.bayonet;
			display_message = "[KC] Bayonet equiped.";
			break;
		}

		case Knife.daggers:
		{
			kc_current_knife = Knife.daggers;
			display_message = "[KC] Shadow Daggers equiped.";
			break;
		}

		case Knife.bowie:
		{
			kc_current_knife = Knife.bowie;
			display_message = "[KC] Bowie equiped.";
			break;
		}

		case Knife.butterfly:
		{
			kc_current_knife = Knife.butterfly;
			display_message = "[KC] Butterfly Knife equiped.";
			break;
		}

        case Knife.stiletto: 
        {
            kc_current_knife = Knife.stiletto;
			display_message = "[KC] Stiletto Knife equiped.";
			break;
        }

        case Knife.ursus: 
        {
            kc_current_knife = Knife.ursus;
			display_message = "[KC] Ursus Knife equiped.";
			break;
        }

		case Knife.widowmaker: 
        {
            kc_current_knife = Knife.widowmaker;
			display_message = "[KC] Talon Knife equiped.";
			break;
        }

		case Knife.gypsy_jackknife: 
        {
            kc_current_knife = Knife.gypsy_jackknife;
			display_message = "[KC] Najava Knife equiped.";
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
		case Knife.flip:
		{
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_flip.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_flip.mdl");

			break;
		}

		case Knife.gut:
		{
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_gut.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_gut.mdl");

			break;
		}

		case Knife.falchion:
		{
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_falchion_advanced.mdl");

			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_falchion_advanced.mdl");

			break;
		}

		case Knife.huntsman:
		{
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_tactical.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_tactical.mdl");

			break;
		}

		case Knife.karambit:
		{
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_karam.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_karam.mdl");

			break;
		}

		case Knife.m9:
		{
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_m9_bay.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_m9_bay.mdl");

			break;
		}

		case Knife.bayonet:
		{
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_bayonet.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_bayonet.mdl");

			break;
		}

		case Knife.daggers:
		{
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_push.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_push.mdl");

			break;
		}

		case Knife.bowie:
		{
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_survival_bowie.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_survival_bowie.mdl");

			break;
		}

		case Knife.butterfly:
		{
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_butterfly.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_butterfly.mdl");

			break;
		}

        case Knife.stiletto:
		{
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_stiletto.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_stiletto.mdl");

			break;
		}

		case Knife.ursus:
		{
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_ursus.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_ursus.mdl");

			break;
		}

		case Knife.widowmaker:
		{
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_widowmaker.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_widowmaker.mdl");

			break;
		}

		case Knife.gypsy_jackknife:
		{
			local knife = null;
			while (knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_t.mdl"))
				knife.SetModel("models/weapons/v_knife_gypsy_jackknife.mdl");

			local knife = null;
			while(knife = Entities.FindByModel(knife, "models/weapons/v_knife_default_ct.mdl"))
				knife.SetModel("models/weapons/v_knife_gypsy_jackknife.mdl");

			break;
		}
	}
}

/* knifechoose.nut v2.2
 * Firstperson Knife Model Changer
 * by Gray
 * nadetraining.nut by S0lll0s, Bidj and Rurre is used as a base of the script
 *
 * goes into /csgo/scripts/vscripts/knifechoose.nut
 *
 * USAGE, in console:
 *  	script_execute knifechoose
 *	script knifeSetup()
 * Write the knife's name in your console
 * 	 kc_<m9, flip, bayonet, butterfly, falchion, gut, huntsman, karambit, daggers, bowie>
 * Done!
 * More features and optimization will be included in future updates! Stay turned!
 * Also the butterfly knife's very buggy, even unusable, but there's nothing I can do about it, at least yet.
 */

v_butterfly		<- false;
v_falchion		<- false;
v_flip 			<- false;
v_gut 			<- false;
v_huntsman 		<- false;
v_karambit 		<- false;
v_m9 			<- false;
v_bayonet 		<- false;
v_daggers 		<- false;
v_bowie 		<- false;

SendToConsole( "alias setup script knifeSetup()");
SendToConsole( "bind end setup");

//ScreenMessage
ScriptPrintMessageChatAll ("Original Script by Gray; Modded by PalOne");
ScriptPrintMessageChatAll ("-------------------------------------------------------------------");
ScriptPrintMessageChatAll ("Look at the Keys above your Arrow Keys:");
ScriptPrintMessageChatAll ("Press INS to choose a Knife");
ScriptPrintMessageChatAll ("Press DEL to equip a Knife");
ScriptPrintMessageChatAll ("Press END at every roundstart to setup the script again.");
ScriptPrintMessageChatAll ("-------------------------------------------------------------------");

//Reminder
ScriptPrintMessageCenterAll ("REMEBER TO PRESS END AT EVERY ROUNDSTART!");

//Instant Setup
SendToConsole( "script knifeSetup()");

function knifeSetup()
{	
	ScriptPrintMessageChatAll( "Script loaded for this Round!");
	//Regular Knife Binds
	
	SendToConsole( @"alias kc_m9 script m9()");
	SendToConsole( @"alias kc_flip script flip()");
	SendToConsole( @"alias kc_bayonet script bayonet()");
	SendToConsole( @"alias kc_butterfly script butterfly()");
	SendToConsole( @"alias kc_falchion script falchion()");
	SendToConsole( @"alias kc_gut script gut()");
	SendToConsole( @"alias kc_huntsman script huntsman()");
	SendToConsole( @"alias kc_karambit script karambit()");
	SendToConsole( @"alias kc_daggers script daggers()");
	SendToConsole( @"alias kc_bowie script bowie()");
	SendToConsole( @"alias kc_reset script knifeReset()");
	
	SendToConsole( @"alias ch_m9 script ch_m9()");
	SendToConsole( @"alias ch_flip script ch_flip()");
	SendToConsole( @"alias ch_bayonet script ch_bayonet()");
	SendToConsole( @"alias ch_butterfly script ch_butterfly()");
	SendToConsole( @"alias ch_falchion script ch_falchion()");
	SendToConsole( @"alias ch_gut script ch_gut()");
	SendToConsole( @"alias ch_huntsman script ch_huntsman()");
	SendToConsole( @"alias ch_karambit script ch_karambit()");
	SendToConsole( @"alias ch_daggers script ch_daggers()");
	SendToConsole( @"alias ch_bowie script ch_bowie()");
	
	//Knife change
	SendToConsole( "bind ins ch_m9");
	
	//Not neccesary anymore
	//SendToConsole( @"sv_cheats 1" );

	if (!Entities.FindByName(null, "knifeTimer"))
	{
		local v_knifeTimer = null;
		v_knifeTimer = Entities.CreateByClassname("logic_timer");
		EntFireByHandle(v_knifeTimer, "addoutput", "targetname knifeTimer", 0.0, null, null);
	}

	EntFire("knifeTimer", "addoutput", "refiretime 0.05");
	EntFire("knifeTimer", "disable");
	EntFire("knifeTimer", "addoutput", "startdisabled 1");
	EntFire("knifeTimer", "addoutput", "UseRandomTime 0"1);
	EntFire("knifeTimer", "addoutput", "ontimer knifeTimer,RunScriptCode,knifeSet()");

}

function ch_m9()
{
	ScriptPrintMessageChatAll ("M9 chosen. Press DEL to equip it");
	SendToConsole("bind del kc_m9");
	SendToConsole( "bind ins ch_flip");
}

function ch_flip()
{
	ScriptPrintMessageChatAll ("Flip chosen. Press DEL to equip it");
	SendToConsole( "bind del kc_flip");
	SendToConsole( "bind ins ch_bayonet");
}

function ch_bayonet()
{
	ScriptPrintMessageChatAll ("Bayonet chosen. Press DEL to equip it");
	SendToConsole( "bind del kc_bayonet");
	SendToConsole( "bind ins ch_butterfly");
}

function ch_butterfly()
{
	ScriptPrintMessageChatAll ("Butterfly chosen. Press DEL to equip it");
	SendToConsole( "bind del kc_butterfly");
	SendToConsole( "bind ins ch_falchion");
}

function ch_falchion()
{
	ScriptPrintMessageChatAll ("Falchion chosen. Press DEL to equip it");
	SendToConsole( "bind del kc_falchion");
	SendToConsole( "bind ins ch_gut");
}

function ch_gut()
{
	ScriptPrintMessageChatAll ("Gut chosen. Press DEL to equip it");
	SendToConsole( "bind del kc_gut");
	SendToConsole( "bind ins ch_huntsman");
}

function ch_huntsman()
{
	ScriptPrintMessageChatAll ("Huntsman chosen. Press DEL to equip it");
	SendToConsole( "bind del kc_huntsman");
	SendToConsole( "bind ins ch_karambit");
}

function ch_karambit()
{
	ScriptPrintMessageChatAll ("Karambit chosen. Press DEL to equip it");
	SendToConsole( "bind del kc_karambit");
	SendToConsole( "bind ins ch_daggers");
}

function ch_daggers()
{
	ScriptPrintMessageChatAll ("Daggers chosen. Press DEL to equip it");
	SendToConsole( "bind del kc_daggers");
	SendToConsole( "bind ins ch_bowie");
}

function ch_bowie()
{
	ScriptPrintMessageChatAll ("Bowies chosen. Press DEL to equip it");
	SendToConsole( "bind del kc_bowie");
	SendToConsole( "bind ins ch_m9");
}
	


function knifeDebug()
{
	printl( @"v_butterfly	= " + v_butterfly);
	printl( @"v_falchion	= " + v_falchion);
	printl( @"v_flip	= " + v_flip);
	printl( @"v_gut	= " + v_gut);
	printl( @"v_huntsman	= " + v_huntsman);
	printl( @"v_karambit	= " + v_karambit);
	printl( @"v_m9	= " + v_m9);
	printl( @"v_bayonet	= " + v_bayonet);
	printl( @"v_daggers	= " + v_daggers);
	printl( @"v_bowie	= " + v_bowie);
}

function m9()
{
	v_butterfly	= false;
	v_falchion = false;
	v_flip = false;
	v_gut = false;
	v_huntsman = false;
	v_karambit = false;
	v_bayonet = false;
	v_daggers = false;
	v_bowie = false;

	v_m9 = true;

	EntFire("knifeTimer", "enable");
	ScriptPrintMessageChatAll( @"[KC] M9 Bayonet equiped.");
	printl( @"[KC] M9 Bayonet equiped.");
}

function flip()
{
	v_butterfly	= false;
	v_falchion = false;
	v_gut = false;
	v_huntsman = false;
	v_karambit = false;
	v_m9 = false;
	v_bayonet = false;
	v_daggers = false;
	v_bowie = false;

	v_flip = true;

	EntFire("knifeTimer", "enable");
	ScriptPrintMessageChatAll( @"[KC] Flip Knife equiped.");
	printl( @"[KC] Flip Knife equiped.");
}

function bayonet()
{
	v_butterfly	= false;
	v_falchion = false;
	v_flip = false;
	v_gut = false;
	v_huntsman = false;
	v_karambit = false;
	v_m9 = false;
	v_daggers = false;
	v_bowie = false;

	v_bayonet = true;

	EntFire("knifeTimer", "enable");
	ScriptPrintMessageChatAll( @"[KC] Bayonet equiped.");
	printl( @"[KC] Bayonet equiped.");
}

function butterfly()
{
	v_falchion = false;
	v_flip = false;
	v_gut = false;
	v_huntsman = false;
	v_karambit = false;
	v_m9 = false;
	v_bayonet = false;
	v_daggers = false;
	v_bowie = false;

	v_butterfly = true;

	EntFire("knifeTimer", "enable");
	ScriptPrintMessageChatAll( @"[KC] Butterfly Knife equiped. (Buggy!)");
	printl( @"[KC] Butterfly Knife equiped. (Buggy!)");
}

function falchion()
{
	v_butterfly	= false;
	v_flip = false;
	v_gut = false;
	v_huntsman = false;
	v_karambit = false;
	v_m9 = false;
	v_bayonet = false;
	v_daggers = false;
	v_bowie = false;

	v_falchion = true;

	EntFire("knifeTimer", "enable");
	ScriptPrintMessageChatAll( @"[KC] Falchion Knife equiped.");
	printl( @"[KC] Falchion Knife equiped.");
}

function gut()
{
	v_butterfly	= false;
	v_falchion = false;
	v_flip = false;
	v_huntsman = false;
	v_karambit = false;
	v_m9 = false;
	v_bayonet = false;
	v_daggers = false;
	v_bowie = false;

	v_gut = true;

	EntFire("knifeTimer", "enable");
	ScriptPrintMessageChatAll( @"[KC] Gut Knife equiped.");
	printl( @"[KC] Gut Knife equiped.");
}

function huntsman()
{
	v_butterfly	= false;
	v_falchion = false;
	v_flip = false;
	v_gut = false;
	v_karambit = false;
	v_m9 = false;
	v_bayonet = false;
	v_daggers = false;
	v_bowie = false;

	v_huntsman = true;

	EntFire("knifeTimer", "enable");
	ScriptPrintMessageChatAll( @"[KC] Huntsman Knife equiped.");
	printl( @"[KC] Huntsman Knife equiped.");
}

function karambit()
{
	v_butterfly	= false;
	v_falchion = false;
	v_flip = false;
	v_gut = false;
	v_huntsman = false;
	v_m9 = false;
	v_bayonet = false;
	v_daggers = false;
	v_bowie = false;

	v_karambit = true;

	EntFire("knifeTimer", "enable");
	ScriptPrintMessageChatAll( @"[KC] Karambit equiped.");
	printl( @"[KC] Karambit equiped.");
}

function daggers()
{
	v_butterfly	= false;
	v_falchion = false;
	v_flip = false;
	v_gut = false;
	v_huntsman = false;
	v_m9 = false;
	v_bayonet = false;
	v_karambit = false;
	v_bowie = false;

	v_daggers = true;

	EntFire("knifeTimer", "enable");
	ScriptPrintMessageChatAll( @"[KC] Shadow Daggers equiped.");
	printl( @"[KC] Shadow Daggers equiped.");
}

function bowie()
{
	v_butterfly	= false;
	v_falchion = false;
	v_flip = false;
	v_gut = false;
	v_huntsman = false;
	v_m9 = false;
	v_bayonet = false;
	v_daggers = false;
	v_karambit = false;

	v_bowie = true;

	EntFire("knifeTimer", "enable");
	ScriptPrintMessageChatAll( @"[KC] Bowie Knife equiped.");
	printl( @"[KC] Bowie Knife equiped.");
}

function knifeReset()
{
	v_butterfly	= false;
	v_falchion = false;
	v_flip = false;
	v_gut = false;
	v_huntsman = false;
	v_m9 = false;
	v_bayonet = false;
	v_daggers = false;
	v_karambit = false;
	v_bowie = false;

	EntFire("knifeTimer", "disable");
	ScriptPrintMessageChatAll( @"[KC] Standart Knife equiped.");
	printl( @"[KC] Standart Knife equiped.");
}

function knifeSet()
{
		if(v_bayonet)
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
		else if (v_m9)
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
		else if (v_karambit)
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
		else if (v_huntsman)
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
		else if (v_gut)
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
		else if (v_flip)
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
		else if (v_falchion)
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
		else if (v_butterfly)
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
		else if (v_daggers)
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
		else if (v_bowie)
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
}

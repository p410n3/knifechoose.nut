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

printl( @"knifechoose script executed");
printl( @"type to start: script knifeSetup()");
printl( @"type to view about screen: script knifeAbout()");

function knifeSetup()
{
	printl( @"[KC] knifechoose.nut");
	printl( @"[KC] Firstperson Knife Model Changer v2.2");
	printl( @"[KC] by Gray, site: https://github.com/serkas001/knifechoose.nut");
	printl( @"[KC] Type the knife's name in your console:");
	printl( @"[KC] 	 kc_<m9, flip, bayonet, butterfly, falchion, gut, huntsman, karambit, daggers, bowie>");
	printl( @"[KC] Example: kc_daggers");
	
	printl( @"[KC] starting setup...");

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
	
	printl( @"[KC] script loaded successfully.");
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

function knifeAbout()
{
	printl( @"[KC] Firstperson Knife Model Changer v2.2");
	printl( @"[KC] by Gray");
	printl( @"-----------------------------------------");
	printl( @"[KC] Don't forget to check for updates! Maybe there's a big bug fixed or a useful feature added!");
	printl( @"[KC] Site: https://github.com/serkas001/knifechoose.nut");
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

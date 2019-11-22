local equip = Entities.CreateByClassname("game_player_equip");
EntFireByHandle(equip, "addoutput", "weapon_knife_css 1", 0, null, null);
EntFire("weapon_knife*", "kill");
EntFireByHandle(equip, "TriggerForAllPlayers", "", 0, null, null);
EntFire("weapon_knife", "addoutput", "classname weapon_knifegg");

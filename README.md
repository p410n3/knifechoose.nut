kc.nut
---------------

VScript to use almost all knife models on a local server.
Thanks to Phillip L.(p410n3) for forking the project and adding some awesome functions to the script. I really hope we will work together to improve it even more.

Installation and Usage
---------------

The kc.nut needs to be placed in "<your csgo directory>/csgo/scripts/vscripts"

To run it in-game: start a local server (for example 'Offline with Bots') and write "script_execute kc"
in your console. Then you can:

* Press INS (or Insert) on your keyboard to scroll through every possible knife
* Press HOME (or Home) at every roundstart to actually load the script again. (It resets every round)

You don't know which Keys I am talking about? I mean these, above your arrowkeys:

![Keys](http://i.imgur.com/80HBEjD.png)

ToDo List:
* Add a little menu(though I have no idea how to implement it yet)

Some things Phillip added:

* Removed sv_cheats 1 as it's not needed anymore
* Removed some not really necessary functions
* Added a system that allows the Script to be controlled with keys instead of console
* Auto setup of the script for the first round

Links:

[Gamebanana](http://gamebanana.com/gamefiles/4107)

Youtube Preview Video(a little bit outdated, but still shows what the script does)

 <a href="http://www.youtube.com/watch?feature=player_embedded&v=iy13ZF4DDP4" target="_blank"><img src="http://img.youtube.com/vi/iy13ZF4DDP4/0.jpg" alt="Example of using Knife Chooser Script 2.0 " width="240" height="180" border="10" /></a>


How the script works and why you have to press a key on every roundstart to reload it:

Valve disallowed direct access to the weapon_knife entities, so we can't just change the weapon to the desired knife. What the script does is it uses Entities.SetModel() vscript function to change your knife model to another one. But because the function is one-off, we would need to run it every time we change our weapon to a knife. To make the change automatic and almost instant the script creates on the map an invisible logic_timer entity, which searches for a standard knife model every 0.5 seconds and if finds, it changes it to the knife of your choice. But 'cause the logic_timer entity is located DIRECTLY on the map, every round start it disappears(just like weapons, nades etc). What happens when you press 'HOME' is you create a new logic_timer entity, and everything is working just again.

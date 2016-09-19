kc.nut
---------------

VScript to use all Knife models on a local server. 

Original Script from https://github.com/serkas001/knifechoose.nut


Installation and Usage
---------------

The kc.nut needs to be placed in `[your CSGO directory]/csgo/scripts/vscripts`
    
To run it ingame start a local server (for example 'Offline with Bots') and write `script_execute kc`

in your console. Then you need to write

    script knifeSetup()

(it will also tell you that in the console). Then you can choose your knife with writing 

    kc_[knifename]

in your console. For example:

    kc_karambit

When a new round starts the Knifes get resetted so you need to write  
    
    script knifeSetup()
    
and the knifename again. I suggest binding that to a key. (I will make bind feature and an ingame menu in the future). To do so write:
    
     bind "[key]" "script knifeSetup(); kc_[knifename]"
    
This Fork
-----------------

In this fork I plan to add some features like an little menu, and an AutoBind feature that makes it more convenient to give you the knife at every round start. It's most likely wont change core features or fix major bugs unless they are easy to implement but rather adds some Workarounds, remove clutter and add convenience.

Things I already did:

* Removed sv_cheats 1 as its not needed anymore
    
    

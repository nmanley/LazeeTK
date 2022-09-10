/**
  *
  * 
  *  .__                                          __   __    
  *  |  | _____  ________ ____   ____           _/  |_|  | __
  *  |  | \__  \ \___   // __ \_/ __ \   ______ \   __\  |/ /
  *  |  |__/ __ \_/    /\  ___/\  ___/  /_____/  |  | |    < 
  *  |____(____  /_____ \\___  >\___  >          |__| |__|_ \
  *            \/      \/    \/     \/                     \/
  *
  * Spells Configuration
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: config/memory_map.ahk
  * Description: Easy to use scripting SDK for memory based and macro'd scripting
  * Version: 1.0.0
  *
  *
  */

class LZSpells
{
    spells      := {}
    allignments := {}
    paths       := {}
    types       := {}

    __New()
    {
        ; Name, Type, Target, ManaCost, Aethers, Duration

        ; Multi Path Spells
        spells.sooth := new Spell("Soothe", "heal", "self", 3, 0, 0, [])
        spells.gateway := new Spell("Gateway", "transport", "self", 0, 0, 0)
        
        ; Poet
        spells.invoke := new Spell()

    }

    addSpell(name, alignmentNames := {}, )
}
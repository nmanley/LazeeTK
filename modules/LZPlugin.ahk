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
  * LZ Plugin
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: modules/LZPlugin.ahk
  * Version: 1.0.0
  * Description: LazeeTK Plugin Manager
  *
  *
  */

class LZPlugin
{
    registered := []
    registered_hooks := []

    register(name, mainLoop)
    {
        this.registered.Push(["name" => mainLoop])
    }
}
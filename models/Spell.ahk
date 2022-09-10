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
  * Spell Model
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: models/Spell.ahk
  * Version: 1.0.0
  * Description: Spell Instance Class
  *
  *
  */

class Spell
{

    position := 0
    letter := ""
    type := 0
    name := ""
    prompt := ""

    targetable := false
    selfCasted := false
    utility := false
    

    __New(letter, ByRef buf) {

        this.letter := letter
        this.readSpellProperties(buf)
    }

    /**
      * Read From Buffer
      * Reads a value from the referenced buffer, using the address's offset, encoding and size
      *
      * TODO: Clean up code
      * STATUS: Partially Functional
      *
      * @param [Buf] buf
      * @return bool
      */
    readSpellProperties(Byref buf) {
        
        tkm := tkmemory.spells
        this.type := tkm.type.readFromBuffer(buf)
        this.name := tkm.name.readStringFromBuffer(buf)
        this.prompt := tkm.prompt.readStringFromBuffer(buf)

        if (this.type = 0)
        {
            return false ; Spell slot isn't active
        }
        else if (this.type = 1)
        {
            this.utility := true
        }
        else if (this.type = 2)
        {
            this.targetable := true
        }
        else if (this.type = 5)
        {
            this.selfCasted := true
        }

        return
    }
}
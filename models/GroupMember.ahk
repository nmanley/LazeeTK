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
  * Group Member
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: models/GroupMember.ahk
  * Version: 1.0.0
  * Description: Group Member Data Model 
  *
  *
  */

class GroupMember
{
    client := -1

    uid := 0
    name := 0

    manaCurrent := 0
    manaMax := 0
    vitaCurrent := 0
    vitaMax := 0

    xpos := 0
    ypos := 0
    
    __New(ByRef client, uid, name, manaCurrent, manaMax, vitaCurrent, vitaMax, xpos := 0, ypos := 0)
    {
        this.client := client

        this.uid := uid
        this.name := name
        this.manaCurrent := manaCurrent
        this.manaMax := manaMax
        this.vitaCurrent := vitaCurrent
        this.vitaMax := vitaMax

        this.xpos := xpos
        this.ypos := ypos
    }

    castSpell(spell)
    {
        if (spell.__Class != "Spell")
            logger.ERROR("Spell cast must be of spell class type.")       
    }
}
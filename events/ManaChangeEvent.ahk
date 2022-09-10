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
  * Mana Change Event
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: events/ManaChangeEvent.ahk
  * Version: 1.0.0
  * Description: Move event class
  *
  *
  */

class ManaChangeEvent extends BaseEvent
{    
    manaDiff := 0
    manaMaxDiff := 0
    
    manaCurrent := 0
    manaMax := 0

    manaPast := 0
    manaPastMax := 0

    __New(ByRef client, payload)
    {
 
        this.name := "mana-change"
        this.payload := payload
        this.client := client

        this.manaCurrent := payload.current
        this.manaMax := payload.currentMax
        this.manaPast := payload.past
        this.manaPastMax := payload.pastMax

        this.computeChange()
    }

    computeChange()
    {
        this.manaDiff := this.manaCurrent - this.manaPast
        this.manaMaxDiff := this.manaMax - this.manaPastMax
    }

    assertDecreasedBy(diff)
    {
        return (diff > this.manaDiff) ? true : false
    }

    assertDecreasedMaxBy(diff)
    {
        return (diff > this.manaMaxDiff) ? true : false
    }

    assertBelowPercentage(percent)
    {
        return ((this.manaCurrent / this.manaMax) * 100 < percent) ? true : false
    }
}
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
  * Vita Change Event
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: events/VitaChangeEvent.ahk
  * Version: 1.0.0
  * Description: Vita change event class
  *
  *
  */

class VitaChangeEvent extends BaseEvent
{  
    vitaDiff := 0
    vitaMaxDiff := 0
    
    vitaCurrent := 0
    vitaMax := 0

    vitaPast := 0
    vitaPastMax := 0

    __New(ByRef client, payload)
    {
 
        this.name := "vita-change"
        this.payload := payload
        this.client := client

        this.vitaCurrent := payload.current
        this.vitaMax := payload.currentMax
        this.vitaPast := payload.past
        this.vitaPastMax := payload.pastMax

        this.computeChange()
    }

    computeChange()
    {
        this.vitaDiff := this.vitaCurrent - this.vitaPast
        this.vitaMaxDiff := this.vitaMax - this.vitaPastMax
    }

    assertDecreasedBy(diff)
    {
        return (diff > this.vitaDiff) ? true : false
    }

    assertDecreasedMaxBy(diff)
    {
        return (diff > this.vitaMaxDiff) ? true : false
    }

    assertBelowPercentage(percent)
    {
        return ((this.vitaCurrent / this.vitaMax) * 100 < percent) ? true : false
    }

    loggerOutput()
    {
        return Format("Vita Change Event: Diff {:s}, Current: {:s}", this.vitaDiff, this.vitaCurrent)
    }
}
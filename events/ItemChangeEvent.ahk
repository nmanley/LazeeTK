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
  * Item Change Event
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: events/ItemChangeEvent.ahk
  * Version: 1.0.0
  * Description: Item Change event class
  *
  *
  */

class ItemChangeEvent extends BaseEvent
{
    item := -1
    event := ""
    eventGrammar := ""

    __New(ByRef client, payload)
   {
        this.name := "item-change"
        this.client := client

        this.event := payload.event
        this.item := payload.item

        if (this.event = "new")
          this.eventGrammar := "found"
        else if (this.event = "drop")
          this.eventGrammar := "dropped"
        else if (this.event = "use")
          this.eventGrammar := "used"
        else  
          this.eventGrammer := "unknown"
    }

    loggerOutput()
    {
      return Format("Item {:s} was {:s} in slot {:s} Qty: {:i}", this.item.itemName, this.eventGrammar, this.item.letter, this.item.qty)
    }
}
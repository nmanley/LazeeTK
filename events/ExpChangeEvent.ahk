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
  * EXP Change Event
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: events/ExpChangeEvent.ahk
  * Version: 1.0.0
  * Description: Exp Change event class
  *
  *
  */

class ExpChangeEvent extends BaseEvent
{
    amount := 0
    oldAmount := 0

    diff := 0

    __New(ByRef client, payload)
   {
        this.name := "exp-change"
        this.client := client

        this.amount := payload.amount
        this.oldAmount := payload.oldAmount

        this.diff := this.amount - this.oldAmount
    }

    loggerOutput()
    {
      return Format("EXP {:s} by: {:s} from: {:s} -> {:s}", (this.diff > 0) ? "increased" : "decreased", this.diff, this.oldAmount, this.amount)
    }
}
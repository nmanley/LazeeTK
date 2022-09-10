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
  * Subscription
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: models/Subscription.ahk
  * Version: 1.0.0
  * Description: Subscription instance class
  *
  *
  */

class Subscription
{
    uuid := 0
    name := ""

    callback := ""
    callbackAddr := 0x00
    paramCount := 0
    functionParams := []
    
    maxPeriods := 0
    calledNTimes := 0
    
    __New(name, callback, paramCount, maxPeriods := 0)
    {         
        this.name := name
        this.callback := callback
        this.maxPeriods := maxPeriods
    }

    __Callback(event)
    {
        if (this.maxPeriods = -1  OR (this.maxPeriods > this.calledNTimes)) {

            this.calledNTimes += 1
            this.callback.Call(event)

            return true
        }
        else {
            return false
        }
    }

    __Delete()
    {
        ObjRelease(this.cbInfo)
        DllCall("GlobalFree", "Ptr", this.callbackAddr, "Ptr")
    }

}
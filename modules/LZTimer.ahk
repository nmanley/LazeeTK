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
  * LZTK Timer Module
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: modules/LZTimer.ahk
  * Version: 1.0.0
  * Description: Timer instance class.
  *
  *
  */

class LZTimer 
{

    name := ""
    period := 0
    boundClassMethod := -1
    priority := 0
    iterations := -1 ; Run indefinitely
    iterCount := 0
    
    __New(name, callback, period, priority, interations := -1)
    {
        /*
        if (!IsFunc(boundClassMethod)) {
            logger.ERROR(Format("LZTimer was passed a non function callback for {:s}", name))
            return false
        } 
        */           

        this.name := name
        this.callback := callback
        this.priority := priority
        this.period := period

        SetTimer %this%, %period%
    }
    
    __Call() 
    {
        ;StdOut(Format("Timer Called {:s}, {:i} times.", this.name, this.iterCount))
        ;logger.DEBUG(Format("Calling Class Method On Timer: {:s} -- {:s}", this.name, this.boundClassMethod))
        this.callback()

        this.iterCount += 1
        if this.iterations != -1 {
            if (this.iterCount >= this.iterations) {
                SetTimer, %this%, Delete
                ;StdOut(Format("[{:s}] Timer Deleted", this.name))
            }
        }
    }

    __Delete() 
    {
        SetTimer, %this%, Delete
    }
}
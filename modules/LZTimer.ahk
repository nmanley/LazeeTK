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

class LZTimer {
    name := ""
    period := 0
    classRef := 0
    method := 0
    args := 0
    priority := 0
    iterations := -1 ; Run indefinitely
    iterCount := 0
    
    __New(name, ByRef classRef, method, period, priority := 1, iterations := -1, args*) {
        this.name := name
        this.priority := priority
        this.period := period
        this.classRef := IsObject(classRef) ? classRef : StdErr("Non object type passed to LZTimer") ; Call type
        this.method := method
        this.args := args
        SetTimer %this%, %period%
        ;StdOut(Format("New Timer Created {:s} running every {:i} ms", this.name, this.period))
    }

    __Call() {
        ;StdOut(Format("Timer Called {:s}, {:i} times.", this.name, this.iterCount))
        callable := this.method.(this.classRef)
        this.iterCount += 1
        if this.iterations != -1 {
            if (this.iterCount >= this.iterations) {
                SetTimer, %this%, Delete
                ;StdOut(Format("[{:s}] Timer Deleted", this.name))
            }
        }
    }

    Delete() {
        SetTimer, %this%, Delete
    }
}
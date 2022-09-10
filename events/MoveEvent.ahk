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
  * Move Event
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: events/MoveEvent.ahk
  * Version: 1.0.0
  * Description: Move event class
  *
  *
  */

class MoveEvent extends BaseEvent
{
    name := "move"

    __New(ByRef source, from, to)
    {
        this.source := source
        this.originalValues := from
        this.newValues := to
    }
}
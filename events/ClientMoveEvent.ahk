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

class ClientMoveEvent extends BaseEvent
{
    currentPos := -1
    previousPos := -1

    ; Useful for determining jumps, warps, summons.
    distance := 0

    mapName := ""
    oldMapName := ""

    __New(ByRef client, payload)
    {
        this.name := "client-move"
        this.client := client
        
        this.currentPos := payload.currentPos
        this.previousPos := payload.previousPos

        this.mapName := payload.mapName
        this.oldMapName := payload.oldMapName

        this.distance := this.currentPos.distanceFrom(this.previousPos.xpos, this.previousPos.ypos)
    }

    loggerOutput()
    {
      return Format("Client {:s} moved from: [{:i},{:i}] -> [{:i},{:i}] Distance: {:i}", this.client.name, this.previousPos.xpos, this.previousPos.ypos, this.currentPos.xpos, this.currentPos.ypos, this.distance)
    }
}
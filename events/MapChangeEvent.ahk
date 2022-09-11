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
  * Map Change Event
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: events/MapChangeEvent.ahk
  * Version: 1.0.0
  * Description: Map Change event class
  *
  *
  */

class MapChangeEvent extends BaseEvent
{
    mapName := ""
    oldMapName := ""

    __New(ByRef client, payload)
   {
        this.name := "map-change"
        this.client := client

        this.mapName := payload.mapName
        this.oldMapName := payload.oldMapName

        this.distance := this.currentPos.distanceFrom(this.previousPos.xpos, this.previousPos.ypos)
    }

    loggerOutput()
    {
      return Format("Map changed from: {:s} -> {:s}", this.oldMapName, this.mapName)
    }
}
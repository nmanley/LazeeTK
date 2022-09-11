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
  * LZEvent
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: events/LZEvent.ahk
  * Version: 1.0.0
  * Description: Event Base Class
  *
  *
  */

class BaseEvent
{
    uuid := ""   
    name := ""
    data := ""
    client := -1
    
    ; Reference to the source of where the event was emitted from
    emittedFrom := 0

    originalValues  := {}
    newValues       := {}

    ; Do we allow callbacks to take place on this Event?            
    permitCallbacks := true

    dataset := {}
    
    flattenDataValues(dataset)
    {
        response := ""

        if (IsObject(dataset) || (dataset[1] is integer)) {

            for key, value in dataset {
                if (IsObject(value) || (dataset[1] is integer)) {
                    ; Recursive calling
                    response .= Format(" [{:s} => {s:}] ", key, this.flattenDataValues(value))
                }
                else {
                    response .= Format("{:s} = {:s}", key, value)
                }
            }
        }

        return response
    }
}
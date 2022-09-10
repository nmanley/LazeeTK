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
  * Event Model
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: models/Event.ahk
  * Version: 1.0.0
  * Description: Event 
  *
  *
  */

class LZEvent {

    name := "event"
    obj := 0
    callbackFn := 0
    data := 0

    __New(name, data) {

        this.name := name
        this.data := data
    }

    eventDescriptionAsString()
    {
      string := ""
      for param, value in this.data {
        string .= Format(" {:s} = {:s} ", param, value)
      }

      return string
    }
}

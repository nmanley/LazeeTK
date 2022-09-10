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
  * LZTK Pathing Module
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: modules/LZPathing.ahk
  * Version: 1.0.0
  * Description: NTK Pathing A* 
  *
  *
  */

class LZPathing {

    boundries := []
    
    mapName := ""
    loadedMapFile := ""
    mapFileBuf := 0

    curXPos := 0
    curYPos := 0
    desXPos := 0
    desYPos := 0
}
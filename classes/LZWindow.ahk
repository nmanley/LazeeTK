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
  * Window Management
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: classes/Window.ahk
  * Version: 1.0.0
  * Description: Window Management Class
  *
  *
  */

class LZWindow {

    hWnd := 0
    pid := 0
    title := 0
    xpos := 0
    ypos := 0
    
    launch(name := 0, xpos := 0, ypos := 0, minimized := false) {

      if FileExist(%NexusTKEXE%)
        this.pid := Run %NexusTKEXE%
      
      pidStr := "ahk_id " . pid
      WinGet, hWnd, ID, % pidStr
      
      ; Is the window even active?
      if (this.hWnd == 0) {
        throw new LZException("New window launch failed.", -1)
      }
    }

    setName(name := "Nexus") {


      WinSetTitle, "ahk_pid" this.pid,, name
    }

}
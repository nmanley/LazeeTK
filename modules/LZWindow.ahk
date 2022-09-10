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
  * LZTK Window Module
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: modules/LZWindow.ahk
  * Version: 1.0.0
  * Description: NTK Client window management class
  *
  *
  */

class LZWindow 
{

    Hwnd := 0
    pid := 0
    title := "Nexus"

    /**
      * Attach
      * Finds a NexusTK Window that matches the username and returns it's Process ID
      *
      * TODO: Error Handling, duplicate function in Models/Client
      * STATUS: Functional
      *
      * @param [string] username
      * @return int
      */
    attach(username) {
      for i, pid in FindNTKPIDS("NexusTK.exe")
      {
          ; Attach process memory
          _mHandle := new _ClassMemory("ahk_pid" pid, hProcessCopy)
          _result := tkmemory.client.name.readString(_mHandle)
          _mHandle.close()
          
          ; Found the window
          if (_result == username) {
            this.pid := pid
            break
          }
      }

      return this.pid
    }

    testSend()
    {
      testString := GetKeyVK("h")

      pid := this.pid
      ControlSend,, u, % "ahk_pid " pid
      SendMessage, 0xC,, testString,, % "ahk_pid " pid
    }
    
    /**
      * Launch
      * Launches a new NexusTK.exe process
      *
      * TODO: Nothing?
      * STATUS: Functional
      *
      * @param [string] title
      * @return int
      */
    launch(title := "Nexus") {
      if FileExist(%NTKExe%) {
        this.pid := Run, %NTKExe%
      }
      else {
        StdErr("Unable to load NTK Window. File does not exist.")
      }
        
      this.pid := pid
      this.setTitle(title)
      return pid
    }

    /**
      * Set Title
      * Sets the window title for the class
      *
      * TODO: Finish Coding
      * STATUS: Partially Functional
      *
      * @param [string] title
      * @return null
      */
    setTitle(title) {
      if(!this.pid)
        return StdErr("Cannot set title on unattached window.")
      
      pid := this.pid
      WinSetTitle, %title%, ahk_pid %pid%
    }

    /**
      * Set Opacity
      * Sets the window opacity
      *
      * TODO: Finish Coding
      * STATUS: Partially Functional
      *
      * @param [int] opacity
      * @return null
      */
    setOpacity(opacity := 255) {
      if(opacity < 0 or opacity > 255)
        return StdErr("Opacity must be between 0 and 255.")
      
      return this.set("Transparent", opacity)
    }

    /**
      * Set Position
      * Sets the window position
      *
      * TODO: Finish Coding
      * STATUS: Partially Functional
      *
      * @param [int] x
      * @param [int] y
      * @return null
      */
    setPosition(x := 0, y := 0) {
      if(!this.pid)
        return StdErr("Cannot set position on unattached window.")
      
      pid := this.pid
      WinMove, %x%, %y%, ahk_pid %pid%
    }

    /**
      * Set
      * Sets specified AHK window property
      *
      * TODO: Finish Coding, add option constraints
      * STATUS: Partially Functional
      *
      * @param [string] subCommand
      * @param [mixed] value
      * @return null
      */
    set(subCommand, value) {
      if (!this.pid)
        return StdErr(Format("Cannot set {:s} on unattached window.", subCommand))
      
      pid := this.pid
      WinSet, %subCommand%, %value%, ahk_pid %pid%
    }

    /**
      * Send Keys
      * Sends keystrokes to the window
      *
      * TODO: Finish Coding
      * STATUS: Partially Functional
      *
      * @param [string] keys 
      * @return null
      */
    sendkeys(keys) {
      if(!this.pid)
        return StdErr("Cannot send keystrokes to unattached window.")

      pid := this.pid
      ControlSend,, %keys%, ahk_pid %pid%
    }
}
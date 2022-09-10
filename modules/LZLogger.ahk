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
  * LZTK Loggin Module
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: modules/LZLogger.ahk
  * Version: 1.0.0
  * Description: Logging utility for LazeeTK
  *
  *
  */

class LZLogger
{

    stack := []
    client := 0

    level := 4

    writeToFile := false
    fileHandle := 0

    writeToConsole := true
    consoleHandle := 0

    prependTimestamp := true

    logNameFormat := ""
    logFolder := ""
    

    __New(ByRef client) 
    {
     
        this.client := client
        this.level := LOG_LEVEL
        this.writeToFile := LOG_WRITE_TO_FILE
        this.writeToConsole := LOG_WRITE_TO_CONSOLE
        this.logNameFormat := LOG_NAME_FORMAT
        this.logFolder := (LOG_FOLDER != "") ? LOG_FOLDER : A_ScriptDir + "\logs"

        if (this.writeToConsole)
            this.allocConsole()       
    }

    /**
      * AllocConsole
      * Allocates the console attached to the parent process
      *
      * TODO: Add checking for Scite to use FileAppend for output
      * STATUS: Testing
      *
      * @param none
      * @return bool
      */
    allocConsole() 
    {   
        return
    }

    /**
      * Enable Console
      * Enables and allocates the console
      *
      * TODO: Make it better? Add error reporting probably
      * STATUS: Testing
      *
      * @param none
      * @return bool
      */    
    enableConsole()
    {
        this.writeToConsole := true
        
        return (this.allocConsole()) ? true : false
    }

    /**
      * Disable Console
      * Disables the destroys the console
      *
      * TODO: Make it better? Add error reporting probably
      * STATUS: Testing
      *
      * @param none
      * @return bool
      */
    disableConsole()
    {
        this.writeToConsole := false
        return (this.destroyConsole()) ? true : false
    }
 
    getLogFileName() 
    {   
        fmt := this.logNameFormat
        return FormatTime,,, %fmt%
    }

    getLogLevelName()
    {
        if (this.level = 0)
            return "OFF"
        else if (this.level = 1)
            return "ERROR"
        else if (this.level = 2)
            return "INFO"
        else if (this.level = 3)
            return "DEBUG"
        else if (this.level = 4)
            return "XDEBUG"
    }

    /**
      * Write
      * Writes to the defined messaging mediums
      *
      * TODO: Make it better? Add error reporting probably
      * STATUS: Testing
      *
      * @param [string] message
      * @return null
      */
    write(message) 
    {   
        FormatTime, timestamp,, yyyy-MM-dd
        if (this.prependTimestamp)
            message := Format("[{:s}]: {:s}", timestamp, message)

        Stdout(message)

        ; Write output to file if enabled
        if (this.writeToFile)
            FileAppend, message, this.logFileName()
        
        return true
    }

    /**
      * AllocConsole
      * Allocates the console attached to the parent process
      *
      * TODO: Make it better? Add error reporting probably
      * STATUS: Testing
      *
      * @param none
      * @return bool
      */
    ERROR(message) 
    {
        if(this.level >= 1)
            return this.write(Format("[ERROR] {:s}", message))
    }

    DEBUG(message)
    {
        if(this.level >= 3)
            return this.write(Format("[DEBUG] {:s}", message))
    }

    XDEBUG(message)
    {
        if(this.level >= 4)
            return this.write(Format("[XDEBUG] {:s}", message))
    }

    LOG(message)
    {
        if(this.level >= 0)
            return this.write(Format("[LOG] {:s}", message))
    }

    INFO(message)
    {
        if(this.level >= 1)
        return this.write(Format("[INFO] {:s}", message))
    }

    destroyConsole()
    {   
        return DllCall("FreeConsole", int)
        this.consoleHandle := 0
    }    

}

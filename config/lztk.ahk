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
  * NexusTK Scripting SDK
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: config/lztk.ahk
  * Version: 1.0.0
  * Description: Environment configuration
  *
  *
  */


/**
  * NTK Exe
  * Full path to NexusTK.exe
  *
  */
Global NTKexe := "C:\Program Files (x86)\KRU\NexusTK\NexusTK.exe"

/**
  * Log Level
  * Set the log level output to the console
  * 
  * 0 = Off
  * 1 = Errors
  * 2 = Info
  * 3 = Debug
  * 4 = Xtreme Debug
  */
Global LOG_LEVEL := 4

Global LOG_WRITE_TO_FILE := false
Global LOG_WRITE_TO_CONSOLE := true
Global LOG_NAME_FORMAT := "yyyy-MM-dd.txt"
Global LOG_FOLDER := A_ScriptDir + "\logs"
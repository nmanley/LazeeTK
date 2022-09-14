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
  * Version: 1.0.0
  * Description: Easy to use scripting SDK for memory based and macro'd scripting
  *
  *
  */

#NoEnv
#InstallMouseHook
#SingleInstance force
RunAs, Administrator
SendMode, Event
SetBatchLines, -1
DetectHiddenWindows On
SetWorkingDir, %A_ScriptDir%
SetKeyDelay -1, -1
ListLines 1

OnExit("ExitCleanup")

#Include config/lztk.ahk
#Include config/lzmemory.ahk

#Include modules/LZLogger.ahk

#Include classes/LZCallable.ahk

#Include models/Subscription.ahk
#Include models/MemoryAddress.ahk
#Include models/Client.ahk
#Include models/Entity.ahk
#Include models/Spell.ahk
#Include models/Item.ahk
#Include models/Coordinate.ahk

#Include modules/LZWindow.ahk
#Include modules/LZTimer.ahk

#Include helpers/window_helper.ahk
#Include helpers/console_helper.ahk
#Include helpers/utilities_helper.ahk

#Include lib/ClassMemory.ahk
#Include lib/Console.ahk
#Include lib/EventStack.ahk

#Include events/BaseEvent.ahk
#Include events/ClientMoveEvent.ahk
#Include events/ManaChangeEvent.ahk
#Include events/VitaChangeEvent.ahk
#Include events/GoldChangeEvent.ahk
#Include events/ExpChangeEvent.ahk
#Include events/ItemChangeEvent.ahk

;#Include lib/EventStack.ahk

Global LZ := new LazeeTK()
Global logger := new LZLogger()
Global tkmemory := new LZMemory()

Global clients := []
Global usernames := ["cPlusPlus"]


for i, username in usernames {

    newClient := new LZClient()
    logger.DEBUG(Format("Attaching to: {:s}", username))
    if (newClient.attach(username)) {

      newClient.registerTimers()
      clients.Push(newClient)

      logger.DEBUG("Client successfully attached")
    }
    else {
      logger.ERROR(Format("There was an error attaching to: {:s}", username))
    }
}

EventDebugFunction(event) 
{
  logger.info(event.loggerOutput())
}

clients[1].subscribeTo("item-change", new Subscription("itemWatcher", Func("EventDebugFunction"), 1, -1))
clients[1].subscribeTo("gold-change", new Subscription("goldWatcher", Func("EventDebugFunction"), 1, -1))
clients[1].subscribeTo("exp-change", new Subscription("expWatcher", Func("EventDebugFunction"), 1, -1))
clients[1].subscribeTo("map-change", new Subscription("mapWatcher", Func("EventDebugFunction"), 1, -1))
clients[1].subscribeTo("client-move", new Subscription("move", Func("EventDebugFunction"), 1, -1))
clients[1].subscribeTo("mana-change", new Subscription("mana-change", Func("EventDebugFunction"), 1, -1))
clients[1].subscribeTo("vita-change", new Subscription("vita-change", Func("EventDebugFunction"), 1, -1))

Global swingEnabled := false

while true {  

  if (swingEnabled) { 

    ; Map name safe guard
    if (clients[1].mapName != "Bear Forest") {
      swingEnabled := false
    }

    clients[1].swing()

    ; Axe broke
    if (clients[1].assertLastStatusBoxEntry("You are unable to chop with bare hands and a full pack.") OR clients[1].assertLastStatusBoxEntry("Your Axe broke!")) {
      Random, randomWait, 0, 8
      if (randomWait = 3) {             
        clients[1].useAxe()
      }
    }

    if (clients[1].item("Ginko wood").qty = 30) {
      swingEnabled := false
      MsgBox You need to deposit your Ginkos
    }

      
  }
}

NumpadAdd::
  swingEnabled := (swingEnabled) ? false : true
  logger.INFO(Format("Swing Toggled to: {:s}", (swingEnabled) ? "On" : "Off"))
Return

ExitCleanup(reason, code)
{
  for i, client in clients
    client.detach()

  Stdout("Shutting down. Goodbye!")
  ExitApp
}




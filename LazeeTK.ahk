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
DetectHiddenWindows On
SetWorkingDir, %A_ScriptDir%
Global debugEnabled := true

SetKeyDelay -1, -1
ListLines Off

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
#Include models/Event.ahk

#Include modules/LZPathing.ahk
#Include modules/LZWindow.ahk
#Include modules/LZTimer.ahk

#Include helpers/window_helper.ahk
#Include helpers/console_helper.ahk
#Include helpers/utilities_helper.ahk

#Include lib/ClassMemory.ahk
#Include lib/Console.ahk
#Include lib/EventStack.ahk

#Include events/BaseEvent.ahk
#Include events/MoveEvent.ahk
#Include events/ManaChangeEvent.ahk
#Include events/VitaChangeEvent.ahk

;#Include lib/EventStack.ahk

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

TestFunction(event) {
  if (event.name = "mana-change")
    logger.INFO(Format("Mana Change Event: Diff {:s}, Current: {:s}", event.manaDiff, event.manaCurrent))
  else
    logger.INFO(Format("Vita Change Event: Diff {:s}, Current: {:s}", event.vitaDiff, event.vitaCurrent))
}

NumpadAdd::
MsgBox, Running Test
clients[1].window.testSend()
return


clients[1].subscribeTo("mana-change", new Subscription("mana-change", Func("TestFunction"), 1, -1))
clients[1].subscribeTo("vita-change", new Subscription("vita-change", Func("TestFunction"), 1, -1))


while true {

  for i, client in clients {
    event := client.eventStack.processStack()
      
    
  }

  Sleep 20
}

ExitCleanup(reason, code)
{
  client.detach()
  Stdout("Cleanup Successful!")
  ExitApp
}




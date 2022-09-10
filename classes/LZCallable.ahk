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
  * Callable Class
  * 
  * Author(s) Teadrinker <ahkforums>
  * Source: https://www.autohotkey.com/boards/viewtopic.php?t=88704#p390726
  * File: classes/LZCallable.ahk
  * Version: 1.0.0
  * Description: Register callbacks
  *
  *
  */
class LZCallable
{
   __New(BoundFuncObj, paramCount, options := "F") 
   {
      this.pInfo := Object( {BoundObj: BoundFuncObj, paramCount: paramCount} )
      this.addr := RegisterCallback(this.__Class . "._Callback", options, paramCount, this.pInfo)
   }
   
   __Delete() 
   {
      ObjRelease(this.pInfo)
      DllCall("GlobalFree", "Ptr", this.addr, "Ptr")
   }
   
   _Callback(Params*) 
   {
      Info := Object(A_EventInfo), Args := []
      Loop % Info.paramCount
         Args.Push( NumGet(Params + A_PtrSize*(A_Index - 2)) )
      Return Info.BoundObj.Call(Args*)
   }
}
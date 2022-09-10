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
  * Author(s) HelgeffegleH
  * Git Repo: https://github.com/HelgeffegleH/AHK-misc.
  * File: lib/QuickTimer.ahk
  * Description: Easy to use scripting SDK for memory based and macro'd scripting
  * Version: 1.0.0
  *
  *
  */

class QuickTimer {
	; User methods
	__new(callback, priority:=0){
		this.callback := callback
		this.priority := priority
		quickTimer.timers[this] := ""	; store the instance for xxxAll() methods
	}
	; Timer states:
	; 1 - running
	; 0 - stopped
	; -1 - deleted (or never started)
	state := -1
	start(){
		if this.state == 1
			return
		SetTimer(this.callback, 0, this.priority)
		this.state := 1	
		pte := quickTimer.enabled++
		if !pte
			quickTimer.toggleQT()
		return this
	}
	stop(){
		if this.state != 1
			return
		this.state := 0
		quickTimer.enabled--
		SetTimer(this.callback, "off")
	}
	delete(){
		if this.state == 1
			this.stop()
		this.state := -1
		SetTimer(this.callback, "delete")
		this.Destroy()
		this.base := "" ; will throw error on further use.
	}
	startAll(){
		this.loopTimers(quickTimer.start)
	}
	stopAll(){
		this.loopTimers(quickTimer.stop)
	}
	deleteAll(){
		this.loopTimers(quickTimer.delete)
	}
	; Interal methods
	static timers := []
	loopTimers(fn){
		global quickTimer
		for timer in quickTimer.timers
			fn.call(timer)
	}
	static enabled := 0
	toggleQT(){
		static tfn := quickTimer.quickFn.bind(quickTimer)
		SetTimer(tfn, -0)
	}
	static speed := -1 ; fastest. Set to -1 for fastest, 0 for fast or 1+ for 'quite' slow
	quickFn(){
		static dllsleep := Func("dllcall").Bind("Sleep", "uint")
		critical false
		while this.enabled {
			if (this.speed > -1) {
				dllsleep.call(this.speed)
				Sleep, -1
			}
		}		
	}
}
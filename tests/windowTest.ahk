#Include classes/LZWindow.ahk
SendMode, Event
SetWorkingDir, %A_ScriptDir%
SetKeyDelay -1, -1
SetBatchLines -1
ListLines Off
SetKeyDelay, 0

window := new LZWindow()
window.launch()
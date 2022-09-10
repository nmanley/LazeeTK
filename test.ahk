#Include events/BaseEvent.ahk
#Include events/ManaChangeEvent.ahk

mc := new ManaChangeEvent({}, {past: 0, current: 200000, pastMax: 0, currentMax: 200000})
diff := mc.manaDiff
MsgBox %diff%
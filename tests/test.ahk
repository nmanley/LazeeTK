#Include lib/ClassMemory.ahk
;;;;; OPTOMIZE SORCERY ;;;;;
#singleinstance force
#NoEnv
SetBatchLines -1
ListLines Off
;;;;; OTHER GOODIES ;;;;;
coordmode, mouse, client 
coordmode, pixel, screen 
coordmode, tooltip, screen
#InstallMouseHook
SetKeyDelay, 0
#Include helpers/utilities_helper.ahk


mem := new _ClassMemory("Nexus1","", hProcessCopy)


Global entities := []
Global offset := 0x00

mem := new _ClassMemory("ahk_exe NexusTK.exe")

Global buf
Global entities := []
Global offset := 0x04

getEntity(offset) 
{
    Global mem

    VarSetCapacity(buff, 0x20C)
    mem.readRaw(0x69B89C, buff, 0x20C, offset)
    return {uid: NumGet(buff, 0xFC, "uint"), xpos: NumGet(buff, 0x104, "uint"), ypos: NumGet(buff, 0x104, "uint"), drawHeight: NumGet(buff, 0x50, "uint"), name: StrGet(&buff + 0x12A,, "utf-16")}

}

loop, 9 {

    offset += 0x20C * (A_Index - 1)
    entity := getEntity(offset)

    uid := entity.uid
    xpos := entity.xpos
    ypos := entity.ypos
    dh := entity.drawHeight
    name := entity.name

    entities.Push(entity)
    MsgBox [uid] %uid% | [YPos] %YPos% | [XPos] %dh% [Name]: %name%
}
    
getSpell(offset)
{
    Global mem
    VarSetCapacity(buf, 0x148)
    mem.readRaw(0x0067a748, buf, 0x148, offset)
    return {type: NumGet(&buf, 0x04, "uchar"), name: StrGet(&buf + 0x08,, "utf-16"), prompt: StrGet(&buf + 0xA8,, "utf-16")}
}

offset := 0x13A834

loop, 5 {

    offset += 0x148 * (A_Index - 1)
    spell := getSpell(offset)

    name := spell.name
    prompt := spell.prompt
    
    if(spell.type == 1) 
    {
        type := "non-player"
    }
    else if(spell.type == 2)
    {
        type := "player-castable"
    }
    else if(spell.type == 5)
    {
        type := "self"
    }

    ;MsgBox [Name]: %name% [Prompt]: %prompt% [Type]: %type%
}
/*

*/


mem.Close()

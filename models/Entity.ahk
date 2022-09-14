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
  * Entity Model
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: models/Entity.ahk
  * Version: 1.0.0
  * Description: Inventory Management Class
  *
  *
  */

class Entity
{

    uid := 0
    type := 0
    drawWidth := 0
    drawHeight := 0
    xpos := 0
    ypos := 0
    imageId := 0
    name := 0
    faceDir := 0 ; 4 bytes [128=Up, 256=Right, 512=Down, 768=Left]
    vitaBarPtr := 0 ; 4 byte pointer
    manaVarPtr := 0 ; 4 byte pointer
    
    spells := {}

    /**
      * Constructor
      * Just what the name says...It constructs :D
      *
      * @param [Buf] buf
      * @return null
      */
    __New(ByRef buf, bufferOffset := 0) 
    {
      
      this.readEntityProperties(buf, bufferOffset)
    }

    /**
      * Read Entity Properties
      * Reads the entity properties from buffer
      *
      * TODO: N/A
      * STATUS: Functional
      *
      * @param [Buf] buf
      * @return null
      */
    readEntityProperties(ByRef buf, bufferOffset) 
    {

      tkm := tkmemory.entities

      this.uid := tkm.uid.readFromBuffer(buf, bufferOffset)
      this.drawWidth      := tkm.drawWidth.readFromBuffer(buf, bufferOffset)
      this.drawHeight     := tkm.drawHeight.readFromBuffer(buf, bufferOffset)
      this.xpos           := tkm.xpos.readFromBuffer(buf, bufferOffset)
      this.ypos           := tkm.ypos.readFromBuffer(buf, bufferOffset)
      this.imageId        := tkm.imageId.readFromBuffer(buf, bufferOffset)
      this.name           := tkm.name.readStringFromBuffer(buf, bufferOffset)
      this.faceDir        := tkm.faceDir.readFromBuffer(buf, bufferOffset)
      this.vitaBarPtr     := tkm.vitaBarPtr.readFromBuffer(buf, bufferOffset)
      this.manaBarPtr     := tkm.manaBarPtr.readFromBuffer(buf, bufferOffset)
      
      ;Stdout(Format("[Entity] {:i} [Coords] {:i},{:i} [Name] {:s}", this.uid, this.xpos, this.ypos, this.name))
    }

    /**
      * Compare
      * Compares the current with a provided instance

      * TODO: Finish coding
      * STATUS: Not functional

      * @param [Object] newValues
      * @return array
      */
    compare(newValues) 
    {

    }

    /**
      * Compare From PTR
      * Compares the current with a provided struct reference
      *
      * TODO: Finish coding
      * STATUS: Not functional
      *
      * @param [MemoryAddress] memory
      * @param [_ClassMemory] mHandle
      * @return array
      */
    compareFromPtr(ByRef memory, ByRef mHandle) 
    {

      return this.compare(newValues)
    }

    /**
      * Hydrate From PTR
      * Hydrates Class with provided struct reference
      *
      * TODO: Finish coding
      * STATUS: Not functional
      *
      * @param [_ClassMemory] mHandle
      * @return self
      */
    hydrateFromPtr(ByRef mHandle) 
    {

      
    }

    /**
      * Cast
      * Casts a spell on this entity
      * 
      * TODO: Finsih coding
      * STATUS: Not functional
      *
      * @param [Spell] spell
      * @param [Client] client
      * @return bool
      */
    cast(ByRef spell, ByRef client) 
    {
      
      client.send("{shift}z")
      client.send()
    }
       
}
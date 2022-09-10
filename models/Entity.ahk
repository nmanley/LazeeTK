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
    xPos := 0
    yPos := 0
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
    __New(ByRef buf) {
      
      this.readEntityProperties(buf)
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
    readEntityProperties(ByRef buf) {

      tkm := tkmemory.entities

      this.uid := tkm.uid.readFromBuffer(buf)
      this.drawWidth      := tkm.drawWidth.readFromBuffer(buf)
      this.drawHeight     := tkm.drawHeight.readFromBuffer(buf)
      this.xpos           := tkm.xpos.readFromBuffer(buf)
      this.ypos           := tkm.ypos.readFromBuffer(buf)
      this.imageId        := tkm.imageId.readFromBuffer(buf)
      this.name           := tkm.name.readStringFromBuffer(buf)
      this.faceDir        := tkm.faceDir.readFromBuffer(buf)
      this.vitaBarPtr     := tkm.vitaBarPtr.readFromBuffer(buf)
      this.manaBarPtr     := tkm.manaBarPtr.readFromBuffer(buf)
      
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
    compare(newValues) {

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
    compareFromPtr(ByRef memory, ByRef mHandle) {

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
    hydrateFromPtr(ByRef mHandle) {

      
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
    cast(ByRef spell, ByRef client) {
      
      client.send("{shift}z")
      client.send()
    }


        
}
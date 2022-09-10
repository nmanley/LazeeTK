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
  * File: classes/LZMemory.ahk
  * Description: LZ Memory Class
  * Version: 1.0.0
  *
  *
  */

class LZMemory 
{   

    static processEntryPoint  := 0
    static clientVersion      := 752
    baseAddress               := 0x0400000
    client                    := {}
    clientLocal               := {}
    statusBox                 := {}
    party                     := {}
    targets                   := {}
    items                     := {}
    spells                    := {}
    entities                  := {}

    __New()
    {
      baseAddress                 := 0x0400000
      client__baseOffset          := 0x27A748
      userStatus__baseOffset      := 0x29B4E4
      mapPane__baseOffset         := 0x29B4B4
      entities_baseOffset         := 0x29B89C
      spells_baseOffset           := 0x27A748
      items_baseOffset            := 0x27A748

      ; Client
      this.client.baseAddr        := 0x0067a748
      this.client.baseOffset      := 0x27a748
      this.client.structBufSize   := 0x200
      
      ; Local Player
      this.client.name            := new MemoryAddress(this.client.baseAddr, 0x12A, "utf-16")
      this.client.xpos            := new MemoryAddress(this.client.baseAddr, 0x100, "UInt", 2)
      this.client.ypos            := new MemoryAddress(this.client.baseAddr, 0x108, "UInt", 2)
      this.client.faceDir         := new MemoryAddress(this.client.baseAddr, 0x1C5, "UInt", 1)
      this.client.isTargeted      := new MemoryAddress(this.client.baseAddr, 0x1E8, "UChar", 1)
      this.client.manaCurrent     := new MemoryAddress(this.client.baseAddr, 0x10C, "UInt", 4)
      this.client.manaMax         := new MemoryAddress(this.client.baseAddr, 0x110, "UInt", 4)
      this.client.vitaCurrent     := new MemoryAddress(this.client.baseAddr, 0x104, "UInt", 4)
      this.client.vitaMax         := new MemoryAddress(this.client.baseAddr, 0x108, "UInt", 4)

      ; Status Box
      this.statusBox.baseAddr     := this.baseAddress + 0x37AF4
      this.statusBox.msg          := new MemoryAddress(this.statusBox.baseAddr, 0x1A4, "UTF-16", 255)
      ; Not really a nonce, or checksum, but it changes every time the entry is added.
      ; Location is 12bytes before text, but no pointer points to it.
      this.statusBox.nonce        := new MemoryAddress(this.statusBox.baseAddr, 0x198, "UInt", 4)

      
      ; Local Player Stats
      this.clientLocal.baseAddr   := 0x69B4E4      
      this.clientLocal.baseOffset := 0x29B4E4
      this.clientLocal.structSize := 0x200 ; 255
      this.clientLocal.structOffset := 0x00
      this.clientLocal.gold       := new MemoryAddress(this.clientLocal.baseAddr, 0x11C, "UInt", 4)
      this.clientLocal.exp        := new MemoryAddress(this.clientLocal.baseAddr, 0x114, "UInt", 4)
      this.clientLocal.xpos       := new MemoryAddress(this.clientLocal.baseAddr, 0xFC, "UInt", 4)
      this.clientLocal.ypos       := new MemoryAddress(this.clientLocal.baseAddr, 0x100, "UInt", 4)
      this.clientLocal.manaCurrent := new MemoryAddress(this.clientLocal.baseAddr, 0x10C, "UInt", 4)
      this.clientLocal.manaMax    := new MemoryAddress(this.clientLocal.baseAddr, 0x110, "UInt", 4)
      this.clientLocal.vitaCurrent := new MemoryAddress(this.clientLocal.baseAddr, 0x104, "UInt", 4)
      this.clientLocal.vitaMax    := new MemoryAddress(this.clientLocal.baseAddr, 0x108, "UInt", 4)
      this.clientLocal.mapName    := new MemoryAddress(0x69B4B4, 0xF8, "UTF-16", 20)
      
      ; Party
      this.party.baseAddr         := 0x0067a748
      this.party.baseOffset       := 0x27a748
      this.party.offset           := 0x218
      this.party.memberSize       := 0x12C
      this.party.partySize        := 0x3CB0
      this.party.uid              := new MemoryAddress(this.party.baseAddr, [0x00], "UInt", 4)
      this.party.name             := new MemoryAddress(this.party.baseAddr, [0x00], "UInt", 4)
      this.party.faceDir          := new MemoryAddress(this.party.baseAddr, [0x1C5], "UInt", 1)
      this.party.isTargeted       := new MemoryAddress(this.party.baseAddr, [0x1E8], "UChar", 1)
      this.party.manaCurrent      := new MemoryAddress(this.party.baseAddr, [0x128], "UInt", 4)
      this.party.manaMax          := new MemoryAddress(this.party.baseAddr, [0x124], "UInt", 4)
      this.party.vitaCurrent      := new MemoryAddress(this.party.baseAddr, [0x338], "UInt", 4)
      this.party.vitaMax          := new MemoryAddress(this.party.baseAddr, [0x334], "UInt", 4)

      ; Targets
      this.targets.spell          := new MemoryAddress(0x0069BF20, 0x00, "UInt", 4)
      this.targets.tab            := new MemoryAddress(0x0069BF2C, 0x00, "UInt", 4)
      this.targets.v              := new MemoryAddress(0x0069BF28, 0x00, "UInt", 4)
      this.targets.lastUid        := new MemoryAddress(0x0069bf30, 0x00, "UInt", 4)

      ; Local Player Spells
      this.spells.baseAddr        := this.client.baseAddr
      this.spells.offset          := 0x13A834
      this.spells.entrySize       := 0x148
      this.spells.type            := new MemoryAddress(this.spells.baseAddr, 0x04, "UChar")
      this.spells.name            := new MemoryAddress(this.spells.baseAddr, 0x08, "utf-16")
      this.spells.prompt          := new MemoryAddress(this.spells.baseAddr, 0xA8, "utf-16")

      ; Player items
      this.items.baseAddr         := this.client.baseAddr
      this.items.offset           := 0x13410A
      this.items.entrySize        := 0x1FC
      this.items.displayName      := new MemoryAddress(this.items.baseAddr, 0x0, "UTF-16", 32)
      this.items.itemName         := new MemoryAddress(this.items.baseAddr, 0xA0, "UTF-16", 32)
      this.items.qty              := new MemoryAddress(this.items.baseAddr, 0x1E2, "UInt", 4)

      ; Entities Table
      this.entities.baseAddr      := 0x69B89C
      this.entities.baseOffset    := [0x134, 0x30, 0xCA4, 0x58, 0xCE8, 0x14, 0x2C]
      this.entities.structSize    := 0x20C
      this.entities.nextPtr       := 0x00
      this.entities.nullPtr       := 0x00
      this.entities.structOffset  := 0x00
      this.entities.nextBucket    := 0x04
      this.entities.bucketSize    := 10

      ; 2C must be something with the map
      ; 
      this.entities.vTableOffsets := [0x00, 0x04] ; These are pointers to the 3 tables that are established.
                                                        ; 0X005444BB MOV [EBX], PTR
                                                        ; 0x005444C1 MOV [EBX + 0xA0], PTR
                                                        ; 0x005444CB MOV [EBX + 0xA4], PTR
      ;7C 09 62 = Player or 58 2f 62
      this.entities.drawWidth     := new MemoryAddress(this.entities.baseAddr, 0x4C, "UInt", 4)
      this.entities.drawHeight    := new MemoryAddress(this.entities.baseAddr, 0x50, "UInt", 4)
      this.entities.uid           := new MemoryAddress(this.entities.baseAddr, 0xFC, "UInt", 4)
      this.entities.xpos          := new MemoryAddress(this.entities.baseAddr, 0x100, "UChar", 1)
      this.entities.ypos          := new MemoryAddress(this.entities.baseAddr, 0x104, "UChar", 1)
      this.entities.imageId       := new MemoryAddress(this.entities.baseAddr, 0x50, "UChar", 1)
      this.entities.name          := new MemoryAddress(this.entities.baseAddr, 0x12A, "utf-16", 10)
      this.entities.faceDir       := new MemoryAddress(this.entities.baseAddr, 0x1C4, "UChar", 1)
      this.entities.vitaBarPtr    := new MemoryAddress(this.entities.baseAddr, 0x1DC, "UInt", 4)
      this.entities.manaBarPtr    := new MemoryAddress(this.entities.baseAddr, 0x1DC, "UInt", 4)
    }
}

; Need ot find offsets
;506A3790




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
  * Client Instance Class
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: models/Client.ahk
  * Version: 1.0.0
  * Description: Client instance management class. 
  *
  *
  */

class LZClient {

    pid                     := 0
    mHandle                 := 0
    window                  := 0

    ; Stats
    name                    := ""
    xpos                    := 0
    ypos                    := 0
    coordinates             := false
    faceDir                 := 0
    isTargeted              := 0
    manaCurrent             := 0
    manaMax                 := 0
    vitaCurrent             := 0
    vitaMax                 := 0
    gold                    := 0
    exp                     := 0
    mapName                 := ""
    items                   := 0  ; Object of inventory items
    spells                  := [] ; Spells Inventory

    party                   := {} ; Group/Party
    entities                := {} ; Entities array

    timers                  := {} ; Array of running timers
    events                  := [] ; Array of emitted events
    watchers                := {} ; Array of watchers

    ; Autofollow
    leader                  := {} ; Instance of Entity

    ; Define polling timers
    pollingTimers           := {}

    statusBox               := {}
    statusBoxLastNonce      := 0

    spellCount              := 0
    walkCount               := 0

    eventStack              := 0

    timeBetweenSwing        := 100
    nextSwingTime           := 0
    useAxeLastNonce         := 0
    

    __New(username := false)
    {

        this.window := new LZWindow()
        this.eventStack := new EventStack()

        if (username != false) {
            this.attach(username)
        }

        this.items := ComObjCreate("Scripting.Dictionary")
    }

    /**
      * Attach
      * Attaches the client class to a NTK Window based on username.
      * 
      * TODO: N/A at this point.
      * STATUS: Working
      *
      * @param [string] username
      * @return mixed
      */
    attach(username) 
    {
        if(!pid := this.window.attach(username)) 
        {
            return logger.ERROR(Format("Unable to locate window logged in with username: {:s}", username))
        }
        else
        {
            this.mHandle := new _ClassMemory("ahk_pid" pid, hProcessCopy)    
            if !this.mHandle.isHandleValid() {
                logger.ERROR(Format("Unable to attach to process memory for username: {:s}", username))
                return false
            }
        }

        return true
    }

    /**
      * Detach
      * Detaches the _ClassMemory handle from the client.
      * 
      * TODO: Make this function part of the class Destroy method.
      * STATUS: Working
      *
      * @param none
      * @return null
      */
    detach() 
    {
        this.mHandle.close()
    }

    /**
      * Mem
      * Returns the memory handle for the client window
      * 
      * TODO: N/A
      * STATUS: Working
      *
      * @param none
      * @return _ClassMemory
      */
    mem() 
    {
        return this.mHandle
    }

    /**
      * Register Timers
      * Registers timers to be called on from a queue.
      * 
      * TODO: Move to a separate queue instance class
      * STATUS: Working
      *
      * @param none
      * @return array
      */
    registerTimers() 
    {
        this.timers.Push(new LZTimer("stack", ObjBindMethod(this.eventStack, "processStack"), 250, 0, -1))
        this.timers.Push(new LZTimer("client-local", ObjBindMethod(this, "update__clientLocal"), 400, 0, -1))
        ;this.timers.Push(new LZTimer("update_map", ObjBindMethod(this, "update__map"), 1000, -1))
        this.timers.Push(new LZTimer("entities", ObjBindMethod(this, "update__entities"), 5000, -1))
        this.timers.Push(new LZTimer("statusbox", ObjBindMethod(this, "fetch__statusBoxEntry"), 550, 0, -1))
        this.timers.Push(new LZTimer("items", ObjBindMethod(this, "update__items"), 1000, 10, -1))
        this.timers.Push(new LZTimer("spells", ObjBindMethod(this, "update__spells"), 600000, 50, -1))

        this.update__entities()
    }

    /**
      * Subscribe To
      * Shortcut to eventStack.subscribeTo
      * 
      * TODO: N/A
      * STATUS: Working
      *
      * @param [string] name
      * @param [Subscription] subscription
      * @return bool
      */
    subscribeTo(name, subscription)
    {
        return this.eventStack.subscribeTo(name, subscription)
    }

    /**
      * Emit Event
      * Pushes an event onto the event stack
      * 
      * TODO: N/A
      * STATUS: Working
      *
      * @param [Event] event
      * @return bool
      */
    emitEvent(event)
    {
        return this.eventStack.push(event)
    }

    /**
      * Output Entities
      * Debug function for printing entities to console via stdout
      * 
      * TODO: N/A
      * STATUS: Working
      *
      * @param none
      * @return null
      */
    outputEntities() {
        StdOut("//Entites Table---------")
        for i, entity in this.entities {
            StdOut(Format("Entity: {:i} Name: {:s} X/Y: {:i},{:i}", entity.uid, entity.name, entity.xpos, entity.ypos))
        }
        StdOut("//Entites Table---------")
    }

    /**
      * Update Client Local
      * Updates the memory values relevant to the local client.
      *
      * TODO: N/A
      * STATUS: Working
      *
      * @param none
      * @return bool
      */
    update__clientLocal() 
    {
        
        ; Saving for comparison later
        xpos := this.xpos
        ypos := this.ypos
        gold := this.gold
        exp := this.exp
        manaCurrent := this.manaCurrent
        manaMax := this.manaMax
        vitaCurrent := this.vitaCurrent
        vitaMax := this.vitaMax
        mapName := this.mapName

        this.update__map()

        tkm := tkmemory.clientLocal
        VarSetCapacity(buf, tkm.structSize)  
        this.mHandle.readRaw(tkm.baseAddr, buf, tkm.structSize, tkm.structOffset)
        this.xpos := tkm.xpos.readFromBuffer(buf)
        this.ypos := tkm.ypos.readFromBuffer(buf)
        this.gold := tkm.gold.readFromBuffer(buf)
        this.exp := tkm.exp.readFromBuffer(buf)
        this.manaCurrent := tkm.manaCurrent.readFromBuffer(buf)
        this.manaMax := tkm.manaMax.readFromBuffer(buf)
        this.vitaCurrent := tkm.vitaCurrent.readFromBuffer(buf)
        this.vitaMax := tkm.vitaMax.readFromBuffer(buf)
        
        if (xpos != this.xpos or ypos != this.ypos) 
            this.emitEvent(new ClientMoveEvent(this, {currentPos: new Coordinate(this.xpos, this.ypos), previousPos: new Coordinate(xpos, ypos), mapName: this.mapName, oldMapName: mapName}))

        if (gold != this.gold)
            this.emitEvent(new GoldChangeEvent(this, {amount: this.gold, oldAmount: gold}))

        if (exp != this.exp)
            this.emitEvent(new ExpChangeEvent(this, {amount: this.exp, oldAmount: exp}))
        
        ; Changes in Mana
        if (manaCurrent != this.manaCurrent || manaMax != this.manaMax)
            this.eventStack.push(new ManaChangeEvent(this, {past: manaCurrent, current: this.manaCurrent, pastMax: manaMax, currentMax: this.manaMax}))
            
        ; Changes in Vita
        if (vitaCurrent != this.vitaCurrent || vitaMax != this.vitaMax)        
            this.eventStack.push(new VitaChangeEvent(this, {past: vitaCurrent, current: this.vitaCurrent, pastMax: vitaMax, currentMax: this.vitaMax}))


        return true
    }

    /**
      * Update Map
      * Updates the map name
      * 
      * TODO: Include the map file, and store boundries in an array.
      * STATUS: Working
      *
      * @param none
      * @return bool
      */
    update__map() 
    {
        ;StdOut(Format("Map Name {:s}", this.mapName))
        map := this.mapName
        this.mapName := tkmemory.clientLocal.mapName.readString(this.mHandle)

        if (map != this.mapName) {
            this.emitEvent(new MapChangeEvent(this, {mapName: this.mapName, oldMapName: mapName}))
        }
    
        return true
    }

    /**
      * Update Spells
      * Updates the spells on the client
      * 
      * TODO: Create a more robust analysis of Models/Spell.ahk
      * STATUS: Working
      *
      * @param none
      * @return bool
      */
    update__spells() 
    {

        tkm := tkmemory.spells
        newSpells := []
        index := 0

        While index < 52 {

            
            offset := tkm.offset + (tkm.entrySize * index)

            VarSetCapacity(buf, tkm.entrySize)
            this.mHandle.readRaw(tkm.baseAddr, buf, tkm.entrySize, offset)
            alphaIndex := NumberToLetter(A_Index)
            
            spell := new Spell(alphaIndex, buf)

            if(spell != false)
                newSpells.Push(spell)

            index += 1
        }

        this.spells := newSpells

        return true
    }

    /**
      * Update Items
      * Updates users inventory items
      * 
      * TODO: Benchmark the cycle difference between single memory snap, versus individual struct grabs.
      * STATUS: Working
      *
      * @param none
      * @return bool
      */
    update__items() 
    {

        tkm := tkmemory.items
        newItems := ComObjCreate("Scripting.Dictionary")
        index := 0

        while index < 52 {

            offset := tkm.offset + (tkm.entrySize * index)

            VarSetCapacity(buf, tkm.entrySize)
            this.mHandle.readRaw(tkm.baseAddr, buf, tkm.entrySize, offset)
            alphaIndex := NumberToLetter(A_Index)

            item := new Item(alphaIndex, buf)
            
            
            if (item.name != "") {
                
                itemExists := (this.items.Exists(alphaIndex) AND this.items.Item[alphaIndex].name = item.name) ? true : false
                
                /*
                if (this.items.Exists(alphaIndex)) {

                    oldItem := this.items.Item[alphaIndex]
                    if(oldItem.itemName = item.itemName AND oldItem.letter = item.letter)
                }
                if (this.items.Exists(alphaIndex) AND this.items.Item[alphaIndex].itemName = item.itemName AND this.items) {
                    itemExists := true

                    ; Item Used
                    if (this.items.Item[alphaIndex].qty < item.qty) {
                        ; Ambiguous with a drop of a single item.
                        ; Add status box checking to see if that item was consumed or dropped
                        this.emitEvent(new ItemChangeEvent(this, {event: "use", item: item}))
                    }
                }
                */               

                if (!itemExists)
                    this.emitEvent(new ItemChangeEvent(this, {event: "new", item: item}))
                    

                newItems.Item(alphaIndex) := item
            }

            index += 1
        }
        
        itemDiff = this.items.Count - newItems.Count
        if (itemDiff != 0) {
            iterations := 0
            for itemKey in this.items.Keys {
                if (!newItems.Exists(itemKey)) {
                    this.emitEvent(new ItemChangeEvent(this, {event: "drop", item: this.items.Item[itemKey]}))
                }

                iterations += 1
                if (iterations >= itemDiff)
                    break
            }
        }
        
        this.items := ""  ; Delisting so they property get destroyed. For some reason, garbage collection isn't picking them up.
        this.items := newItems

        return false
    }

    /**
      * Update Entities
      * Updates the entities table by recursively scanning until a vtable null ptr is found.
      * 
      * TODO: Fix the stupid thing.
      * STATUS: Not working, it is not reading the nested pointer.
      *
      * @param none
      * @return bool
      */
    update__entities() 
    {

        tkm := tkmemory.entities
        newEntities := ComObjCreate("Scripting.Dictionary")
        scanning := true
        bucketDepth := 0
        nextBucket := 0x00
        bucketSizeInt := 30 ; 30 * 0x20c = 0x3D6F
        bucketSize := 0x3D6F
        nullPtr := 0x00
        baseAddr := tkm.baseAddr

        logger.XDEBUG(Format("Reading Address: {:x}", this.mHandle.pointer(tkm.baseAddr, "UInt")))
        logger.XDEBUG(Format("Reading Address: {:x}", this.mHandle.pointer(tkm.baseAddr, "UInt", 0x0)))
        logger.XDEBUG(Format("Reading Address: {:x}", this.mHandle.pointer(tkm.baseAddr, "UInt", [0x0, 0x0])))

        for i, vOffset in tkm.vTableOffsets {

            offset := [0x00]
        }
        VarSetCapacity(buf, 0x20C)
        args := [0x00]
        this.mHandle.readRaw(tkm.baseAddr + 0x04, buf, 0x20C, args*) 

        logger.INFO(Format("Entity Test: [ID] {:i}", NumGet(buf, 0x100, "UInt")))
        logger.INFO(Format("Entity Test: [ID] {:i}", NumGet(buf, 0xFC, "UInt")))

        return
        while scanning {
            
            if (bucketDepth = 0)
                baseAddr := tkm.baseAddr
            else if (bucketDepth = 1)
                baseAddr := this.mHandle.pointer(tkm.baseAddr, "UInt", 0x00)
            else {
                offsets := []
                loop bucketDepth
                    offsets.Push(0x00)

                baseAddr := this.mHandle.pointer(tkm.baseAddr, "UInt", offsets)
            }

            VarSetCapacity(buf, 0x20C)
            tkm.readRaw(baseAddr, buf, 0x20C, 0x04)
            ;tkm.readRaw(tkm.baseAddr, buf, 4+0x20C)
            logger.INFO(Format("Entity ID: {:i} {:x} From Address: {:x}", NumGet(buf, (0x04 + 0xFC), "UInt"), NumGet(buf, 0xFC + 4, "UInt"), baseAddr))

   
            ; Null pointer?
            if (baseAddr = 0 OR baseAddr = 0x00) {
                logger.INFO("Breaking from scan loop")
                scanning := false
                break
            }

            bucketDepth += 1
            continue

            logger.XDEBUG(Format("Reading from address: {:i} {:x}", baseAddr, baseAddr))            
            
            entityBufferPosition := 0            
            ; Looping throught each of the 30 entity slots.
            while entityBufferPosition < 30 {

                VarSetCapacity(buf, 0x20C)
                tkm.readRaw(baseAddr + (0x20C * entityBufferPosition), buf)
                logger.DEBUG(Format("Fetching: {:i} {:x}",0 NumGet(buf, 0xFC, "UInt"), baseAddr + (0x20C * entityBufferPosition)))
                
                
                entityId := tkm.uid.readFromBuffer(buf, 4)
                if (entityId != 0) {

                    newEntity := new Entity(buf, 4)
                    newEntities.Item(entityId) := newEntity
                    logger.INFO(Format("Found UID: {:i}, xpos: {:i}, ypos: {:i} [NAME]: {:s}", entityId, newEntity.xpos, newEntity.ypos, newEntity.name))
                }
                else {
                    logger.INFO(Format("No entity found."))
                }

                entityBufferPosition += 1
            }
                
            bucketDepth += 1
        }
        
        
        /*
        for i, entity in this.entities {
            if (newEntities.HasKey(entity.uid)) {

                ; Check moveme
                if (entity.xpos != newEntities[entity.uid].xpos or entity.ypos != newEntities[entity.uid].ypos) {
                    this.events.Push(new LZEvent("entity-move", {uid: entity.uid, prevCoords: [entity.xpos, entity.ypos], newCoords: [newEntities[entity.uid].xpos, newEntities[entity.uid].ypos]}))
                }

                this.entities[entity.uid] := newEntities[entity.uid]
                ; Removing
                newEntities.Delete(entity.uid)                
            }
            else {
                ; Remove from list because it's no longer available.
                this.entities.Delete(entity.uid)
                this.events.Push(new LZEvent("entity-removed", {uid: entity.uid, location: [entity.xpos, entity.ypos]}))

                ; Insert event emit
            }
        }

        ; Adding new entities
        for i, entity in newEntities {
            this.entities[entity.uid] := entity
            this.events.Push(new LZEvent("entity-appeared", {uid: entity.uid, location: [entity.xpos, entity.ypos]}))
        }
        */

        return true

    }

    /**
      * Fetch Status Box Entry
      * Returns the last status box entry.
      * This can be called frequenty. Tested at 5x/s without client hiccup on a 2015 Intel i7 CPU.
      * 
      * TODO: Create a StatusBoxClass
      * STATUS: Working
      *
      * @param none
      * @return bool
      */
    fetch__statusBoxEntry() 
    {

        tkm := tkmemory.statusBox

        ; Get last nonce
        newNonce := tkm.nonce.read(this.mHandle)
        ; Has the nonce changed?
        if (this.statusBoxLastNonce != newNonce) {
            this.statusBoxLastNonce := newNonce

            this.statusBox.Push(tkm.msg.readString(this.mHandle))
        }

        return true
    }

    lastStatusBoxEntry()
    {
        return this.statusBox[this.statusBox.Count()]
    }

    assertLastStatusBoxEntry(text)
    {
        return (this.lastStatusBoxEntry() = text) ? true : false
    }

    /**
      * Cast Spell
      * Sends a spell cast to the client.
      * 
      * TODO: Include entity ID as an optional argument which sets the vbox, id.
      * STATUS: Working, but there is a much beter way to achieve this.
      *
      * @param [string] name
      * @return bool
      */
    cast__spell(name) {

        if StrLen(name) > 1 {
            for i, spell in this.spells {
                if InStr(spell.name, name) {
                    ; Found spell letter
                    this.sendKeys("{CTRL DOWN}Z{CTRL UP}" item.letter "{ENTER}")
                    break
                }
            }
        }

        return true
    }

    /**
      * Use
      * Uses an item in inventory.
      * 
      * TODO: Make this better
      * STATUS: Working
      *
      * @param [string] name
      * @return bool
      */
    use(name) 
    {
        item := this.item(name)
        if (item) {
            cmd := Format("{:s}u{:s}", "{ESC}", item.letter)
            logger.INFO(Format("Using item {:s} with the following command: {:s}", item.name, cmd))
            
            return this.sendKeys(cmd)            
        }
        else {
            return false
        }
    }

    useAxe()
    {
        if (this.useAxeLastNonce != this.statusBoxLastNonce) {
            this.use("Axe")
            this.useAxeLastNonce := this.statusBoxLastNonce
        }
    }

    swing()
    {
        if (this.nextSwingTime <= A_TickCount) {
            this.sendKeys("{Space}")
            this.nextSwingTime := A_TickCount + this.timeBetweenSwing
        }
    }

    item(name)
    {
        response := false

        for item in this.items.Items {
            if (item.itemName = name) {
                response := item
                break
            }
        }

        return response
    }

    /**
      * Use Kindred
      * Uses a kindred talisman
      * 
      * TODO: Move to a separate helper class to clean up the namespace
      * STATUS: Working
      *
      * @param none
      * @return bool
      */
    use__kindred() {

        return this.use("Kindred talisman")
    }

    /**
      * Equip Item
      * Equipts an item by name found in inventory
      * 
      * TODO: Move to separate helper class to clean up the namespace
      * STATUS: Working
      *
      * @param [string] name
      * @param [bool] refreshItems
      * @return bool
      */
    equip__item(name, refreshItems = true) 
    {

        if (refreshItems) {
            this.update__items()
        }

        for i, item in this.items {
            if  InStr(item.name, name) {
                this.sendKeys(Format("{ESC}{:s}u{:s}", item.letter))
                break
            }
        }
    }

    targetUID(uid)
    {
        tkm := tkmemory.targets.v

        this.mem.write(tkm.baseAddr, uid, tkm.encoding, tkm.offsets)
    }

    /**
      * Compute Coord Diff
      * Computes the distance between two coord sets
      * 
      * TODO: Move to a dedicated A* Pathing class
      * STATUS: Working
      *
      * @param [int] p1_x
      * @param [int] p1_y
      * @param [int] p2_x
      * @param [int] p2_y
      * @return int
      */
    computeCoordDiff(p1_x, p1_y, p2_x, p2_y) {  
        diff_x := this.xpos - entity.xpos
        diff_y := this.ypos - entity.ypos
        return (diff_x * diff_x) + (diff_y * diff_y)
    }

    /**
      * Find Closest
      * Finds the closest entity
      * 
      * TODO: Finish writing
      * STATUS: Not Working
      *
      * @param [array] entites
      * @return array
      */
    findClosest(entities) {

        closest := 0
        shortestDistance := 999

        for uid, entity in entities {
            
            dist := this.computeCoordDiff(this.xpos, this.ypos, entity.xpos, entity.ypos)
            ;Stdout(Format("My {:i},{:i} Found {:i},{:i} -- Dist = {:i}", this.xpos, this.ypos, entity.xpos, entity.ypos, dist))
            if (dist < shortestDistance) {
                closest := entity
                shortestDistance := dist
            }
        }

        return closest
    }

    /**
      * Find Closest Entity
      * Finds the closest entity
      * 
      * TODO: Finish writing
      * STATUS: Not working
      *
      * @param none
      * @return array
      */
    findClosestEntity() {

        return this.findClosest(this.entities)
    }

    /**
      * Send Keys
      * Sends Keys to the client window
      * 
      * TODO: Rewrite
      * STATUS: Working
      *
      * @param [string] key
      * @return bool
      */
    sendKeys(key) {

        ;logger.INFO(Format("Sending Keys To Client {:i}: {:s}", this.window.pid, key))
        pid := this.window.pid
        ;key := GetKeyVK(key)
        ;PostMessage, 0x100, %key%, 01000010,, ahk_pid %pid%
        ControlSend,, %key%, % "ahk_pid " pid

        return true
    }
}
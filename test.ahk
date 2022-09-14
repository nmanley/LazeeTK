#Include events/BaseEvent.ahk
#Include events/ManaChangeEvent.ahk

mc := new ManaChangeEvent({}, {past: 0, current: 200000, pastMax: 0, currentMax: 200000})
diff := mc.manaDiff
MsgBox %diff%

/*
for i, offset in tkm.vTableOffsets {
            ; Add one to the bucket
            bucketCount += 1

            ; Reading the entire bucket from memory
            nextBucket := this.mHandle.readUInt()
            VarSetCapacity(buf, bucketSize)
            this.mHandle.readRaw()
            
        }

        for i, offset in tkm.vTableOffsets {

            nextEntity := tkm.baseAddr + offset
            
            while recursiveScanning {

                iterCount += 1
                VarSetCapacity(buf, tkm.structSize)
                this.mHandle.readRaw(nextEntity, buf, tkm.structSize)
                ; Reading next address from block
                nextEntity := NumGet(buf, 0x00, "UInt")

                uid := tkm.uid.readFromBuffer(buf)
                logger.DEBUG(Format("Found UID {:i}", uid))

                if(uid != 0x00)
                    newEntities[uid] := new LZEntity(buf)

                if (nextEntity = 0x00 or nextEntity = 0x61CF68)
                    recursiveScanning := false             
            }
        }
        */
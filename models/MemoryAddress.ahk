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
  * File: models/MemoryAddress.ahk
  * Description: Memory address object wrapper
  * Version: 1.0.0
  *
  *
  */

class MemoryAddress
{
    baseAddr        := 0x00
    baseOffset      := 0x00
    offsets         := 0x00
    encoding        := ""
    nBytes          := 0

    __New(baseAddr, offsets := 0x00, encoding := "UInt", nBytes := 4) 
    {
        this.baseAddr := baseAddr
        this.offsets := offsets
        this.encoding := encoding
        this.nBytes := nBytes
    }

    /**
      * Read String
      * Reads a string from the attached _ClassMemory instance using the address's offset, encoding and size
      *
      * TODO: Error Catching from _ClassMemory
      * STATUS: Functional
      *
      * @param [_ClassMemory] mHandle
      * @return string
      */
    readString(ByRef mHandle)
    {   
        return mHandle.readString(this.baseAddr,, this.encoding, this.offsets)
    }

    /**
      * Read
      * Reads a value the attached _ClassMemory instance using the address's offset, encoding and size
      *
      * TODO: Error Handling from _ClassMemory
      * STATUS: Functional
      *
      * @param [_ClassMemory] mHandle
      * @return mixed
      */
    read(ByRef mHandle)
    {       
        return mHandle.read(this.baseAddr, this.encoding, this.offsets)
    }

    /**
      * Read From Buffer
      * Reads a value from the referenced buffer, using the address's offset, encoding and size
      *
      * TODO: Error handling
      * STATUS: Functional
      *
      * @param [Buf] buf
      * @return mixed
      */
    readFromBuffer(ByRef buf, blockOffset := 0)
    {
        return NumGet(buf, blockOffset + this.offsets, this.encoding)
    }

    /**
      * Read String From Buffer
      * Reads a string from the referenced buffer, using the address's offset, encoding and size
      *
      * TODO: Error Handling
      * STATUS: Functional
      *
      * @param [Buf] buf
      * @return string
      */
    readStringFromBuffer(ByRef buf, blockOffset := 0)
    {
        return StrGet(&buf + blockOffset + this.offsets,, this.encoding)
    }

}
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
  * Item Model
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: models/Item.ahk
  * Version: 1.0.0
  * Description: Item Data Model
  *
  *
  */

class Item
{

    letter := ""
    name := ""
    itemName := ""
    qty := 0

    usable := false
    stackable := false
    dropable := false
    transferable := false
       
    __New(letter, ByRef buf) 
    {

        this.letter := letter

        tkm := tkmemory.items
        this.name := tkm.displayName.readStringFromBuffer(buf)
        this.itemName := tkm.itemName.readStringFromBuffer(buf)
        this.qty := tkm.qty.readFromBuffer(buf)

        tkm := ""
        
        /*
        wines := ["Rice wine", "Herb pipe", "Sonhi pipe"]
        scrolls := ["Yellow scroll", "Kindred talisman"]
        weapons := ["Axe", "Throwing axe", "Forged kallal", "Breeze fan"]
        orbs := ["Easter Orb of Sul Slash"]
        craftables := ["Ginko wood", "Amber", "Dark amber", "Yellow amber", "White amber", "Wool"]

        for i, category in {"wines": wines, "scrolls": scrolls, "weapons": weapons, "orbs": orbs} {
            
            for x, item in category {

                if (this.itemName = item) {
                    this.type := i
                    break
                }
            }

            if (this.type != 0)
                break
        }
        if this.type = 0 {
            this.type := "unknown"
        }
        

        qtyDelimiters := ["[", "("]
        
        ; Found the qty already.
        for i, delim in qtyDelimiters {
            ; Is the delimiter in the string?
            delimPos := InStr(this.name, delim)
            if delimPos {
                part := SubStr(this.name, delimPos)
                RegexMatch(part, "[0-9]{1,4}", strSearchResults)
                ;StdOut(Format("Found qty in {:s}. Correction: {:i} -> {:i}", this.name, this.qty, strSearchResults))
                this.qty := strSearchResults + 0 ; What a bizarre way to typecast.
                break
            }           
        }
        */

        return this
    }
}
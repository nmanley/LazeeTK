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
  * Event Stack
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: lib/EventStack.ahk
  * Description: Easy to use scripting SDK for memory based and macro'd scripting
  * Version: 1.0.0
  *
  *
  */

class EventStack {

    stack := []
    subscriptions := []
    
    processStackItem() 
    {
      event := this.pop()

      if (event) {
        
        ;logger.XDEBUG(Format("[Event] {:s} --{:s}", event.name, event.eventDescriptionAsString()))

        if (this.subscriptions.HasKey(event.name)) {
          for i, subscriber in this.subscriptions[event.name] {

            if subscriber.__Class != "Subscription" {
              logger.DEBUG("Subscription not callable must be of class type: Subscription")
            }
            else {

              response := subscriber.__Callback(event)
              
              if (!response) 
                this.subscriptions[event.name].RemoveAt(i)
            }   
          }
        }
      }
    }
    
    subscribeTo(to := "", subscription := "")
    {
      if subscription.__Class != "Subscription" {
        logger.ERROR(Format("Subscription callback must be of Class Type: Subscription, Found: {:s}", subscription.__Class))
        return false
      }
      else {
        ; Creating empty array if it doesn't exist.
        if (!this.subscriptions.HasKey(to))
          this.subscriptions[to] := []

        ; Pushing the new subscription onto the subscription stack
        this.subscriptions[to].Push(subscription)
        logger.XDEBUG(Format("Successfully subscribed {:s} to {:s} events", subscription.name, to))
        return true
      }
    }

    size()
    {
      return this.stack.MaxIndex()
    }

    purge()
    {
      return this.stack := []
    }

    pop()
    {
      return this.stack.Pop()
    }

    popN(i)
    {
      return this.stack.RemoveAt(i)
    }

    push(item)
    {
      ; Do we have anyone subscribed to this event?
      if (this.subscriptions.HasKey(item.name))
        return this.stack.Push(item)
    }

    pushN(item, i)
    {
      return this.stack.InsertAt(i, item)
    }  
}

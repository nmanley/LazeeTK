class Woody
{
    name := "Woody"


    __New()
    {
        this.eventHandler := ObjBindMethod(this, ["eventHandler"])
        this.mainLoop := ObjBindMethod(this, ["main"])
        this.eventSubscriptions := ["client-move", "item-change"]

        this.initializeEventSubscriptions("cPlusPlus", this.eventHandler, this.eventSubscriptions)
        this.register(this.name, ObjBindMethod(this, ["main"]))
    }

    eventHandler(event)
    {
        switch event.name
        {
            case "client-move":
                this.handleClientMove(event)
                return
            case "item-change":
                this.handleItemChange()
                return
            default:
                logger.XDEBUG(Format("Skipping unhandled, subscribed event {:s}", event.name))
        }
    }

    mainLoop()
    {
        ; Check some things
        ; Do some things
    }

    handleClientMove(event)
    {

    }
}
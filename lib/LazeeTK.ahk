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
  * File: lib/LazeeTK.ahk
  * Description: Easy to use scripting SDK for memory based and macro'd scripting
  * Version: 1.0.0
  *
  *
  */

class LazeeTK
{
    state := -1
    
    usernames := []

    clients := []
    
    plugins := []
    
    windows := []

    __New()
    {

    }

    /**
      * Get Client By Username
      * Returns the client instance by username if exists
      *
      * @param [string] username
      * @return mixed
      */
    getClientByUsername(username)
    {
        for i, client in this.clients {
            if (client.name = username) {
                return client
            }
        }

        ; Return false if nothing has been found
        return false
    }

    /**
      * Init Client
      * Initializes a new client
      *
      * @param [string] username
      * @return mixed
      */
    initClient(username)
    {
        if (client = this.getClientByUsername(username)) {
            return client
        }
        else {
            client := new Client(username)
            if client {
                logger.XDEBUG(Format("Sucessfully initialized new client on username {:s}", username))
                this.clients.Push(client)
                return client
            }
            else {
                logger.DEBUG(Format("Failed to Init New Client on username {:s}", username))
                return false
            }
        }
    }
}

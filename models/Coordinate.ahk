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
  * Coordinate Data Model
  * 
  * Author(s) Nathan <nathan@manleynet.ca>
  * File: models/Coordinate.ahk
  * Version: 1.0.0
  * Description: Coordinate Data Class
  *
  *
  */

class Coordinate
{
    xpos := 0
    ypos := 0

    __New(xpos, ypos)
    {
        this.xpos := xpos
        this.ypos := ypos
    }

    calculateDistanceFrom(xpos, ypos)
    {
        return this.distanceFrom(xpos, ypos)
    }

    distanceFrom(xpos, ypos)
    {
        diff_x := this.xpos - xpos
        diff_y := this.ypos - ypos
        return (diff_x * diff_x) + (diff_y * diff_y)
    }

    findClosest(coords)
    {
        closest := 0
        shortestDistance := 0

        for i, coord in coordsArray {

            coord.calculateDistance(this.xpos, this.ypos)

            if (coord.distance < shortestDistance) {
                 shortestDistance := coord.distance
                 closest := coord
            }               
        }

        return closest
    }

}
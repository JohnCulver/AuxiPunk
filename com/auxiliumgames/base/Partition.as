/**
 * Created with IntelliJ IDEA.
 * User: jculver
 * Date: 7/5/12
 * Time: 3:01 PM
 * To change this template use File | Settings | File Templates.
 */
package com.auxiliumgames.base {
import net.flashpunk.Entity;

public class Partition {
    public var x:int;
    public var y:int;
    public var unitSize:uint;

    public function Partition() {
    }

    public function setValues(x:int,y:int,unitSize:uint):void {
        this.x = x;
        this.y = y;
        this.unitSize = unitSize;
    }

    public function setXYForRowCol(e:Entity,row:uint,col:uint, center:Boolean = false):void{
        e.x = x + ( (row * unitSize) + (center ? unitSize / 2 : 0));
        e.y = y + ( (col * unitSize) + (center ? unitSize / 2 : 0));
    }
}
}

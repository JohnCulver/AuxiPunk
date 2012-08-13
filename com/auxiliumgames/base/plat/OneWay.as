/**
 * Created with IntelliJ IDEA.
 * User: JC
 * Date: 7/4/12
 * Time: 7:57 PM
 * To change this template use File | Settings | File Templates.
 */
package com.auxiliumgames.base.plat {
import net.flashpunk.Entity;

public class OneWay extends Entity{

    public function OneWay(x:int,y:int,width:uint,height:uint) {
        this.type = SimplePlatUtils.ONEWAYPLATFORM;
        setHitbox(width,height);
        this.x = x;
        this.y = y;
    }


}
}

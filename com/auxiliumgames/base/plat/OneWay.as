package com.auxiliumgames.base.plat {
import net.flashpunk.Entity;

/**
 * A one way platform like in mario, where you can jump through it from the bottom,
 * but wont fall through it from the top.
 */
public class OneWay extends Entity{

	/**
	 * @param	x			The x location of the top left corner of the one way.
	 * @param	y			The y location of the top left corner of the one way.
	 * @param	width		The width of the one way.
	 * @param	height		The height of the one way.
	 */
    public function OneWay(x:int,y:int,width:uint,height:uint) {
        this.type = PlatForceUtils.ONEWAYPLATFORM;
        setHitbox(width,height);
        this.x = x;
        this.y = y;
    }


}
}

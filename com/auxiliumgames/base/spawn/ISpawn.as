/**
 * Created with IntelliJ IDEA.
 * User: jculver
 * Date: 7/5/12
 * Time: 4:34 PM
 * To change this template use File | Settings | File Templates.
 */
package com.auxiliumgames.base.spawn {
import flash.geom.Point;

public interface ISpawn {

    function spawn(onComplete:Function, l:Point):void;
	function forceComplete():void;
}
}

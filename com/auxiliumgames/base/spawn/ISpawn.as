package com.auxiliumgames.base.spawn {
import flash.geom.Point;

/**
 * 
 */
public interface ISpawn {

    function spawn(onComplete:Function, l:Point):void;
	function forceComplete():void;
}
}

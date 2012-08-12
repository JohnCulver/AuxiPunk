package com.auxiliumgames.base.shmup {
	import flash.geom.Rectangle;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author jculver
	 */
	public class BulletConfig {

		public var image:Image;
		public var hb:Rectangle;
		public var type:String;
		public var world:World;
		public var updateMyLocation:Function;
		public var amIdead:Function;
		
		public function BulletConfig() {
			
		}
		
	}

}
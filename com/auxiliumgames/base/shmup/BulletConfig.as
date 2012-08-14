package com.auxiliumgames.base.shmup {
	import flash.geom.Rectangle;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	/**
	 * This is basically a configuration for a bullet pattern, to be used with BulletHelper.
	 * @author jculver
	 */
	public class BulletConfig {

		/**
		 * The image to be used by each bullet in the pattern.
		 */
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
package com.auxiliumgames.base.shmup {
	import flash.geom.Rectangle;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	/**
	 * This is basically a configuration for a bullet pattern, to be used with BulletPatternManager.
	 * @author jculver
	 */
	public class BulletPattern {

		/**
		 * The image to be used by each bullet in the pattern.
		 */
		public var image:Image;
		/**
		 * The hitbox of the individual bullets.
		 */
		public var hb:Rectangle;
		/**
		 * The type to be used for collision.
		 */
		public var type:String;
		/**
		 * The function that will update the location. The function should take a bullet
		 * as the first param, and the number of updates so far as the second.
		 * Also you can use BulletPatternManager.getUpdateFunctionForAV and
		 * BulletPatternManager.getUpdateFunctionForRing as shortcuts for common patterns.
		 */
		public var updateMyLocation:Function;
		/**
		 * A function to tell the bullet when it is to be no more. The function should take:
		 * (Bullet,uint) where the second param is the number of updates.
		 */
		public var amIdead:Function;
		
		public function BulletPattern() {
			
		}
		
	}

}
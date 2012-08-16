package com.auxiliumgames.base.shmup {
	import com.auxiliumgames.base.CappedObjectPool;
	import com.auxiliumgames.base.Config;
	import com.auxiliumgames.base.Utils;
	import flash.utils.Dictionary;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	/**
	 * A class to help manage various bullet patterns.
	 * @author jculver
	 */
	public class BulletPatternManager {
		
		//info for storing all the bullet patterns.
		private static var configs:Dictionary = new Dictionary();
		
		
		
		public function BulletPatternManager() {
		}
		
		/**
		 * To be called sometime in the world instantiation, maybe in the constructor or if an "init" method
		 * exists thatd be kewl.
		 * 
		 * An alternative would be to create a static initializer block in the class that intends to use the 
		 * specific pattern that you would like to add.
		 * 
		 * @param	name	the name of the pattern, to be used later by the fire method
		 * @param	bp		the bullet pattern
		 */
		public static function addFire(name:String,bps:Vector.<BulletPattern>):void {
			configs[name] = bps;
		}
		
		/**
		 * To clear out all the patterns that have been inserted so far.
		 */
		public static function clearAllBulletPatterns():void {
			configs = new Dictionary();
		}
		
		/**
		 * Returns a bullet update location function for a specific angle and velocity.
		 * @param	velocity	the velocity of the bullet.
		 * @param	angle		the angle (in degrees).
		 * @return
		 */
		public static function getUpdateFunctionForAV(velocity:Number,angle:Number):Function {
			var a1:Number = Utils.degreesToRadians(angle);
			var cosa:Number = Math.cos(a1);
			var xp:Number = velocity * cosa;
			var sina:Number = Math.sin(a1);
			var yp:Number = velocity * sina;
			var f1:Function = function(b:Bullet, u:uint):void {   b.x += xp; b.y -= yp;  };
			return f1;
		}
		
		/**
		 * A helper function for getting the location update functions involved in creating a bullet ring.
		 * To get all the functions for the ring loop from i==0 to i==bulletsInRing passing in i each time.
		 * 
		 * @param	velocity		the velocity of the bullet
		 * @param	index			the position in the ring
		 * @param	bulletsInRing	the total number of bullets in the ring
		 * @return	a function to update a bullets location
		 */
		public static function getUpdateFunctionForRing(velocity:Number,index:uint,bulletsInRing:uint):Function {
			return getUpdateFunctionForAV(velocity, (index * (360 / bulletsInRing)));
		}
		
		//used in the object pool
		private static function newBullet():Bullet {
			return new Bullet();
		}
		
		/**
		 * Used to fire a previously added bullet pattern at a given location.
		 * 
		 * @param	fireName	The name given to the pattern.
		 * @param	startx		The x coordinate where the bullets should start at.
		 * @param	starty		The y coordinate where the bullets should start at.
		 * @param	putInto		A vector to insert the bullets into, should you need to keep track of them.
		 */
		public static function fire(fireName:String, startx:Number, starty:Number, putInto:Vector.<Bullet> =null ):void {
			var bps:Vector.<BulletPattern> = configs[fireName] as Vector.<BulletPattern>;
			if (bps == null)
				return;
			for (var i:int = 0; i < bps.length; i++) {
				var b:Bullet = FP.world.create(Bullet) as Bullet;
				var bp:BulletPattern = bps[i] as BulletPattern;
				b.spawn(startx, starty, bp.updateMyLocation, bp.amIdead, bp.image, bp.hb, bp.layer, bp.type);
				if (putInto != null)
					putInto.push(b);
			}
		}
		
	}

}
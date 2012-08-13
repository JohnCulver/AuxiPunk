package com.auxiliumgames.base.shmup {
	import com.auxiliumgames.base.CappedObjectPool;
	import com.auxiliumgames.base.Globals;
	import flash.utils.Dictionary;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author jculver
	 */
	public class BulletHelper {
		
		
		private static var configs:Dictionary = new Dictionary();
		private static const pool:CappedObjectPool = new CappedObjectPool(newBullet, null, Globals.ETC_ESTIMATED_MAX_BULLETS);
		private static var checkInBullet:Function = function(b:Bullet,world:World):void { pool.checkIn(b); world.remove(b) } ;
		
		public function BulletHelper() {
		}
		
		/**
		 * To be called sometime in the world instantiation, maybe in the constructor or if an "init" method
		 * exists thatd be kewl
		 * @param	name
		 * @param	bc
		 */
		public static function addFire(name:String,bcs:Vector.<BulletConfig>):void {
			configs[name] = bcs;
		}
		
		public static function clearAllBulletConfigs():void {
			configs = new Dictionary();
		}
		
		public static function getUpdateFunctionForAV(velocity:Number,angle:Number):Function {
			var a1:Number = Globals.degreesToRadians(angle);
			var cosa:Number = Math.cos(a1);
			var xp:Number = velocity * cosa;
			var sina:Number = Math.sin(a1);
			var yp:Number = velocity * sina;
			var f1:Function = function(b:Bullet, u:uint):void {   b.x += xp; b.y -= yp;  };
			return f1;
		}
		
		/**
		 * to get all the functions for the ring loop from i==0 to i==bulletsInRing passing in i each time
		 * @param	velocity
		 * @param	index
		 * @param	bulletsInRing
		 * @return
		 */
		public static function getUpdateFunctionForRing(velocity:Number,index:uint,bulletsInRing:uint):Function {
			return getUpdateFunctionForAV(velocity, (index * (360 / bulletsInRing)));
		}
		
		private static function newBullet():Bullet {
			return new Bullet();
		}
		
		public static function fire(fireName:String, world:World, startx:Number, starty:Number, color:int = 0xFFFFFFF, putInto:Vector.<Bullet> =null ):void {
			var bcs:Vector.<BulletConfig> = configs[fireName] as Vector.<BulletConfig>;
			if (bcs == null)
				return;
			for (var i:int = 0; i < bcs.length; i++) {
				var b:Bullet = pool.checkOut() as Bullet;
				if (b != null) {
					var bc:BulletConfig = bcs[i] as BulletConfig;
					b.spawn(startx, starty, bc.updateMyLocation, bc.amIdead, checkInBullet, bc.image, bc.hb, bc.type);
					world.add(b);
					if (putInto != null)
						putInto.push(b);
				}
				else
					break;
			}
		}
		
	}

}
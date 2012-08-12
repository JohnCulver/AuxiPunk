package com.auxiliumgames.base.example.shmup {
	import com.auxiliumgames.base.example.assets.tex.TEXTURES;
	import com.auxiliumgames.base.Globals;
	import com.auxiliumgames.base.shmup.Bullet;
	import com.auxiliumgames.base.shmup.BulletConfig;
	import com.auxiliumgames.base.shmup.BulletHelper;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author ...
	 */
	public class BulletHelperTestWorld extends World{
		
		private var image:Image = new Image(TEXTURES.BLOCK, new Rectangle(18, 10, 8, 8));
		private var hb:Rectangle = new Rectangle( -7, -7, 6, 6);
		
		
		public function BulletHelperTestWorld() {
			FP.screen.color = 0x000000;
			
			var bInRing:Number = 10;
			var velocity:Number = 5;
			var bcs:Vector.<BulletConfig> = new Vector.<BulletConfig>();

			for (var i:Number = 0; i < bInRing; i++) {
				var bc:BulletConfig = new BulletConfig();			
				bc.world = this;
				bc.updateMyLocation = BulletHelper.getUpdateFunctionForRing(velocity, i, bInRing);
				bc.type = "bullet";
				bc.image = new Image(TEXTURES.BLOCK, new Rectangle(0, 0, 8, 8));
				bc.hb = hb;
				bc.amIdead = function(b:Bullet, updates:uint):Boolean { if (updates > 200) return true; else return false; };
				bcs.push(bc);
			}
			
			BulletHelper.addFire("ring1", bcs);
			BulletHelper.fire("ring1", 200, 200);
			
			var inc:Number = 15;
			var count:Number = 13;
			var start:Number = 0;
			var v:Number = 1;
			var bcs2:Vector.<BulletConfig> = new Vector.<BulletConfig>();
			for (var j:Number = 0; j < count; j++) {
				var bc2:BulletConfig = new BulletConfig();			
				bc2.world = this;
				bc2.updateMyLocation = BulletHelper.getUpdateFunctionForAV(v, start + (j * inc));
				bc2.type = "bullet";
				bc2.image = new Image(TEXTURES.BLOCK, new Rectangle(0, 0, 8, 8));
				bc2.hb = hb;
				bc2.amIdead = function(b:Bullet, updates:uint):Boolean { if (updates > 200) return true; else return false; };
				bcs2.push(bc2);
			}
			BulletHelper.addFire("arc1", bcs2);
			BulletHelper.fire("arc1", 200, 200, 0xFF0000);
			
		}
		
	}

}
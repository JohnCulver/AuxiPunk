package com.auxiliumgames.base.example.shmup {
	import com.auxiliumgames.base.example.assets.tex.TEXTURES;
	import com.auxiliumgames.base.Utils;
	import com.auxiliumgames.base.shmup.Bullet;
	import com.auxiliumgames.base.shmup.BulletPattern;
	import com.auxiliumgames.base.shmup.BulletPatternManager;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	/**
	 * A world for testing and demonstrating how to use the BulletPatternManager
	 * @author jculver
	 */
	public class BulletPatternManagerTestWorld extends World{
		
		private var image:Image = new Image(TEXTURES.BLOCK, new Rectangle(18, 10, 8, 8));
		private var hb:Rectangle = new Rectangle( -7, -7, 6, 6);
		
		
		public function BulletPatternManagerTestWorld() {
			FP.screen.color = 0x000000;
			
			var bInRing:Number = 10;
			var velocity:Number = 5;
			var bcs:Vector.<BulletPattern> = new Vector.<BulletPattern>();

			for (var i:Number = 0; i < bInRing; i++) {
				var bc:BulletPattern = new BulletPattern();			
				bc.updateMyLocation = BulletPatternManager.getUpdateFunctionForRing(velocity, i, bInRing);
				bc.type = "bullet";
				bc.image = new Image(TEXTURES.BLOCK, new Rectangle(0, 0, 8, 8));
				bc.hb = hb;
				bc.layer = 100;
				bc.amIdead = function(b:Bullet, updates:uint):Boolean { if (updates > 200) return true; else return false; };
				bcs.push(bc);
			}
			
			BulletPatternManager.addFire("ring1", bcs);
			BulletPatternManager.fire("ring1", this, 200, 200);
			
			var inc:Number = 15;
			var count:Number = 13;
			var start:Number = 0;
			var v:Number = 1;
			var bcs2:Vector.<BulletPattern> = new Vector.<BulletPattern>();
			for (var j:Number = 0; j < count; j++) {
				var bc2:BulletPattern = new BulletPattern();			
				bc2.updateMyLocation = BulletPatternManager.getUpdateFunctionForAV(v, start + (j * inc));
				bc2.type = "bullet";
				bc2.image = new Image(TEXTURES.BLOCK, new Rectangle(0, 0, 8, 8));
				bc2.hb = hb;
				bc2.layer = 100;
				bc2.amIdead = function(b:Bullet, updates:uint):Boolean { if (updates > 200) return true; else return false; };
				bcs2.push(bc2);
			}
			BulletPatternManager.addFire("arc1", bcs2);
			BulletPatternManager.fire("arc1", this,  200, 200);
			
		}
		
	}

}
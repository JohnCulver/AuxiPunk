package com.auxiliumgames.base.example.shmup {
import com.auxiliumgames.base.Utils;
import com.auxiliumgames.base.shmup.Bullet;
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author ...
	 */
	public class BWorld extends World{
		
		public function BWorld() {
			FP.screen.color = 0x000000;
			
			var bInRing:Number = 10;
			var velocity:Number = 5;
			
			for (var i:Number = 0; i < bInRing; i++) {
				spawnOne(velocity, (i * (360/bInRing)));
			}
			
			//var inc:Number = 15;
			//var count:Number = 13;
			//var start:Number = 0;
			//var v:Number = 1;
			//for (var j:Number = 0; j < count; j++) {
				//spawnOne(v, start + (j * inc));
			//}
			
			//var a1:Number = 30;
			//var b1:Bullet = new Bullet();
			//var f1:Function = function(b:Bullet, u:uint):void { if (u == 0) { b.x = 200; b.y = 200; } else { b.x += velocity * Math.cos(a1); b.y += velocity * Math.sin(a1); } };
			//var d1:Function = function(b:Bullet, u:uint):Boolean { return u > 200; };
			//var c1:Function = function():void { remove(b1)};
			//b1.spawn(f1, d1, c1, false, 0xFF0000);
			//add(b1);
			//
			//var a2:Number = a1 + between;
			//var b2:Bullet = new Bullet();
			//var f2:Function = function(b:Bullet, u:uint):void { if (u == 0) { b.x = 200; b.y = 200; } else { b.x += velocity * Math.cos(a2); b.y += velocity * Math.sin(a2); } };
			//var d2:Function = function(b:Bullet, u:uint):Boolean { return u > 200; };
			//var c2:Function = function():void { remove(b2)};
			//b2.spawn(f2, d2, c2, false, 0xFF00FF);
			//add(b2);
		}
		
		private function spawnOne(velocity:Number, angle:Number):void {
			var a1:Number = Utils.degreesToRadians(angle);
			var cosa:Number = Math.cos(a1);
			var xp:Number = velocity * cosa;
			var sina:Number = Math.sin(a1);
			var yp:Number = velocity * sina;
			var b1:Bullet = new Bullet();
			b1.x = 200; 
			b1.y = 200;
			var f1:Function = function(b:Bullet, u:uint):void {   b.x += xp; b.y -= yp;  };
			var d1:Function = function(b:Bullet, u:uint):Boolean { return u > 200; };
			var c1:Function = function():void { remove(b1)};
			b1.spawn(f1, d1, c1, 0xF0AFFF);
			add(b1);
		}
		

	}

}
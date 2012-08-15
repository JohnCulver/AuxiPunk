package com.auxiliumgames.base.example.shmup {
	import com.auxiliumgames.base.example.assets.tex.TEXTURES;
	import com.auxiliumgames.base.Globals;
	import com.auxiliumgames.base.shmup.Bullet;
	import com.auxiliumgames.base.shmup.BulletPattern;
	import com.auxiliumgames.base.shmup.BulletPatternManager;
	import com.auxiliumgames.base.shmup.ShmupInput;
	import com.auxiliumgames.base.shmup.ShmupPositionManager;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author jculver
	 */
	public class ShmupDude extends Entity{
		
		/*
		 * A static block initializing the bullets we will fire
		 */
		{
			
			private static function fillInBulletPattern(bcs:Vector.<BulletPattern>, velocity:Number, bInRing:Number):void {
				var hb:Rectangle = new Rectangle( -7, -7, 6, 6);
				for (var i:Number = 0; i < bInRing; i++) {
					var bc:BulletPattern = new BulletPattern();			
					bc.updateMyLocation = BulletPatternManager.getUpdateFunctionForRing(velocity, i, bInRing);
					bc.type = "bullet";
					bc.image = new Image(TEXTURES.BLOCK, new Rectangle(0, 0, 8, 8));
					bc.hb = hb;
					bc.amIdead = function(b:Bullet, updates:uint):Boolean { if (updates > 200) return true; else return false; };
					bcs.push(bc);
				}
			}
			
			private static var bInRing:Number = 10;
			private static var velocity:Number = 5;
			private static var bcs:Vector.<BulletPattern> = new Vector.<BulletPattern>();
			
			fillInBulletPattern(bcs,velocity,bInRing);
			
			BulletPatternManager.addFire("ring1", bcs);
		}
		
		private var image:Spritemap = new Spritemap(TEXTURES.DUDE, 36, 36);
		private var input:ShmupInput;
		private var posMan:ShmupPositionManager;
		
		private var cantFireTime:uint = 0;
		
		public function ShmupDude() {
			graphic = image;
            image.add("rest", [0]);
            image.add("move", [1]);
			image.play("rest");
			
			centerOrigin();
			image.centerOrigin();
			
			setHitbox(30, 30,16,16);
            x = 200;
            y = 200;
			
			posMan = new ShmupPositionManager();
			input = new ShmupDudeInput();
			posMan.setBaseVelocity(5);
			posMan.setCricularVelocity(true);
			posMan.setFocusVelocity(3);
		}
		
		override public function update():void {
			if (Globals.STATE == Globals.STATE_PLAY) {
				posMan.updatePosition(this, input);
				updateAnimation();
				if (cantFireTime <= 0) {
					if (input.isFocused()) {
						BulletPatternManager.fire("ring1",world,x,y);
						cantFireTime = 10;
					}
				}
				else {
					cantFireTime--;
				}
			}
			super.update();
		}
		
		private function updateAnimation():void {
            if(input.pressingDown() || input.pressingLeft() || input.pressingRight() || input.pressingUp())
                image.play("move");
            else
                image.play("rest");
		}
	}
}
import com.auxiliumgames.base.shmup.ShmupInput;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

class ShmupDudeInput implements ShmupInput {
	public function pressingUp():Boolean {
		return Input.check(Key.UP);
	}
	
	public function pressingDown():Boolean {
		return Input.check(Key.DOWN);
	}
	
	public function pressingLeft():Boolean {
		return Input.check(Key.LEFT);
	}
	
	public function pressingRight():Boolean {
		return Input.check(Key.RIGHT);
	}

	public  function isFocused():Boolean{
		return Input.check(Key.Z);
	}
}
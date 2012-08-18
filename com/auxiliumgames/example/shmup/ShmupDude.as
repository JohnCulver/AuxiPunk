package com.auxiliumgames.example.shmup {
	import com.auxiliumgames.example.assets.tex.TEXTURES;
	import com.auxiliumgames.base.Utils;
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
	 * An example of a player controlled shmup entity
	 * @author jculver
	 */
	public class ShmupDude extends Entity{
		
		/*
		 * A static block initializing the bullets we will fire
		 */
		{
			//used to setup the bullet pattern
			private static function fillInBulletPattern(bcs:Vector.<BulletPattern>, velocity:Number, bInRing:Number):void {
				var hb:Rectangle = new Rectangle( -7, -7, 6, 6);
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
			}
			
			//the vars we use for building the pattern
			private static var bInRing:Number = 10;
			private static var velocity:Number = 5;
			private static var bcs:Vector.<BulletPattern> = new Vector.<BulletPattern>();
			
			//actually fill in the pattern
			fillInBulletPattern(bcs,velocity,bInRing);
			//add the pattern to the manager
			BulletPatternManager.addFire("ring1", bcs);
		}
		
		//the sprite for the player
		private var image:Spritemap = new Spritemap(TEXTURES.DUDE, 36, 36);
		//the keyboard input
		private var input:ShmupInput;
		//the position manager
		private var posMan:ShmupPositionManager;
		//used to pace the firing of bullets
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
			//to manage the position based on the input
			posMan = new ShmupPositionManager();
			//ketboard input
			input = new ShmupKeyboardInput();
			//configure the position manager
			posMan.setBaseVelocity(5);
			posMan.setCricularVelocity(true);
			posMan.setFocusVelocity(3);
		}
		
		override public function update():void {
			//update position based on input
			posMan.updatePosition(this, input);
			//change the animation if necessary
			updateAnimation();
			//throttle the firing
			if (cantFireTime <= 0) {
				if (input.isFocused()) {
					BulletPatternManager.fire("ring1",x,y);
					cantFireTime = 10;
				}
			}
			else {
				cantFireTime--;
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
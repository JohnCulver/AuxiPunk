package com.auxiliumgames.base.example.platformer {
	import com.auxiliumgames.base.example.assets.snd.SOUNDS;
	import com.auxiliumgames.base.example.assets.tex.TEXTURES;
	import com.auxiliumgames.base.example.LightWorldExample;
	import com.auxiliumgames.base.Globals;
	import com.auxiliumgames.base.lighting.Light;
	import com.auxiliumgames.base.plat.PlatformerInput;
	import com.auxiliumgames.base.plat.PlatformerPositionManger;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author jculver
	 */
	public class PlatDude extends Entity{
		
		private var image:Spritemap = new Spritemap(TEXTURES.DUDE, 36, 36);
		private var positionManager:PlatformerPositionManger;
		private var input:PlatformerInput;
		
		public function PlatDude() {
			graphic = image;
			image.add("rest", [0]);
			image.add("move", [1]);
			image.add("jump", [2]);
			image.play("rest");
			
			positionManager = new PlatformerPositionManger();
			input = new PlatDudeInput();
			
			positionManager.setJumpVelocity( -14);
			positionManager.setMaxMoveVelocity(8, 15);
			positionManager.setMoveAccel(2);
			positionManager.setAirJumps(4);
			positionManager.setCanAirJumpWhileFalling(true);
			//setJumpOomf(-.3); //.25
			
			centerOrigin();
			image.centerOrigin();
			
			setHitbox(36, 36, 36 / 2, 36 / 2);
			layer = 50;
			setCamera();
		}
		
		private function setCamera():void {
			FP.camera.x = Math.floor(x - FP.screen.width/2);
			FP.camera.y = Math.floor(y - FP.screen.height/2);
		}
		
		override public function update():void {
			if (Globals.STATE == Globals.STATE_PLAY) {
				if(positionManager.onGround && input.pressedJump())
					SOUNDS.JUMP.play(1);
				positionManager.updatePosition(this, input);
				updateAnimation();
				setCamera();
			}
			super.update();
		}
		
		private function updateAnimation():void {
			if (!positionManager.onGround) {
				image.play("jump");
				image.angle += ((positionManager.v.x > 0) ? -.5 : ((positionManager.v.x == 0) ? 0 : .5));
			}
			else {
				image.angle = 0;
				if (positionManager.v.x != 0){
					if(input.pressingRight() || input.pressingLeft())
						image.play("move");
					else
						image.play("rest");
					image.flipped = positionManager.v.x > 0;
				}
				else
					image.play("rest");
			}
				
		}
	}

}

import com.auxiliumgames.base.plat.PlatformerInput;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;
class PlatDudeInput implements PlatformerInput{
	
	/* INTERFACE com.auxiliumgames.base.plat.PlatformerInput */
	
	public function pressingRight():Boolean {
		return Input.check(Key.RIGHT);
	}
	
	public function pressingLeft():Boolean {
		return Input.check(Key.LEFT);
	}
	
	public function pressedJump():Boolean {
		return Input.pressed(Key.Z);
	}
	
	public function holdingJump():Boolean {
		return Input.check(Key.Z);
	}
}
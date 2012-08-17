package com.auxiliumgames.example.platformer {
	import com.auxiliumgames.example.assets.snd.SOUNDS;
	import com.auxiliumgames.example.assets.tex.TEXTURES;
	import com.auxiliumgames.example.lighting.LightWorldExample;
	import com.auxiliumgames.base.Utils;
	import com.auxiliumgames.base.lighting.Light;
	import com.auxiliumgames.base.platformer.PlatformerInput;
	import com.auxiliumgames.base.platformer.PlatformerPositionManger;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * An example of a player controlled entity in a platformer game.
	 * @author jculver
	 */
	public class PlatDude extends Entity{
		
		//the example texture used for our player entity
		private var image:Spritemap = new Spritemap(TEXTURES.DUDE, 36, 36);
		//used to manage the position of any platformer entity
		private var positionManager:PlatformerPositionManger;
		//we make a keyboard based implementation of this below
		private var input:PlatformerInput;
		
		public function PlatDude() {
			graphic = image;
			image.add("rest", [0]);
			image.add("move", [1]);
			image.add("jump", [2]);
			image.play("rest");
			
			positionManager = new PlatformerPositionManger();
			input = new PlatDudeInput();
			//configure the manager
			positionManager.setJumpVelocity( -14);
			positionManager.setMaxMoveVelocity(8, 15);
			positionManager.setMoveAccel(2);
			positionManager.setAirJumps(4);
			positionManager.setCanAirJumpWhileFalling(true);
			positionManager.setJumpOomf(0);
			
			centerOrigin();
			image.centerOrigin();
			
			setHitbox(36, 36, 36 / 2, 36 / 2);
			layer = 50;
			setCamera();
		}
		
		//keep the camera on the player
		private function setCamera():void {
			FP.camera.x = Math.floor(x - FP.screen.width/2);
			FP.camera.y = Math.floor(y - FP.screen.height/2);
		}
		
		override public function update():void {
			//play a sound when we jump
			if(positionManager.onGround && input.pressedJump())
				SOUNDS.JUMP.play(1);
			//update position	
			positionManager.updatePosition(this, input);
			//update animation
			updateAnimation();
			//move camera to player
			setCamera();
			super.update();
		}
		
		//change the animation based on the state of the entity
		private function updateAnimation():void {
			//if he is jumping
			if (!positionManager.onGround) {
				image.play("jump");
				image.angle += ((positionManager.v.x > 0) ? -.5 : ((positionManager.v.x == 0) ? 0 : .5));
			}
			else {
				image.angle = 0;
				if (positionManager.v.x != 0) {
					//if moving
					if(input.pressingRight() || input.pressingLeft())
						image.play("move");
					//if resting	
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

import com.auxiliumgames.base.platformer.PlatformerInput;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;
/**
 * An implementation of the input that used the keyboard.
 * @author jculver
 * 
 */
class PlatDudeInput implements PlatformerInput{
	
	/* INTERFACE com.auxiliumgames.base.platformer.PlatformerInput */
	
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
package com.auxiliumgames.base.example.platformer {
import assets.snd.SOUNDS;
import com.auxiliumgames.base.example.assets.tex.TEXTURES;
	import com.auxiliumgames.base.example.LightWorldExample;
	import com.auxiliumgames.base.Globals;
	import com.auxiliumgames.base.lighting.Light;
	import com.auxiliumgames.base.plat.AbstPlatformerPlayer;
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
	public class PlatDude extends AbstPlatformerPlayer{
		
		private var image:Spritemap = new Spritemap(TEXTURES.DUDE, 36, 36);
		private var jo:Number;
		private var light:Light;
		
		public function PlatDude(light:Light = null) {
			this.light = light;
			graphic = image;
			image.add("rest", [0]);
			image.add("move", [1]);
			image.add("jump", [2]);
			image.play("rest");
			type = "physical";
			
			edtJumpVelocity( -14);
			edtMaxMoveVelocity(8, 15);
			edtMoveAccel(2);
			edtAirJumps(4);
			edtCanAirJumpWhileFalling(true);
			//edtJumpOomf(-.3); //.25
			
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
				updatePosition();
				if (light) {
					light.x = this.x;
					light.y = this.y;
				}
				updateAnimation();
				setCamera();
			}
            if(isCurrentlyOnGround && abstPressedJump())
                SOUNDS.JUMP.play(1);
			super.update();
		}
		
		private function updateAnimation():void {
			if (!isCurrentlyOnGround) {
				image.play("jump");
				
				image.angle += ((v.x > 0) ? -.5 : ((v.x == 0) ? 0 : .5));
			}
			else {
				image.angle = 0;
				if (v.x != 0){
					if(abstPressingLeft() || abstPressingRight())
						image.play("move");
					else
						image.play("rest");
					image.flipped = v.x > 0;
				}
				else
					image.play("rest");
			}
				
		}
		
		override protected function abstPressedJump():Boolean {
			return Input.pressed(Key.Z);
		}
		
		override protected function abstHoldingJump():Boolean {
			return Input.check(Key.Z);
		}
		
		override protected function abstPressingLeft():Boolean {
			return Input.check(Key.LEFT);
		}
		
		override protected function abstPressingRight():Boolean {
			return Input.check(Key.RIGHT);
		}
	}

}
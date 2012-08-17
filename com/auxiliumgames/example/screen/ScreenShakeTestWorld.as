package com.auxiliumgames.example.screen {
	import com.auxiliumgames.example.assets.tex.TEXTURES;
	import com.auxiliumgames.base.screen.ScreenShaker;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	/**
	 * A class for demonstrating and testing the ScreenShaker class.
	 * Puts a small image on screen, and then allows the user to shake
	 * the screen on the x and y axis by pressing the x and y keys (respectively).
	 * @author jculver
	 */
	public class ScreenShakeTestWorld extends World{
		
		public function ScreenShakeTestWorld() {
			var e:Entity = new Entity(200, 200, new Image(TEXTURES.BLOCK));
			add(e);
			//set the rate at which the shake wave shrinks:
			ScreenShaker.xShrinkRate = 1.5;
			ScreenShaker.yShrinkRate = 1.5;
			ScreenShaker.maxXPower = 60;
			ScreenShaker.maxYPower = 60;
		}
		
		
		override public function update():void {
			super.update();
			if (Input.pressed(Key.X)) {
				ScreenShaker.currentXPower += 20;
			}
			if (Input.pressed(Key.Y)) {
				ScreenShaker.currentYPower += 20;
			}
			//first we set the camera to wherever it should be.
			//If the camera never moves in your game then set it to zero
			//before applying shake.
			//If the camera is following an entity then set the camera.x/y to
			//the entity.x/y before applying the shake.
			FP.camera.x = 0;
			FP.camera.y = 0;
			ScreenShaker.applyShake();
		}
	}

}
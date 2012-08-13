package com.auxiliumgames.base.example.shmup {
	import com.auxiliumgames.base.example.assets.tex.TEXTURES;
	import com.auxiliumgames.base.Globals;
	import com.auxiliumgames.base.shmup.ShmupInput;
	import com.auxiliumgames.base.shmup.ShmupPositionManager;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author jculver
	 */
	public class ShmupDude extends Entity{
		
		private var image:Spritemap = new Spritemap(TEXTURES.DUDE, 36, 36);
		private var input:ShmupInput;
		private var posMan:ShmupPositionManager;
		
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
package com.auxiliumgames.base.example.shmup {
	import com.auxiliumgames.base.example.assets.tex.TEXTURES;
	import com.auxiliumgames.base.Globals;
	import com.auxiliumgames.base.shmup.AbstShmupPlayer;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author jculver
	 */
	public class ShmupDude extends AbstShmupPlayer{
		
		private var image:Spritemap = new Spritemap(TEXTURES.DUDE, 36, 36);
		
		public function ShmupDude() {
			graphic = image;
            image.add("rest", [0]);
            image.add("move", [1]);
			image.play("rest");
			type = "physical";
			
			centerOrigin();
			image.centerOrigin();
			
			setHitbox(30, 30,16,16);
            x = 200;
            y = 200;
			
			edtBaseVelocity(5);
			edtClampVelocity(true);
			edtFocusVelocity(3);
		}
		
		override public function update():void {
			if (Globals.STATE == Globals.STATE_PLAY) {
				updatePosition();
				updateAnimation();
			}
			super.update();
		}
		
		private function updateAnimation():void {

            if(abstPressingLeft() || abstPressingRight() || abstPressingUp() || abstPressingDown())
                image.play("move");
            else
                image.play("rest");
		}
		
		override protected function abstPressingUp():Boolean {
			return Input.check(Key.UP);
		}
		
		override protected function abstPressingDown():Boolean {
			return Input.check(Key.DOWN);
		}
		
		override protected function abstPressingLeft():Boolean {
			return Input.check(Key.LEFT);
		}
		
		override protected function abstPressingRight():Boolean {
			return Input.check(Key.RIGHT);
		}

        override  protected  function abstIsFocused():Boolean{
            return Input.check(Key.CONTROL);
        }
	}
}
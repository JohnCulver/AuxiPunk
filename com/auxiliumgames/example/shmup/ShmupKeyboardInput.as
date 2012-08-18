package com.auxiliumgames.example.shmup {
	import com.auxiliumgames.base.shmup.ShmupInput;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	/**
	 * A Keyboard implementation of the shmupinput
	 * @author jculver
	 */
	public class ShmupKeyboardInput implements ShmupInput {
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

}
package com.auxiliumgames.example.display {
	import com.auxiliumgames.base.display.FullScreenColor;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	/**
	 * A demo/test of the FullScreenColor class.
	 * Press z to demo fade in, x to see fade out, and c to add/remove a solid.
	 * @author jculver
	 */
	public class FullScreenColorTestWorld extends World{
		
		private var solidAdded:Boolean= false;
		private var solid:FullScreenColor;
		
		public function FullScreenColorTestWorld() {
			solid = new FullScreenColor(0x00ff00, 100, FullScreenColor.MODE_SOLID );
		}
		
		override public function update():void {
			super.update();
			if (Input.released(Key.Z)) {
				var fscOne:FullScreenColor = new FullScreenColor(0x0000ff, 100, FullScreenColor.MODE_FADE_IN,.03, function():void { remove(fscOne); } );
				add(fscOne);
			}
			if (Input.released(Key.X)) {
				var fscTwo:FullScreenColor = new FullScreenColor(0xff0000, 50, FullScreenColor.MODE_FADE_OUT,.03, function():void { remove(fscTwo); } );
				add(fscTwo);
			}
			if (Input.released(Key.C)) {
				if (solidAdded) 
					remove(solid);
				else
					add(solid);
					
				solidAdded = !solidAdded;
			}
			
		}
		
	}

}
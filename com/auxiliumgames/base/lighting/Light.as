package com.auxiliumgames.base.lighting {
	import flash.display.BlendMode;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author hi
	 */
	public class Light extends Entity{
		private var _image:Image;
		public static var TYPE:String = "light";
		public function Light(image:Image) {
			_image = image;
			type = Light.TYPE;
			_image.blend = BlendMode.ERASE;
			setHitboxTo(image);
			centerOrigin();
			_image.centerOO();
		}
		
		public function get image():Image {
			return _image;
		}
		
		
		
	}

}
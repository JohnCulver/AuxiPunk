package com.auxiliumgames.base.lighting {
	import flash.display.BlendMode;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * Intended to be used with the Darkness class.
	 * The light works sort of the opposite as expected. 
	 * The less transparent an image the more intense the light.
	 * @author John Culver
	 */
	public class Light extends Entity{
		private var _image:Image;
		public static var TYPE:String = "light";
		/**
		 * 
		 * @param	image	The image used to describe the light.
		 * 					The less transparent an image the more intense the light.
		 */
		public function Light(image:Image) {
			_image = image;
			type = Light.TYPE;
			_image.blend = BlendMode.ERASE;
			setHitboxTo(image);
			centerOrigin();
			_image.centerOO();
		}
		/**
		 * @return the image the light is using.
		 */
		public function get image():Image {
			return _image;
		}
		
		
		
	}

}
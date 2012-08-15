package com.auxiliumgames.base.lighting {
	import com.auxiliumgames.base.Config;
	import flash.display.BlendMode;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * Intended to be used with the Darkness class.
	 * The light works sort of the opposite of what is expected:
	 * The less transparent an image the more intense the light.
	 * @author John Culver
	 */
	public class Light extends Entity{
		private var _image:Image;
		/**
		 * 
		 * @param	image	The image used to describe the light.
		 * 					The less transparent an image the more intense the light.
		 */
		public function Light(image:Image) {
			_image = image;
			type = Config.TYPE_LIGHT;
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
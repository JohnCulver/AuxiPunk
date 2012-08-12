package com.auxiliumgames.base.example {
	import com.auxiliumgames.base.example.assets.tex.TEXTURES;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author jculver
	 */
	public class Block extends Entity{
		private var image:Image;
		
		public function Block() {
			image = new Image(TEXTURES.BLOCK);
			graphic = image;
		}
		
	}

}
package com.auxiliumgames.example.screen {
	import com.auxiliumgames.example.assets.tex.TEXTURES;

	import flash.geom.Point;
	import flash.geom.Rectangle;

	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;

	/**
	 * A quick example partition.
	 * @author jculver
	 */
	public class PartitionExampleEntity extends Entity{
		private var onComplete:Function;

		public var image:Image = new Image(TEXTURES.DUDE,new Rectangle(0,0,32,32))

		public function PartitionExampleEntity() {
			graphic = image;
		}
	}
}

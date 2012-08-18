package com.auxiliumgames.base.fx {
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	/**
	 * A class representing a single peice of a trail.
	 * @author jculver
	 */
	public class Trail extends Entity{
		private var image:Image;
		private var fadeRate:Number;
		
		public function Trail() {
			
		}
		
		/**
		 * Instead of putting this into the constructor we put this in an init method
		 * so that we can use world.create and recycle to manage these.
		 * @param	x			The x coord to render at.
		 * @param	y			The y coord to render at.
		 * @param	graphic		The graphic to render.
		 * @param	fadeRate	The rate we fade the graphic out (per frame).
		 * @param	layer		The layer we render the graphic into.
		 */
		public function init(x:int, y:int, graphic:Image, fadeRate:Number, layer:int):void {
			this.fadeRate = fadeRate;
			this.x = x;
			this.y = y;
			this.graphic = this.image = graphic;
			this.fadeRate = fadeRate;
			this.layer = layer;
			
		}
		
		override public function update():void {
			//fade out till it's gone then recycle it
			image.alpha -= fadeRate;
			if (image.alpha <= 0)
				FP.world.recycle(this);
		}
		
	}

}
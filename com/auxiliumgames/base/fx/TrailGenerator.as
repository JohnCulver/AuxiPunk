package com.auxiliumgames.base.fx {
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	/**
	 * A class to add a trailing effect to an image.
	 * @author jculver
	 */
	public class TrailGenerator {
		
		//handy to have zero zero around
		static private const zz:Point = new Point();
		
		//to track the origin of the image we will trail.
		private var origin:Point;
		
		//tracking the trail info
		private var graphic:Image;
		private var color:uint;
		private var fadeRate:Number;
		private var staringAlpha:Number;
		private var framesBetweenTrails:uint;
		private var bmp:BitmapData;
		
		//how many frames since we dropped a trail
		private var frameCount:uint = 0;
		
		//the layer we will trail in
		private var layer:int;
		//the offset of the trail when we are asked to render
		private var offset:Point;
		
		public function TrailGenerator() {
			
		}
		
		/**
		 * 
		 * @param	graphic					The graphic we use to trail.
		 * @param	color					The color of the trail.
		 * @param	framesBetweenTrails		The gap, in frames, between trail renders.
		 * @param	startingAlpha			The initial alpha of each trail.
		 * @param	fadeRate				The rate at which each trail fades out.
		 * @param	layer					The layer we render the trails into.
		 * @param	xOffset					The x offset of the render.
		 * @param	yOffset					The y offset of the render.
		 */
		public function init(graphic:Image, color:uint, framesBetweenTrails:uint, startingAlpha:Number, fadeRate:Number, layer:int, xOffset:int = 0, yOffset:int = 0):void {
			this.graphic = graphic;
			this.color = color;
			this.framesBetweenTrails = framesBetweenTrails;
			this.staringAlpha = startingAlpha;
			this.fadeRate = fadeRate;
			if (fadeRate < 0)
				fadeRate = 0;
			frameCount = 0;
			this.layer = layer;
			this.origin = new Point(graphic.originX, graphic.originY);
			this.offset = new Point(xOffset, yOffset);
		}
		
		/**
		 * To be called during the games update loop.
		 * @param	x	The x coord to render the top left. The xOffset will be applied to this each time.
		 * @param	y	The y coord to render the top left. The yOffset will be applied to this each time.
		 */
		public function trail(x:int, y:int):void {
			//if we need to leave a new trail
			if (frameCount == framesBetweenTrails) {
				frameCount = 0;
				bmp = new BitmapData(graphic.width, graphic.height,true,0x00000000);
				graphic.render(bmp, origin, zz);
				var image:Image = new Image(bmp);
				image.color = color;
				image.alpha = staringAlpha;
				var trail:Trail = FP.world.create(Trail) as Trail;
				trail.init(x + offset.x, y + offset.y, image, fadeRate, layer);
			}
			else
				frameCount++;
		}
	}

}
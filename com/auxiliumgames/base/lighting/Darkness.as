package com.auxiliumgames.base.lighting {
	import com.auxiliumgames.base.Config;
	import com.auxiliumgames.example.assets.tex.TEXTURES;
	import flash.display.BlendMode;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Image;
	/**
	 * Adds a layer of darkness over the screen.
	 * This class is intented to work with the Light class.
	 * @author jculver
	 */
	public class Darkness extends Entity{
		
		//The visual elements of the Darkness.
		private var c:Canvas;
		private var color:uint;
		private var alpha:Number;
		
		//To keep track of the lights we collide with.
		private var into:Vector.<Light>;
		
		/**
		 * 
		 * @param	color	The color of the fill. This can be black/dark grey/blue or whatever.
		 * @param	alpha	The alpha of the fill. Usually between .8 and 1.
		 * @param	layer	The layer the Darkness is in.
		 */
		public function Darkness(color:uint,alpha:Number,layer:int) {
			this.alpha = alpha;
			this.color = color;
			c = new Canvas(FP.screen.width,FP.screen.height);
			c.blend = BlendMode.LAYER;
			this.layer = layer;
			graphic = c;
			into = new Vector.<Light>();
			setHitbox(FP.screen.width, FP.screen.height);
		}
		
		/**
		 * We override this because we have to check collisions every frame.
		 */
		override public function update():void {
			this.x = FP.camera.x;
			this.y = FP.camera.y;
			collideInto(Config.TYPE_LIGHT, x, y, into);
		}
		
		/**
		 * Since we use a Canvas we have to change the way we render.
		 */
		override public function render():void {
			c.fill(new Rectangle(0, 0, FP.screen.width, FP.screen.height), color, alpha);
			for (var i:int = 0; i < into.length; i++) {
				var light:Light = into[i];
				c.drawGraphic(light.x - FP.camera.x, light.y - FP.camera.y, light.image);
			}
			into.splice(0,into.length);
			super.render();
		}
	}

}
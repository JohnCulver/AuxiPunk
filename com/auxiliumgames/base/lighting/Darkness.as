package com.auxiliumgames.base.lighting {
	import com.auxiliumgames.base.example.assets.tex.TEXTURES;
	import flash.display.BlendMode;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author hi
	 */
	public class Darkness extends Entity{
		
		private var c:Canvas;
		private var color:uint;
		private var alpha:Number;
		private var into:Vector.<Light>;
		
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
		
		override public function update():void {
			this.x = FP.camera.x;
			this.y = FP.camera.y;
			collideInto("light", x, y, into);
		}
		
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
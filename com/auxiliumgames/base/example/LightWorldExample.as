package com.auxiliumgames.base.example {
	import com.auxiliumgames.base.example.assets.tex.TEXTURES;
	import com.auxiliumgames.base.FullScreenColor;
	import com.auxiliumgames.base.lighting.Darkness;
	import com.auxiliumgames.base.lighting.Light;
	import flash.display.BlendMode;
	import flash.geom.Rectangle;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author jculver
	 */
	public class LightWorldExample extends World{
		private var darkness:Darkness;
		
		
		public function LightWorldExample() {
			darkness = new Darkness(0x000000, 1,5);
			add(darkness);
			
			var light1:Light = new Light(new Image(TEXTURES.LIGHT));
			light1.x = 100; 
			light1.y = 250;
			add(light1);
			FP.screen.color = 0xFFFFFF;
			FP.console.enable();
		}
		
		
		override public function update():void {
			if (Input.check(Key.LEFT))
				camera.x -= 1;
			else if (Input.check(Key.RIGHT))
				camera.x += 1;
			if (Input.check(Key.UP))
				camera.y -= 1;
			else if (Input.check(Key.DOWN))
				camera.y += 1;	
			super.update();
		}
		
	}

}
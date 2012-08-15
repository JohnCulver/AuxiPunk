package com.auxiliumgames.base.example {
	import com.auxiliumgames.base.example.assets.tex.TEXTURES;
	import com.auxiliumgames.base.Utils;
	import com.auxiliumgames.base.spawn.SpawnableEntity;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;




	public class SpawnExampleEntity extends SpawnableEntity{
		private var onComplete:Function;
		private var exploding:uint;

		public var image:Image = new Image(TEXTURES.DUDE,new Rectangle(0,0,32,32))

		public function SpawnExampleEntity() {
			graphic = image;
			setHitboxTo(image);
			type = "see";
			layer = 105;
		}

		override public function spawn(onComplete:Function, l:Point):void {
			this.onComplete = onComplete;
			exploding = 0;
			x = l.x;
			y = l.y;
		}
		
		override public function update():void {
			if (exploding > 0) {
				exploding--;
				if (exploding == 0){
					trace("Finished splode");
					onComplete();
				}
			}
			else{
				if (Input.mouseReleased) 
					if (collidePoint(x, y, Input.mouseX, Input.mouseY))
						onComplete();
			}
			
		}
		
		
		override public function forceComplete():void {
			trace("SPLODE");
			exploding = 30;
		}
	}
}

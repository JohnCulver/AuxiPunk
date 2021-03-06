package com.auxiliumgames.example.spawn {
	import com.auxiliumgames.example.assets.tex.TEXTURES;
	import com.auxiliumgames.base.Utils;
	import com.auxiliumgames.base.spawn.SpawnableEntity;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;




	/**
	 * An example entity to demonstrate a spawnable entity.
	 * @author jculver
	 */
	public class SpawnExampleEntity extends SpawnableEntity{
		private var onComplete:Function;
		//to represent an explosion that takes time before we clear the sprite
		private var exploding:uint;

		//the sprite for the spawnable
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
			/**
			 * we dont onComplete until the explosion is finished.
			 */
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
		
		/**
		 * here we start the explosion
		 */
		override public function forceComplete():void {
			trace("SPLODE");
			exploding = 30;
		}
	}
}

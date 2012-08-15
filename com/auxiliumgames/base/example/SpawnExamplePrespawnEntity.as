package com.auxiliumgames.base.example {
	import com.auxiliumgames.base.example.assets.tex.TEXTURES;
	import com.auxiliumgames.base.spawn.SpawnableEntity;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * A class to demonstrate how prespawning works.
	 * A prespawner could be like a glimmer before a coin spawns etc.
	 * @author hi
	 */
	public class SpawnExamplePrespawnEntity extends SpawnableEntity{
		private var onComplete:Function;
		private var image:Image;
		//how long to stay before we call onComplete
		private var lifeTime:Number;
		
		public function SpawnExamplePrespawnEntity(){
			image = new Image(TEXTURES.BLOCK);
			graphic = image;
		}
		
		override public function spawn(onComplete:Function, l:Point):void {
			this.onComplete = onComplete;
			x = l.x;
			y = l.y;
			lifeTime = 50;
		}
		
		override public function forceComplete():void {
			onComplete();
		}
		
		override public function update():void {
			if (lifeTime > 0) {
				lifeTime--;
				if (lifeTime == 0)
					onComplete();;
			}
		}
	}

}
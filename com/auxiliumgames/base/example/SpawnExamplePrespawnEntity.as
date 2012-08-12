package com.auxiliumgames.base.example {
	import com.auxiliumgames.base.example.assets.tex.TEXTURES;
	import com.auxiliumgames.base.spawn.ISpawn;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author hi
	 */
	public class SpawnExamplePrespawnEntity extends Entity implements ISpawn{
		private var onComplete:Function;
		private var image:Image;
		private var lifeTime:Number;
		
		public function SpawnExamplePrespawnEntity(){
			image = new Image(TEXTURES.BLOCK);
			graphic = image;
		}
		
		public function spawn(onComplete:Function, l:Point):void {
			this.onComplete = onComplete;
			x = l.x;
			y = l.y;
			lifeTime = 50;
		}
		
		public function forceComplete():void {
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
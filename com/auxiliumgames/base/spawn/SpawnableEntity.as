package com.auxiliumgames.base.spawn {
	import flash.geom.Point;
	import net.flashpunk.Entity;
	/**
	 * An entity that can be used with @see Spawner
	 * @author jculver
	 */
	public class SpawnableEntity extends Entity{
		
		public function SpawnableEntity() {
			
		}
		
		/**
		 * Override this, It will be called when the entity is spawned.
		 * @param	onComplete is the function the entity is expected to call when it becomes irrelevant
		 * @param	l is the location the entity is expected to spawn at
		 */
		public function spawn(onComplete:Function, l:Point):void {
			
		}
		
		/**
		 * When this is called the entity needs to do any cleanup it needs to do
		 * and then call onComplete
		 */
		public function forceComplete():void {

		}
		
	}

}
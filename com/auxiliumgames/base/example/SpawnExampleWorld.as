package com.auxiliumgames.base.example {
	import com.auxiliumgames.base.example.SpawnExampleEntity;
	import com.auxiliumgames.base.spawn.Spawner;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	import flash.geom.Point;

	import net.flashpunk.FP;

	import net.flashpunk.World;

	/**
	 * @author John Culver
	 */
	public class SpawnExampleWorld extends World {

		private var i:int = 0;
		private var spawner:Spawner;
		private var continuous:Boolean;
		private var exploding:Boolean;
		
		
		public function SpawnExampleWorld() {
			continuous = true; //change this to false for testing a set amount
			spawner = new Spawner(this,newSpawner,"see",100,newPreSpawner,10);
			FP.screen.color = 0xffffff;
			spawner.newWave(20, 5, continuous, locFunc);
			FP.console.enable();
		}

		private function locFunc(t:uint):Point { 
			i++; 
			if (i > 10) 
				i = 0; 
			return new Point(i * 50, i * 50);
		}
		
		private function newSpawner():SpawnExampleEntity{
			return new SpawnExampleEntity();
		}
		
		private function newPreSpawner():SpawnExamplePrespawnEntity {
			return new SpawnExamplePrespawnEntity();
		}
		
		override public function update():void {
			spawner.update();
			if (continuous) {
				if (exploding) {
					if (spawner.currentNumberSpawned == 0){
						spawner.newWave(20, 5, continuous, locFunc);
						exploding = false;
					}
				}
				else {
					if (Input.released(Key.ESCAPE)) {
						spawner.clearAll();
						exploding = true;
					}
				}
			}
			else {
				if (spawner.waveComplete) {
					spawner.newWave(20, 5, false, locFunc);
				}
			}
			
			super.update();
		}
	}
}

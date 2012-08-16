package com.auxiliumgames.base.example {
	import com.auxiliumgames.base.example.SpawnExampleEntity;
	import com.auxiliumgames.base.spawn.Spawner;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	import flash.geom.Point;

	import net.flashpunk.FP;

	import net.flashpunk.World;

	/**
	 * A class for demonstrating and testing the Spawner and related classes.
	 * @author jculver
	 */
	public class SpawnExampleWorld extends World {

		private var i:int = 0;
		private var spawner:Spawner;
		private var continuous:Boolean;
		private var exploding:Boolean;
		
		
		public function SpawnExampleWorld() {
			continuous = true; //change this to false for testing a set amount
			spawner = new Spawner(SpawnExampleEntity,SpawnExamplePrespawnEntity,10);
			FP.screen.color = 0xffffff;
			spawner.newWave(20, 5, continuous, locFunc);
			FP.console.enable();
		}

		//this is the function we will pass to the spawner
		//to determine the location of what it will spawn
		private function locFunc(t:uint):Point { 
			i++; 
			if (i > 10) 
				i = 0; 
			return new Point(i * 50, i * 50);
		}
		
		override public function update():void {
			spawner.update();
			//if we are doing continuous
			if (continuous) {
				//did we set off an explosion?
				if (exploding) {
					//cool is the wave over?
					if (spawner.currentNumberSpawned == 0) {
						//ok start a new one
						spawner.newWave(20, 5, continuous, locFunc);
						exploding = false;
					}
					//if not then we are still waiting for them to "explode"
				}
				//ok did they press the explode button?
				else {
					if (Input.released(Key.ESCAPE)) {
						spawner.clearAll();
						exploding = true;
					}
				}
			}
			//no continuous much simpler logic
			else {
				//is the wave complete?
				if (spawner.waveComplete) {
					//ok start a new one.
					spawner.newWave(20, 5, false, locFunc);
				}
			}
			
			super.update();
		}
	}
}

package com.auxiliumgames.base.spawn {
	import com.auxiliumgames.base.CappedObjectPool;
	import flash.geom.Point;
	import net.flashpunk.FP;

	import net.flashpunk.Entity;
	import net.flashpunk.World;

	/**
	 * A Spawner is useful for periodically adding entities to a world.
	 * For example, it could be used to periodically spawn more enemies.
	 * @author jculver
	 */
	public class Spawner{

		private var spawnClass:Class;				//this is the class we will spawn ( should extend SpawnableEntity)
		private var updatesBetweenSpawns:uint;		//the frequency of spawning
		private var getLocation:Function;			//the function called when we need to determine the next location
		private var preSpawnClass:Class;			//this should be a ? extends SpawnableEntity
		private var preSpawnUpdates:uint;			//the number of updates a prespawn will be created before a spawner
		
		private var updatesSinceLastSpawn:uint = 0; //updates since last spawn
		private var max:uint = 0;                   //max things we will spawn
		private var continuous:Boolean = false;     //should we keep spawning if some of our spawned things go away?
		private var currentlySpawned:uint = 0;      //how many are currently spawned
		private var numSpawnedThisWave:uint = 0;    //number spawned this wave

		private var nextLocation:Point;             //the next spawn location
		private var nextLocIndex:uint = 0;          //the index we will feed to getLocationm
		private var entityType:String;              //the type of the entity we will spawn
		private var clearing:Boolean;               //when this is true we are in process of ending the wave, and spawning is done for now

		/**
		 * Creates a new spawner:
		 * @param	spawnClass			the class of the thing we want to spawn. (this should extend SpawnableEntity)
		 * @param	preSpawnClass		the class of the thing we want to display before we spawn. (this should extend SpawnableEntity)
		 * @param	preSpawnerTime		the time the prespawner gets spawned before the spawner
		 */
		public function Spawner( spawnClass:Class, preSpawnClass:Class = null, preSpawnerTime:uint = 1) {
			this.spawnClass = spawnClass;
			this.preSpawnClass = preSpawnClass;
			this.preSpawnUpdates = preSpawnerTime;
		}


		/**
		 * To start the next wave
		 * @param	updatesBetween	the number of updates between each spawn
		 * @param	max				the number of things we will spawn this wave at the most
		 * @param	continuous		continuous means that the wave will not end and waveComplete will never return true
		 * @param	getLocation		the function used to determine the spawn locations (this function will get an int as a arameter indicating 
		 * 							the index of where we are at spawning this wave.
		 */
		public function newWave(updatesBetween:uint,max:uint,continuous:Boolean,getLocation:Function):void{
			this.max = max;
			this.continuous = continuous;
			this.updatesBetweenSpawns = updatesBetween;
			this.getLocation = getLocation;
			this.updatesSinceLastSpawn = 0;
			this.numSpawnedThisWave = 0;
			this.clearing = false;
		}



		/**
		 * Since spawner is not an entity this will need to be called
		 * during the worlds update loop.
		 */
		public function update():void{
			//do we need to do anything?
			if(spawningActive && !clearing){
				updatesSinceLastSpawn++;

				//do we have to deal with pre spawners?
				if(preSpawnClass != null){
					//is it time to spawn a new pre spawner?
					if(updatesSinceLastSpawn ==  (updatesBetweenSpawns - preSpawnUpdates) > 0 ? (updatesBetweenSpawns - preSpawnUpdates) : 0){
						nextLocation = getLocation(nextLocIndex++);
						var p:SpawnableEntity = FP.world.create(preSpawnClass) as SpawnableEntity;
						var f:Function = function():void {
							FP.world.recycle(p);
						};
						p.spawn(f, nextLocation);
					}
				}

				if (updatesSinceLastSpawn >=  updatesBetweenSpawns) {
					updatesSinceLastSpawn = 0;
					currentlySpawned++;
					numSpawnedThisWave++;
					var s:SpawnableEntity = FP.world.create(spawnClass)  as SpawnableEntity;
					if (entityType == null)
						entityType = s.type;
					var c:Function = function():void {
						FP.world.recycle(s);
						currentlySpawned--;
					};
					//if this is null then we will need to
					//update the next location here,
					//if it is not null then we should be able
					//to assume that the nextLocation was updated
					//when we spawned the last prespawner
					if(preSpawnClass == null)
						nextLocation = getLocation(nextLocIndex++);
					s.spawn(c, nextLocation);
				}
			}
		}

		/**
		 * Returns true if all the entities spawned this wave are no longer added to the world.
		 * Always returns false if in continuous mode.
		 */
		public function get waveComplete():Boolean{
			return !continuous && numSpawnedThisWave >= max && currentlySpawned == 0;
		}

		/**
		 * Determines if we should currently be spawning.
		 * Are we continuous and we dont currently have the max number out there?
		 * Or if it is not continuous have we not spawned the max for this wave?
		 */
		private function get spawningActive():Boolean {
			return continuous ?  currentlySpawned < max : numSpawnedThisWave < max;
		}

		/**
		 * Deisgned for use with continuous spawning. a wave is never complete, even when you clear all
		 * but if you are using continuous, you can use clearAll() and then start a newWave
		 * this is because if you are doing continuous then you have some other condition for when
		 * to change the wave info other than if everything is dead.
		 * 
		 * so the two ways to use spawner class are like this
		 * 
		 * in update loop (not continuous)
		 * if(spawner.waveComplete)
		 *     spawner.newWave(... your values here)
		 * 
		 * in update loop (continuous)
		 * if(your specific condition){
		 *     spawner.clearAll();
		 *     spawner.newWave(... whatever);
		 * }
		 * 
		 */
		public function clearAll():void {
			if (entityType) {
				var ents:Vector.<Entity> = new Vector.<Entity>();
				FP.world.getType(entityType, ents);
				clearing = true;
				for (var i:int = 0; i < ents.length; i++) {
					var s:SpawnableEntity = ents[i] as SpawnableEntity;
					s.forceComplete();
				}
			}
		}
		
		/**
		 * Returns the number of spawns that are currently added to the world.
		 */
		public function get currentNumberSpawned():int {
			return currentlySpawned;
		}
		
	}
}

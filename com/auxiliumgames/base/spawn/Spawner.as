/**
 * Created with IntelliJ IDEA.
 * User: jculver
 * Date: 7/5/12
 * Time: 4:34 PM
 * To change this template use File | Settings | File Templates.
 */
package com.auxiliumgames.base.spawn {
import com.auxiliumgames.base.CappedObjectPool;
import flash.geom.Point;

import net.flashpunk.Entity;
import net.flashpunk.World;

public class Spawner{

    //TODO be able to force clear all

    private var createNew:Function;
    private var updatesBetweenSpawns:uint;
    private var getLocation:Function;
    private var createNewPreSpawner:Function;
    private var preSpawnUpdates:uint;
    private var prePool:CappedObjectPool;
    private var pool:CappedObjectPool;


    private var updatesSinceLastSpawn:uint = 0; //updates since last spawn
    private var max:uint = 0;                   //max things we will spawn
    private var continuous:Boolean = false;     //should we keep spawning if some of out spawned things die?
    private var currentlySpawned:uint = 0;      //how many are currently spawned
    private var numSpawnedThisWave:uint = 0;    //number spawned this wave

    private var nextLocation:Point;             //the next spawn location
    private var nextLocIndex:uint = 0;          //the index we will feed to getLocation
	private var world:World;
	private var entityType:String;
	private var clearing:Boolean;

    public function Spawner(world:World,createNew:Function,entityType:String, poolSize:uint = 100, createNewPreSpawner:Function = null,preSpawnerTime:uint = 1) {
        this.entityType = entityType;
		this.world = world;
		this.createNew = createNew;
        this.createNewPreSpawner = createNewPreSpawner;
        this.preSpawnUpdates = preSpawnerTime;

        pool = new CappedObjectPool(createNew, null, poolSize, poolSize * 2);
        if(createNewPreSpawner != null)
            prePool = new CappedObjectPool(createNewPreSpawner, null, poolSize, poolSize * 2);
    }


    public function newWave(updatesBetween:uint,max:uint,continuous:Boolean,getLocation:Function):void{
        this.max = max;
        this.continuous = continuous;
		this.updatesBetweenSpawns = updatesBetween;
		this.getLocation = getLocation;
        updatesSinceLastSpawn = 0;
        numSpawnedThisWave = 0;
		clearing = false;
    }



    public function update():void{
        //do we need to do anything?
        if(spawningActive && !clearing){
            updatesSinceLastSpawn++;

            //do we have to deal with pre spawners?
            if(createNewPreSpawner != null){
                //is it time to spawn a new pre spawner?
                if(updatesSinceLastSpawn ==  (updatesBetweenSpawns - preSpawnUpdates)){
                    nextLocation = getLocation(nextLocIndex++);
                    var p:ISpawn = prePool.checkOut();
                    var f:Function = function():void {
                        world.remove(p as Entity);
                        prePool.checkIn(p);
                    };

                    p.spawn(f, nextLocation);
                    world.add(p as Entity);
                }
            }

            if (updatesSinceLastSpawn >=  updatesBetweenSpawns) {
                updatesSinceLastSpawn = 0;
                currentlySpawned++;
                numSpawnedThisWave++;
                var s:ISpawn = pool.checkOut();
				var e:Entity = s as Entity;
                var c:Function = function():void {
                    world.remove(e);
                    pool.checkIn(s);
                    currentlySpawned--;
                };
                //if this is null then we will need to
                //update the next location here,
                //if it is not null then we should be able
                //to assume that the nextLocation was updated
                //when we spawned the last prespawner
                if(createNewPreSpawner == null)
                    nextLocation = getLocation(nextLocIndex++);
                world.add(s as Entity);
                s.spawn(c, nextLocation);
            }
        }
    }

    public function get waveComplete():Boolean{
        return !continuous && numSpawnedThisWave >= max && currentlySpawned == 0;
    }

    /**
     *  are we continuous and we dont currently have the max number out there?
     *  or if it is not continuous have we not spawned the max for this wave?
     */
    private function get spawningActive():Boolean {
        return continuous ?  currentlySpawned < max : numSpawnedThisWave < max;
    }

	/**
	 * deisgned for use with continuous spawning. a wave is never complete, even when you clear all
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
		var ents:Vector.<Entity> = new Vector.<Entity>();
		world.getType(entityType, ents);
		clearing = true;
		for (var i:int = 0; i < ents.length; i++) {
			var s:ISpawn = ents[i] as ISpawn;
			s.forceComplete();
		}
	}
	
	public function get currentNumberSpawned():int {
		return currentlySpawned;
	}
	
}
}

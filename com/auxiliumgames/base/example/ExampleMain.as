package com.auxiliumgames.base.example{
import com.auxiliumgames.base.example.platformer.PlatformerLevelTestWorld;
import com.auxiliumgames.base.example.shmup.BulletHelperTestWorld;
import com.auxiliumgames.base.example.shmup.ShmupTestWorld;
import com.auxiliumgames.base.Globals;
import flash.events.Event;
import net.flashpunk.Engine;
import net.flashpunk.FP;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

/**
	 * ...
	 * @author jculver
	 */
	[Frame(factoryClass="com.auxiliumgames.base.Preloader")]
    [SWF(width="900", height="900")]
	public class ExampleMain extends Engine {

		public function ExampleMain():void {
			var width:int = Globals.SCREENWIDTH;
			var height:int = Globals.SCREENHEIGHT;
			super(width, height, 30, false);
			if (stage) go();
			else addEventListener(Event.ADDED_TO_STAGE, go);
		}

		private function go(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//FP.world = new ShmupTestWorld();
			//FP.world = new PlatformerLevelTestWorld();
			//FP.world = new BulletHelperTestWorld();
          //FP.world = new SpawnExampleWorld();
            //FP.world = new PartitionExampleWorld();
			//FP.world = new LightWorldExample();
			//FP.world =  new DialogExampleWorld();
			//FP.world = new BarTestWorld();
		}

//        override public function focusGained():void{
//            paused = false;
//        }
//
//        override public function focusLost():void{
//            paused = true;
//        }


        override public function update():void{
            super.update();
            if(Input.released(Key.P)){
                FP.world.active = !FP.world.active;
            }
        }


	}

}
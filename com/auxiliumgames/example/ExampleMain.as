package com.auxiliumgames.example{
import com.auxiliumgames.example.display.BarTestWorld;
import com.auxiliumgames.example.display.DialogExampleWorld;
import com.auxiliumgames.example.display.FullScreenColorTestWorld;
import com.auxiliumgames.example.lighting.LightWorldExample;
import com.auxiliumgames.example.platformer.PlatformerLevelTestWorld;
import com.auxiliumgames.example.screen.PartitionExampleWorld;
import com.auxiliumgames.example.screen.ScreenShakeTestWorld;
import com.auxiliumgames.example.shmup.BulletPatternManagerTestWorld;
import com.auxiliumgames.example.shmup.ShmupTestWorld;
import com.auxiliumgames.base.Utils;
import com.auxiliumgames.example.spawn.SpawnExampleWorld;
import flash.events.Event;
import net.flashpunk.Engine;
import net.flashpunk.FP;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

	/**
	 * A class used to run the various demo/test worlds.
	 * Un-comment the desired test world in the go method.
	 * @author jculver
	 */
    [SWF(width="900", height="900")]
	public class ExampleMain extends Engine {

		public function ExampleMain():void {
			super(800, 800, 30, false);
			go();
		}

		private function go(e:Event = null):void {
			//FP.world = new ShmupTestWorld();
			//FP.world = new PlatformerLevelTestWorld();
			//FP.world = new BulletPatternManagerTestWorld();
			//FP.world = new SpawnExampleWorld();
            //FP.world = new PartitionExampleWorld();
			//FP.world = new LightWorldExample();
			//FP.world =  new DialogExampleWorld();
			//FP.world = new BarTestWorld();
			//FP.world = new ScreenShakeTestWorld();
			FP.world = new FullScreenColorTestWorld();
		}

        override public function update():void{
            super.update();
            if(Input.released(Key.P)){
                FP.world.active = !FP.world.active;
            }
        }


	}

}
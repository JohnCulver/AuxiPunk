package com.auxiliumgames.example.screen {
	
	import com.auxiliumgames.base.screen.Partition;

	import flash.geom.Point;

	import net.flashpunk.FP;
	import net.flashpunk.World;

	/**
	 * A class for demonstrating and testing the Partition class.
	 * 
	 * Press the tilde to turn on the console and see the grid surrounding.
	 * @author jculver
	 */
	public class PartitionExampleWorld extends World{

		private var i:int = 0;

		public function PartitionExampleWorld() {
			FP.screen.color = 0x000088;
			FP.console.enable();
			var p:Partition = new Partition();
			p.setValues(50,50,50);

			for (var j:int = 0; j < 3; j++) {
				for (var k:int = 0; k < 3; k++) {
					var t:PartitionExampleEntity = newP();
					p.setXYForRowCol(t,j, k, true);
					add(t);
				}
			}

			add(new PartitionGrid());

		}

		private function newP():PartitionExampleEntity{
			var pee:PartitionExampleEntity =  new PartitionExampleEntity();
			pee.centerOrigin();
			pee.image.centerOrigin();
			return pee;
		}
	}
}

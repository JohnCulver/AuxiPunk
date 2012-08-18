package com.auxiliumgames.example.fx {
	import net.flashpunk.World;
	/**
	 * A world for demoing/testing the trail effect of TrailGenerator.
	 * @author jculver
	 */
	public class TrailTestWorld extends World{
		
		public function TrailTestWorld() {
			var ttg:TrailTestGuy = new TrailTestGuy();
			add(ttg);
		}
		
	}

}
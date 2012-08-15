package com.auxiliumgames.base.example.shmup {
	import net.flashpunk.FP;
	import net.flashpunk.World;
	/**
	 * A world for testing and demonstrating the basics of what
	 * AuxiPunk can provide for building a shmup
	 * @author jculver
	 */
	public class ShmupTestWorld extends World{
		private var dude:ShmupDude;
		
		public function ShmupTestWorld() {
			FP.screen.color = 0xFFFFFF;
			dude = new ShmupDude();
			dude.x = 40;
			dude.y = 200;
			add(dude);
		}
		
	}

}
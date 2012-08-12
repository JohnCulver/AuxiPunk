package com.auxiliumgames.base.example.platformer {
	import com.auxiliumgames.base.example.Tiles;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author jculver
	 */
	public class PlatFormerTestWorld extends World{
		private var dude:PlatDude;
		
		public function PlatFormerTestWorld() {
			FP.screen.color = 0x555555;
			dude = new PlatDude();
			dude.x = 40;
			dude.y = 200;
			add(dude);
			FP.console.enable();
			add(new Tiles());
			add(new Platform());
		}
		
	}

}
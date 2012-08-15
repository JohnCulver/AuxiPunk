package com.auxiliumgames.base.example {
	import com.auxiliumgames.base.Bar;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author hi
	 */
	public class BarTestWorld extends World{
		private var updates:uint = 0;
		private var b:Bar;
		
		public function BarTestWorld() {
			FP.screen.color = 0xFFFFFF;
			b = new Bar(0xFF0000, 0xFF00FF, 200, 40, true, 0x0000FF, 2, 0x000000);
			add(b);
			b.amount = 0;
			b.x = 100;
			b.y = 100;
		}
		
		override public function update():void {
			updates++;
			if (updates % 2 == 0)
				if (b.amount < 100) 
					b.amount += 1;
			super.update();
		}
		
	}

}
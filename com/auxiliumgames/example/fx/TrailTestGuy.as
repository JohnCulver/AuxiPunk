package com.auxiliumgames.example.fx {
	import com.auxiliumgames.base.fx.TrailGenerator;
	import com.auxiliumgames.base.shmup.ShmupInput;
	import com.auxiliumgames.base.shmup.ShmupPositionManager;
	import com.auxiliumgames.example.assets.tex.TEXTURES;
	import com.auxiliumgames.example.shmup.ShmupKeyboardInput;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * A shmup guy controlled by the keyboard for demoing/testing
	 * TrailGenerator.
	 * @author jculver
	 */
	public class TrailTestGuy extends Entity{
		
		//the sprite for the player
		private var image:Spritemap = new Spritemap(TEXTURES.DUDE, 36, 36);
		//the keyboard input
		private var input:ShmupInput;
		//the position manager
		private var posMan:ShmupPositionManager;
		private var tg:TrailGenerator;
		
		public function TrailTestGuy() {
			graphic = image;
            image.add("rest", [0]);
            image.add("move", [1]);
			image.play("rest");
			
			centerOrigin();
			image.centerOrigin();
			
            x = 200;
            y = 200;
			//to manage the position based on the input
			posMan = new ShmupPositionManager();
			//ketboard input
			input = new ShmupKeyboardInput();
			//configure the position manager
			posMan.setBaseVelocity(5);
			posMan.setCricularVelocity(true);
			posMan.setFocusVelocity(3);
			
			tg = new TrailGenerator();
			tg.init(image, 0xFFFFFF, 1, 1, .02, 100, -16, -16);
		}
		

		override public function update():void {
			//update position based on input
			posMan.updatePosition(this, input);
			//change the animation if necessary and add trails :D
			updateAnimation();
		}
		
		//change animation and update our trailer
		private function updateAnimation():void {
            if(input.pressingDown() || input.pressingLeft() || input.pressingRight() || input.pressingUp()){
                image.play("move");
				tg.trail(x, y);
			}
            else
                image.play("rest");
		}
		
		
	}

}
package com.auxiliumgames.base.screen {
	import net.flashpunk.FP;
	/**
	 * A utility for shaking the screen. This is cool for like
	 * explosions, of to add emphasis to things like that.
	 * @author jculver
	 */
	public class ScreenShaker {
		
		
		/**
		 * How quickly the x wave amplitude gets smaller
		 */
		public static var xShrinkRate:Number = 1;
		/**
		 * How quickly the y wave amplitude gets smaller
		 */
		public static var yShrinkRate:Number = 1;
		/**
		 * The power of the x wave.
		 */
		public static var currentXPower:Number = 0;
		/**
		 * The power of the y wave
		 */
		public static var currentYPower:Number = 0;
		/**
		 * How quickly we move through the shake wave
		 */
		public static var xRate:Number = 1;
		/**
		 * How quickly we move through the y shake wave
		 */
		public static var yRate:Number = 1;
		
		/**
		 * The max power we allow on the y axis.
		 */
		public static var maxYPower:Number = 100;
		/**
		 * The max power we allow on the x axis.
		 */
		public static var maxXPower:Number = 20;
		
		//internal vars for tracking the camera shake offsets
		private static var xOffset:Number = 0;
		private static var yOffset:Number = 0;
		private static var xOsc:Number = 0;
		private static var xSin:Number = 0;
		private static var yOsc:Number = 0;
		private static var ySin:Number = 0;
		
		//calculate the camera offsets
		static private function calcShake():void {
			//calc the offsets
			xSin = Math.sin(xOsc);
			ySin = Math.sin(yOsc);
			
			currentXPower = Math.min(currentXPower, maxXPower);
			currentYPower = Math.min(currentYPower, maxYPower);
			xOffset = xSin * currentXPower;
			yOffset = ySin * currentYPower;
			//prep the values for the next calc
			xOsc += (180 / Math.PI) * xRate;
			yOsc += (180 / Math.PI) * yRate;
			currentXPower = Math.max(currentXPower - xShrinkRate,0);
			currentYPower = Math.max(currentYPower - yShrinkRate,0);
		}
		
		public static function applyShake():void {
			calcShake();
			FP.camera.x += xOffset;
			FP.camera.y += yOffset;
		}
		
	}

}
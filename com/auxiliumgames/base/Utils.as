package com.auxiliumgames.base {
	/**
	 * Generic Helper functions that are not found in the 
	 * big FP class can go here.
	 * @author jculver
	 */
	public class Utils {
				
		public function Utils() {
			
		}
		
		/**
		 * One radian worth of degrees.
		 */
		public static const RAD:Number = .0174532925; //one radian worth of degrees
		
		/**
		 * Converts degrees into radians. This is useful because a lot
		 * of AS3 math functions take radians, and it's easier for some 
		 * people to thing in degrees.
		 * 
		 * @param	degrees		The amount of degrees to convert into radians.
		 * 
		 * @return	the radian value.
		 */
		public static function degreesToRadians(degrees:Number) : Number{
			return degrees * Math.PI / 180;
		}
		
	}

}
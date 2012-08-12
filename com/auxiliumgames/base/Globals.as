package com.auxiliumgames.base {
	/**
	 * ...
	 * @author jculver
	 */
	public class Globals {
		
		//World variables
		public static const UNIT:uint = 8;
		public static const ROWS:uint = 100;
		public static const COLUMNS:uint = 100;
		public static const SCREENWIDTH:uint = 800;
		public static const SCREENHEIGHT:uint = 800;
		
		//layers
		public static const LAYER_WALL:uint = 100;
		static public const LAYER_BULLET:uint = 50;

        //TILE/Object Layers
        static public const OLAYER_OBJECTS:uint = 1;
        static public const OLAYER_ONE_WAY:uint = 0;
        static public const TLAYER_TILES:uint = 1;
        static public const TLAYER_WALL:uint = 0;

		//colors
		
		//states
		public static const STATE:String = STATE_PLAY;
		public static const STATE_PLAY:String = "PLAY";
		
		//Performance/etc
		public static const ETC_ESTIMATED_MAX_BULLETS:uint = 200;
		
		public function Globals() {
			
		}
		
		public static function degreesToRadians(degrees:Number) : Number{
			return degrees * Math.PI / 180;
		}
		
	}

}
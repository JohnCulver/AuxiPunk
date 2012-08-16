package com.auxiliumgames.base {
	/**
	 * Settings that will need to be configurable for each game.
	 * 
	 * Each game using Auxipunk will probably have some different values here.
	 * @author jculver
	 */
	public class Config {
		
		//Platformer "Physics" lol
		/**
		 * The vertical force applied each frame to airborn Entities managed 
		 * by a PlatformPositionManager.
		 */
		public static const GRAVITY:Number = .8;
		/**
		 * The horizontal force multiplied into airborn Entities.x value each frame 
		 * (when the Entity is managed by a PlatformPositionManager.)
		 */
		public static const AIRRESISTANCE:Number = .5;
		/**
		 * The horizontal force multiplied into grounded Entities.x value each frame 
		 * (when the Entity is managed by a PlatformPositionManager.)
		 */
		public static const FLOORFRICTION:Number = .8;
		/**
		 * The vertical force multiplied into Entities.y value each frame when against a wall
		 * (when the Entity is managed by a PlatformPositionManager.)
		 */
		public static const WALLFRICTION:Number = 1;
		/**
		 * When applying the physical type force numbers to an entity,
		 * sometimes numbers get very small. This is the smallest number we
		 * intend to deal with. Anything with absolute value smaller than this will be considered zero when
		 * applying forces like friction and air resistance.
		 */
		public static const CLOSENOUGHTOZERO:Number = .05;
		
		//types
		/**
		 * The type used for walls.
		 */
		public static const TYPE_WALL:String = "wall";
		/**
		 * The type used for oneway platforms.
		 */
		public static const TYPE_ONEWAYPLATFORM:String = "onewayplatform";
		/**
		 * The type used for lights.
		 */
		public static const TYPE_LIGHT:String = "light";
		
		
	}

}
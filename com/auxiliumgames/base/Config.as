package com.auxiliumgames.base {
	/**
	 * Settings that will need to be configurable for each game.
	 * 
	 * Each game using Auxipunk will probably have different values here.
	 * @author jculver
	 */
	public class Config {
		
		//performance
		/**
		 * The amount of bullets you expect to see on screen, at most.
		 * This is an estimate, it doesn't have to be exact, it isn't a limit, but
		 * the closer the estimate, the better the performance will be.
		 * Set this to 0 if not using Bullets at all.
		 */
		public static const ESTIMATED_MAX_BULLETS_ONSCREEN:uint = 200;
		
		
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
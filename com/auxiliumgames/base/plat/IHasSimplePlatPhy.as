package com.auxiliumgames.base.plat {
	import flash.geom.Point;
	/**
	 * ...
	 * @author jculver
	 */
	public interface IHasSimplePlatPhy {
		/**
		 * velocity
		 */
		function get v():Point;
		/**
		 * the amount of movement acceleration
		 */
		function get moveAccel():Point;
		/**
		 * max speed an entity can acheive by moving
		 */
		function get maxMoveSpeed():Point;
		/**
		 * max move speed an entity should acheive in any situation
		 */
		function get maxSpeed():Point;
	}

}
package com.auxiliumgames.base.platformer{
	import flash.geom.Point;
	/**
	 * This interface allows a class to easily apply forces,
	 * by using SimplePlatUtil
	 * @author jculver
	 */
	public interface ICanPlatForce {
		/**
		 * base movement velocity
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
	}

}
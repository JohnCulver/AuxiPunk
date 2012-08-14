package com.auxiliumgames.base.plat {
	/**
	 * Used to get the current input for an entity in a platformers.
	 * 
	 * @author jculver
	 */
	public interface PlatformerInput {
		/**
		 * Should return true if the platformer entity wants to move right.
		 */
		function pressingRight():Boolean;
		/**
		 * Should return true if the platformer entity wants to move left.
		 */
		function pressingLeft():Boolean;
		/**
		 * Should return true if the platformer entity wants to jump.
		 */
		function pressedJump():Boolean;
		/**
		 * Should return true if the platformer entity is holding jump.
		 */
		function holdingJump():Boolean;
		
	}

}
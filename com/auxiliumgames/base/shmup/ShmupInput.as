package com.auxiliumgames.base.shmup {
	
	/**
	 * Used to get the current input for an entity in a shmup.
	 * 
	 * @author jculver
	 */
	public interface ShmupInput {
		
		/**
		 * Should return true if the shmup entity wants to move right.
		 */
		function pressingRight():Boolean;
		/**
		 * Should return true if the shmup entity wants to move left.
		 */
		function pressingLeft():Boolean;
		/**
		 * Should return true if the shmup entity wants to move up.
		 */
		function pressingUp():Boolean;
		/**
		 * Should return true if the shmup entity wants to move down.
		 */
		function pressingDown():Boolean;
		/**
		 * Should return true if the shmup is in a state where they should move at the focus velocity.
		 */
        function isFocused():Boolean;
		
	}
	
}
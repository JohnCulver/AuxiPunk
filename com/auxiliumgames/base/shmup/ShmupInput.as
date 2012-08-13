package com.auxiliumgames.base.shmup {
	
	/**
	 * ...
	 * @author hi
	 */
	public interface ShmupInput {
		
		function pressingRight():Boolean;
		function pressingLeft():Boolean;
		function pressingUp():Boolean;
		function pressingDown():Boolean;
        function isFocused():Boolean;
		
	}
	
}
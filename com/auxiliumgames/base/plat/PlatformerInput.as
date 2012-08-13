package com.auxiliumgames.base.plat {
	/**
	 * ...
	 * @author hi
	 */
	public interface PlatformerInput {
		
		function pressingRight():Boolean;
		function pressingLeft():Boolean;
		function pressedJump():Boolean;
		function holdingJump():Boolean;
		
	}

}
package com.auxiliumgames.base {
	/**
	 * A class for keeping Entity Layers all in one place,
	 * so they can be easily managed.
	 * @author jculver
	 */
	public class Layers {
		
		/**
		 * Using this class is not necessary to manage layers.
		 * However, it is a very easy way to manage the entity layers in a project.
		 * The largest advantage is being able to see all your layers in one place
		 * so that the z-index of every entity will be obvious.
		 * 
		 * Here is an example:
		 *
		 * public static const WALL:int = 1000;
		 * public static const PLAYER:int = 750;
		 * public static const BULLET:int = 500;
		 * 
		 * this would put walls behind, players and bullets,
		 * and it would keep bullets in front of players.
		 * 
		 * Then all we have to do, is use these layers in the corresponding entities like this:
		 *	  
		 * layer = Layers.WALL;
		 * 
		 * and etc.
		 * 
		 * As long as we keep the list in one place it is easy enough to move things around, 
		 * and put things inbetween the corresponding layers if we need to.
		 *  
		 */
		
		
	}

}
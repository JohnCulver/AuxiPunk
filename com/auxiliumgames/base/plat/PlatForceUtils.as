package com.auxiliumgames.base.plat {
	import com.auxiliumgames.base.Config;
	import com.auxiliumgames.base.Utils;
	import flash.geom.Point;
	/**
	 * Utility class to apply generic forces to an ICanPlatForce.
	 * @author jculver
	 */
	public class PlatForceUtils {
		
		
		public function PlatForceUtils() {
			
		}
		
		/**
		 * Applies the specific "force" gravity to an ICPF's vertail velocity
		 * 
		 * @param	phy 	The object to apply the force to.
		 */
		public static function applyGravity(phy:ICanPlatForce):void {
			phy.v.y += Config.GRAVITY;
		}
		
		/**
		 * 
		 * Applies floor friction, or wall friction depending on the floor param
		 * 
		 * @param	phy		The object we apply the force to.
		 * @param	floor	If the type of friction we want is floor apposed to wall.
		 */
		public static function applyFriction(phy:ICanPlatForce,floor:Boolean = true):void {
			if(floor)
				phy.v.x *= Config.FLOORFRICTION;
			else
				phy.v.y *= Config.WALLFRICTION;
				
		}
		
		/**
		 * This applies the ICPF's movement acceleration to it's horizontal access.
		 * The acceleration is based on the movement direction which is the second parameter.
		 * 
		 * @param	phy		The object to apply it to.
		 * @param	right	If the force is to the right, if false then to the left.
		 */
		public static function applyHMoveAccel(phy:ICanPlatForce,right:Boolean = true):void {
			//check if we are changing directions
			if (phy.v.x < 0 && right) {
				phy.v.x = phy.moveAccel.x;
				return;
			}
			if (phy.v.x > 0 && !right) {
				phy.v.x = phy.moveAccel.x * -1;
				return;
			}
			//otherwise
			//if we are already over the max movespeed bail
			if (Math.abs(phy.v.x) > phy.maxMoveSpeed.x)
				return;
			
			
			//calc the amount
			var amount:Number = right ? phy.moveAccel.x : phy.moveAccel.x * -1;
			phy.v.x += amount;
			
			phy.v.x = Math.min(phy.v.x, phy.maxMoveSpeed.x);
		}
		
		/**
		 * When applying the physical type force numbers to an entity,
		 * sometimes numbers get very small. This function will reduce the velocity.x and y to 0 
		 * if either one's absolute value is smaller than Config.CLOSENOUGHTOZERO.
		 * 
		 * 
		 * @param	phy		The number whose velocity we want to check.
		 */
		public static function zeroOutSmallNumbers(phy:ICanPlatForce):void {
			if (Math.abs(phy.v.x) < Config.CLOSENOUGHTOZERO)
				phy.v.x = 0;
			if (Math.abs(phy.v.y) < Config.CLOSENOUGHTOZERO)
				phy.v.y = 0;	
		}
		
		
		/**
		 * Applies Config.AIRRESISTANCE to the phy.v.x
		 * @param	phy		The ICPF we want to apply the air resistance to.
		 */
		public static function applyAirResistance(phy:ICanPlatForce):void {
			phy.v.x *= Config.AIRRESISTANCE;
		}
		
		/**
		 * A utility function for applying forces not covered elsewhere.
		 * This could be useful for when an entity gets bumped by something or jumps etc.
		 * 
		 * @param	phy		The ICPF to apply the force to
		 * @param	force	The force to apply.
		 */
		public static function applyGenericAdditiveForce(phy:ICanPlatForce, force:Point):void {
			phy.v.x += force.x;
			phy.v.y += force.y;
		}
		
		/**
		 * A utility function for applying forces not covered elsewhere.
		 * This could be useful for things similar to friction and air resistance,
		 * like if there is water for entities to swim in.
		 * 
		 * @param	phy		The ICPF to apply the force to
		 * @param	force	The force to apply.
		 */
		public static function applyGenericMultiplicitaveForce(phy:ICanPlatForce, force:Point):void {
			phy.v.x *= force.x;
			phy.v.y *= force.y;
		}
		
	}

}
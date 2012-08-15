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
		
		public static function applyGravity(phy:ICanPlatForce):void {
			phy.v.y += Config.GRAVITY;
		}
		
		public static function applyFriction(phy:ICanPlatForce,floor:Boolean = true):void {
			if(floor)
				phy.v.x *= Config.FLOORFRICTION;
			else
				phy.v.y *= Config.WALLFRICTION;
				
		}
		
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
		
		public static function applyVMoveAccel(phy:ICanPlatForce,down:Boolean = true):void {
			//check if we are changing directions
			if (phy.v.y < 0 && down) {
				phy.v.y = phy.moveAccel.y;
				return;
			}
			if (phy.v.y > 0 && !down) {
				phy.v.y = phy.moveAccel.y * -1;
				return;
			}
			//otherwise
			//if we are already over the max movespeed bail
			if (Math.abs(phy.v.y) > phy.maxMoveSpeed.y)
				return;
			
			
			//calc the amount
			var amount:Number = down ? phy.moveAccel.y : phy.moveAccel.y * -1;
			phy.v.y += amount;
			
			phy.v.y = Math.min(phy.v.y, phy.maxMoveSpeed.y);
		}
		
		public static function applyGenericAdditiveForce(phy:ICanPlatForce, force:Point):void {
			phy.v.x += force.x;
			phy.v.y += force.y;
		}
		
		public static function applyGenericMultiplicitaveForce(phy:ICanPlatForce, force:Point):void {
			phy.v.x *= force.x;
			phy.v.y *= force.y;
		}
		
		public static function zeroOutSmallNumbers(phy:ICanPlatForce):void {
			if (Math.abs(phy.v.x) < Config.CLOSENOUGHTOZERO)
				phy.v.x = 0;
			if (Math.abs(phy.v.y) < Config.CLOSENOUGHTOZERO)
				phy.v.y = 0;	
		}
		
		static public function applyAirResistance(phy:ICanPlatForce):void {
			phy.v.x *= Config.AIRRESISTANCE;
		}
		
	}

}
package com.auxiliumgames.base.plat {
	import com.auxiliumgames.base.Globals;
	import flash.geom.Point;
	/**
	 * ...
	 * @author jculver
	 */
	public class SimplePlatUtils {
		
		//"Physics" lol
		//gravity, (additive)
		public static const GRAVITY:Number = .8;
		//should be < 1 (mult)
		public static const AIRRESISTANCE:Number = .5;
		//should be < 1 (mult)
		public static const FLOORFRICTION:Number = .8;
		//should be < 1 (mult)
		public static const WALLFRICTION:Number = 1;
		//close enough to zero that we can consider it 0
		public static const CLOSENOUGHTOZERO:Number = .05;
		//what is the type to check against for walls?
		public static const WALL:String = "wall";
		//what is the type to check against for one wat platforms?
		public static const ONEWAYPLATFORM:String = "onewayplatform";
		
		
		
		public function SimplePlatUtils() {
			
		}
		
		public static function applyGravity(phy:IHasSimplePlatPhy):void {
			phy.v.y += GRAVITY;
		}
		
		public static function applyFriction(phy:IHasSimplePlatPhy,floor:Boolean = true):void {
			if(floor)
				phy.v.x *= FLOORFRICTION;
			else
				phy.v.y *= WALLFRICTION;
				
		}
		
		public static function applyHMoveAccel(phy:IHasSimplePlatPhy,right:Boolean = true):void {
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
		
		public static function applyVMoveAccel(phy:IHasSimplePlatPhy,down:Boolean = true):void {
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
		
		public static function applyGenericAdditiveForce(phy:IHasSimplePlatPhy, force:Point):void {
			phy.v.x += force.x;
			phy.v.y += force.y;
		}
		
		public static function applyGenericMultiplicitaveForce(phy:IHasSimplePlatPhy, force:Point):void {
			phy.v.x *= force.x;
			phy.v.y *= force.y;
		}
		
		public static function zeroOutSmallNumbers(phy:IHasSimplePlatPhy):void {
			if (Math.abs(phy.v.x) < CLOSENOUGHTOZERO)
				phy.v.x = 0;
			if (Math.abs(phy.v.y) < CLOSENOUGHTOZERO)
				phy.v.y = 0;	
		}
		
		static public function applyAirResistance(phy:IHasSimplePlatPhy):void {
			phy.v.x *= AIRRESISTANCE;
		}
		
	}

}
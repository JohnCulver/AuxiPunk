package com.auxiliumgames.base.plat {
	import com.auxiliumgames.base.Config;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author hi
	 */
	public class PlatformerPositionManger implements ICanPlatForce {
		
		private const jumpV:Point = new Point(0, 3);
		private var airJumps:uint = 0;
		private var canAirJumpWhileFalling:Boolean = false;
		private var airJumpsSinceJump:uint = 0;
		private var jumpOomf:Point = new Point(0, 0);
		
		private const _moveAccel:Point = new Point(.2, 0);
		private const _maxMoveSpeed:Point = new Point(4, 4);
		private const _maxSpeed:Point = new Point(10, 10);
		private const _v:Point = new Point(0, 0);
		
		private const previousPosition:Point = new Point(0, 0);
		private const previousVelocity:Point = new Point(0, 0);
		
		private var currentlyGrounded:Boolean;
		private var currentlyAgainstWall:Boolean;
		private var isJumping:Boolean;
		
		public function PlatformerPositionManger() {
			
		}
		
		public function updatePosition(e:Entity, input:PlatformerInput):void {
			previousPosition.x = e.x;
			previousPosition.y = e.y;
			previousVelocity.x = _v.x;
			previousVelocity.y = _v.y;
			calcVelocity(input);
			applyVelocity(e);
		}
		
		private function calcVelocity(input:PlatformerInput):void {
			
			var left:Boolean = input.pressingLeft();
			var right:Boolean = input.pressingRight();
			var jump:Boolean = input.pressedJump();
			var wall:Boolean = currentlyAgainstWall;
			
			//process environment
			PlatForceUtils.applyGravity(this);
			if (!currentlyGrounded){
				PlatForceUtils.applyAirResistance(this);
			}
			else {
				PlatForceUtils.applyFriction(this);
				airJumpsSinceJump = 0;
				isJumping = false;
			}
			
			if (wall) 
				PlatForceUtils.applyFriction(this, false);
			
			//process input
			if (jump) {
				if(currentlyGrounded){
					PlatForceUtils.applyGenericAdditiveForce(this, jumpV);
					isJumping = true;
				}
				else {
					if ((isJumping || canAirJumpWhileFalling) && airJumps > 0 && airJumpsSinceJump < airJumps){
						_v.y = 0; //remove gravity
						PlatForceUtils.applyGenericAdditiveForce(this, jumpV);
						airJumpsSinceJump++;
					}
					
				}
			}
			
			//should we apply oomf?
			if (!currentlyGrounded && isJumping && input.holdingJump() && _v.y < 0 && jumpOomf.y < 0) {
				PlatForceUtils.applyGenericAdditiveForce(this, jumpOomf);
			}	
			
			if (left) 
				PlatForceUtils.applyHMoveAccel(this, false);
			
			if (right) 
				PlatForceUtils.applyHMoveAccel(this, true);
			
			PlatForceUtils.zeroOutSmallNumbers(this);
			
				
		}
		
		private function applyVelocity(e:Entity):void {
			var i:int;
			currentlyAgainstWall = false;
			currentlyGrounded = false;
			for (i = 0; i < Math.abs(_v.x); i++){
				if (e.collide(Config.TYPE_WALL, e.x + FP.sign(_v.x), e.y)){
					currentlyAgainstWall = true;
					_v.x = 0;
					break;
				}
				else
					e.x += FP.sign(_v.x);
				
			}

			for (i = 0; i < Math.abs(_v.y); i++) {
				var owp:Entity = null;
				if (e.collide(Config.TYPE_WALL, e.x, e.y + FP.sign(_v.y))) {
					if (_v.y > 0)
						currentlyGrounded = true;
					_v.y = 0;
					break;
				}

				else {
					
					var oldHeight:int = e.height;
					var oldOriY:int = e.originY;
					//use height = 1
					//and new y is old y - old height
					e.setHitbox(e.width, 1, e.originX, oldOriY - oldHeight);
					var underFeet:Entity = e.collide(Config.TYPE_ONEWAYPLATFORM, e.x, e.y);
					//return hitbox
					e.setHitbox(e.width, oldHeight, e.originX, oldOriY);
					
					if (underFeet != null) {
						if (FP.sign(_v.y) > 0 && (e.y - e.halfHeight) < underFeet.y) {
							if (_v.y > 0)
								currentlyGrounded = true;
							_v.y = 0;
							break;
						}
						else
							e.y += FP.sign(_v.y);
					}
					
					e.y += FP.sign(_v.y);
				}
			}
		}
		
		private function iWasPreviouslyHigherThanThisWall(e:Entity):Boolean {
			var highestOfWall:Number = getHighestYOfThisWallIAmHitting(e);
			return previousPosition.y <= highestOfWall + 1;
		}
		
		private function getHighestYOfThisWallIAmHitting(e:Entity):int {
			return e.y - e.height;
		}
		
		public function get onGround():Boolean {
			return currentlyGrounded;
		}
		
		public function setJumpOomf(jo:Number):void {
			jumpOomf.y = jo;
		}
		
		public function setAirJumps(aj:Number):void {
			airJumps = aj;
		}
		
		public function setCanAirJumpWhileFalling(cajwf:Boolean):void {
			canAirJumpWhileFalling = cajwf;
		}
		
		public function setMoveAccel(xma:Number):void {
			_moveAccel.x = xma;
		}
		
		public function setMaxMoveVelocity(xmmv:Number, ymmv:Number):void {
			_maxMoveSpeed.x = xmmv;
			_maxMoveSpeed.y = ymmv;
		}
		
		public function setMaxVelocity(xmv:Number, ymv:Number):void {
			_maxSpeed.x = xmv;
			_maxSpeed.y = ymv;
		}
		
		public function setJumpVelocity(jv:Number):void {
			jumpV.y = jv;
		}
		
		/* INTERFACE com.auxiliumgames.base.plat.ICanPlatForce */
		
		public function get v():Point {
			return _v;
		}
		
		public function get moveAccel():Point {
			return _moveAccel;
		}
		
		public function get maxMoveSpeed():Point {
			return _maxMoveSpeed;
		}
		
		public function get maxSpeed():Point {
			return _maxSpeed;
		}
	}

}
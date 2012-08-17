package com.auxiliumgames.base.platformer{
	import com.auxiliumgames.base.Config;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	/**
	 * A class used to manage an Entities position in a platformer type game.
	 * This can be used for the player character or enemies or both.
	 * @author jculver
	 */
	public class PlatformerPositionManger implements ICanPlatForce {
		
		//jump related vars
		private const jumpV:Point = new Point(0, -3);
		private var airJumps:uint = 0;
		private var canAirJumpWhileFalling:Boolean = false;
		private var airJumpsSinceJump:uint = 0;
		private var jumpOomf:Point = new Point(0, 0);
		
		//used for ICanPlatForce interface.
		private const _moveAccel:Point = new Point(.2, 0);
		private const _maxMoveSpeed:Point = new Point(4, 4);
		private const _v:Point = new Point(0, 0);
		
		//information about the previous state.
		private const previousPosition:Point = new Point(0, 0);
		private const previousVelocity:Point = new Point(0, 0);
		
		//information about which types of forces we need to apply to this entity.
		private var currentlyGrounded:Boolean;
		private var currentlyAgainstWall:Boolean;
		private var isJumping:Boolean;
		
		public function PlatformerPositionManger() {
			
		}
		
		/**
		 * Updates the position of e based on input, and wall collisions.
		 * @param	e		The entity whose position needs updating.
		 * @param	input	The input we will use to help determine position.
		 */
		public function updatePosition(e:Entity, input:PlatformerInput):void {
			//before updating, record the previous state
			previousPosition.x = e.x;
			previousPosition.y = e.y;
			previousVelocity.x = _v.x;
			previousVelocity.y = _v.y;
			//calc the velocity before applying it
			calcVelocity(input);
			//apply the calculated velocity to the entity
			applyVelocity(e);
		}
		
		/**
		 * Calc the velocity vector based on the input, and the 
		 * environmental forces like gravity and friction.sssssss
		 * @param	input	The current state of the input.
		 */
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
		
		/**
		 * This applies the velocity we calculated to the position of e, but respects any walls
		 * and platforms.
		 * @param	e		The entity whose position will be updated.
		 */
		private function applyVelocity(e:Entity):void {
			var i:int;
			currentlyAgainstWall = false;
			currentlyGrounded = false;
			//collision checks on the x axis
			for (i = 0; i < Math.abs(_v.x); i++){
				if (e.collide(Config.TYPE_WALL, e.x + FP.sign(_v.x), e.y)){
					currentlyAgainstWall = true;
					_v.x = 0;
					break;
				}
				else
					e.x += FP.sign(_v.x);
				
			}
			//collision checks on the y axis
			for (i = 0; i < Math.abs(_v.y); i++) {
				var owp:Entity = null;
				if (e.collide(Config.TYPE_WALL, e.x, e.y + FP.sign(_v.y))) {
					if (_v.y > 0)
						currentlyGrounded = true;
					_v.y = 0;
					break;
				}

				//the added complexity here is due to oneway platforms
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
		
		//for use with oneway platforms
		private function iWasPreviouslyHigherThanThisWall(e:Entity):Boolean {
			var highestOfWall:Number = getHighestYOfThisWallIAmHitting(e);
			return previousPosition.y <= highestOfWall + 1;
		}
		//for use with oneway platforms
		private function getHighestYOfThisWallIAmHitting(e:Entity):int {
			return e.y - e.height;
		}
		
		/**
		 * True if the entity has ground underneath it.
		 */
		public function get onGround():Boolean {
			return currentlyGrounded;
		}
		
		/**
		 * The force applied to the y axis while the user holds the jump
		 * button while airborn.
		 * @param	jo
		 */
		public function setJumpOomf(jo:Number):void {
			jumpOomf.y = jo;
		}

		/**
		 * Sets the number of jumps an entity can perform when
		 * already jumping.
		 * @param	aj
		 */
		public function setAirJumps(aj:Number):void {
			airJumps = aj;
		}
		
		/**
		 * Can the entity jump when it just walked off a ledge (as opposed to being airborn
		 * due to a jump)
		 * @param	cajwf
		 */
		public function setCanAirJumpWhileFalling(cajwf:Boolean):void {
			canAirJumpWhileFalling = cajwf;
		}
		
		/**
		 * Sets the horizontal movement acceleration
		 * @param	xma		The amount applied multiplicitavely each frame
		 */
		public function setMoveAccel(xma:Number):void {
			_moveAccel.x = xma;
		}
		
		/**
		 * The max speeds an entity can acheive in either direction.
		 * @param	xmmv
		 * @param	ymmv
		 */
		public function setMaxMoveVelocity(xmmv:Number, ymmv:Number):void {
			_maxMoveSpeed.x = xmmv;
			_maxMoveSpeed.y = ymmv;
		}
		
		/**
		 * The velocity of a jump. Use negative values for jumps that go up.
		 * @param	jv
		 */
		public function setJumpVelocity(jv:Number):void {
			jumpV.y = jv;
		}
		
		/* INTERFACE com.auxiliumgames.base.platformer.ICanPlatForce */
		
		public function get v():Point {
			return _v;
		}
		
		public function get moveAccel():Point {
			return _moveAccel;
		}
		
		public function get maxMoveSpeed():Point {
			return _maxMoveSpeed;
		}
		
	}

}
package com.auxiliumgames.base.plat {
	import com.auxiliumgames.base.plat.IHasSimplePlatPhy;
	import com.auxiliumgames.base.plat.SimplePlat;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author jculver
	 */
	public class AbstPlatformerPlayer extends Entity implements IHasSimplePlatPhy{
		
		
		
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
		private const previousLowestPoint:int = 0;
		
		private var currentlyGrounded:Boolean;
		private var currentlyAgainstWall:Boolean;
		private var isJumping:Boolean;
		
		public function AbstPlatformerPlayer() {
			
		}
		
		/* INTERFACE com.auxiliumgames.base.SimplePlatPhy.IHasSimplePlatPhy */
		
		
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
		
		protected function abstPressingRight():Boolean {
			return false;
		}
		
		protected function abstPressingLeft():Boolean {
			return false;
		}
		
		protected function abstPressedJump():Boolean {
			return false;
		}
		
		protected function abstHoldingJump():Boolean {
			return false;
		}
		
		private function onGround():Boolean {
			var oldHeight:int = height;
			var oldOriY:int = originY;
			//use height = 1
			//and new y is old y - old height
			setHitbox(width, 1, originX, oldOriY - oldHeight);
			var underFeet:Entity = collide(SimplePlat.WALL, x, y);
			if (underFeet == null)
				underFeet = collide(SimplePlat.ONEWAYPLATFORM, x, y);
			//return hitbox
			setHitbox(width, oldHeight, originX, oldOriY);
			return ( underFeet != null);
		}
		
		private function calcVelocityFromEnvironmentAndPlayerInput():void {

			currentlyGrounded = _v.y == 0;
			
			var left:Boolean = abstPressingLeft();
			var right:Boolean = abstPressingRight();
			var jump:Boolean = abstPressedJump();
			var wall:Boolean = currentlyAgainstWall;
			
			//process environment
			SimplePlat.applyGravity(this);
			if (!currentlyGrounded){
				SimplePlat.applyAirResistance(this);
			}
			else {
				SimplePlat.applyFriction(this);
				//_v.y = 0;
				airJumpsSinceJump = 0;
				isJumping = false;
			}
			
			if (wall) 
				SimplePlat.applyFriction(this, false);
			
			//process input
			if (jump) {
				if(currentlyGrounded){
					SimplePlat.applyGenericAdditiveForce(this, jumpV);
					isJumping = true;
				}
				else {
					if ((isJumping || canAirJumpWhileFalling) && airJumps > 0 && airJumpsSinceJump < airJumps){
						_v.y = 0; //remove gravity
						SimplePlat.applyGenericAdditiveForce(this, jumpV);
						airJumpsSinceJump++;
					}
					
				}
			}
			
			//should we apply oomf?
			if (!currentlyGrounded && isJumping && abstHoldingJump() && _v.y < 0 && jumpOomf.y < 0) {
				SimplePlat.applyGenericAdditiveForce(this, jumpOomf);
			}	
			
			if (left) 
				SimplePlat.applyHMoveAccel(this, false);
			
			if (right) 
				SimplePlat.applyHMoveAccel(this, true);
			
			SimplePlat.zeroOutSmallNumbers(this);
			
				
		}
		
		protected function get isCurrentlyOnGround():Boolean {
			return currentlyGrounded;
		}
		
		protected function updatePosition():void {
			previousPosition.x = x;
			previousPosition.y = y;
			calcVelocityFromEnvironmentAndPlayerInput();
			applyVelocity();
		}
		
		private function applyVelocity():void {
			var i:int;
			currentlyAgainstWall = false;
			
			for (i = 0; i < Math.abs(_v.x); i++){
				if (collide(SimplePlat.WALL, x + FP.sign(_v.x), y)){
					currentlyAgainstWall = true;
					_v.x = 0;
					break;
				}
				else
					x += FP.sign(_v.x);
				
			}

			for (i = 0; i < Math.abs(_v.y); i++) {
				var owp:Entity = null;
				if (collide(SimplePlat.WALL, x, y + FP.sign(_v.y))) {
					_v.y = 0;
					
					break;
				}
				//else if ( (owp = collide(SimplePlat.ONEWAYPLATFORM, x, y + FP.sign(_v.y))) != null) {
					//if(FP.sign(_v.y) > 0 && (y - halfHeight) < owp.y){
						//_v.y = 0;
						//break;
					//}
					//else
						//y += FP.sign(_v.y);
				//}
				else {
					
					var oldHeight:int = height;
					var oldOriY:int = originY;
					//use height = 1
					//and new y is old y - old height
					setHitbox(width, 1, originX, oldOriY - oldHeight);
					var underFeet:Entity = collide(SimplePlat.ONEWAYPLATFORM, x, y);
					//return hitbox
					setHitbox(width, oldHeight, originX, oldOriY);
					
					if (underFeet != null) {
						if(FP.sign(_v.y) > 0 && (y - halfHeight) < underFeet.y){
							_v.y = 0;
							break;
						}
						else
							y += FP.sign(_v.y);
					}
					
					y += FP.sign(_v.y);
				}
			}
		}
		
		private function iWasPreviouslyHigherThanThisWall(e:Entity):Boolean {
			var highestOfWall:Number = getHighestYOfThisWallIAmHitting(e);
			return previousPosition.y <= highestOfWall + 1;
			//why += 1 you might ask. I DUNNO
			//but on the realz... if you remove thsi thing, the bugs and strange behavior that will rain
			//down upon you with great force and terror... oh they are massive
			//i honestly dunno wtf, but in seriousness after wasting hours on trying to figure out
			//why occasionally i would just mysteriously fall through a platform when a certain velocity was hit etc,
			//this motherfucker right here was the reason.
			//i made the check a little looser than it should be with the +1 and everything was right with the world
			//my desire to understand why was superceded by the fact that I am done wasting time on this mother fucker
			//right here and move on. THE WORLD NEEDS MORE GAMES NOT MORE CRAZY PEOPLE. FUCK YOU highestOfWall
		}
		
		private function getHighestYOfThisWallIAmHitting(e:Entity):int {
			return e.y - e.height;
		}
		
		protected function edtJumpVelocity(jv:Number):void {
			jumpV.y = jv;
		}
		
		protected function edtJumpOomf(jo:Number):void {
			jumpOomf.y = jo;
		}
		
		protected function edtAirJumps(aj:Number):void {
			airJumps = aj;
		}
		
		protected function edtCanAirJumpWhileFalling(cajwf:Boolean):void {
			canAirJumpWhileFalling = cajwf;
		}
		
		protected function edtMoveAccel(xma:Number):void {
			_moveAccel.x = xma;
		}
		
		protected function edtMaxMoveVelocity(xmmv:Number, ymmv:Number):void {
			_maxMoveSpeed.x = xmmv;
			_maxMoveSpeed.y = ymmv;
		}
		
		protected function edtMaxVelocity(xmv:Number, ymv:Number):void {
			_maxSpeed.x = xmv;
			_maxSpeed.y = ymv;
		}
		
		
	}

}
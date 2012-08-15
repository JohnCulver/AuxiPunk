package com.auxiliumgames.base.shmup {
	import com.auxiliumgames.base.Utils;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	/**
	 * Used to manage where a shmup entity can move on the screen.
	 * @author jculver
	 */
	public class ShmupPositionManager {
		
		//for keeping track of position
		private var baseVelocity:Number = 3.5;
        private var focusVelocity:Number = 2;
        private var v:Point = new Point(0,0);
        private var xValues:Point = new Point(0,FP.screen.width);
        private var yValues:Point = new Point(0,FP.screen.width);
        
		//Basically circular velocity means that no matter what directions are being input the total velocity is the same.
		//When this is false, if the user is pressing up and left, the will move BOTH up and left in the amount of the velocity.
		//However if this is true, then the user will only move the velocity amount in the up left direction.
		private var circularVelocity:Boolean = true;
        private const leftCV:Point = new Point(-Math.cos(0),-Math.sin(0));
        private const upLeftCV:Point = new Point(-Math.cos(Utils.degreesToRadians(45)),-Math.sin(Utils.degreesToRadians(45)));
        private const upCV:Point = new Point(Math.cos(Utils.degreesToRadians(90)),-Math.sin(Utils.degreesToRadians(90)));
		
		public function ShmupPositionManager() {
			
		}
		
		/**
		 * Takes an entity and an input and moves the entity according to the input.
		 * 
		 * @param	e		The entity to be moved.
		 * @param	input	The input to examine and used to determnine where to move the entity.
		 */
		public function updatePosition(e:Entity,input:ShmupInput):void {
            calcVelocity(input);
			applyVelocity(e);
		}
		
		//Figures out where to move the shmup entity based on the input
		private function calcVelocity(input:ShmupInput):void {
			
			var left:Boolean = input.pressingLeft();
			var right:Boolean = input.pressingRight();
			var up:Boolean = input.pressingUp();
			var down:Boolean = input.pressingDown();
            var focus:Boolean = input.isFocused();

			//which velocity should we use?
            var useVelocity:Number = focus ? focusVelocity : baseVelocity;

            if(circularVelocity){
                if(left)
                    v.x = upLeftCV.x * useVelocity;
                else if (right)
					 v.x = -upLeftCV.x * useVelocity;
				else
					v.x = 0;
					 
				if (up) 
					v.y= upLeftCV.y * useVelocity;
				else if(down)
					v.y = -upLeftCV.y * useVelocity;
				else
					v.y = 0;
            }
            else{
                if(left)
                    v.x = -useVelocity;
                if(right)
                    v.x = useVelocity;
                if(down)
                    v.y = useVelocity;
                if(up)
                    v.y = -useVelocity;
				if(!left && !right){
                    v.x = 0;
                }
				if (!up && !down) {
					v.y = 0;
				}
            }
		}
		
		//this actually applies the value of the velocity
		//we calculated
		private function applyVelocity(e:Entity):void {

            var newX:Number = e.x + v.x;
            if (newX  < xValues.x ) {
                e.x = xValues.x;
            }
            else if( newX > xValues.y){
                e.x = xValues.y;
            }
            else{
                e.x = newX;
            }

            var newY:Number = e.y + v.y;
            if (newY  < yValues.x ) {
                e.y = yValues.x;
            }
            else if( newY > yValues.y){
                e.y = yValues.y;
            }
            else{
                e.y = newY;
            }

		}
		
		/**
		 * @param	b	Basically circular velocity means that no matter what directions are being input the total velocity is the same.
		 *				When this is false, if the user is pressing up and left, the will move BOTH up and left in the amount of the velocity.
		 * 				However if this is true, then the user will only move the velocity amount in the up left direction.
		 */
		public function setCricularVelocity(b:Boolean):void{
            circularVelocity = b;
        }

		/**
		 * @param	baseV	How much we move the shmup per frame when NOT focused.
		 */
        public function setBaseVelocity(baseV:Number):void{
            baseVelocity = baseV;
        }

		/**
		 * @param	fV	How much we move the shmup per frame when focused.
		 */
        public function setFocusVelocity(fV:Number):void{
            focusVelocity = fV;
        }

		/**
		 * @param	min		The shmup will not be allowed to navigate below this x value.
		 */
        public function setXMin(min:Number):void{
            xValues.x = min;
        }

		/**
		 * @param	max		The shmup will not be allowed to navigate above this x value.
		 */
        public function setXMax(max:Number):void{
            xValues.y = max;
        }

		/**
		 * @param	min		The shmup will not be allowed to navigate below this y value.
		 */
        public function setYMin(min:Number):void{
            yValues.x = min;
        }

		/**
		 * @param	max		The shmup will not be allowed to navigate above this y value.
		 */
        public function setYMax(max:Number):void{
            yValues.y = max;
        }
		
	}

}
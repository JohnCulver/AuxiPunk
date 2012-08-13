package com.auxiliumgames.base.shmup {
	import com.auxiliumgames.base.Globals;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author hi
	 */
	public class ShmupPositionManager {
		
		private var baseVelocity:Number = 3.5;
        private var focusVelocity:Number = 2;

        private var v:Point = new Point(0,0);
        private var xValues:Point = new Point(0,Globals.SCREENWIDTH);
        private var yValues:Point = new Point(0,Globals.SCREENHEIGHT);
        private var circularVelocity:Boolean = true;

        private const leftCV:Point = new Point(-Math.cos(0),-Math.sin(0));
        private const upLeftCV:Point = new Point(-Math.cos(Globals.degreesToRadians(45)),-Math.sin(Globals.degreesToRadians(45)));
        private const upCV:Point = new Point(Math.cos(Globals.degreesToRadians(90)),-Math.sin(Globals.degreesToRadians(90)));
		
		public function ShmupPositionManager() {
			
		}
		
		public function updatePosition(e:Entity,input:ShmupInput):void {
            calcVelocity(input);
			applyVelocity(e);
		}
		
		private function calcVelocity(input:ShmupInput):void {
			
			var left:Boolean = input.pressingLeft();
			var right:Boolean = input.pressingRight();
			var up:Boolean = input.pressingUp();
			var down:Boolean = input.pressingDown();
            var focus:Boolean = input.isFocused();

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
		
		public function setCricularVelocity(b:Boolean):void{
            circularVelocity = b;
        }

        public function setBaseVelocity(baseV:Number):void{
            baseVelocity = baseV;
        }

        public function setFocusVelocity(fV:Number):void{
            focusVelocity = fV;
        }

        public function setXMin(min:Number):void{
            xValues.x = min;
        }

        public function setXMax(max:Number):void{
            xValues.y = max;
        }

        public function setYMin(min:Number):void{
            yValues.x = min;
        }

        public function setYMax(max:Number):void{
            yValues.y = max;
        }
		
	}

}
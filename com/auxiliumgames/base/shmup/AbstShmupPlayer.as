package com.auxiliumgames.base.shmup {
import com.auxiliumgames.base.Globals;
import com.auxiliumgames.base.plat.IHasSimplePlatPhy;
	import com.auxiliumgames.base.plat.SimplePlat;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author jculver
	 */
	public class AbstShmupPlayer extends Entity {
		
		

        private var baseVelocity:Number = 3.5;
        private var focusVelocity:Number = 2;

        private var v:Point = new Point(0,0);
        private var xValues:Point = new Point(0,Globals.SCREENWIDTH);
        private var yValues:Point = new Point(0,Globals.SCREENHEIGHT);
        private var clampVelocity:Boolean = true;

        private const leftCV:Point = new Point(-Math.cos(0),-Math.sin(0));
        private const upLeftCV:Point = new Point(-Math.cos(Globals.degreesToRadians(45)),-Math.sin(Globals.degreesToRadians(45)));
        private const upCV:Point = new Point(Math.cos(Globals.degreesToRadians(90)),-Math.sin(Globals.degreesToRadians(90)));



		public function AbstShmupPlayer() {

		}
		
		protected function abstPressingRight():Boolean {
			return false;
		}
		
		protected function abstPressingLeft():Boolean {
			return false;
		}
		
		protected function abstPressingUp():Boolean {
			return false;
		}
		
		protected function abstPressingDown():Boolean {
			return false;
		}

        protected function abstIsFocused():Boolean {
            return false;
        }

        public function edtClampVelocity(b:Boolean):void{
            clampVelocity = b;
        }

        public function edtBaseVelocity(baseV:Number):void{
            baseVelocity = baseV;
        }

        public function edtFocusVelocity(fV:Number):void{
            focusVelocity = fV;
        }

        public function edtXMin(min:Number):void{
            xValues.x = min;
        }

        public function edtXMax(max:Number):void{
            xValues.y = max;
        }

        public function edtYMin(min:Number):void{
            yValues.x = min;
        }

        public function edtYMax(max:Number):void{
            yValues.y = max;
        }

		private function calcVelocityFromPlayerInput():void {
			
			var left:Boolean = abstPressingLeft();
			var right:Boolean = abstPressingRight();
			var up:Boolean = abstPressingUp();
			var down:Boolean = abstPressingDown();
            var focus:Boolean = abstIsFocused();

            var useVelocity:Number = focus ? focusVelocity : baseVelocity;

            if(clampVelocity){
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
		
		protected function updatePosition():void {
            calcVelocityFromPlayerInput();
			applyVelocity();
		}
		
		private function applyVelocity():void {

            var newX:Number = x + v.x;
            if (newX  < xValues.x ) {
                x = xValues.x;
            }
            else if( newX > xValues.y){
                x = xValues.y;
            }
            else{
                x = newX;
            }

            var newY:Number = y + v.y;
            if (newY  < yValues.x ) {
                y = yValues.x;
            }
            else if( newY > yValues.y){
                y = yValues.y;
            }
            else{
                y = newY;
            }

		}

	}

}
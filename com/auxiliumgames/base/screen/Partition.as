package com.auxiliumgames.base.screen {
	import net.flashpunk.Entity;

	/**
	 * A class used to help separate the screen/field into smaller sqaures.
	 */
	public class Partition {
		public var x:int = 0;
		public var y:int = 0;
		public var unitSize:uint = 1;

		public function Partition() {
		}

		/**
		 * Initializes the partition with the specified values.
		 * 
		 * @param	x			The x coordinate of the top left corner of the partition.
		 * @param	y			The x coordinate of the top left corner of the partition.
		 * @param	unitSize	The size of each square of the partition in pixels.
		 */
		public function setValues(x:int,y:int,unitSize:uint):void {
			this.x = x;
			this.y = y;
			this.unitSize = unitSize;
		}

		/**
		 * Sets an Entity's x and y to a particular square in the partition.
		 * @param	e			The Entity to move.
		 * @param	col			The column in the partition to move the Entity to.
		 * @param	row			The row in the partition to move the Entity to.
		 * @param	center		If the Entity should be centered in the square.
		 */
		public function setXYForRowCol(e:Entity,col:uint,row:uint, center:Boolean = false):void{
			e.x = x + ( (col * unitSize) + (center ? unitSize / 2 : 0));
			e.y = y + ( (row * unitSize) + (center ? unitSize / 2 : 0));
			trace(e.y, e.x);
		}
	}
}

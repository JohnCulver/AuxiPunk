package com.auxiliumgames.base.example {
	import net.flashpunk.Entity;
	import net.flashpunk.masks.Grid;

	/**
	 * A grid to help demo the partition class.
	 * @author jculver
	 */
	public class PartitionGrid extends Entity{
		public function PartitionGrid() {
			var g:Grid = new Grid(150,150,50,50,50,50);
			for (var i:int = 0; i < 3; i++) {
				for (var j:int = 0; j < 3; j++) {
					g.setTile(i, j);
				}
			}
			mask = g;
		}
	}
}

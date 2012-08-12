package com.auxiliumgames.base.example.platformer {
	import com.auxiliumgames.base.example.assets.tex.TEXTURES;
	import com.auxiliumgames.base.Globals;
	import com.auxiliumgames.base.plat.SimplePlat;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	/**
	 * ...
	 * @author jculver
	 */
	public class Platform extends Entity{
		private var tiles:Tilemap;
		private var g:Grid;
		
		public function Platform() {
			tiles = new Tilemap(TEXTURES.BLOCK, 8 * Globals.UNIT, 1 * Globals.UNIT, Globals.UNIT, Globals.UNIT);
			g = new Grid(8 * Globals.UNIT, 1 * Globals.UNIT, Globals.UNIT, Globals.UNIT);
			
			tiles.setRect(0, 0, (Globals.SCREENWIDTH / Globals.UNIT)/4, 1, 1);
			
			var s:String = tiles.saveToString();
			g.loadFromString(s);
			
			mask = g;
			
			x = 1 * Globals.UNIT;
			y = 27 * Globals.UNIT;
			
			graphic = tiles;
			layer = Globals.LAYER_WALL;
			
			type = SimplePlat.ONEWAYPLATFORM;
		}
	}

}
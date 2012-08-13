package com.auxiliumgames.base.example {
import com.auxiliumgames.base.example.assets.tex.TEXTURES;
import com.auxiliumgames.base.Globals;
import com.auxiliumgames.base.plat.SimplePlatUtils;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	/**
	 * ...
	 * @author jculver
	 */
	public class Tiles extends Entity{
		private var tiles:Tilemap;
		private var g:Grid;

		public function Tiles() {
			tiles = new Tilemap(TEXTURES.BLOCK, Globals.COLUMNS * Globals.UNIT, Globals.ROWS * Globals.UNIT, Globals.UNIT, Globals.UNIT);
			g = new Grid(Globals.COLUMNS * Globals.UNIT, Globals.ROWS * Globals.UNIT, Globals.UNIT, Globals.UNIT);
			
//			tiles.setRect(0, 0, Globals.SCREENWIDTH / Globals.UNIT, 1, 1);
//			tiles.setRect(0, (Globals.SCREENHEIGHT / Globals.UNIT) - 1 , Globals.SCREENWIDTH / Globals.UNIT, 1, 1);
//			tiles.setRect(0, 0, 1, Globals.SCREENHEIGHT / Globals.UNIT, 1);
//			tiles.setRect((Globals.SCREENWIDTH / Globals.UNIT) - 1, 0, 1, Globals.SCREENHEIGHT / Globals.UNIT, 1);
//
//			var s:String = tiles.saveToString();
//			g.loadFromString(s);

            
			mask = g;

			
			graphic = tiles;
			layer = Globals.LAYER_WALL;
			
			type = SimplePlatUtils.WALL;
		}
		
	}

}
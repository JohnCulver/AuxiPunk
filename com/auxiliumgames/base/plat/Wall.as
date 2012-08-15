package com.auxiliumgames.base.plat {
import com.auxiliumgames.base.example.assets.tex.TEXTURES;

import com.auxiliumgames.base.Utils;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Tilemap;
import net.flashpunk.masks.Grid;

	/**
	 * The part of the platformer level that is the mask.
	 * This keeps the platformer characters within the level by
	 * using collison between them and the mask.
	 * @author jculver
	 */
	public class Wall extends Entity{
		private var g:Grid;

		/**
		 * 
		 * @param	width			The total width of the map.
		 * @param	height			The total height of the map.
		 * @param	tileWidth		The width of the individual tiles in px.
		 * @param	tileHeight		The height of the individual tiles in px.
		 * @param	incType			The type to be used for collision checking.
		 * @param	data			The data from Tiled that we will use to make the grid.
		 */
		public function Wall(width:uint,height:uint,tileWidth:uint, tileHeight:uint, incType:String,data:String) {
            g = new Grid(width * tileWidth, height * tileHeight, tileWidth, tileHeight);
            var t:Array = data.split('\n').join('').split(',');
            for (var i:int = 0; i < t.length; i++) {
                var u:uint = t[i];
                if (u > 0) {
                    var col:uint = i < width ? i : (i % width);
                    var row:uint = Math.floor(i / width);
                    g.setTile(col, row, true);
                }
            }
            mask = g;
            type = incType;
        }
		
	}

}
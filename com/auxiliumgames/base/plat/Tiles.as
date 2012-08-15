package com.auxiliumgames.base.plat {
import com.auxiliumgames.base.example.assets.tex.TEXTURES;

import com.auxiliumgames.base.Utils;

import net.flashpunk.Entity;
import net.flashpunk.graphics.Tilemap;
import net.flashpunk.masks.Grid;

	/**
	 * This is the visual part of the platformer level that gets parsed by
	 * PlatTmxLevelParser.
	 * @author jculver
	 */
	public class Tiles extends Entity{
        private var tilemap:Tilemap;

		/**
		 * Based on this constructor it is obvious that Tiles sits on top of TileMap,
		 * and it does. The constructor basically parses the info we get from the Tiled map
		 * editor into a Tilemap.
		 * 
		 * @param	width			The total width of the map.
		 * @param	height			The total height of the map.
		 * @param	tileWidth		The width of the individual tiles in px.
		 * @param	tileHeight		The height of the individual tiles in px.
		 * @param	layer			The layer we will put the TileMap in.
		 * @param	data			The data we got from Tiled.
		 * @param	tex				The actual tile images we want to use.
		 */
		public function Tiles(width:uint, height:uint, tileWidth:uint, tileHeight:uint,  layer:int, data:String, tex:Class) {
            tilemap = new Tilemap(tex, width * tileWidth, height * tileHeight, tileWidth, tileHeight);
            var t:Array = data.split('\n').join('').split(',');
            for (var i:int = 0; i < t.length; i++) {
                var u:uint = t[i];
                if (u > 0) {
                    var col:uint = i < width ? i : (i % width);
                    var row:uint = Math.floor(i / width);
                    tilemap.setTile(col, row, u + 1);
                }

            }
            graphic = tilemap;
            this.layer = layer;
        }
		
	}

}
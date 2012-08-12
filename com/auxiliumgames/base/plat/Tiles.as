package com.auxiliumgames.base.plat {
import com.auxiliumgames.base.example.assets.tex.TEXTURES;

import com.auxiliumgames.base.Globals;

import net.flashpunk.Entity;
import net.flashpunk.graphics.Tilemap;
import net.flashpunk.masks.Grid;

/**
	 * ...
	 * @author jculver
	 */
	public class Tiles extends Entity{
        private var tilemap:Tilemap;

		public function Tiles(width:uint, height:uint, data:String, tex:Class) {
            tilemap = new Tilemap(tex, width * Globals.UNIT, height * Globals.UNIT, Globals.UNIT, Globals.UNIT);
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
            layer = Globals.LAYER_WALL;
        }
		
	}

}
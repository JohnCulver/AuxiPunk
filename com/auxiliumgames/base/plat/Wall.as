package com.auxiliumgames.base.plat {
import com.auxiliumgames.base.example.assets.tex.TEXTURES;

import com.auxiliumgames.base.Globals;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Tilemap;
import net.flashpunk.masks.Grid;

	/**
	 * ...
	 * @author jculver
	 */
	public class Wall extends Entity{
		private var g:Grid;

		public function Wall(incType:String,width:uint,height:uint,data:String) {
            g = new Grid(width * Globals.UNIT, height * Globals.UNIT, Globals.UNIT, Globals.UNIT);
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
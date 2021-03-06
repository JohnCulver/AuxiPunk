package com.auxiliumgames.example.platformer{

	import com.auxiliumgames.example.assets.tex.TEXTURES;
	import com.auxiliumgames.example.assets.levels.LEVELS;
	import com.auxiliumgames.base.Utils;
	import com.auxiliumgames.base.lighting.Darkness;
	import com.auxiliumgames.base.lighting.Light;
	import com.auxiliumgames.base.platformer.PlatTmxLevelParser;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;

	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	/**
	 * An example of a platformer level parsed from 
	 * two tiled maps side by side.
	 * 
	 * @author jculver
	 */
	public class PlatformerLevelTestWorld extends World{

		public function PlatformerLevelTestWorld() {

			//we init a level parser with the Tiled map
			var parser:PlatTmxLevelParser = new PlatTmxLevelParser(LEVELS.ROOM1);
			//we parse the level, and we get the objects layer back.
			var objects:XML = parser.parse(0, 0, 1000);
			//we add the things we parsed to the world.
			parser.add(this);
			//we init a parser for the objects
			var oParser:PlatformerLevelTestObjectHandler = new PlatformerLevelTestObjectHandler();
			//we parse the objects
			oParser.parse(objects);
			//and add them to the world
			oParser.add(this);
			
			//we do the same thing as above but with the second room
			var parser2:PlatTmxLevelParser = new PlatTmxLevelParser(LEVELS.ROOM2);
			var p:XML = parser2.parse(parser.tileWidth * parser.totalWidth, 0, 1000);
			parser2.add(this);
			var oParser2:PlatformerLevelTestObjectHandler = new PlatformerLevelTestObjectHandler();
			oParser2.parse(p);
			oParser2.add(this);
		}

		

	}
}

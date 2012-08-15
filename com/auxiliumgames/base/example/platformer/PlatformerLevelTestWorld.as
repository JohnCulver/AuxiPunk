package com.auxiliumgames.base.example.platformer {

	import com.auxiliumgames.base.example.assets.tex.TEXTURES;
	import com.auxiliumgames.base.example.assets.levels.LEVELS;
	import com.auxiliumgames.base.Utils;
	import com.auxiliumgames.base.lighting.Darkness;
	import com.auxiliumgames.base.lighting.Light;
	import com.auxiliumgames.base.plat.PlatTmxLevelParser;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;

	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class PlatformerLevelTestWorld extends World{

		public function PlatformerLevelTestWorld() {
			FP.console.enable();
			var parser:PlatTmxLevelParser = new PlatTmxLevelParser(LEVELS.ROOM1);
			var objects:XML = parser.parse(0,0,1000);
			parser.add(this);
			var oParser:PlatformerLevelTestObjectHandler = new PlatformerLevelTestObjectHandler();
			oParser.parse(objects);
			oParser.add(this);
			
			var parser2:PlatTmxLevelParser = new PlatTmxLevelParser(LEVELS.ROOM2);
			var p:XML = parser2.parse(parser.tileWidth * parser.totalWidth, 0, 1000);
			parser2.add(this);
			var oParser2:PlatformerLevelTestObjectHandler = new PlatformerLevelTestObjectHandler();
			oParser2.parse(p);
			oParser2.add(this);
		}

		

	}
}

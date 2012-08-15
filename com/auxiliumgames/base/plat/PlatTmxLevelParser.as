package com.auxiliumgames.base.plat {
	import com.auxiliumgames.base.Config;
	import com.auxiliumgames.base.example.assets.tex.TEXTURES;
	import net.flashpunk.FP;
	import net.flashpunk.World;



	public class PlatTmxLevelParser {

		private var wall:Wall;
		private var tiles:Tiles;
		private var oneWays:Vector.<OneWay>;
		private var tmxFile:Class;

		//TILE/Object Layers
        static private const OLAYER_OBJECTS:uint = 1;
        static private const OLAYER_ONE_WAY:uint = 0;
        static private const TLAYER_TILES:uint = 1;
        static private const TLAYER_WALL:uint = 0;
		
		//we keep these after parse in case needed later
		private var _tileWidth:uint = 0;
		private var _tileHeight:uint = 0;
		private var _totalWidth:uint = 0;
		private var _totalHeight:uint = 0;
		
		/**
		 * requires a map built by Tiled.
		 * the layers have to be:
		 * 4. Objects (object, these are the players and enemies, and anything else you want to add)
		 * 3. OneWay (object, these are the one way platforms)
		 * 2. Tiles  (tile using desired tile set, this is the graphics of the tiles)
		 * 1. Wall   (tile using the first tile of the tile set, this is the Grid Mask[1's represent active])
		 * @param tmxFile
		 */
		public function PlatTmxLevelParser(tmxFile:Class) {
			this.tmxFile = tmxFile;
		}

		/**
		 * this should return the objects layer so a game specific
		 * handler can parse it out
		 */
		public function parse(xOffset:uint,yOffset:uint,layer:int):XML {
			var xml:XML = FP.getXML(tmxFile);
			
			_tileWidth = xml.@tilewidth;
			_tileHeight = xml.@tileheight;
			_totalWidth = xml.@width;
			_totalHeight = xml.@height;
			
			
			var wallXML:XML = xml.layer[TLAYER_WALL];
			wall = new Wall(Config.TYPE_WALL, wallXML.@width, wallXML.@height, wallXML.data);
			wall.x = xOffset;
			wall.y = yOffset;
			
			var tileXML:XML = xml.layer[TLAYER_TILES];
			tiles = new Tiles(_tileWidth, _tileHeight, tileXML.@width,tileXML.@height,layer,tileXML.data,TEXTURES.BLOCK);
			tiles.x = xOffset;
			tiles.y = yOffset;
			
			parseOneWays(xml,xOffset,yOffset);
			var objects:XML = xml.objectgroup[OLAYER_OBJECTS];

			return objects;
		}

		private function parseOneWays(xml:XML,xOffset:uint,yOffset:uint):void {
			oneWays = new Vector.<OneWay>();
			var owXML:XML = xml.objectgroup[OLAYER_ONE_WAY];
			for (var i:int = 0; i < owXML.children().length(); i++) {
				var child:XML = owXML.children()[i];
				oneWays.push(new OneWay( int(child.@x) + int(xOffset),int(child.@y) + int(yOffset),child.@width,child.@height));
			}
		}

		public function add(world:World):void {
			world.add(wall);
			world.add(tiles);
			world.addList(oneWays);
		}
		
		public function get tileWidth():uint {
			return _tileWidth;
		}
		
		public function get tileHeight():uint {
			return _tileHeight;
		}
		
		public function get totalWidth():uint {
			return _totalWidth;
		}
		
		public function get totalHeight():uint {
			return _totalHeight;
		}
		
	}
}

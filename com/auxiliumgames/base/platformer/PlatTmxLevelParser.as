package com.auxiliumgames.base.platformer{
	import com.auxiliumgames.base.Config;
	import com.auxiliumgames.example.assets.tex.TEXTURES;
	import net.flashpunk.FP;
	import net.flashpunk.World;



	public class PlatTmxLevelParser {

		// the various components that make up the level.
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
		 * Requires a map built by Tiled.
		 * The layers have to be:
		 * 4. Objects (object, these are the players and enemies, and anything else you want to add)
		 * 3. OneWay (object, these are the one way platforms)
		 * 2. Tiles  (tile using desired tile set, this is the graphics of the tiles)
		 * 1. Wall   (tile using the first tile of the tile set, this is the Grid Mask[1's represent active])
		 * @param tmxFile	A level built by Tiled in the specific format mentioned above.
		 */
		public function PlatTmxLevelParser(tmxFile:Class) {
			this.tmxFile = tmxFile;
		}
		
		 /**
		  * Parses the tmx file into corresponding level components.
		  * @param	xOffset		The x coord of the top left corner of the level.
		  * @param	yOffset		The y coord of the top left corner of the level.
		  * @param	layer		The layer the visual part of the level should go.
		  * @return				The objects layer so a game specific handler can parse it out.
		  *
		  */
		public function parse(xOffset:uint,yOffset:uint,layer:int):XML {
			var xml:XML = FP.getXML(tmxFile);
			
			//get the top level info
			_tileWidth = xml.@tilewidth;
			_tileHeight = xml.@tileheight;
			_totalWidth = xml.@width;
			_totalHeight = xml.@height;
			
			//parse out the wall (collision)
			var wallXML:XML = xml.layer[TLAYER_WALL];
			wall = new Wall(wallXML.@width, wallXML.@height,_tileWidth, _tileHeight, Config.TYPE_WALL, wallXML.data);
			wall.x = xOffset;
			wall.y = yOffset;
			
			//parse out the tiles (visual)
			var tileXML:XML = xml.layer[TLAYER_TILES];
			tiles = new Tiles(tileXML.@width,tileXML.@height, _tileWidth, _tileHeight,layer,tileXML.data,TEXTURES.BLOCK);
			tiles.x = xOffset;
			tiles.y = yOffset;
			
			//parse out one ways
			parseOneWays(xml,xOffset,yOffset);
			var objects:XML = xml.objectgroup[OLAYER_OBJECTS];

			//return the objects for the object parser.
			return objects;
		}

		//used to parse the one way layer
		private function parseOneWays(xml:XML,xOffset:uint,yOffset:uint):void {
			oneWays = new Vector.<OneWay>();
			var owXML:XML = xml.objectgroup[OLAYER_ONE_WAY];
			for (var i:int = 0; i < owXML.children().length(); i++) {
				var child:XML = owXML.children()[i];
				oneWays.push(new OneWay( int(child.@x) + int(xOffset),int(child.@y) + int(yOffset),child.@width,child.@height));
			}
		}

		/**
		 * Instead of world.add we use add(world) since we 
		 * have multiple things to add.
		 * @param	world		The world to add these things to.
		 */
		public function add(world:World):void {
			world.add(wall);
			world.add(tiles);
			world.addList(oneWays);
		}
		
		/**
		 * @return	The width of the tiles we parsed.
		 */
		public function get tileWidth():uint {
			return _tileWidth;
		}
		
		/**
		 * @return	The height of the tiles we parsed.
		 */
		public function get tileHeight():uint {
			return _tileHeight;
		}
		
		/**
		 * @return	The toptal width of the tiles we parsed.
		 */
		public function get totalWidth():uint {
			return _totalWidth;
		}
		
		/**
		 * @return	The height of the tiles we parsed.
		 */
		public function get totalHeight():uint {
			return _totalHeight;
		}
		
	}
}

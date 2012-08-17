package com.auxiliumgames.example.platformer{
	import com.auxiliumgames.example.assets.tex.TEXTURES;
	import com.auxiliumgames.base.lighting.Light;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;

	/**
	 * While we have a level handler that handles the peices of a level,
	 * we will always need to write a custom handler that handles everything else,
	 * like the player, the enemies, lighting etc.
	 * 
	 * Whatever we added to the level we made with Tiled, we need to also
	 * add it here.
	 * 
	 * @author jculver
	 */
	public class PlatformerLevelTestObjectHandler {

		private var ents:Vector.<Entity>;

		/**
		 * as an example this class handles an array of objects
		 *
		 * this array we only handle the player object but we could handle
		 * others (this is just an example)
		 */
		public function PlatformerLevelTestObjectHandler() {
		}

		/**
		 * 
		 * @param	xml		The objects layer we got from Tiled.
		 * 					We will take this and map it accordingly.
		 */
		public function parse(xml:XML):void{
			ents = new Vector.<Entity>();
			for (var i:int = 0; i < xml.children().length(); i++) {
				var child:XML = xml.children()[i];
				addEntityToList(child);
			}
		}

		/**
		 * Anything we parse we are going to want to add to the world.
		 * @param	child	The entity we will want to add
		 */
		private function addEntityToList(child:XML):void {
			if (child.@type == 'Player') {
				var p:PlatDude = new PlatDude();
				p.x = child.@x;
				p.y = child.@y;
				ents.push(p);
			}
		}

		/**
		 * Add the stufff we parsed to the world.
		 * @param	world		The world we will add the objects to.
		 */
		public function add(world:World):void{
			world.addList(ents);
		}
	}
}

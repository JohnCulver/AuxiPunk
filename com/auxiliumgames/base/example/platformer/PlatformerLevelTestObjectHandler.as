/**
 * Created with IntelliJ IDEA.
 * User: JC
 * Date: 7/4/12
 * Time: 8:24 PM
 * To change this template use File | Settings | File Templates.
 */
package com.auxiliumgames.base.example.platformer {
import com.auxiliumgames.base.example.assets.tex.TEXTURES;
import com.auxiliumgames.base.lighting.Light;
import net.flashpunk.Entity;
import net.flashpunk.graphics.Image;
import net.flashpunk.World;

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

    public function parse(xml:XML):void{
        ents = new Vector.<Entity>();
        for (var i:int = 0; i < xml.children().length(); i++) {
            var child:XML = xml.children()[i];
            addEntityToList(child);
        }
    }

    private function addEntityToList(child:XML):void {
        if (child.@type == 'Player') {
			var light:Light = new Light(new Image(TEXTURES.LIGHT));
            var p:PlatDude = new PlatDude(light);
            p.x = child.@x;
            p.y = child.@y;
            ents.push(p);
			ents.push(light);
        }
    }

    public function add(world:World):void{
        world.addList(ents);
    }
}
}

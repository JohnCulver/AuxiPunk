/**
 * Created with IntelliJ IDEA.
 * User: JC
 * Date: 7/4/12
 * Time: 5:13 PM
 * To change this template use File | Settings | File Templates.
 */
package com.auxiliumgames.base.example.platformer {

import com.auxiliumgames.base.example.assets.tex.TEXTURES;
import com.auxiliumgames.base.example.assets.levels.LEVELS;
import com.auxiliumgames.base.Globals;
import com.auxiliumgames.base.lighting.Darkness;
import com.auxiliumgames.base.lighting.Light;
import com.auxiliumgames.base.plat.PlatTmxLevelParser;
import net.flashpunk.graphics.Image;

import net.flashpunk.World;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

public class PlatformerLevelTestWorld extends World{


    public function PlatformerLevelTestWorld() {
        var parser:PlatTmxLevelParser = new PlatTmxLevelParser(LEVELS.EXAMPLE);
        var objects:XML = parser.parse();
        parser.add(this);
        var oParser:PlatformerLevelTestObjectHandler = new PlatformerLevelTestObjectHandler();
        oParser.parse(objects);
        oParser.add(this);
		//var light:Light = new Light(new Image(TEXTURES.LIGHT));
		//light.x = 500;
		//light.y = 500;
		//add(light);
		//add(new Darkness(0x000000,.9,5));
    }

    

}
}

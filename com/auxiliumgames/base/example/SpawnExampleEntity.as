/**
 * Created with IntelliJ IDEA.
 * User: JC
 * Date: 7/6/12
 * Time: 4:33 PM
 * To change this template use File | Settings | File Templates.
 */
package com.auxiliumgames.base.example {
import com.auxiliumgames.base.example.assets.tex.TEXTURES;
import com.auxiliumgames.base.Globals;
import com.auxiliumgames.base.spawn.ISpawn;
import flash.geom.Point;
import flash.geom.Rectangle;
import net.flashpunk.Entity;
import net.flashpunk.graphics.Image;
import net.flashpunk.utils.Input;




public class SpawnExampleEntity extends Entity implements ISpawn{
    private var onComplete:Function;
	private var exploding:uint;

    public var image:Image = new Image(TEXTURES.DUDE,new Rectangle(0,0,32,32))

    public function SpawnExampleEntity() {
        graphic = image;
		setHitboxTo(image);
		type = "see";
		layer = Globals.LAYER_BULLET + 2;
    }

    public function spawn(onComplete:Function, l:Point):void {
        this.onComplete = onComplete;
		exploding = 0;
        x = l.x;
        y = l.y;
    }
	
	override public function update():void {
		if (exploding > 0) {
			exploding--;
			if (exploding == 0){
				trace("Finished splode");
				onComplete();
			}
		}
		else{
			if (Input.mouseReleased) 
				if (collidePoint(x, y, Input.mouseX, Input.mouseY))
					onComplete();
		}
		
	}
	
	
	public function forceComplete():void {
		trace("SPLODE");
		exploding = 30;
	}
}
}

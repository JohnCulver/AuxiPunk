/**
 * Created with IntelliJ IDEA.
 * User: JC
 * Date: 7/6/12
 * Time: 4:33 PM
 * To change this template use File | Settings | File Templates.
 */
package com.auxiliumgames.base.example {
import com.auxiliumgames.base.example.assets.tex.TEXTURES;

import flash.geom.Point;
import flash.geom.Rectangle;

import net.flashpunk.Entity;
import net.flashpunk.graphics.Image;

public class PartitionExampleEntity extends Entity{
    private var onComplete:Function;

    public var image:Image = new Image(TEXTURES.DUDE,new Rectangle(0,0,32,32))

    public function PartitionExampleEntity() {
        graphic = image;
    }
}
}

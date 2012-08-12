/**
 * Created with IntelliJ IDEA.
 * User: JC
 * Date: 7/5/12
 * Time: 8:02 AM
 * To change this template use File | Settings | File Templates.
 */
package com.auxiliumgames.base {
import flash.display.BitmapData;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Image;

public class FullScreenColor extends Entity{

    public static const MODE_SOLID:String = "SOLID";
    public static const MODE_FADE_IN:String = "FIN";
    public static const MODE_FADE_OUT:String = "FOUT";

    private var bd:BitmapData;
    public var image:Image;
    private var onComplete:Function;
    private var mode:String;
    private var fadeRate:Number;

    public function FullScreenColor(color:uint,layer:int,mode:String = MODE_SOLID, fadeRate:Number = .02, onComplete:Function = null ) {
        this.mode = mode;
        this.onComplete = onComplete;
        this.fadeRate = fadeRate;
        bd = new BitmapData(FP.width, FP.height, false, color);
        image = new Image(bd);
        graphic = image;
        this.layer = layer;
        x = 0;
        y = 0;
        if (this.mode == MODE_FADE_IN)
            image.alpha = 0;
        else
            image.alpha = 1;
    }

    override public function update():void {
        switch (this.mode){
            case MODE_FADE_IN :
                image.alpha += fadeRate;
                if(image.alpha >= 1 && onComplete != null){
                    onComplete();
                    onComplete = null;
                }
                break;
            case MODE_FADE_OUT :
                image.alpha -= fadeRate;
                if(image.alpha <= 0 && onComplete != null){
                    onComplete();
                    onComplete = null;
                }
                break;
        }
    }

}
}

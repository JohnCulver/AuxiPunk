package com.auxiliumgames.base {
import flash.display.BitmapData;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Image;

/**
 * A class to fill the screen with a color. 
 * The color can fade in or out (good for disolves/scene changes) or remain solid.
 * @author John Culver
 */
public class FullScreenColor extends Entity{

    public static const MODE_SOLID:String = "SOLID";
    public static const MODE_FADE_IN:String = "FIN";
    public static const MODE_FADE_OUT:String = "FOUT";

    private var bd:BitmapData;
    public var image:Image;
    private var onComplete:Function;
    private var mode:String;
    private var fadeRate:Number;

	/**
	 * 
	 * @param	color			The color of the fill.
	 * @param	layer			The layer the fill will be in.
	 * @param	mode			Use the consts defined in this class for fade in, fade out, or solid.
	 * @param	fadeRate		The rate (per frame) to fade.
	 * @param	onComplete		An optional function to be called if a fade mode was seclected, when the fade is complete.
	 */
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

	/**
	 * This is overriden to handle some of the details when fading.
	 */
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

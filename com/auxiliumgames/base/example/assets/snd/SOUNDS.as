/**
 * Created with IntelliJ IDEA.
 * User: JC
 * Date: 7/2/12
 * Time: 9:50 PM
 * To change this template use File | Settings | File Templates.
 */
package com.auxiliumgames.base.example.assets.snd {
import flash.media.Sound;
import flash.net.URLRequest;

import net.flashpunk.Sfx;

public class SOUNDS {


    /*** EXAMPLE ***/
    [Embed(source = '/com/auxiliumgames/base/example/assets/snd/kick.mp3')] private static const jumpSound:Class;
    public static var JUMP:Sfx = new Sfx(jumpSound);
    /**************/

    public function SOUNDS() {
    }
}
}

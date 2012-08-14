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

package com.auxiliumgames.base.example {
	import com.auxiliumgames.base.example.assets.tex.TEXTURES;
	import com.auxiliumgames.base.Dialog;
	import flash.geom.Rectangle;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author hi
	 */
	public class DialogExampleWorld extends World{
		private var dialog:Dialog;
		private var im:Image;
		private var updates:uint = 0;
		private var img:Image;
		
		public function DialogExampleWorld() {
			dialog = new Dialog(400, 100, 10, 50, 0xFF0000, 0x00FF00, 0xFFFFFF);
			add(dialog);
			im = new Image(TEXTURES.BLOCK);
			im.centerOrigin();
			im.scale = 5;
			dialog.show(50, 50, im, 10, "center", "Well hello whatever this is so stupid, this text is excessive in length, but I am not ashamed of it, ok thanks anyways, cya later. Fuck off.");
		}
		
		override public function update():void {
			updates++;
			if (updates >  50) {
				img = new Image(TEXTURES.BLOCK, new Rectangle(0,0,8,8));
				img.centerOrigin();
				img.scale = 7;
				dialog.show(60, 60, img, 10, "center", "Ok but seriously.");
			}
			if (updates >  120) {
				img = new Image(TEXTURES.BLOCK, new Rectangle(0,0,8,8));
				img.centerOrigin();
				img.scale = 10;
				dialog.show(100, 60, img, 10, "center", "Ok but not really, but perhaps, but not necessarily, but possibly, but unlikely, highly unlikely even that it might be.");
			}
			super.update();
		}
		
	}

}
package com.auxiliumgames.example.display {
	import com.auxiliumgames.base.display.Dialog;
	import com.auxiliumgames.example.assets.tex.TEXTURES;
	import flash.geom.Rectangle;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	/**
	 * A class for demonstrating and testing the Dialog class
	 * @author jculver
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
			//start with a dialog with long text
			dialog.show(50, 50, "Well hello whatever this is so stupid, this text is excessive in length, but I am not ashamed of it, ok thanks anyways, cya later. K BYE.", im, 10, "center");
		}
		
		override public function update():void {
			updates++;
			//after a while we change it to centered text and a different portrait scale
			if (updates >  50) {
				img = new Image(TEXTURES.BLOCK, new Rectangle(0,0,8,8));
				img.centerOrigin();
				img.scale = 7;
				dialog.show(60, 60, "Ok but seriously.", img, 10, "center");
			}
			//finally we do one with no portrait and default text size etc
			if (updates >  120) {
				dialog.show(100, 60, "Ok but not really, but perhaps, but not necessarily, but possibly, but unlikely, highly unlikely even that it might be.");
			}
			super.update();
		}
		
	}

}
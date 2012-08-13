package com.auxiliumgames.base {
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author hi
	 */
	public class Dialog extends Entity{
		private var bg:Image;
		private var text:Text;
		private var topBorder:Image;
		private var botBorder:Image;
		private var leftBorder:Image;
		private var rightBorder:Image;
		private var glist:Graphiclist;
		private var dwidth:uint;
		private var dheight:uint;
		private var dborderWidth:uint;
		private var lastImage:Image;
		
		public function Dialog(width:uint, height:uint, borderWidth:uint, layer:int, bgColor:uint, borderColor:uint, textColor:uint) {
			this.dheight = height;
			this.dwidth = width;
			this.dborderWidth = borderWidth;
			this.layer = layer;
			text = new Text("");
			text.color = textColor;
			bg = new Image(new BitmapData(width, height, false, bgColor));
			topBorder = new Image(new BitmapData(width, dborderWidth, false, borderColor));
			botBorder = new Image(new BitmapData(width, dborderWidth, false, borderColor));
			leftBorder = new Image(new BitmapData(dborderWidth, height, false, borderColor));
			rightBorder = new Image(new BitmapData(dborderWidth, height, false, borderColor));
			glist = new Graphiclist(bg, topBorder, botBorder, leftBorder, rightBorder, text);
			graphic = glist;
			
			botBorder.y = dheight - dborderWidth;
			rightBorder.x = dwidth - dborderWidth;
		}
		
		public function show(x:int, y:int, image:Image, textSize:uint, align:String, string:String):void {
			if (lastImage)
				glist.remove(lastImage);
			glist.add(image);	
			this.lastImage = image;
			this.x = x;
			this.y = y;
			
			var txOff:int = Math.max(dborderWidth * 1.5, (image.scaledWidth / 2));
			var tyOff:int = Math.max(dborderWidth * 1.5, (image.scaledHeight / 2));
			
			text.x = txOff;
			text.y = tyOff;
			text.resizable = false;
			text.width = dwidth - (2 * txOff);
			text.height = dheight - (2 * tyOff);
			text.text = string;
			text.align = align;
			text.wordWrap = true;
			text.size = textSize;
		}
	}

}
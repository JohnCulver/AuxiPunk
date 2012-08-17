package com.auxiliumgames.base.display {
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	/**
	 * A class for displaying a dialog box, that can have a portrait in the top left 
	 * corner. Useful for displaying conversation within a game.
	 * @author jculver
	 */
	public class Dialog extends Entity {
		//Graphical information
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
		
		/**
		 * 
		 * @param	width			The total width of the dialog.
		 * @param	height			The total height of the dialog.
		 * @param	borderWidth		The width of the border around the dialog.
		 * @param	layer			The layer should the dialog be displayed in.
		 * @param	bgColor			The color behind the text.
		 * @param	borderColor		The color of the border.
		 * @param	textColor		The color of the text.
		 */
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
		
		/**
		 * To show the dialog on the screen.
		 * This should be called around the same time as this is added to the world.
		 * Remove it from the World to make it go away.
		 * 
		 * 
		 * @param	x				The x coordinate of the top left corner.
		 * @param	y				The y coordinate of the top left corner.
		 * @param	string			The actual dialog text.
		 * @param	image			The image (portrait) to display in the top left corner. Can be null.
		 * @param	textSize		The font size.
		 * @param	align			The alignment of the text. Values can be "left", "right" or "center".
		 */
		public function show(x:int, y:int, string:String, image:Image = null, textSize:uint = 16, align:String = "center"):void {
			if (lastImage)
				glist.remove(lastImage);
			if(image)
				glist.add(image);	
			this.lastImage = image;
			this.x = x;
			this.y = y;
			
			var txOff:int = Math.max(dborderWidth * 1.5, (image ? (image.scaledWidth / 2) : 0));
			var tyOff:int = Math.max(dborderWidth * 1.5, (image ? (image.scaledHeight / 2) : 0));
			
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
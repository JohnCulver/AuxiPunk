package com.auxiliumgames.base {
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author hi
	 */
	public class Bar extends Entity{
		private var notFull:Spritemap;
		private var full:Image;
		private var border:Boolean;
		private var glist:Graphiclist;
		private var _amount:uint;
		
		public function Bar(color:uint, fullColor:uint, width:uint, height:uint, border:Boolean = false, borderColor:uint = 0xFFFFFF, borderWidth:uint = 1) {
			notFull = new Spritemap(new BitmapData(width, height, false, color), width, height);
			notFull.add("be", [0]);
			notFull.play("be");
			full = new Image(new BitmapData(width, height, false, fullColor));
			this.border = border;
			if (this.border) {
				var topBorder:Image = new Image(new BitmapData(width + (2 * borderWidth), borderWidth, false, borderColor));
				var botBorder:Image = new Image(new BitmapData(width+ (2 * borderWidth), borderWidth, false, borderColor));
				var leftBorder:Image = new Image(new BitmapData(borderWidth, height, false, borderColor));
				var rightBorder:Image = new Image(new BitmapData(borderWidth, height, false, borderColor));
				glist = new Graphiclist(notFull, full, topBorder, botBorder, leftBorder, rightBorder);
				topBorder.y = -borderWidth;
				topBorder.x = -borderWidth;
				botBorder.x = -borderWidth;
				botBorder.y = height-borderWidth;
				rightBorder.x = width;
				leftBorder.x = -borderWidth;
			}
			else {
				glist = new Graphiclist(notFull, full);
			}
			graphic = glist;
			_amount = 100;
		}
		
		public function set amount(value:uint):void {
			if (value > 100) value = 100;
			_amount = value;
			if (_amount == 0) {
				notFull.visible = false;
				full.visible = false;
			}
			else if (_amount == 100) {
				full.visible = true;
				notFull.visible = false;
			}
			else {
				full.visible = false;
				notFull.visible = true;
				notFull.clipRect.width = full.width * (_amount / 100);
				notFull.clear();
				notFull.updateBuffer();
			}
		}
		
		public function get amount():uint {
			return _amount;
		}
		
	}

}
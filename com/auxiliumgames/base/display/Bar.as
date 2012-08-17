package com.auxiliumgames.base.display {
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * A generic class for  bars, like health bars etc.
	 * @author jculver
	 */
	public class Bar extends Entity {

		// Visual information
		private var notFull:Spritemap;
		private var full:Image;
		private var bg:Image;
		private var border:Boolean;
		private var glist:Graphiclist;
		
		//how full the bar is
		private var _amount:uint;
		
		/**
		 * 
		 * @param	fillColor		the color of the bar filling
		 * @param	fullColor		the color the filling should be when the bar is full
		 * @param	width			the total width of the bar
		 * @param	height			the total height of the bar
		 * @param	border			should the bar have a border
		 * @param	borderColor		the color of the border
		 * @param	borderWidth		the thickness of the border
		 * @param	bgColor			the color behind the filling, leave default for transparent
		 */
		public function Bar(fillColor:uint, fullColor:uint, width:uint, height:uint, border:Boolean = false, borderColor:uint = 0xFFFFFF, borderWidth:uint = 1, bgColor:int = -1) {
			glist = new Graphiclist();
			
			if(bgColor >= 0)
				bg = new Image(new BitmapData(width, height, false, bgColor));
			
			notFull = new Spritemap(new BitmapData(width, height, false, fillColor), width, height);
			notFull.add("be", [0]);
			notFull.play("be");
			
			full = new Image(new BitmapData(width, height, false, fullColor));
			
			if(bg)
				glist.add(bg);
			glist.add(notFull);
			glist.add(full);
			
			this.border = border;
			if (this.border) {
				var topBorder:Image = new Image(new BitmapData(width + (2 * borderWidth), borderWidth, false, borderColor));
				var botBorder:Image = new Image(new BitmapData(width+ (2 * borderWidth), borderWidth, false, borderColor));
				var leftBorder:Image = new Image(new BitmapData(borderWidth, height, false, borderColor));
				var rightBorder:Image = new Image(new BitmapData(borderWidth, height, false, borderColor));
				
				glist.add(topBorder);
				glist.add(botBorder);
				glist.add(leftBorder);
				glist.add(rightBorder);
				
				topBorder.y = -borderWidth;
				topBorder.x = -borderWidth;
				botBorder.x = -borderWidth;
				botBorder.y = height-borderWidth;
				rightBorder.x = width;
				leftBorder.x = -borderWidth;
			}
			graphic = glist;
			_amount = 100;
		}
		
		
		/**
		 * @param value 	How full we want the bar to be. 
		 * 					Should be between 0 and 100.
		 */
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
		
		/**
		 * @return	How full the bar is currently.
		 */
		public function get amount():uint {
			return _amount;
		}
		
	}

}
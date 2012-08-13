package com.auxiliumgames.base.shmup 	
{
	import com.auxiliumgames.base.example.assets.tex.TEXTURES;
	import com.auxiliumgames.base.Globals;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author jculver
	 */
	public class Bullet extends Entity
	{
		private var updateMyLocation:Function;
		private var amIdead:Function;
		private var updateCount:Number;
		private var whenIamDead:Function;
		private var forcedToBeClear:Boolean;
		private var image:Image;
		
		public function Bullet() {
			this.layer = Globals.LAYER_BULLET;
		}
		
		public function spawn(startx:Number, starty:Number, updateMyLocation:Function, amIdead:Function, whenIamDead:Function, image:Image, hitBox:Rectangle, type:String = "bullet"):void {
			x = startx;
			y = starty;
			this.updateMyLocation = updateMyLocation;
			this.amIdead = amIdead;
			this.whenIamDead = whenIamDead;
			this.image = image;
			setHitboxTo(hitBox);
			this.type = type;
			this.graphic = image;
			forcedToBeClear = false;
			updateCount = 0;
			this.collidable = true;
		}
		
		override public function update():void {
			if (amIdead(this,updateCount) || forcedToBeClear) {
				whenIamDead(this,world);
				this.collidable = false;
				return;
			}
			updateMyLocation(this, updateCount);	
			updateCount++;
		}
		
		public function forceClear():void {
			forcedToBeClear = true;
		}
	}

}
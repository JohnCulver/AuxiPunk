package com.auxiliumgames.base.shmup 	
{
	import com.auxiliumgames.example.assets.tex.TEXTURES;
	import com.auxiliumgames.base.Utils;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * Represents a bullet or any other type of projectile.
	 * @author jculver
	 */
	public class Bullet extends Entity
	{
		private var updateMyLocation:Function;
		private var amIdead:Function;
		private var updateCount:Number;
		private var forcedToBeClear:Boolean;
		private var image:Image;
		
		public function Bullet() {
		}
		
		/**
		 * Resets the bullet to start on a new path.
		 * 
		 * @param	startx				The x coord of where the bullet should start.
		 * @param	starty				The y coord of where the bullet should start.
		 * 
		 * @param	updateMyLocation	The method we will pass the bullet to, and we will also pass in the number of updates. 
		 * 								This will move the bullet each frame.
		 * 
		 * @param	amIdead				We will pass the bullet and the number of updates to this function to determine if
		 * 								the bullet has come to an end.
		 * 
		 * 
		 * @param	image				The graphic of the bullet.
		 * @param	hitBox				The hitbox used for collision.
		 * @param	layer				The layer for the bullet.
		 * @param	type				The type used for collision.
		 */
		public function spawn(startx:Number, starty:Number, updateMyLocation:Function, amIdead:Function, image:Image, hitBox:Rectangle, layer:uint, type:String = "bullet"):void {
			x = startx;
			y = starty;
			this.updateMyLocation = updateMyLocation;
			this.amIdead = amIdead;
			this.image = image;
			setHitboxTo(hitBox);
			this.type = type;
			this.graphic = image;
			forcedToBeClear = false;
			updateCount = 0;
			this.collidable = true;
			this.layer = layer;
		}
		
		/**
		 * Here we update the position, checl if the bullet is at an end,
		 * and call the onComplete functions when necessary.
		 */
		override public function update():void {
			if (amIdead(this,updateCount) || forcedToBeClear) {
				this.collidable = false;
				FP.world.recycle(this);
				return;
			}
			updateMyLocation(this, updateCount);	
			updateCount++;
		}
		
		/**
		 * Used to manually bring a bullet to it's end.
		 */
		public function forceClear():void {
			forcedToBeClear = true;
		}
	}

}
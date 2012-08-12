package com.auxiliumgames.base.example {
	import flash.net.SharedObject;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author hi
	 */
	public class SharedObjectDemoWorld extends World{
		private var t:Text;
		
		public function SharedObjectDemoWorld() {
			t = new Text("");
			add(new Entity(50, 50, t));
			
			var local:SharedObject = SharedObject.getLocal("gameNameSaveData");
			if (!local.data.number) {
				local.data.number = 1;
			}
			else {
				local.data.number++;
			}
			if (!local.data.complex) {
				var co:ComplexObject = new ComplexObject();
				co.property1 = "SimpleString";
				co.strings.push('1');
				co.strings.push('2');
				local.data.complex = co;
			}
			else {
				var lco:Object = local.data.complex as Object;
			}
			local.close();
		}
		
		override public function update():void {
			super.update();
		}
		
	}

}
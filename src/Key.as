package  
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class Key 
	{
		static private var keys:Array = [];
		
		static public function init(stg:Stage):void
		{
			stg.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stg.addEventListener(KeyboardEvent.KEY_UP, onKeyRel);
		}
		
		static private function onKeyRel(e:KeyboardEvent):void 
		{
			keys[e.keyCode] = false;
		}
		
		static private function onKeyDown(e:KeyboardEvent):void 
		{
			keys[e.keyCode] = true;
			//trace(e.keyCode);
		}
		
		static public function forceUp(kc:int):void {
			keys[kc] = false;
		}
		
		static public function isDown(kc:int):Boolean {
			return (keys[kc] == true);
		}

		
	}

}
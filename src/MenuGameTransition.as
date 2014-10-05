package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class MenuGameTransition extends Sprite 
	{
		[Embed(source = "../img/stage/stage1to2.png")] private var transition:Class;
		
		private const offset:int = 1200;
		private var trans_bmp:Bitmap = new transition();
		
		public function MenuGameTransition(_r:Sprite, stg:Stage) 
		{
			super();
			_r.y = offset;
			this.y = -offset;
			Main(_r).menu.y = -offset;
			
			trans_bmp.y = Main(_r).menu.height;
			
			addChild(trans_bmp);
			addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function onEnter(e:Event):void 
		{
			root.y -= (root.y) / 10;
			if (root.y <= 0) {
				root.y = 0;
				Main(root).removeChild(Main(root).menu);
				parent.removeChild(this);
				removeEventListener(Event.ENTER_FRAME, onEnter);
			}
		}
		
	}

}
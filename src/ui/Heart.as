package ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class Heart extends Sprite 
	{
		[Embed(source = "../../img/ui/heart.1.png")] private var container:Class;
		[Embed(source = "../../img/ui/heart.2.png")] private var heart:Class;
		
		private var cont_bmp:Bitmap = new container();
		private var heart_bmp:Bitmap = new heart();
		
		public function Heart() 
		{
			super();
			addChild(cont_bmp);
			addChild(heart_bmp);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		private function onRemove(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			removeEventListener(Event.ENTER_FRAME, die);
		}
		
		public function lose():void {
			addEventListener(Event.ENTER_FRAME, die);
		}
		
		private function die(e:Event):void 
		{
			heart_bmp.y ++;
			heart_bmp.alpha -= .1;
			if (heart_bmp.alpha <= 0) {
				heart_bmp.y = 0;
				removeEventListener(Event.ENTER_FRAME, die);
			}
		}
		
	}

}
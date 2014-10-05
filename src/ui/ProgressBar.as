package ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class ProgressBar extends Sprite 
	{
		[Embed(source = "../../img/ui/progressbar/icon.png")] private var icon:Class;
		[Embed(source = "../../img/ui/progressbar/moon.png")] private var moon:Class;
		[Embed(source = "../../img/ui/progressbar/progressbg.png")] private var bar:Class;
		
		private var icon_bmp:Bitmap = new icon();
		private var moon_bmp:Bitmap = new moon();
		private var bar_bmp:Bitmap = new bar();
		
		public function ProgressBar() 
		{
			super();
			
			moon_bmp.x = bar_bmp.width - moon_bmp.width / 2;
			
			setPos(0);
			
			addChild(bar_bmp);
			addChild(moon_bmp);
			addChild(icon_bmp);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		private function onRemove(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			removeEventListener(Event.ENTER_FRAME, onHiding);
		}
		
		public function setPos(pos:Number):void {
			if (pos > 100) pos = 100;
			icon_bmp.x = (pos / 100) * (bar_bmp.width - icon_bmp.width / 2);
		}
		
		public function hide():void {
			addEventListener(Event.ENTER_FRAME, onHiding);
		}
		
		private function onHiding(e:Event):void 
		{
			if (Game.paused) return;
			y += 2;
			if (y >= Game.stage.stageWidth + 50) {
				parent.removeChild(this);
			}
		}
		
	}

}
package ui
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class LaunchBar extends Sprite
	{
		[Embed(source = "../../img/Launchbar.png")]private var barIMG:Class;
		[Embed(source = "../../img/Launchbar_cursor.png")]private var barcursorIMG:Class;
		
		private var bar_bmp:Bitmap = new barIMG();
		private var cursor_bmp:Bitmap = new barcursorIMG();
		
		private var velocity:int = 0;
		private var acceleration:int = 2;
		private var done:Boolean = false;
		
		public function LaunchBar() 
		{
			x = Game.stage.stageWidth / 2 - bar_bmp.width / 2;
			cursor_bmp.y = bar_bmp.height / 2 - cursor_bmp.height / 2;
			addChild(bar_bmp);
			addChild(cursor_bmp);
			addEventListener(Event.ENTER_FRAME, onEnter);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		private function onRemove(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			removeEventListener(Event.ENTER_FRAME, fadeAway);
			removeEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function onEnter(e:Event):void 
		{
			if (Game.paused) return;
			
			velocity+=acceleration;
			cursor_bmp.x += velocity;
			if (cursor_bmp.x + cursor_bmp.width >= bar_bmp.width) {
				velocity = 0;
				acceleration *= -1;
				cursor_bmp.x = bar_bmp.width - cursor_bmp.width;
			}
			
			if (cursor_bmp.x <= 0) {
				cursor_bmp.x = 0;
				velocity = 0;
				acceleration *= -1;
			}
			
			if (Key.isDown(32)) {
				removeEventListener(Event.ENTER_FRAME, onEnter);
				velocity = 0;
				acceleration = 0;
				var score:int = Math.abs((cursor_bmp.x + cursor_bmp.width / 2) - bar_bmp.width / 2);
				
				if (score < 95) {
					//in winner zone
				}else if (score < 200) {
					//in okay zone
				}else {
					//in lame zone
				}
				
				addEventListener(Event.ENTER_FRAME, fadeAway);
				Game.launch(score);
			}
		}
		
		private function fadeAway(e:Event):void 
		{
			if (Game.paused) return;
			y -= 5;
			if (y <= -100) {
				parent.removeChild(this);
			}
		}
		
	}

}
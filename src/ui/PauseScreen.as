package ui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class PauseScreen extends Sprite 
	{
		[Embed(source = "../../img/ui/pause/pausebg.png")] private var menu:Class;
		
		private var menu_bmp:Bitmap = new menu();
		private var mute_btn:MuteButton = new MuteButton();
		private var esc_btn:EscapeButton = new EscapeButton();
		private var frozenBG:Bitmap;
		private var step:int = 0;
		
		public function PauseScreen() 
		{
			super();
			
			frozenBG = new Bitmap(new BitmapData(Game.stage.stageWidth, Game.stage.stageHeight));
			
			frozenBG.bitmapData.draw(Game.stage);
			
			mute_btn.x = Game.stage.stageWidth - mute_btn.width - 10;
			mute_btn.y = Game.stage.stageHeight - mute_btn.height - 10;
			
			addChild(frozenBG);
			addChild(menu_bmp);
			addChild(mute_btn);
			addChild(esc_btn);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			addEventListener(Event.ENTER_FRAME, blurBG);
		}
		
		private function blurBG(e:Event):void 
		{
			var bf:BlurFilter = new BlurFilter(5, 5);
			frozenBG.bitmapData.applyFilter(frozenBG.bitmapData, frozenBG.bitmapData.rect, new Point(0, 0), bf);
			step++;
			if (step > 5) {
				removeEventListener(Event.ENTER_FRAME, blurBG);
			}
		}
		
		private function onRemove(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			removeEventListener(Event.ENTER_FRAME, blurBG);
		}
		
	}

}
package MapEffects 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class Star extends Sprite 
	{
		[Embed(source = "../../img/map/etc/stars/star_layer.png")] private var star1:Class;
		[Embed(source = "../../img/map/etc/stars/star_layer2.png")] private var star2:Class;
		[Embed(source = "../../img/map/etc/stars/star_layer2B.png")] private var star3:Class;
		
		
		private var star_bmp:Bitmap;
		
		public function Star() 
		{
			super();
			
			x = Game.stage.stageWidth + 10;
			y = Utils.randomMinMax( -10, Game.stage.stageWidth);
			if (Game.on_moon) y -= 20;
			
			star_bmp = new this["star" + Utils.randomMinMax(1, 3)]();
			
			addChild(star_bmp);
			addEventListener(Event.ENTER_FRAME, onEnter);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		private function onRemove(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			removeEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function onEnter(e:Event):void 
		{
			if (Game.paused) return;
			x -= 3;
			if (x <= -100) {
				parent.removeChild(this);
			}
		}
		
	}

}
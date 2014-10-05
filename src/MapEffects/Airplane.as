package MapEffects 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class Airplane extends Sprite 
	{
		[Embed(source = "../../img/interactive/beach/plane.1.png")] private var plane:Class;
		
		private var plane_bmp:Bitmap = new plane();
		private var speedX:int = 0;
		private var speedY:int = 0;
		
		public function Airplane() 
		{
			super();
			
			if (Math.random() < .5) {
				//go left
				speedX = Utils.randomMinMax( -8, -5);
				x = Game.stage.stageWidth + 100;
			}else {
				//go right
				speedX = Utils.randomMinMax(5, 8);
				scaleX = -1;
				x = -100;
			}
			
			speedY = Utils.randomMinMax( 1, 2);
			y = -100;
			
			addChild(plane_bmp);
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
			x += speedX;
			y += speedY;
			
			if (scaleX == 1) {
				//going left
				if (x <= -100) {
					parent.removeChild(this);
				}
			}else {
				//going right
				if (x > Game.stage.stageWidth + 100) {
					parent.removeChild(this);
				}
			}
		}
		
	}

}
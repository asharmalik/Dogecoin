package MapEffects 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class FlappyBird extends Sprite 
	{
		[Embed(source = "../../img/interactive/beach/flappybird.png")] private var bird:Class;
		
		private var bird_bmp:Bitmap = new bird();
		private var g:int = 0;
		private var speedX:int;
		
		public function FlappyBird() 
		{
			super();
			
			y = - 20;
			speedX = (Math.random() < .5)? -2:2;
			
			if (speedX < 0) {
				scaleX = -1;
				x = Game.stage.stageWidth;
			}
			
			addChild(bird_bmp);
			addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function onEnter(e:Event):void 
		{
			if (Game.paused) return;
			g++;
			y += g;
			y += 2;
			x += speedX;
			if (Math.random() < .15) {
				g = -5;
			}
			rotation = g*speedX;
		}
		
	}

}
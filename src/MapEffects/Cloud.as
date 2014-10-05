package MapEffects 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class Cloud extends Sprite 
	{
		[Embed(source = "../../img/map/etc/clouds/cloud1.png")] private var cloud1:Class;
		[Embed(source = "../../img/map/etc/clouds/cloud2.png")] private var cloud2:Class;
		[Embed(source = "../../img/map/etc/clouds/cloud3.png")] private var cloud3:Class;
		[Embed(source = "../../img/map/etc/clouds/cloud4.png")] private var cloud4:Class;
		[Embed(source = "../../img/map/etc/clouds/cloud5.png")] private var cloud5:Class;
		[Embed(source = "../../img/map/etc/clouds/cloud6.png")] private var cloud6:Class;
		[Embed(source = "../../img/map/etc/clouds/cloud7.png")] private var cloud7:Class;
		
		static private var VERT_SPEED:int = 5;
		
		private var cloud_bmp:Bitmap;
		private var speedX:int;
		private var speedY:int;
		
		public function Cloud() 
		{
			super();
			var id:int = Utils.randomMinMax(1, 7);
			cloud_bmp = new this["cloud" + String(id)]();
			x = Utils.randomMinMax( -50, Game.stage.stageWidth - 50);
			y = Utils.randomMinMax( -200, -100);
			
			speedX = Utils.randomMinMax( -10, -4);
			if(speedX == 0)speedX = Utils.randomMinMax( -2, 0); 
			speedY = VERT_SPEED;
			
			if (Game.launching) {
				speedY = 0;
				y = Utils.randomMinMax(0, 150);
				x = Game.stage.stageWidth;
				speedX = Utils.randomMinMax( -5, -2);
			}
			
			addChild(cloud_bmp);
			addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function onEnter(e:Event):void 
		{
			if (Game.paused) return;
			if (speedY == 0 && !Game.launching) speedY = VERT_SPEED;
			x += speedX;
			y += speedY;
		}
		
	}

}
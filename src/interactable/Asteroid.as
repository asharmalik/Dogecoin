package interactable  
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class Asteroid extends Sprite 
	{
		[Embed(source="../../img/interactive/asteroid/asteroid.1.png")] private var asteroid_1:Class;
		
		private var types:int = 1;
		private var angularVelocity:Number = 0;
		public var speedX:int;
		public var speedY:int;
		
		public function Asteroid() 
		{
			super();
			var added:DisplayObject = addChild(new this["asteroid_" + Utils.randomMinMax(1, types)]());
			
			while(angularVelocity == 0) angularVelocity = Utils.randomMinMax( -5, 8);
			
			this.x = Game.stage.stageWidth + 40;
			this.y =  Utils.randomMinMax(50, Game.stage.stageHeight);
			
			speedX = Utils.randomMinMax( -10, -5);
			speedY = Utils.randomMinMax( -2, 2);
			
			added.x = -width / 2;
			added.y = -height / 2;
			
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
			this.rotation += angularVelocity;
			this.x += speedX;
			this.y += speedY;
			
			//hit test
			if (Math.abs(Game.dogesled.x - this.x) <= ((Game.dogesled.width + this.width) / 2 ) *.7 &&
					Math.abs(Game.dogesled.y - this.y) <= ((Game.dogesled.height + this.height) / 2) * .6){
				Game.asteroidHit(this);
			}
			
			if (this.x < -100) {
				parent.removeChild(this);
			}
		}
		
	}

}
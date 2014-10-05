package interactable 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class PowerUp extends Sprite 
	{
		public static const MAGNET:int = 0;
		public static const MULTIPLIER:int = 1;
		public static const SHIELD:int = 2;
		
		public static const MAGNET_TIME:int = 30 * 10;
		public static const MULT_TIME:int = 30 * 10;
		public static const SHIELD_TIME:int = 30 * 5;
		
		public static const MULT_COIN_TIME:int = 50;
		
		[Embed(source = "../../img/interactive/powerups/magnet.png")] private var magnet:Class;
		[Embed(source = "../../img/interactive/powerups/moneymult.png")] private var mult:Class;
		[Embed(source = "../../img/interactive/powerups/shield.png")] private var shield:Class;
		
		private var type:int = 0;
		private var speedX:int = 0;
		private var speedY:int = 0;
		private var fade:Boolean = false;
		
		public function PowerUp() 
		{
			super();
			type = Utils.randomMinMax(0, 2);
			if (type == PowerUp.MAGNET) {
				addChild(new magnet());
			}else if (type == PowerUp.MULTIPLIER) {
				addChild(new mult());
			}else if (type == PowerUp.SHIELD) {
				addChild(new shield());
			}
			
			if(!Game.goingUp){
				x = Game.stage.stageWidth + 100;
				y = Utils.randomMinMax(0, Game.stage.stageHeight - 50);
				
				speedX = Utils.randomMinMax( -6, -12);
				speedY = Utils.randomMinMax( -2, 2);
			}else {
				if(Game.sled_type == Sled.ROCKET){
					x = Utils.randomMinMax(0, Game.stage.stageWidth - 50);
					y = - 100;
					
					speedX = Utils.randomMinMax( -2, 2);
					speedY = Utils.randomMinMax( 6, 12);
				}else {
					x = Utils.randomMinMax(50, Game.stage.stageWidth + 100);
					y = -100;
					speedX = Utils.randomMinMax( -10, -5);
					speedY = Utils.randomMinMax(6, 12);
				}
			}
			
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
			
			if (fade) {
				alpha -= .08;
			}
			
			if (this.hitTestObject(Game.dogesled)) {
				fade = true;
				Game.applyPowerUp(this.type);
			}
			
			if (x <= -100 || y>Game.stage.stageHeight + 50 || alpha<=0) {
				parent.removeChild(this);
			}
		}
		
	}

}
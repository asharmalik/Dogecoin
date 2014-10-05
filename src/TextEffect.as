package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class TextEffect extends Sprite
	{
		static private var amount:int = 0;
		static public var COIN_GET:int = 0;
		static public var HURT:int = 1;
		
		[Embed(source = "../img/map/text/coin.1.png")] private var coin1:Class;
		[Embed(source = "../img/map/text/coin.2.png")] private var coin2:Class;
		[Embed(source = "../img/map/text/coin.3.png")] private var coin3:Class;
		[Embed(source = "../img/map/text/coin.4.png")] private var coin4:Class;
		[Embed(source = "../img/map/text/coin.5.png")] private var coin5:Class;
		private const COIN_GET_AMOUNT:int = 5;
		
		[Embed(source = "../img/map/text/meteor.1.png")] private var hurt1:Class;
		[Embed(source = "../img/map/text/meteor.2.png")] private var hurt2:Class;
		[Embed(source = "../img/map/text/meteor.3.png")] private var hurt3:Class;
		[Embed(source = "../img/map/text/meteor.4.png")] private var hurt4:Class;
		private const HURT_AMOUNT:int = 4;
		
		public function TextEffect(type:int, _x:int, _y:int) 
		{
			super();
			
			x = _x - Utils.randomMinMax(-15, 15);
			y = _y - Utils.randomMinMax( -8, 8) - amount * 20;
			TextEffect.amount++;
			
			
			if (type == TextEffect.COIN_GET) {
				addChild(new this["coin" + Utils.randomMinMax(1, COIN_GET_AMOUNT)]());
			}else if (type == TextEffect.HURT) {
				addChild(new this["hurt" + Utils.randomMinMax(1, HURT_AMOUNT)]());
			}
			
			addEventListener(Event.ENTER_FRAME, onEnter);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		private function onRemove(e:Event):void 
		{
			TextEffect.amount--;
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			removeEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function onEnter(e:Event):void 
		{
			if (Game.paused) return;
			y--;
			alpha -= .03;
			if (alpha <= 0) {
				parent.removeChild(this);
			}
		}
		
	}

}
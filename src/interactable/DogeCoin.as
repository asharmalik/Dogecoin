package interactable
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class DogeCoin extends Sprite 
	{
		[Embed(source = "../../img/interactive/dogecoin/dgB.1.png")] private var dgL1:Class;
		[Embed(source = "../../img/interactive/dogecoin/dgB.2.png")] private var dgL2:Class;
		[Embed(source = "../../img/interactive/dogecoin/dgB.3.png")] private var dgL3:Class;
		[Embed(source = "../../img/interactive/dogecoin/dgM.1.png")] private var dgM1:Class;
		[Embed(source = "../../img/interactive/dogecoin/dgM.2.png")] private var dgM2:Class;
		[Embed(source = "../../img/interactive/dogecoin/dgM.3.png")] private var dgM3:Class;
		[Embed(source = "../../img/interactive/dogecoin/dgS.1.png")] private var dgS1:Class;
		[Embed(source = "../../img/interactive/dogecoin/dgS.2.png")] private var dgS2:Class;
		[Embed(source = "../../img/interactive/dogecoin/dgS.3.png")] private var dgS3:Class;
		
		private var ticker:int = 0;
		private var animation:Array = new Array();
		private var current:Bitmap;
		private var currentID:int = 0;
		
		private var speedX:int = 0;
		private var speedY:int = 0;
		private var angularSpeed:int = 0;
		private var offsetX:int;
		private var offsetY:int;
		
		private const AMOUNT_SML:int = 1;
		private const AMOUNT_MED:int = 5;
		private const AMOUNT_LRG:int = 10;
		private var amount:int = 1;
		private var loss:Boolean = false;
		
		public var fade:Boolean = false;
		
		public function DogeCoin(loss:Boolean = false) 
		{
			super();
			
			var type:int = Utils.randomMinMax(1, 3);
			
			if (loss) type = 1;
			
			if (type == 1) {
				amount = AMOUNT_SML;
				animation = [new dgS1(),new dgS2(),new dgS3()];
			}else if (type == 2) {
				amount = AMOUNT_MED;
				animation = [new dgM1(), new dgM2(), new dgM3()];
			}else if (type == 3) {
				amount = AMOUNT_LRG;
				animation = [new dgL1(), new dgL2(), new dgL3()];
			}
			
			current = animation[0];
			
			offsetX = -current.width / 2;
			offsetY = -current.height / 2;
			
			current.x = offsetX;
			current.y = offsetY;
			
			if(!loss){
				if(!Game.goingUp)angularSpeed = Utils.randomMinMax( -15, 15);
				
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
					}else if (Game.sled_type == Sled.BOBSLED) {
						x = Utils.randomMinMax(50, Game.stage.stageWidth + 100);
						y = -100;
						speedX = Utils.randomMinMax( -10, -5);
						speedY = Utils.randomMinMax(6, 12);
					}
				}
			}else {
				x = Game.dogesled.x;
				y = Game.dogesled.y;
				
				fade = true;
				this.loss = true;
				
				speedX = Utils.randomMinMax( -10, 10);
				speedY = Utils.randomMinMax( -10, 10);
			}
			
			addChild(current);
			
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
			if(alpha == 1 || this.loss){
				x += speedX;
				y += speedY;
				rotation += angularSpeed;
			}
			ticker++;
			if (ticker > 2) {
				ticker = 0;
				removeChild(current);
				currentID++;
				if (currentID == animation.length) {
					currentID = 0;
				}
				
				current = animation[currentID];
				
				current.x = offsetX;
				current.y = offsetY;
				
				addChild(current);
			}
			
			if (!fade && (this.hitTestObject(Game.dogesled) || 
					(Game.magnet && Math.abs(Game.dogesled.x-this.x)<300 && Math.abs(Game.dogesled.y-this.y)<300))) {
				Game.coinHit(this);
			}
			
			if (fade && alpha > 0) {
				alpha -= .08;
				
				if(!this.loss){
					if(!Game.magnet){
						this.x += ((Game.doge_wallet.x + Game.doge_wallet.width / 3) - this.x) / 5;
						this.y += (Game.doge_wallet.y - this.y) / 5;
					}else {
						this.x += (Game.dogesled.x - this.x) / 5;
						this.y += (Game.dogesled.y - this.y) / 5;
					}
				}
			}
			
			if (x <= -100 || y>Game.stage.stageHeight + 50 || alpha<=0) {
				parent.removeChild(this);
			}
		}
		
		public function get _amount():int {
			return amount;
		}
	}

}
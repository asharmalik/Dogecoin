package  
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import interactable.Asteroid;
	import interactable.PowerUp;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class Sled extends Sprite 
	{
		static public const BOBSLED:int = 1;
		static public const ROCKET:int = 2;
		[Embed(source="../img/sleds/rocket/Rocket_small.png")] private var rocket_1:Class;
		[Embed(source="../img/sleds/rocket/Rocket_small2.png")] private var rocket_2:Class;
		[Embed(source = "../img/sleds/rocket/Rocket_small3.png")] private var rocket_3:Class;
		
		[Embed(source = "../img/sleds/bobsled/bobsledhelmet.png")] private var bobsled:Class;
		[Embed(source = "../img/sleds/bobsled/bobsledjump.png")] private var bobsled45:Class;
		
		private const X_SPEED:int = 10;
		private const Y_SPEED:int = 10;
		
		private var animation:Array = new Array();
		private var current:DisplayObject;
		private var currentID:int = 0;
		private var ticker:int = 0;
		private var base_rot:int;
		private var to_rot:int;
		private var extra_rot:int = 0;
		private var speedX:int = 0;
		private var speedY:int = 0;
		private var currentSled:int;
		private var invincible:int = 0;
		private var shieldTime:int = 0;
		
		public function Sled(sled:int) 
		{
			super();
			
			setSled(sled);
			
			addEventListener(Event.ENTER_FRAME, onEnter);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		private function onRemove(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			removeEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		public function beginSpin():void {
			addEventListener(Event.ENTER_FRAME, spin);
		}
		
		private function spin(e:Event):void 
		{
			if (Game.paused) return;
			rotation += 10;
			
			if (Game.transitioningToStage2 == 3) {
				if(currentSled == 2){
					if (Math.abs(rotation)<= 5) {
						rotation = base_rot = to_rot = 0;
						Game.transitioningToStage2 = 0;
						removeEventListener(Event.ENTER_FRAME, spin);
					}
				}
				if (currentSled == 1) {
					if (rotation-10<50 && rotation>=50){
						rotation = base_rot = to_rot = 0;
						Game.transitioningToStage2 = 0;
						setSled(0);
						removeEventListener(Event.ENTER_FRAME, spin);
					}
				}
			}
		}
		
		private function onEnter(e:Event):void 
		{
			if (Game.paused) return;
			
			if (invincible > 0) {
				invincible--;
				alpha = (alpha == .5)?1:.5;
				
				if (invincible < 20) {
					extra_rot = 0;
				}
				if (invincible == 0) {
					alpha = 1;
				}
			}
			
			if (shieldTime > 0) {
				shieldTime--;
				Game.shield_ind.alpha = shieldTime / PowerUp.SHIELD_TIME;
				if (shieldTime == 0) {
					Game.shield_ind.visible = false;
				}
			}
			
			to_rot = base_rot;
			if(!Game.launching){
				if((Key.isDown(37) || Key.isDown(65)) && !(Key.isDown(39) || Key.isDown(68))){
					//left key
					if (speedX > -X_SPEED) speedX--;
					if(Game.goingUp) to_rot = base_rot - 10;
					
					//boundary
					if (x <= 0) {
						x = speedX = 0;
						to_rot = base_rot;
					}
				}else if(!(Key.isDown(37) || Key.isDown(65)) && (Key.isDown(39) || Key.isDown(68))){
					//right key
					if (speedX < X_SPEED) speedX++;
					if (Game.goingUp) to_rot = base_rot + 10;
					
					//boundary
					if (x >= Game.stage.stageWidth) {
						x = Game.stage.stageWidth;
						speedX = 0;
						to_rot = base_rot;
					}
				}
				
				if ((!(Key.isDown(37) || Key.isDown(65)) && !(Key.isDown(39) || Key.isDown(68)))||
						((Key.isDown(37) || Key.isDown(65)) && (Key.isDown(39) || Key.isDown(68)) )) {
					if (speedX != 0) speedX += (speedX > 0)? -1:1;		
				}
				
				if ((Key.isDown(38) || Key.isDown(87)) && !(Key.isDown(40) || Key.isDown(83))) {
					//up key
					if (speedY > -Y_SPEED) speedY--;
					
					if (!Game.goingUp) to_rot = base_rot - 10;
					
					//boundary
					if (y <= 0) {
						y = speedY = 0;
						to_rot = base_rot;
					}
				}else if (!(Key.isDown(38) || Key.isDown(87)) && (Key.isDown(40) || Key.isDown(83))) {
					//down key
					if (speedY < Y_SPEED) speedY++;
					
					if (!Game.goingUp) to_rot = base_rot + 10;
					//boundary
					if (y >= Game.stage.stageHeight) {
						y = Game.stage.stageHeight;
						speedY = 0;
						to_rot = base_rot;
					}
				}
			}
			
			if (((Key.isDown(38) || Key.isDown(87)) && (Key.isDown(40) || Key.isDown(83))) ||
					(!(Key.isDown(38) || Key.isDown(87)) && !(Key.isDown(40) || Key.isDown(83)))) {
				if (speedY != 0) speedY += (speedY > 0)? -1:1;			
			}
			
			x += speedX;
			y += speedY;
			
			x = (x<0)?0:(x>Game.stage.stageWidth)?Game.stage.stageWidth:x;
			y = (y<0)?0:(y>Game.stage.stageHeight)?Game.stage.stageHeight:y;
			
			//handle rotation
			if (Game.transitioningToStage2 < 2 && rotation != (to_rot+extra_rot)) {
				rotation += (to_rot + extra_rot - rotation) / 3;
			}
			
			ticker++;
			
			//Every sprite appears for 2 frames.
			if (ticker >= 2 && animation.length>1) { 
				ticker = 0;
				removeChild(current);
				currentID++;
				if (currentID == animation.length) {
					currentID = 0;
				}
				current = animation[currentID];
				addChild(current);
			}
			
		}
		
		public function hurt(ast:DisplayObject):Boolean {
			if (invincible != 0 || shieldTime != 0) return false;
			
			invincible = 30;
			speedX /= 5;
			
			if (ast is Asteroid) {
				if (ast.y <= this.y) {
					Asteroid(ast).speedY = -Math.abs(Asteroid(ast).speedY) - 3;
					extra_rot = 10;
					speedY = 6;
				}else {
					Asteroid(ast).speedY = Math.abs(Asteroid(ast).speedY) + 3;
					extra_rot = -10;
					speedY = -6;
				}
			}
			
			return true;
		}
		
		public function shield():void {
			shieldTime = PowerUp.SHIELD_TIME;
			alpha = 1;
			invincible = 0;
			extra_rot = 0;
		}
		
		public function setSled(id:int):void {
			var offsetWidth:int = 0;
			var offsetHeight:int = 0;
			
			currentSled = id;
			
			animation = [];
			
			switch(id) {
				case 0://sled
					animation.push(new bobsled());
					
					offsetWidth = -animation[0].width / 2 + 3;
					offsetHeight = -animation[0].height / 2 - 6;
					break;
				case 1://45 deg sled
					animation.push(new bobsled45());
					offsetWidth = -animation[0].width / 2;
					offsetHeight = -animation[0].height / 2;
					break;
				case 2: //rocket
					animation.push(new rocket_1());
					animation.push(new rocket_2());
					animation.push(new rocket_3());
					animation.push(new rocket_2());
					
					rotation = base_rot = to_rot = -90;
					offsetWidth = -animation[0].width / 2;
					offsetHeight = -animation[0].height / 2;
					
					break;
				default:
						break;
			}
			
			
			
			for (var i:int = 0; i < animation.length; i++) {
				animation[i].x += offsetWidth;
				animation[i].y += offsetHeight;
			}
			
			if (current != null) {
				if(current.parent != null) current.parent.removeChild(current);
			}
			
			current = animation[0];
			
			addChild(current);
		}
	
		public function setSpeed(_x:int, _y:int):void {
			speedX = _x;
			speedY = _y;
		}
	}

}
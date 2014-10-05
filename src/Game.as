package  
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import interactable.Asteroid;
	import interactable.DogeCoin;
	import interactable.PowerUp;
	import MapEffects.Airplane;
	import MapEffects.FlappyBird;
	import ui.HeartsContainer;
	import ui.LaunchBar;
	import ui.LossEffect;
	import ui.PauseScreen;
	import ui.PowerUpIndicator;
	import ui.ProgressBar;
	import ui.ShareButton;
	import ui.Wallet;
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class Game 
	{
		static private const COIN_TIMER:int = 200;
		static private const LOSS_PER_HIT:Number = .01;
		static private const LVL_1_TIME:int = 10000;
		static private const _LIVES:int = 3;
		
		static public var stage:Stage;
		static public var root:Sprite;
		
		public static var dogesled:Sled;
		public static var globalSpeedX:int;
		public static var globalSpeedY:int;
		public static var transitioningToStage2:int; //0 when in stage 1; 1 when transitioning; 2 when fading stage2 in
		public static var current_stage:int;
		public static var progress:Number;
		public static var goingUp:Boolean ;
		public static var paused:Boolean;
		public static var muted:Boolean;
		public static var magnet:Boolean;
		public static var launching:Boolean;
		
		static public var doge_wallet:Wallet;
		
		static private var map:Map;
		static private var progress_bar:ProgressBar;
		static private var pause_screen:PauseScreen;
		static private var launch_bar:LaunchBar;
		static private var mag_ind:PowerUpIndicator;
		static private var mult_ind:PowerUpIndicator;
		static public var shield_ind:PowerUpIndicator;
		static public var container:HeartsContainer;
		static public var on_moon:Boolean = false;
		
		static private var coins:int = 0;
		static private var to_lose:int = 0;
		static private var magnet_time:int = 0;
		static private var mult_time:int = 0;
		static private var stopFX:Boolean;
		static public var sled_type:int = Sled.ROCKET;
		static private var PROGRESS_SPEED:Number = .01 * 11; //out of 100
		static private var lives:int;
		
		static private var astTimer:Timer;
		static private var coinTimer:Timer;
		static private var levelTimer:Timer;
		static private var levelFXStopTimer:Timer;
		static private var powerTimer:Timer;
		static private var beachFXTimer:Timer;
		
		static public function start(rt:Sprite = null, stg:Stage = null):void {
			if (rt != null) {
				Key.init(stg);
				stage = stg;
				root = rt;
			}
			
			stopFX = false;
			on_moon = false;
			paused = magnet = false;
			launching = goingUp = true;
			progress = transitioningToStage2 = transitioningToStage2 = globalSpeedX = globalSpeedX = 0;
			current_stage = 1;
			
			map = new Map();
			dogesled = new Sled(sled_type);
			progress_bar = new ProgressBar();
			launch_bar = new LaunchBar();
			doge_wallet = new Wallet(coins);
			mag_ind = new PowerUpIndicator(PowerUp.MAGNET);
			mult_ind = new PowerUpIndicator(PowerUp.MULTIPLIER);
			shield_ind = new PowerUpIndicator(PowerUp.SHIELD);
			container = new HeartsContainer(_LIVES);
			
			mag_ind.visible = mult_ind.visible = shield_ind.visible = false;
			
			dogesled.y = 300;
			dogesled.x = 100;
			lives = _LIVES;
			
			container.y = 3;
			container.x = Game.stage.stageWidth - container.width - 3;
			
			mag_ind.x = Game.stage.stageWidth - mag_ind.width + 3;
			mag_ind.y = Game.stage.stageHeight - mag_ind.height - 5;
			
			shield_ind.x = mag_ind.x - shield_ind.width + 6 ;
			shield_ind.y = Game.stage.stageHeight - shield_ind.height - 5;
			
			mult_ind.x = shield_ind.x - mult_ind.width + 3;
			mult_ind.y = Game.stage.stageHeight - mult_ind.height - 5;
			
			//set up asteroid interval
			astTimer = new Timer(2000);
			astTimer.addEventListener(TimerEvent.TIMER, onCreateAsteroid);
			
			//set up coin interval
			coinTimer = new Timer(Game.COIN_TIMER);
			coinTimer.addEventListener(TimerEvent.TIMER, onCreateCoin);
			
			
			//set up level change timer
			levelTimer = new Timer(LVL_1_TIME, 1);
			levelTimer.addEventListener(TimerEvent.TIMER, onLevelChange);
			
			levelFXStopTimer = new Timer(LVL_1_TIME-5000, 1);
			levelFXStopTimer.addEventListener(TimerEvent.TIMER, onStopFX);
			
			//set up power up timer
			powerTimer = new Timer(3000);
			powerTimer.addEventListener(TimerEvent.TIMER, onCreatePowerUp);
			
			//set up beach effects timer (flappy bird, airplane)
			beachFXTimer = new Timer(2000);
			beachFXTimer.addEventListener(TimerEvent.TIMER, onCreateBeachFX);
			
			progress_bar.x = Game.stage.stageWidth / 2 - progress_bar.width / 2;
			progress_bar.y = Game.stage.stageHeight - progress_bar.height - 5;
			
			doge_wallet.y = Game.stage.stageHeight - doge_wallet.height - 5;
			
			Game.root.addChild(map);
			Game.root.addChild(dogesled);
			Game.root.addChild(launch_bar);
			Game.root.addChild(mult_ind);
			Game.root.addChild(mag_ind);
			Game.root.addChild(shield_ind);
			Game.root.addChild(new FlappyBird());
			Game.root.addChild(container);
			
			Game.map.beginLaunch(sled_type);
			
			Game.root.addChild(new FPSTimer());
			Game.root.addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		static public function togglePause():void {
			paused = !paused;
				if (paused) {
					pause_screen = PauseScreen(Game.root.addChild(new PauseScreen()));
				}else {
					if(pause_screen != null)
						Game.root.removeChild(pause_screen);
				}
		}
		
		static public function stop():void {
			astTimer.removeEventListener(TimerEvent.TIMER, onCreateAsteroid);
			astTimer.stop();
			
			coinTimer.removeEventListener(TimerEvent.TIMER, onCreateCoin);
			coinTimer.stop();
			//TODO: finish this
			//Make sure all these garbage collect
			root.removeChild(map);
			root.removeChild(dogesled);
			root.removeChild(new Asteroid());
			root.removeChild(new FPSTimer());
		}
		
		static public function asteroidHit(ast:Asteroid):void {
			if (Game.dogesled.hurt(ast)) {
				Game.root.addChild(new TextEffect(TextEffect.HURT, Game.dogesled.x, Game.dogesled.y));
				
				var loss:int = coins * LOSS_PER_HIT;
				
				to_lose += loss;
				
				Game.container.loseHeart();
				lives--;
				
				if (lives <= 0) {
					//TODO: dying
				}
				
				if (loss == 0) return;
				
				Game.root.addChild(new LossEffect(loss));
				
				for (var i:int = 0; i < loss; i++) {
					Game.root.setChildIndex(root.addChild(new DogeCoin(true)), getNextIndex());
				}
			}
		}
		
		static public function coinHit(coin:DogeCoin):void {
			coin.fade = true;
			coins += coin._amount;
			Game.doge_wallet.update(coins);
			if (Math.random() < .4) {
				var te:TextEffect = new TextEffect(TextEffect.COIN_GET, Game.dogesled.x, Game.dogesled.y);
				Game.root.addChild(te);
			}
		}
		
		static public function applyPowerUp(id:int):void {
			if (id == PowerUp.MAGNET) {
				Game.magnet = true;
				Game.magnet_time = PowerUp.MAGNET_TIME;
				Game.mag_ind.visible = true;
			}else if (id == PowerUp.MULTIPLIER) {
				coinTimer.delay = PowerUp.MULT_COIN_TIME;
				Game.mult_time = PowerUp.MULT_TIME;
				Game.mult_ind.visible = true;
			}else if (id == PowerUp.SHIELD) {
				Game.dogesled.shield();
				Game.shield_ind.visible = true;
			}
		}
		
		static public function launch(score:int):void {
			if (!Game.launching) return;
			astTimer.start();
			coinTimer.start();
			levelTimer.start();
			levelFXStopTimer.start();
			powerTimer.start();
			beachFXTimer.start();
			
			Game.root.addChild(progress_bar);
			Game.root.addChild(doge_wallet);
			Game.launching = false;
			
			Game.map.doLaunch();
		}
		
		static private function onEnter(e:Event):void 
		{
			if (Key.isDown(27)) {
				Key.forceUp(27);
				togglePause();
			}
			
			//Everything after this is strictly game related
			if (Game.paused) return;
			
			if (to_lose > 0) {
				to_lose--;
				coins--;
				if (to_lose > 30) {
					to_lose--;
					coins--;
				}
				Game.doge_wallet.update(coins);
			}
			
			if (Game.magnet_time > 0) {
				Game.magnet_time --;
				Game.mag_ind.alpha = Game.magnet_time / PowerUp.MAGNET_TIME;
				
				if (Game.magnet_time == 0) {
					Game.magnet = false;
					Game.mag_ind.visible = false;
				}
			}
			
			if (Game.mult_time > 0) {
				Game.mult_time--;
				Game.mult_ind.alpha = Game.mult_time / PowerUp.MULT_TIME;
				if (Game.mult_time == 0) {
					coinTimer.delay = Game.COIN_TIMER;
					Game.mult_ind.visible = false;
				}
			}
			
			if (!Game.launching) {
				progress += Game.PROGRESS_SPEED;
				progress_bar.setPos(progress);
				if (progress >= 101) {//go to moon
					progress = 100;
					Game.PROGRESS_SPEED = 0;
					on_moon = true;
					progress_bar.hide();
					map.gotoMoon();
				}
			}
		}
		
		static private function getNextIndex():int {
			if (progress_bar.parent != null) {
				return root.getChildIndex(progress_bar) - 1;
			}else {
				return root.getChildIndex(Game.dogesled);
			}
		}
		
		static private function onLevelChange(e:TimerEvent):void 
		{
			map.gotoSpace();
		}
		
		static private function onCreateCoin(e:TimerEvent):void 
		{
			if (Game.paused|| Game.transitioningToStage2 != 0) return;
			Game.root.setChildIndex(root.addChild(new DogeCoin()), getNextIndex());
		}
		
		static private function onCreateAsteroid(e:TimerEvent):void 
		{
			if (Game.paused|| Game.current_stage != 2) return;
			root.setChildIndex(root.addChild(new Asteroid()), getNextIndex());
		}
		
		static private function onCreatePowerUp(e:TimerEvent):void 
		{
			if (Game.paused|| Game.transitioningToStage2 != 0) return;
			Game.root.setChildIndex(Game.root.addChild(new PowerUp()), getNextIndex());
		}
		
		static private function onCreateBeachFX(e:TimerEvent):void 
		{
			if (Game.paused || Game.transitioningToStage2 != 0 || Game.current_stage != 1 || stopFX) return;
			
			if (Math.random() < .3) return; //make effects not appear too often
			
			if(Math.random()<.9){
				Game.root.setChildIndex(Game.root.addChild(new Airplane()), root.getChildIndex(Game.dogesled));
			}else {
				Game.root.setChildIndex(Game.root.addChild(new FlappyBird()), root.getChildIndex(Game.dogesled));
			}
		}
		
		static private function onStopFX(e:TimerEvent):void 
		{
			stopFX = true;
		}
	}

}
package  
{
	import flash.display.Bitmap;
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import MapEffects.Cloud;
	import MapEffects.SledRamp;
	import MapEffects.Star;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class Map extends Sprite 
	{
		[Embed(source = "../img/stage/stage1.1.png")] private var stage11:Class;
		[Embed(source = "../img/stage/stage2.1.png")] private var stage21:Class;
		[Embed(source = "../img/stage/stage2.2.png")] private var stage22:Class;
		[Embed(source = "../img/stage/stage2.3.png")] private var stage23:Class;
		[Embed(source = "../img/stage/stage2.4.png")] private var stage24:Class;
		[Embed(source = "../img/stage/stage1to2.png")] private var stage1to2:Class;
		
		[Embed(source = "../img/map/beach/shuttlelaunch.png")] private var shuttlelaunch:Class;
		[Embed(source = "../img/map/beach/sand.png")] private var sand:Class;
		[Embed(source = "../img/map/beach/sea.png")] private var sea:Class;
		
		[Embed(source = "../img/map/beach/back.beachhouse.1.png")] private var house1:Class;
		[Embed(source = "../img/map/beach/back.beachhouse.2.png")] private var house2:Class;
		
		[Embed(source = "../img/map/beach/bush.png")] private var bush1:Class;
		[Embed(source = "../img/map/beach/bush2.png")] private var bush2:Class;
		[Embed(source = "../img/map/beach/bush3.png")] private var bush3:Class;
		[Embed(source = "../img/map/beach/bush4.png")] private var bush4:Class;
		[Embed(source = "../img/map/beach/bush5.png")] private var bush5:Class;
		[Embed(source = "../img/map/beach/bush6.png")] private var bush6:Class;
		
		[Embed(source = "../img/map/beach/front.palmtree.1.png")] private var tree1:Class;
		[Embed(source = "../img/map/beach/front.palmtree.2.png")] private var tree2:Class;
		
		[Embed(source = "../img/map/moon/moon.back3.png")] private var moonback3:Class;
		[Embed(source = "../img/map/moon/moon.back2.png")] private var moonback2:Class;
		[Embed(source = "../img/map/moon/moon.back1.png")] private var moonback1:Class;
		
		[Embed(source = "../img/map/earth.png")] private var earth:Class;
		
		private var stage11_bmp:Bitmap = new stage11();
		private var stage21_bmp:Bitmap = new stage21();
		private var stage22_bmp:Bitmap = new stage22();
		private var stage23_bmp:Bitmap = new stage23();
		private var stage24_bmp:Bitmap = new stage24();
		
		private static const SCROLL_SPEEDY:int = 5; //of launch map
		private static const SCROLL_SPEEDX:int = -1; //of launch map
		private static const SCROLL_MOONX:int = -5;
		
		private var sledramp_mc:SledRamp;
		private var shuttlelaunch_bmp:Bitmap;
		private var sand_bmp:Bitmap;
		private var sea_bmp:Bitmap;
		private var house1_bmp:Bitmap;
		private var house2_bmp:Bitmap;
		private var earth_bmp:Bitmap;
		private var bushes:Array;
		private var trees:Array;
		
		private var i:int = 0;
		private var bgList:Array = new Array();
		private var moonList:Array = new Array();
		private var current:int = 1;
		private var speedX:int = 0;
		private var speedY:int = 0;
		private var starTimer:Timer;
		private var cloudTimer:Timer;
		private var removalTimer:Timer;
		
		private const X_SPEED:int = -2;
		
		public function Map() 
		{
			super();
			
			populateList(1);
			
			starTimer = new Timer(1000);
			starTimer.addEventListener(TimerEvent.TIMER, onAddStar);
			
			cloudTimer = new Timer(2000);//TODO: 500 for going upward
			cloudTimer.addEventListener(TimerEvent.TIMER, onAddCloud);
			cloudTimer.start();
			
			addEventListener(Event.ENTER_FRAME, scrollBG);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		public function beginLaunch(type:int):void {
			sand_bmp = new sand();
			sea_bmp = new sea();
			house1_bmp = new house1();
			house2_bmp = new house2();
			
			sand_bmp.y = Game.stage.stageHeight - sand_bmp.height;
			sea_bmp.y = Game.stage.stageHeight - sea_bmp.height;
			
			//ground
			Game.root.addChild(sea_bmp);
			Game.root.addChild(sand_bmp);
			
			//houses
			house1_bmp.y = Game.stage.stageHeight - house1_bmp.height - 20;
			house1_bmp.x = Utils.randomMinMax(20, Game.stage.stageWidth - house1_bmp.width - 20);
			
			house2_bmp.y = Game.stage.stageHeight - house1_bmp.height - 13;
			house2_bmp.x = Utils.randomMinMax(20, Game.stage.stageWidth - house1_bmp.width - 20);
			
			Game.root.addChild(house1_bmp);
			Game.root.addChild(house2_bmp);
			
			//ramp/shuttle
			if (type == Sled.BOBSLED) {
				sledramp_mc = new SledRamp();
				
				Game.root.addChild(sledramp_mc);
				Game.dogesled.visible = false;
			}else if (type == Sled.ROCKET) {
				shuttlelaunch_bmp = new shuttlelaunch();
				
				shuttlelaunch_bmp.x = Game.stage.stageWidth / 2 - shuttlelaunch_bmp.width / 2;
				shuttlelaunch_bmp.y = Game.stage.stageHeight - shuttlelaunch_bmp.height - 5;
				
				Game.dogesled.x = 400;
				Game.dogesled.y = 200;
				
				Game.root.setChildIndex(Game.dogesled, Game.root.numChildren-1);
				Game.root.addChild(shuttlelaunch_bmp);
			}
			
			//bushes
			var amount:int = Utils.randomMinMax(2, 4);
			
			bushes = [];
			
			for (var i:int = 0; i < amount; i++) {
				bushes.push(new this["bush" + Utils.randomMinMax(1, 6)]());
				
				bushes[i].x = Utils.randomMinMax(0, Game.stage.stageWidth - bushes[i].width);
				bushes[i].y = Game.stage.stageHeight - bushes[i].height;
				
				Game.root.addChild(bushes[i]);
			}
			
			//trees
			amount = Utils.randomMinMax(1, 2);
			trees = [];
			
			for (i = 0; i < amount; i++) {
				trees.push(new this["tree" + Utils.randomMinMax(1, 2)]());
				
				if (i == 0) {
					//add on left side
					trees[i].x = Utils.randomMinMax( -50, Game.stage.stageWidth / 2 - trees[i].width / 2 - 50);
				}else {
					//add on right side
					trees[i].x = Utils.randomMinMax( Game.stage.stageWidth / 2 + 100, Game.stage.stageWidth - 100);
				}
				
				trees[i].y = Game.stage.stageHeight - trees[i].height;
				
				Game.root.addChild(trees[i]);
			}
		}
		
		public function doLaunch():void {
			//called when space bar is hit
			if (sledramp_mc != null) {
				sledramp_mc.beginAnim();
			}
			removalTimer = new Timer(4000); //keep running in case you're paused when this is called
			removalTimer.start();
			removalTimer.addEventListener(TimerEvent.TIMER, onRemovalOfLaunch);
		}
		
		private function onRemovalOfLaunch(e:TimerEvent):void 
		{
			if (Game.paused) return;
			
			Game.root.removeChild(sea_bmp);
			Game.root.removeChild(sand_bmp);
			Game.root.removeChild(house1_bmp);
			Game.root.removeChild(house2_bmp);
			
			if (shuttlelaunch_bmp != null) Game.root.removeChild(shuttlelaunch_bmp);
			
			for (var i:int = 0; i < bushes.length; i++) {
				Game.root.removeChild(bushes[i]);
			}
			
			for (i = 0; i < trees.length; i++) {
				Game.root.removeChild(trees[i]);
			}
			
			removalTimer.stop();
			removalTimer.removeEventListener(TimerEvent.TIMER, onRemovalOfLaunch);
			removalTimer = null;
		}
		
		private function populateList(amount:int):void {
			var added:DisplayObject;
			bgList = [];
			
			Game.current_stage = current;
			
			for (i=1; i <= amount; i++) {
				added = addChild(this["stage" + String(current) + String(i) + "_bmp"]);
				if(i>1){
					added.x = this["stage" + String(current) + String(i - 1) + "_bmp"].x + this["stage" + String(current) + String(i - 1) + "_bmp"].width;
				}
				
				added.y = (Game.stage.stageHeight - added.height);
				bgList.push(added);
			}
		}
		
		private function onAddCloud(e:TimerEvent):void 
		{
			if (Game.paused) return;
			addChild(new Cloud());
		}
		
		private function onAddStar(e:TimerEvent):void 
		{
			if (Game.paused) return;
			addChild(new Star());
		}
		
		private function onRemove(e:Event):void 
		{
			starTimer.stop();
			cloudTimer.stop();
			removeEventListener(TimerEvent.TIMER, onAddCloud);
			removeEventListener(TimerEvent.TIMER, onAddStar);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			removeEventListener(Event.ENTER_FRAME, scrollBG);
			removeEventListener(Event.ENTER_FRAME, moveMoonStuff);
			removeEventListener(Event.ENTER_FRAME, onMoonTransitionIn);
			removeEventListener(Event.ENTER_FRAME, earthShine);
		}
		
		public function gotoSpace():void {
			bgList.push(new stage1to2());
			addChild(bgList[bgList.length - 1]);
			bgList[bgList.length - 1].y = bgList[0].y - bgList[bgList.length - 1].height;
			speedY = 5;
			Game.transitioningToStage2 = 1;
			cloudTimer.stop();
		}
		
		private function scrollBG(e:Event):void 
		{
			if (Game.paused) return;
			var drop:Boolean = false;
			
			for (i = 0; i < bgList.length; i++) {
				bgList[i].x += speedX;
				bgList[i].y += speedY;
				if (bgList[i].x <= -bgList[i].width) {
					drop = true;
				}
				//If transitioning and the current bg is the transition image
				if (Game.transitioningToStage2 == 1 && i == bgList.length - 1) {
					if (bgList[i].y >= (stage.stageHeight-bgList[i].height)) {
						//Means sky is not visible anymore
						Game.transitioningToStage2 = 2;
						Game.dogesled.beginSpin();
						
						current = 2;
						//remove sky
						removeChild(bgList[0]);
						bgList.shift();
						break;
					}
				}else if (Game.transitioningToStage2 == 2) {//the transition image is the only thing in the list
					if (bgList[i].y >= 0) {
						removeChild(bgList[0]);
						
						populateList(4);
						
						speedY = 0;
						speedX = X_SPEED;
						Game.transitioningToStage2 = 3;
						starTimer.start();
						Game.goingUp = false;
						//done transitioning
					}
				}
			}
			
			//drop for looping space backgrounds
			if (drop) {
				var end:Bitmap = bgList.shift();
				
				bgList.push(end);
				end.x = bgList[bgList.length - 2].x + bgList[bgList.length - 2].width;
			}
			
			//We need to scroll launch items down if removalTimer hasn't been ended yet
			if (removalTimer != null) {
				for (i = 0; i < bushes.length; i++) {
					bushes[i].y += SCROLL_SPEEDY;
					if(Game.sled_type == Sled.BOBSLED) bushes[i].x += SCROLL_SPEEDX;
				}
				sea_bmp.y += SCROLL_SPEEDY;
				sand_bmp.y += SCROLL_SPEEDY;
				if (Game.sled_type == Sled.BOBSLED) {
					sea_bmp.x += SCROLL_SPEEDX;
					sand_bmp.x += SCROLL_SPEEDX;
					house1_bmp.x += SCROLL_SPEEDX;
					house2_bmp.x += SCROLL_SPEEDX;
				}
				
				house1_bmp.y += SCROLL_SPEEDY;
				house2_bmp.y += SCROLL_SPEEDY;
				
				for (i = 0; i < trees.length; i++) {
					trees[i].y += SCROLL_SPEEDY;
					if (Game.sled_type == Sled.BOBSLED) trees[i].x += SCROLL_SPEEDX;
				}
				
				if (shuttlelaunch_bmp != null) {
					shuttlelaunch_bmp.y += SCROLL_SPEEDY;
					if (Game.sled_type == Sled.BOBSLED) shuttlelaunch_bmp.x += SCROLL_SPEEDX;
				}
				if (sledramp_mc != null) {
					if (Game.sled_type == Sled.BOBSLED) sledramp_mc.x += SCROLL_SPEEDX;
					sledramp_mc.y += SCROLL_SPEEDY;
				}
			}
		}
		
		
		public function gotoMoon():void {
			moonList = [new moonback3(), new moonback3(), new moonback2(), new moonback2(), new moonback1(), new moonback1()];
			
			//back layer
			moonList[0].y = moonList[1].y = Game.stage.stageHeight - moonList[0].height + 480;
			moonList[1].x = moonList[0].width;
			
			//middle layer
			moonList[3].x = moonList[2].width;
			moonList[2].y = moonList[3].y = Game.stage.stageHeight - moonList[2].height + 490;
			
			//frontlayer
			moonList[5].x = moonList[4].width;
			moonList[4].y = moonList[5].y = Game.stage.stageHeight - moonList[4].height + 500;
			
			earth_bmp = new earth();
			earth_bmp.x = Game.stage.stageWidth + 200;
			earth_bmp.y = Game.stage.stageHeight - 100;
			
			addChild(earth_bmp);
			
			for (var i:int = 0; i < moonList.length; i++) {
				addChild(moonList[i]);
			}
			
			addEventListener(Event.ENTER_FRAME, onMoonTransitionIn);
			addEventListener(Event.ENTER_FRAME, moveMoonStuff);
			addEventListener(Event.ENTER_FRAME, earthShine);
		}
		
		private function earthShine(e:Event):void 
		{
			if (Game.paused) return;
			earth_bmp.x -= 2;
			earth_bmp.y = Math.cos((Game.stage.stageWidth - earth_bmp.x) / Game.stage.stageWidth * 3.14) * 50 + 100;
			if (earth_bmp.x < -earth_bmp.width) earth_bmp.x = Game.stage.stageWidth +  400;
		}
		
		private function onMoonTransitionIn(e:Event):void 
		{
			if (Game.paused) return;
			for (var i:int = 0; i < moonList.length; i++) {
				if (i == 0) {
					if (moonList[i].y == Game.stage.stageHeight - moonList[i].height) {
						removeEventListener(Event.ENTER_FRAME, onMoonTransitionIn);
						return;
					}
				}
				moonList[i].y -= 5;
			}
			earth_bmp.y -= 3;
		}
		
		private function moveMoonStuff(e:Event):void 
		{
			if (Game.paused) return;
			for (var i:int = 0; i < moonList.length; i++) {
				moonList[i].x += Math.floor(i / 2 + 1) * Map.SCROLL_MOONX;
				if (moonList[i].x <= -moonList[i].width) {
					if ((i+1) % 2 == 1) {//if first
						moonList[i].x = moonList[i + 1].x + moonList[i].width + Math.floor((i+1) / 2 + 1) * Map.SCROLL_MOONX ;//add minus width??
					}else {//last
						moonList[i].x = moonList[i - 1].x + moonList[i].width;
					}
					
				}
			}
		}
	}

}
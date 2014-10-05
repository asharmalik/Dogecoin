package MapEffects 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class SledRamp extends Sprite 
	{
		[Embed(source="../../img/map/beach/ramp.launch0001.png")] private var ramp_1:Class;
		[Embed(source="../../img/map/beach/ramp.launch0002.png")] private var ramp_2:Class;
		[Embed(source="../../img/map/beach/ramp.launch0003.png")] private var ramp_3:Class;
		[Embed(source="../../img/map/beach/ramp.launch0004.png")] private var ramp_4:Class;
		[Embed(source="../../img/map/beach/ramp.launch0005.png")] private var ramp_5:Class;
		[Embed(source="../../img/map/beach/ramp.launch0006.png")] private var ramp_6:Class;
		[Embed(source="../../img/map/beach/ramp.launch0007.png")] private var ramp_7:Class;
		[Embed(source="../../img/map/beach/ramp.launch0008.png")] private var ramp_8:Class;
		[Embed(source="../../img/map/beach/ramp.launch0009.png")] private var ramp_9:Class;
		[Embed(source="../../img/map/beach/ramp.launch0010.png")] private var ramp_10:Class;
		[Embed(source="../../img/map/beach/ramp.launch0011.png")] private var ramp_11:Class;
		[Embed(source="../../img/map/beach/ramp.launch0012.png")] private var ramp_12:Class;
		[Embed(source="../../img/map/beach/ramp.launch0013.png")] private var ramp_13:Class;
		[Embed(source="../../img/map/beach/ramp.launch0014.png")] private var ramp_14:Class;
		[Embed(source="../../img/map/beach/ramp.launch0015.png")] private var ramp_15:Class;
		[Embed(source="../../img/map/beach/ramp.launch0016.png")] private var ramp_16:Class;
		
		private var ramp1_bmp:Bitmap = new ramp_1();
		private var ramp2_bmp:Bitmap = new ramp_2();
		private var ramp3_bmp:Bitmap = new ramp_3();
		private var ramp4_bmp:Bitmap = new ramp_4();
		private var ramp5_bmp:Bitmap = new ramp_5();
		private var ramp6_bmp:Bitmap = new ramp_6();
		private var ramp7_bmp:Bitmap = new ramp_7();
		private var ramp8_bmp:Bitmap = new ramp_8();
		private var ramp9_bmp:Bitmap = new ramp_9();
		private var ramp10_bmp:Bitmap = new ramp_10();
		private var ramp11_bmp:Bitmap = new ramp_11();
		private var ramp12_bmp:Bitmap = new ramp_12();
		private var ramp13_bmp:Bitmap = new ramp_13();
		private var ramp14_bmp:Bitmap = new ramp_14();
		private var ramp15_bmp:Bitmap = new ramp_15();
		private var ramp16_bmp:Bitmap = new ramp_16();
		
		private var animation:Array;
		private var ticker:int = 0;
		
		public function SledRamp() 
		{
			super();
			animation = [ramp1_bmp, ramp2_bmp, ramp3_bmp, ramp4_bmp, ramp5_bmp, ramp6_bmp,ramp7_bmp,ramp8_bmp,ramp9_bmp,ramp10_bmp,ramp11_bmp,ramp12_bmp,ramp13_bmp,ramp14_bmp,ramp15_bmp,ramp16_bmp];
			
			x = -180;
			y = Game.stage.stageHeight - animation[0].height + 15;
			
			addChild(animation[0]);
		}
		
		public function beginAnim():void {
			addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function onEnter(e:Event):void 
		{
			if (Game.paused) return;
			if (ticker == 1) {
				ticker = 0;
				removeChild(animation[0]);
				animation.shift();
				if (animation.length != 0) {
					addChild(animation[0]);
				}else {
					//leave empty ramp behind
					//make sled visible again
					Game.dogesled.visible = true;
					Game.dogesled.x = 420;
					Game.dogesled.y = 300;
					Game.dogesled.setSpeed(8, -8);
					
					addChild(ramp1_bmp);
					removeEventListener(Event.ENTER_FRAME, onEnter);
				}
			}
			ticker++;
		}
		
	}

}
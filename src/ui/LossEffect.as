package ui 
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class LossEffect extends TextField 
	{
		[Embed(source = "../../Fonts/TrendHMSlabOne.otf", fontName="Trend", embedAsCFF="false", mimeType="application/x-font")] private var myFont:Class;
		
		public function LossEffect(amt:int) 
		{
			super();
			
			var tf:TextFormat = new TextFormat("Trend", 20, 0xFF0000);
			
			this.selectable = false;
			this.text = "-"+String(amt);
			this.embedFonts = true;
			this.defaultTextFormat = tf;
			this.setTextFormat(tf);
			this.autoSize = TextFieldAutoSize.RIGHT;
			this.multiline = false;
			
			this.x = Game.doge_wallet.x + 80;
			this.y = Game.doge_wallet.y;
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
			y -= 1;
			alpha -= .05;
			if (alpha <= 0) {
				parent.removeChild(this);
			}
		}
		
	}

}
package ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class Wallet extends Sprite
	{
		[Embed(source = "../../Fonts/TrendHMSlabOne.otf", fontName="Trend", embedAsCFF="false", mimeType="application/x-font")] private var myFont:Class;
		[Embed(source = "../../img/ui/dogebag.png")] private var icon:Class;
		
		private var icon_bmp:Bitmap = new icon();
		private var amount_txt:TextField = new TextField();
		
		public function Wallet(init:int) 
		{
			var tf:TextFormat = new TextFormat("Trend", 20, 0xFFFFFF);
			
			amount_txt.selectable = false;
			amount_txt.text = String(init);
			amount_txt.embedFonts = true;
			amount_txt.defaultTextFormat = tf;
			amount_txt.setTextFormat(tf);
			amount_txt.autoSize = TextFieldAutoSize.LEFT;
			amount_txt.multiline = false;
			
			amount_txt.x = icon_bmp.width;
			amount_txt.y = icon_bmp.height / 2 -amount_txt.height / 2;
			
			addChild(icon_bmp);
			addChild(amount_txt);
		}
		
		public function update(amt:int):void {
			amount_txt.text = String(amt);
		}
		
	}

}
package ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class EscapeButton extends Sprite 
	{
		[Embed(source = "../../img/ui/pause/esc.png")] private var esc:Class;
		[Embed(source = "../../img/ui/pause/esc.hover.png")] private var escHov:Class;
		
		private var esc_bmp:Bitmap = new esc();
		private var escHov_Bmp:Bitmap = new escHov();
		
		public function EscapeButton() 
		{
			super();
			addChild(esc_bmp);
			addEventListener(MouseEvent.MOUSE_OVER, onOver);
			addEventListener(MouseEvent.MOUSE_OUT, onOut);
			addEventListener(MouseEvent.CLICK, onToggle);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		private function onToggle(e:MouseEvent):void 
		{
			Game.togglePause();
		}
		
		private function onRemove(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			removeEventListener(MouseEvent.CLICK, onToggle);
			removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			removeEventListener(MouseEvent.MOUSE_OUT, onOut);
		}
		
		private function onOut(e:MouseEvent):void 
		{
			removeChild(escHov_Bmp);
			addChild(esc_bmp);
		}
		
		private function onOver(e:MouseEvent):void 
		{
			removeChild(esc_bmp);
			addChild(escHov_Bmp);
		}
		
	}

}
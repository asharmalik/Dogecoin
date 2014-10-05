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
	public class WhatIsButton extends Sprite 
	{
		[Embed(source = "../../img/ui/menu/what.png")] private var norm:Class;
		[Embed(source = "../../img/ui/menu/what.down.png")] private var down:Class;
		[Embed(source = "../../img/ui/menu/what.hover.png")] private var hover:Class;
		
		private var norm_bmp:Bitmap = new norm();
		private var down_bmp:Bitmap = new down();
		private var hover_bmp:Bitmap = new hover();
		
		public function WhatIsButton() 
		{
			super();
			addChild(norm_bmp);
			addEventListener(MouseEvent.MOUSE_OVER, onOver);
			addEventListener(MouseEvent.MOUSE_OUT, onOut);
			addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			addEventListener(MouseEvent.MOUSE_UP, onUp);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		private function onUp(e:MouseEvent):void 
		{
			if(down_bmp.parent != null) removeChild(down_bmp);
			addChild(hover_bmp);
		}
		
		private function onDown(e:MouseEvent):void 
		{
			removeChild(hover_bmp);
			addChild(down_bmp);
		}
		
		private function onOut(e:MouseEvent):void 
		{
			addChild(norm_bmp);
		}
		
		private function onRemove(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			removeEventListener(MouseEvent.MOUSE_UP, onUp);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		private function onOver(e:MouseEvent):void 
		{
			if (norm_bmp.parent != null) removeChild(norm_bmp);
			if (down_bmp.parent != null) removeChild(down_bmp);
			
			addChild(hover_bmp);
		}
		
	}

}
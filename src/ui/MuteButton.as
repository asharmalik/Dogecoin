package ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class MuteButton extends Sprite 
	{
		[Embed(source = "../../img/ui/pause/muteoff.png")] private var mute_off:Class;
		[Embed(source = "../../img/ui/pause/muteon.png")] private var mute_on:Class;
		
		[Embed(source = "../../img/ui/pause/muteoff.hover.png")] private var mute_offhov:Class;
		[Embed(source = "../../img/ui/pause/muteon.hover.png")] private var mute_onhov:Class;
		
		private var muteoff_bmp:Bitmap = new mute_off();
		private var muteon_bmp:Bitmap = new mute_on();
		private var muteoff_hovbmp:Bitmap = new mute_offhov();
		private var muteon_hovbmp:Bitmap = new mute_onhov();
		
		public function MuteButton() 
		{
			super();
			addChild((Game.muted)?muteon_bmp:muteoff_bmp);
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(MouseEvent.MOUSE_OVER, onOver);
			addEventListener(MouseEvent.MOUSE_OUT, onOut);
		}
		
		private function onOut(e:MouseEvent):void 
		{
			if (Game.muted) {
				addChild(muteon_bmp);
				removeChild(muteon_hovbmp);
			}else {
				addChild(muteoff_bmp);
				removeChild(muteoff_hovbmp);
			}
		}
		
		private function onOver(e:MouseEvent):void 
		{
			if (Game.muted) {
				removeChild(muteon_bmp);
				addChild(muteon_hovbmp);
			}else {
				removeChild(muteoff_bmp);
				addChild(muteoff_hovbmp);
			}
		}
		
		private function onClick(e:MouseEvent):void 
		{
			Game.muted = !Game.muted;
			if (Game.muted) {
				removeChild(muteoff_hovbmp);
				addChild(muteon_hovbmp);
			}else {
				removeChild(muteon_hovbmp);
				addChild(muteoff_hovbmp);
			}
		}
		
	}

}
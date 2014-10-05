package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ui.CreditsButton;
	import ui.PlayGameButton;
	import ui.WhatIsButton;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class MainMenu extends Sprite 
	{
		[Embed(source = "../img/ui/menu/menu.png")] private var bg:Class;
		[Embed(source = "../img/underdoge.png")] private var title:Class;
		[Embed(source = "../img/ui/menu/lockedrocket.png")] private var locked:Class;
		
		private var bg_bmp:Bitmap = new bg();
		private var title_bmp:Bitmap = new title();
		private var pg_btn:PlayGameButton = new PlayGameButton();
		private var cred_btn:CreditsButton = new CreditsButton();
		private var what_btn:WhatIsButton = new WhatIsButton();
		private var locked_bmp:Bitmap = new locked();
		
		public function MainMenu() 
		{
			super();
			
			pg_btn.x = 650 / 2 - pg_btn.width / 2;
			pg_btn.y = 118;
			
			cred_btn.x = 650 / 2 - cred_btn.width / 2;
			cred_btn.y = pg_btn.y + pg_btn.height + 1;
			
			what_btn.x = 650 / 2 - what_btn.width / 2;
			what_btn.y = cred_btn.y + cred_btn.height + 2;
			
			title_bmp.x = 650 / 2 - title_bmp.width / 2;
			title_bmp.y = 50;
			
			locked_bmp.x = 650 / 2 - locked_bmp.width / 2;
			locked_bmp.y = 400 - locked_bmp.height - 10;
			
			//TODO: check unlock status
			
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			pg_btn.addEventListener(MouseEvent.CLICK, onPlayClick);
			cred_btn.addEventListener(MouseEvent.CLICK, onCredClick);
			what_btn.addEventListener(MouseEvent.CLICK, onWhatClick);
			
			addChild(bg_bmp);
			addChild(title_bmp);
			addChild(pg_btn);
			addChild(cred_btn);
			addChild(what_btn);
			addChild(locked_bmp);
		}
		
		private function onWhatClick(e:MouseEvent):void 
		{
			
		}
		
		private function onCredClick(e:MouseEvent):void 
		{
			
		}
		
		private function onRemove(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			pg_btn.removeEventListener(MouseEvent.CLICK, onPlayClick);
			cred_btn.removeEventListener(MouseEvent.CLICK, onCredClick);
			what_btn.removeEventListener(MouseEvent.CLICK, onWhatClick);
		}
		
		private function onPlayClick(e:MouseEvent):void 
		{
			Main(root).startGame();
		}
		
	}

}
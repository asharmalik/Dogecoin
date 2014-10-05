package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class Main extends Sprite 
	{
		public var menu:MainMenu;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			menu = new MainMenu();
			addChild(menu);
			
		}
		
		public function startGame():void {
			addChild(new MenuGameTransition(this, stage));
			Game.start(this, stage);
		}
		
	}
	
}
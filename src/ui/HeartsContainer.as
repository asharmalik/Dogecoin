package ui 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class HeartsContainer extends Sprite 
	{
		private var amount:int;
		private var hearts:Array;
		
		public function HeartsContainer(lives:int) 
		{
			super();
			amount = lives;
			
			hearts = new Array();
			
			for (var i:int = 0; i < lives; i++) {
				hearts.push(addChild(new Heart()));
				hearts[i].x = (hearts[i].width + 2) * i;
			}
		}
		
		public function loseHeart():void {
			if (amount == 0) return;
			hearts[amount - 1].lose();
			amount--;
		}
		
	}

}
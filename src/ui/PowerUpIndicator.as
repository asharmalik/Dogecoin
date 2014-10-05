package ui 
{
	import flash.display.Sprite;
	import interactable.PowerUp;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class PowerUpIndicator extends Sprite 
	{
		[Embed(source = "../../img/interactive/powerups/magnet.png")] private var magnet:Class;
		[Embed(source = "../../img/interactive/powerups/moneymult.png")] private var mult:Class;
		[Embed(source = "../../img/interactive/powerups/shield.png")] private var shield:Class;
		
		public function PowerUpIndicator(type:int) 
		{
			super();
			if (type == PowerUp.MAGNET) {
				addChild(new magnet());
			}else if (type == PowerUp.MULTIPLIER) {
				addChild(new mult());
			}else if (type == PowerUp.SHIELD) {
				addChild(new shield());
			}
		}
		
	}

}
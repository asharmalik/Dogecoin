package  
{
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class Utils 
	{
		
		public static function randomMinMax( min:Number, max:Number ):int
		{
			return min + (max + 1 - min) * Math.random();
		}
		
	}

}
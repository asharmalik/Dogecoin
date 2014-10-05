package ui 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author Ashar Malik
	 */
	public class ShareButton extends Sprite 
	{
		private const _url:String = "google.com";
		private const _image:String = "http://cdn0.sbnation.com/entry_photo_images/9571605/Dogecoin_logo_large_verge_medium_landscape.png";
		private const _title:String = "Title";
		private var _summary:String = "Summary";
		
		public function ShareButton() 
		{
			super();
			
			this.graphics.beginFill(0);
			this.graphics.drawRect(0, 0, 100, 100);
			
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void 
		{	
			var URL:URLRequest = new URLRequest();
			
			URL.url = "http://www.facebook.com/sharer.php?s=100&p[url]="+_url+"&p[images][0]="+_image+"&p[title]="+_title+"&p[summary]="+_summary;

			navigateToURL(URL, '_blank');
		}
		
	}

}
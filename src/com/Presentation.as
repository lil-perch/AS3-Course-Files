package src.com
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Presentation extends MovieClip
	{
		private var _loadedObj:Loader;
		public static const CONTENT_ADDED:String = "contentAdded";
		
		public function Presentation()
		{
			
		}
		
		//This method is called once the content is loaded by contenView.
		public function newContentAdded(ldr:Loader):void
		{
			_loadedObj = ldr;
			dispatchEvent(new Event(Presentation.CONTENT_ADDED));
		}
		
		/*private function updateControl(e:Event):void
		{
			//trace("EVERYTHING: " + e.target);
			//trace("CURRENT TARGET: " + e.currentTarget);
			if (e.target is Loader)
			{
				_loadedObj = Loader(e.target);
				e.target.contentLoaderInfo.addEventListener(Event.COMPLETE, newContentAdded);
				trace("LOADER IS ADDED TO PRESENTATION");
			}
			
			if (this.numChildren > 0)
			{
				//Using Event.COMPLETE on the loader instead.
				//dispatchEvent(new Event(Presentation.CONTENT_ADDED));
			}
				//trace("REAL: " + this.getChildAt(0));
		}*/
		
		public function get contentObject():Loader
		{
			return _loadedObj;
		}
	}
}
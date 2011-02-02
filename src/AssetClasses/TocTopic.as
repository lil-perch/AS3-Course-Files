package src.AssetClasses
{
	import flash.display.MovieClip;

	public class TocTopic extends MovieClip
	{
		public var text_mc:MovieClip;
		
		private var _completed:Boolean; //Either true completed or false not completed.
		private var _pageArray:Array; //A list of the movie clip pages that make up a topic.
		
		public function TocTopic()
		{
			
		}
		
		//GETTER and SETTERS
		public function set completed(b:Boolean):void
		{
			_completed = b;
			if (b) trace("TOPIC IS COMPLETED");
		}
		
		public function get completed():Boolean
		{
			return _completed;
		}
		
		public function set childPages(b:Array):void
		{
			_pageArray = b;
		}
		
		public function get childPages():Array
		{
			return _pageArray;
		}
	}
}
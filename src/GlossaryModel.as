package src
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import src.classes.LoadingPercentages;
	
	public class GlossaryModel extends Model
	{
		public var glossaryData:XML;
		public var glossary:XMLList;
		
		private var _coursePreloader:MovieClip;
		private var _yPosition:Number;
		private var _xPosition:Number
		private var _term:String = "";
		private var _definition:String = "";
		private var _scrollPos:Number = 0;
		private var _percentObj:LoadingPercentages; //Simply for determining loading percentage.
		private var _perc:Number;
		
		public function GlossaryModel(cp:MovieClip)
		{
			_coursePreloader = cp;
			_percentObj = new LoadingPercentages();
			_perc = _percentObj.glossaryModelPerc;
		}
		
		override protected function updateData():void
		{
			trace("Event from GlossaryModel: GLOSSARY_CHANGE");
			dispatchEvent(new Event(Model.GLOSSARY_CHANGE));
		}
		
		override protected function dataLoaded(event:Event):void
		{
			loader.removeEventListener(Event.COMPLETE, dataLoaded);
			loader.removeEventListener(ProgressEvent.PROGRESS, dataLoading);
			
			glossaryData = new XML(loader.data);
			glossary = glossaryData.*;
			//trace("glossaryData: " + glossary);
			dispatchEvent(new Event(Model.MODEL_LOADED));
		}
		
		override protected function dataLoading(e:ProgressEvent):void
		{
			var perc:Number = e.bytesLoaded/e.bytesTotal;
			var newPerc:Number;
			var prevPerc:Number = _percentObj.previousPercent;
			newPerc = perc*(_perc - prevPerc) + prevPerc;
			
			try {
			    _coursePreloader.percent_txt.text = Math.ceil(newPerc*100).toString() + "%";
				_coursePreloader.status_txt.text = "Loading XML Files...";
				_coursePreloader.bar_mc.scaleX = newPerc;
			} catch (error:Error) {
			     trace("The player file is not running inside the course file: ");
			}
		}
		
		public function termSelected(theTerm:String,def:String):void
		{
			_definition = def;
			_term = theTerm;
			updateData();
		}
		
		public function changeScrollPosition(s:Number,update:Boolean):void
		{
			this.scrollPosition = s;
			if (update) updateData();
		}
		
		public function get theTerm():String
		{
			return _term;
		}
		
		public function get definition():String
		{
			return _definition;
		}
		
		public function set scrollPosition(s:Number):void
		{
			_scrollPos = s;
		}
		
		public function get scrollPosition():Number
		{
			return _scrollPos;
		}
	}
}
package src
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import src.classes.LoadingPercentages;
	
	public class QuizModel extends Model
	{
		public var quizData:XML;
		public var quizzes:XMLList;
		
		private var _coursePreloader:MovieClip;
		private var _percentObj:LoadingPercentages; //Simply for determining loading percentage.
		private var _perc:Number;
		
		public function QuizModel(cp:MovieClip)
		{
			_coursePreloader = cp;
			_percentObj = new LoadingPercentages();
			_perc = _percentObj.quizModelPerc;
		}
		
		override protected function updateData():void
		{
			trace("Event from QuizModel: MODEL_CHANGE");
			dispatchEvent(new Event(Model.MODEL_CHANGE));
		}
		
		override protected function dataLoaded(event:Event):void
		{
			loader.removeEventListener(Event.COMPLETE, dataLoaded);
			loader.removeEventListener(ProgressEvent.PROGRESS, dataLoading);
			quizData = new XML(loader.data);
			quizzes = quizData.*;
			//trace("quizData: " + quizzes);
			
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
	}
}
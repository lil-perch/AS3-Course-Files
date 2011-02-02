/*
Many of the ideas used in the pre-loading class were borrowed from an article written by:

Jamie Kosoy of Big Spaceship

Article is accessible here: http://www.adobe.com/devnet/actionscript/articles/lightweight_as3.html
*/

package src.com
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.*;
	import src.CourseModel;
	
	public class Preloading extends MovieClip
	{
		public var p_txt:TextField;
		public var m_txt:TextField;
		public var showPercent:Boolean;
		//Need to add a loading animation.
		
		private var _targetFrame:Number;
		private var _isLoadComplete:Boolean;
		private var _model:CourseModel;
		private var _message:String;
		private var _name:String;
		
		public static const PAGE_LOADED:String = "pageLoaded";
		
		public function Preloading()
		{
			//trace("start preloadings");
			
			showPercent = false; //Don't show percentage.
			message = "";
			addEventListener(Event.ENTER_FRAME,_onProgressEnterFrame,false,0,true);
			stop();
		}
		
		public function updateProgress(bytesLoaded:Number, bytesTotal:Number, itemsLoaded:Number, itemsTotal:Number):void
		{
			
			var framesPerItem:Number = Math.floor(this.totalFrames/(itemsTotal+1));
			
			var pct:Number = bytesLoaded/bytesTotal;
			_targetFrame = Math.floor(framesPerItem * pct) + (framesPerItem * itemsLoaded);
			//trace("tot: " + this.totalFrames + " - " + framesPerItem + " -bl: " + bytesLoaded + " -bt: " +bytesTotal + " -pct: " + pct);
		}
		
		private function _onProgressEnterFrame(evt:Event):void
		{
			//trace("enterFrame: " + currentFrame);
			//This can be used to do a bar with the preloading.
			(_targetFrame > currentFrame) ? play() : stop();
			
			m_txt.text = this._message;
			var loadPct:Number = Number(_model.pageAttributes.loadPercentage);
			var totalPct:Number = Math.round((currentFrame/totalFrames) * 100);
			
			//right now we are comparing with the load percentage, but we need to first load the SWF all the way. Then compare with load percentage for other media.
			if (totalPct >= 99) progressBarComplete();

			// we'll try to tell the textfield to update progress. if it doesn't exist, we won't.
			if (showPercent)
			{
				try
				{
					p_txt.text = totalPct.toString() + "%";	
				}
				catch($error:Error)
				{
					//trace(this + "% loaded: " + totalPct.toString());
				}
			}
		}
		
		
		// we've reached the end of the progress bar timeline. preloading is successful and complete. 
		public function progressBarComplete():void
		{
			_isLoadComplete = true;
			trace("PAGE LOADING IS COMPLETE");
			trace("----------------------------------------");
			removeEventListener(Event.ENTER_FRAME,_onProgressEnterFrame);
			dispatchEvent(new Event(Preloading.PAGE_LOADED));
		}
		
		public function set message(m:String):void
		{
			_message = m;
		}
		
		public function set model(m:CourseModel):void
		{
			_model = m;
		}
	}
}
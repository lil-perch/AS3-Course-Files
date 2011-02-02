package src
{
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import fl.containers.ScrollPane;
	import fl.controls.ScrollPolicy;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	
	import src.AssetClasses.Narration;
	import src.AssetClasses.Toc;
	import src.classes.LoadingPercentages;
	import src.classes.Path;
	import src.classes.Settings;
	import src.classes.Style;
	import src.com.Buttons;

	public class IndexView extends View
	{
		//The purpose of this class is to control the view of the toc.
		private var _scrollPane:ScrollPane;
		private var _index:Sprite;
		private var _styles:Style;
		private var _settings:Settings;
		private var _coursePreloader:MovieClip;
		private var _indexObj:Object;
		private var _indexBtn:Buttons;
		private var _hasIndexBtn:Boolean = true;
		private var _btnStartX:Number;
		private var _indexStartX:Number;
		private var _tocLoc:String;
		private var _loader:Loader;
		private var _cssFile:URLLoader;
		private var _css:StyleSheet;
		private var _narrationObj:DisplayObject;
		private var _paths:Path;
		private var _percentObj:LoadingPercentages; //Simply for determining loading percentage.
		private var _perc:Number;
		private var _percN:Number;
		private var indexTween:TweenLite;
		private var btnTween:TweenLite;
		
		public static const INDEX_VIEW_LOADED:String = "indexViewLoaded";
		
		public function IndexView(paths:Path,toc:String,index:Sprite,styles:Style,sett:Settings,cp:MovieClip,cm:CourseModel,btn:Buttons = null):void
		{
			_index = index;
			_indexStartX = index.x;
			_styles = styles;
			_settings = sett;
			_coursePreloader = cp;
			_indexBtn = btn;
			_tocLoc = toc;
			_paths = paths
			if (btn == null) _hasIndexBtn = false;
			else _btnStartX = _indexBtn.x;
			//if (_hasIndexBtn) trace("name: " + _indexBtn.name);
			model = cm;
			
			//Add event listener for page complete
			model.addEventListener(CourseModel.PAGE_COMPLETE,showPageComplete);
			_percentObj = new LoadingPercentages();
			
			
			//Load the narration first.
			_loader = new Loader();
			
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, narrationLoaded);
			
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,narrationLoading);
			
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadingError);
			
			_loader.load(new URLRequest(_paths.narrationSWF));
			//loadIndex();
		}
		
		override public function update(event:Event = null):void
		{
			//When we receive an update, call the selectPage method in Toc.as. This will select the page and display the checkmark if necessary.
			_indexObj.selectPage(model.currentIndex);
			var usePageComplete:Boolean = model.courseAttributes.pageComplete;
			if (!usePageComplete) {
				CourseModel(model).markPageComplete();
			}
			//Update Narration
			//because of the namespace in the sco.xml file we need to set the default namespace in order to use E4X syntax.
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
			var navText:String = model.currentPage.narration;
			//trace("NAVTEXT: " + navText);
			if (navText == "" || navText == null)
			{
				Narration(_narrationObj).applyText("There is no alternate narration text for this page.");
			} else {
				Narration(_narrationObj).applyText(navText);
			}
			//Hide index if necessary
			if (!model.courseAttributes.persIndex && model.indexVisibleState == "visible") model.indexVisibleState = "hidden";
		}
		
		private function showPageComplete(e:Event):void
		{
			_indexObj.markComplete(model.currentIndex);
		}
		
		private function narrationLoaded(e:Event):void
		{
			_narrationObj = _loader.content;
			_cssFile = new URLLoader();
			_cssFile.addEventListener(Event.COMPLETE,cssLoaded);
			_cssFile.addEventListener(IOErrorEvent.IO_ERROR,cssError);
			_cssFile.load(new URLRequest(_paths.narrationCSS));
			loadIndex();
			trace("NARRATION IS NOW LOADED.");
		}
		
		private function narrationLoading(e:ProgressEvent):void
		{	
			var perc:Number = e.bytesLoaded/e.bytesTotal;
			var newPerc:Number;
			_percN = _percentObj.narrationViewPerc;
			var prevPerc:Number = _percentObj.previousPercent;
			newPerc = perc*(_percN - prevPerc) + prevPerc;
			
			try {
			    _coursePreloader.percent_txt.text = Math.ceil(newPerc*100).toString() + "%";
				_coursePreloader.status_txt.text = "Loading Narration...";
				_coursePreloader.bar_mc.scaleX = newPerc;
			} catch (error:Error) {
			     trace("The player file is not running inside the course file: ");
			}
		}
		
		private function loadingError(e:IOErrorEvent):void
		{
			trace("IOERROR WHILE LOADING NARRATION: " + e.text);
		}
		
		private function loadIndex():void
		{
			_scrollPane = new ScrollPane();
			_scrollPane.setSize(_settings.indexLocW, _settings.indexLocH);
			_scrollPane.move(_settings.indexLocX, _settings.indexLocY);
			_scrollPane.verticalScrollPolicy = ScrollPolicy.ON;
			
			_scrollPane.addEventListener(Event.COMPLETE, indexLoaded);
			
			_scrollPane.addEventListener(ProgressEvent.PROGRESS,indexLoading);
			
			_scrollPane.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);

			_scrollPane.load(new URLRequest(_tocLoc));
		}
		
		private function indexLoading(e:ProgressEvent):void
		{
			var perc:Number = e.bytesLoaded/e.bytesTotal;
			var newPerc:Number;
			_perc = _percentObj.indexViewPerc;
			var prevPerc:Number = _percentObj.previousPercent;
			newPerc = perc*(_perc - prevPerc) + prevPerc;
			
			try {
			    _coursePreloader.percent_txt.text = Math.ceil(newPerc*100).toString() + "%";
				_coursePreloader.status_txt.text = "Loading Index...";
				_coursePreloader.bar_mc.scaleX = newPerc;
			} catch (error:Error) {
			     trace("The player file is not running inside the course file: ");
			}
		}
		
		private function indexLoaded(e:Event):void
		{
			//We need to build the index
			_indexObj = _scrollPane.content;
			//Place reference to index MC in model
			model.tocMC = _indexObj;
		
			_indexObj.buildIndex(model,_styles.xTopicColor,_styles.xPgColor,_styles.xOvColor,_styles.xDisColor,_settings,_styles.highlightIndexColor);
			
			_index.addChild(_scrollPane);
			
			trace("INDEX IS NOW LOADED.");
			
			//Subscribe to index events
			model.addEventListener(CourseModel.INDEX_VISIBILITYCHANGED,easeIndex);
			model.addEventListener(CourseModel.INDEX_CHANGED,showIndexNarration);
			
			dispatchEvent(new Event(IndexView.INDEX_VIEW_LOADED));
		}
		
		private function easeIndex(e:Event):void
		{
			//I think I need to get some settings, start of index, end of index 
			// Also get the persistent index settings.
			//var indexTween:TweenLite;
			//var btnTween:TweenLite;
			
			//trace("EASE INDEX1: " + _indexStartX + " - " + _settings.indexEndX + " - " + model.indexVisibleState + " - " + _index.x + " - " + Math.abs(_indexStartX) + _settings.indexEndX);
			if (model.indexVisibleState == "visible")
			{
				_scrollPane.update();
				if (_index.x <= _settings.indexEndX)
				{ 
					var lenOut:Number = _settings.easingTime;
					if (_hasIndexBtn)
					{
						
						//btnTween = new Tween(_indexBtn,"x",Strong.easeOut,_btnStartX,Math.abs(_indexStartX) + _settings.indexEndX + _btnStartX,lenOut,true);
						btnTween = new TweenLite(_indexBtn, lenOut, {x:Math.abs(_indexStartX) + _settings.indexEndX + _btnStartX, ease:EaseLookup.find(_settings.indexEasing)});
					}
					//indexTween = new Tween (_index,"x",Strong.easeOut,_indexStartX,_settings.indexEndX,lenOut,true);
					indexTween = new TweenLite(_index,lenOut, {x:_settings.indexEndX, ease:EaseLookup.find(_settings.indexEasing)});
				}
			} else if (model.indexVisibleState == "hidden") {
				if (_index.x >= _indexStartX) 
				{
					if (_hasIndexBtn)
					{
						//btnTween = new Tween(_indexBtn,"x",Strong.easeIn,_indexBtn.x,_btnStartX,lenIn,true);
						btnTween.reverse();
					}
					//indexTween = new Tween (_index,"x",Strong.easeIn,_settings.indexEndX,_indexStartX,lenIn,true);
					indexTween.reverse();
				}
			}
			//Update state of index tab button
			_indexBtn.stateCode = model.indexVisibleState;
			if (_indexBtn.hitTestPoint(_indexBtn.stage.mouseX, _indexBtn.stage.mouseY, true))
		     {
		        _indexBtn.onMouseUp();
		     } else {
		     	_indexBtn.onRollOut();
		     }
		}
		
		private function showIndexNarration(e:Event):void
		{
			if (model.indexState == "index")
			{
				//trace("show the index......");
				_index.removeChild(_loader);
			} else if (model.indexState == "read") {
				//trace("show the narration....");
				_index.addChild(_loader);
			}
		}
		
		private function cssLoaded(e:Event):void
		{
			_css = new StyleSheet();
			_css.parseCSS(e.target.data);
			Narration(_narrationObj).applyCss(_css);
			trace("CSS for narration is loaded...");
		}
		
		private function cssError(e:IOErrorEvent):void
		{
			trace("ERROR LOADING CSS FOR NARRATION FILE: " + e.text);
		}
		
		public function ioErrorHandler(event:IOErrorEvent):void
		{
			trace("IOERROR WHILE LOADING TOC: " + event.text);
		}
	}
}
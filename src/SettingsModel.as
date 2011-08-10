package src
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import src.classes.Path;
	import src.classes.Settings;
	import src.classes.Style;
	import src.classes.LoadingPercentages;

	public class SettingsModel extends Model
	{
		
		//public static const SETTINGS_LOADED:String = "modelLoaded";
		public var paths:Path;
		public var settings:Settings;
		public var styles:Style;
		
		private var _settings:XML;
		private var _coursePreloader:MovieClip;
		private var _percentObj:LoadingPercentages;
		private var _perc:Number;
		
		public function SettingsModel(cp:MovieClip):void
		{
			paths = new Path();
			settings = new Settings();
			styles = new Style();
			_coursePreloader = cp;
			_percentObj = new LoadingPercentages();
			_perc = _percentObj.settingsModelPerc;
		}
		
		override protected function updateData():void
		{
			
			trace("Event from SettingsModel: MODEL_CHANGE");
			dispatchEvent(new Event(Model.MODEL_CHANGE));
		}
		
		override protected function dataLoaded(event:Event):void
		{
			//Create objects of settings, styles and paths.
			trace("SETTINGS LOADED.");
			
			_settings = new XML(loader.data);
			
			loader.removeEventListener(Event.COMPLETE, dataLoaded);
			loader.removeEventListener(ProgressEvent.PROGRESS, dataLoading);
			
			paths.scoXML 					= 	_settings.filepaths.scoxml;
			paths.quizXML 					= 	_settings.filepaths.quizxml;
			paths.glossaryXML 				= 	_settings.filepaths.glossaryxml;
			paths.tocSWF 					= 	_settings.filepaths.toclocation;
			paths.controlSWF 				= 	_settings.filepaths.mediacontrol;
			paths.glossarySWF 				= 	_settings.filepaths.glossaryswf;
			paths.glossaryTerm				= 	_settings.filepaths.glossaryterm;
			paths.glossaryCSS				= 	_settings.filepaths.glossarycss;
			paths.narrationSWF				= 	_settings.filepaths.narrationswf;
			paths.narrationCSS				= 	_settings.filepaths.narrationcss;
			paths.courseLogo				=	_settings.filepaths.courselogo;
			paths.noteIcon					=	_settings.filepaths.noteicon;
			paths.tipIcon					=	_settings.filepaths.tipicon;
			paths.warningIcon				=	_settings.filepaths.warningicon;
			paths.as2Loader					=	_settings.filepaths.as2loader;
			paths.pageCSS					=	_settings.filepaths.pagecss;

			settings.useInterfaceColors 	= 	(_settings.coursesettings.useinterfacecolors.toLowerCase() =="true");
			settings.detatchedMenu			= 	(_settings.coursesettings.detatchedmenu.toLowerCase() == "true");
			settings.moveJustTopicText 		= 	(_settings.coursesettings.movejusttopictext.toLowerCase() == "true");
			settings.leftJustifiedHighlight = 	(_settings.coursesettings.leftjustifiedhighlight.toLowerCase() == "true");
			settings.indexLocX 				= 	Number(_settings.coursesettings.indexlocx);
			settings.indexLocY 				= 	Number(_settings.coursesettings.indexlocy);
			settings.indexLocW 				= 	Number(_settings.coursesettings.indexwidth);
			settings.indexLocH 				= 	Number(_settings.coursesettings.indexheight);
			settings.glossaryMenuX 			= 	Number(_settings.coursesettings.lettermenux);
			settings.glossaryMenuY 			= 	Number(_settings.coursesettings.lettermenuy);
			settings.glossaryMenuSpace 		= 	Number(_settings.coursesettings.spacebetweenmenu);
			settings.indexEndX				=	Number(_settings.coursesettings.indexendx);
			settings.presentSizeH			= 	Number(_settings.coursesettings.presentsizeh);
			settings.presentSizeW			=	Number(_settings.coursesettings.presentsizew);
			settings.mediaPlayerSpace		=	Number(_settings.coursesettings.mediaplayerspace);
			settings.maskLocationX			=	Number(_settings.coursesettings.masklocationx);
			settings.maskLocationY			=	Number(_settings.coursesettings.masklocationy);
			settings.showPageTitle			=	(_settings.coursesettings.showpagetitle.toLowerCase() == "true");
			settings.indexEasing			=	_settings.coursesettings.indexeasing;
			settings.easingTime				=	Number(_settings.coursesettings.easingtime);
			settings.autoNavLatency			=	Number(_settings.coursesettings.autonavlatency);
			settings.reviewMargin			=	Number(_settings.coursesettings.reviewmargin);
			
			styles.xTopicColor 				= 	parseInt(_settings.styleinfo.indextopiccolor,16);
			styles.xPgColor 				= 	parseInt(_settings.styleinfo.indexpagecolor,16);
			styles.xOvColor 				= 	parseInt(_settings.styleinfo.indexovercolor,16);
			styles.xDisColor				=	parseInt(_settings.styleinfo.indexdiscolor,16);
			styles.highlightIndexColor 		= 	parseInt(_settings.styleinfo.highlightindexcolor,16);
			styles.glossMenuColor			= 	parseInt(_settings.styleinfo.menucolor,16);
			styles.glossMenuOverColor 		= 	parseInt(_settings.styleinfo.menuovercolor,16);
			styles.glossMenuUnderline		=	(_settings.styleinfo.menuoverunderline.toLowerCase() == "true");
			styles.termColor				= 	parseInt(_settings.styleinfo.termcolor,16);
			styles.termOverColor			=	parseInt(_settings.styleinfo.termovercolor,16);
			styles.termSize					= 	Number(_settings.styleinfo.termsize);
			styles.termStyle				= 	_settings.styleinfo.termstyle;
			styles.termMargin				=	Number(_settings.styleinfo.termmargin);
			styles.letterColor				= 	parseInt(_settings.styleinfo.lettercolor,16);
			styles.letterSize				= 	Number(_settings.styleinfo.lettersize);
			styles.letterStyle				=	_settings.styleinfo.letterstyle;
			styles.letterMargin				=	Number(_settings.styleinfo.lettermargin);
			styles.distractorFont			=	_settings.styleinfo.distractorfont;
			styles.distractorFontColor		=	parseInt(_settings.styleinfo.distractorfontcolor,16);
			styles.distractorFontSize		=	Number(_settings.styleinfo.distractorfontsize);
			
			dispatchEvent(new Event(Model.MODEL_LOADED));
		}
		
		override protected function dataLoading(e:ProgressEvent):void
		{
			//trace("loading settings...");
			var perc:Number = e.bytesLoaded/e.bytesTotal;
			var newPerc:Number;
			var prevPerc:Number = _percentObj.previousPercent;
			newPerc = perc*(_perc - prevPerc) + prevPerc;
			try {
			    _coursePreloader.percent_txt.text = Math.ceil(newPerc*100).toString() + "%";
				_coursePreloader.status_txt.text = "Loading Settings...";
				_coursePreloader.bar_mc.scaleX = newPerc;
			} catch (error:Error) {
			     trace("The player file is not running inside the course file: ");
			}
		}
		
		public function changeSettings(setting:String,val:String):void
		{
			trace("CALL TO CHANGE THE SETTINGS MADE TO changeSettings in SettingsModel-SETTING: " + setting + " -VALUE: " + val);
			//Use this to change a setting.
			//NEED TO FINISH THIS
			
			updateData();
		}
		
		//This Method is so that during customizations we can add other settings and not have to update the SettingsModel class with new getter and setters.
		public function getSetting(s:String):String
		{
			return _settings[s];
		}
	}
}
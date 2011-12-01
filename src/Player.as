package src
{
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	import src.classes.InfoPanel;
	import src.classes.LoadingPercentages;
	import src.classes.ProcessData;
	import src.com.Buttons;
	import src.com.Presentation;
	
	public class Player extends MovieClip
	{
		public var settingsModel:SettingsModel;
		public var playerModel:CourseModel;
		public var quizModel:QuizModel;
		public var glossaryModel:GlossaryModel;
		public var navControl:ButtonController;
		public var contentView:ContentView;
		public var indexView:IndexView;
		public var buttonView:ButtonView;
		public var textView:TextView;
		public var glossaryView:GlossaryView;
		public var mediaControlView:MediaControllerView
		public var feedbackPanel:InfoPanel;
		public var mainPlayer:MovieClip;
		public var cover_mc:MovieClip;
		public var cc_pageName:String;							//Tracks current page for Unison.
		
		//DECLARE STAGE INSTANCES SO THEY CAN BE REFERENCED
		//
		public var top_mc:Sprite;
		public var presentation:Presentation;
		public var indexName_mc:Sprite;
		public var controller_mc:MovieClip;
		public var back_mc:Buttons;
		public var next_mc:Buttons;
		public var audio_onoff_mc:Buttons;
		public var exit_btn:SimpleButton;
		public var index_read_mc:Buttons;
		public var glossary_btn:SimpleButton;
		public var pageNumber_txt:TextField;
		public var courselogo:Sprite;
		public var glossary_mc:Sprite;
		public var heading_txt:TextField;
		public var page_title_txt:TextField;
		public var tab_mc:Buttons;
		public var tocMask_mc:tocMaskCover;
		public var contentMask_mc:tocMaskCover;
		
		private var _coursePreloader:MovieClip;
		private var _toc:String;
		private var pContainer:DisplayObjectContainer;
		private var _percentObj:LoadingPercentages; //Simply for determining loading percentage.
		private var _perc:Number;
		private var _logoLoader:Loader;
		private var _playingLocally:Boolean = false;	//true if playing from the hard drive and not a server.
		private var _processData:ProcessData;			//Instance of this class for determining cachestring
		private var _cacheString:String;				//Used so the XML file will not cache when developing on Unison.
		
		public function Player()
		{
			stop();
			//Create the mask to hide the index and the content when it is outside the content area. 
			tocMask_mc = new tocMaskCover();
			contentMask_mc = new tocMaskCover();
			pContainer = this.parent;
			trace("PLAYER FILE LOADED:");
			mainPlayer = this;
			_percentObj = new LoadingPercentages();
			_perc = _percentObj.viewPerc;
			_processData = new ProcessData();
		
			//If pContainer is null we know it is being loaded inside course.fla
			//Otherwise startLoading is called from course.fla.
			if (pContainer != null) startLoading();
		}
		
		public function getPageName():String
		{
			return this.cc_pageName;
		}
		
		public function startLoading():void
		{
			settingsModel = new SettingsModel(_coursePreloader);
			//Is the course playing locally or from a server			
			_playingLocally = (this.stage.loaderInfo.url.indexOf("file") == 0);
			trace("LOCAL: " + _playingLocally);
			//Make it possible to retrieve the current page name in Unison.
			if (!_playingLocally)
			{
				if (ExternalInterface.available) ExternalInterface.addCallback("getPageName", getPageName);
			}
			
			//Panel for displaying data for debug purposes
			feedbackPanel = new InfoPanel(this.stage);
			feedbackPanel.updatePanel("Player File is loaded");
			feedbackPanel.updatePanel("Playing Locally: " + _playingLocally);
			//Make sure the XML isn't cached
			_cacheString = _processData.getSkipCacheString(_playingLocally);
			if (_cacheString == null) _cacheString = "";
			settingsModel.load(new URLRequest("config.xml" + _cacheString));
			settingsModel.addEventListener(Model.MODEL_LOADED,settingsLoaded);
		}
		
		private function settingsLoaded(e:Event):void
		{
			settingsModel.removeEventListener(Model.MODEL_LOADED,settingsLoaded);
			var scoxml:String = settingsModel.paths.scoXML;
			_toc = settingsModel.paths.tocSWF;
			
			quizModel = new QuizModel(_coursePreloader);
			var quizxml:String = settingsModel.paths.quizXML;
			//Make sure the XML isn't cached.
			_cacheString = _processData.getSkipCacheString(_playingLocally);
			if (_cacheString == null) _cacheString = "";
			quizModel.load(new URLRequest(quizxml + _cacheString));
			quizModel.addEventListener(Model.MODEL_LOADED,quizXMLLoaded);
			
			/*playerModel = new CourseModel(_coursePreloader,this);
			playerModel.feedbackPanel = feedbackPanel;
			//Make sure the XML isn't cached
			_cacheString = _processData.getSkipCacheString(_playingLocally);
			if (_cacheString == null) _cacheString = "";
			playerModel.load(new URLRequest(scoxml + _cacheString));
			playerModel.addEventListener(Model.MODEL_LOADED,courseXMLLoaded);*/
		}
		
		private function courseXMLLoaded(e:Event):void
		{
			trace("THE SCO.XML FILE HAS LOADED:");
			playerModel.removeEventListener(Model.MODEL_LOADED,courseXMLLoaded);
			
			startCourse();
			
			/*quizModel = new QuizModel(_coursePreloader);
			var quizxml:String = settingsModel.paths.quizXML;
			//Make sure the XML isn't cached.
			_cacheString = _processData.getSkipCacheString(_playingLocally);
			if (_cacheString == null) _cacheString = "";
			quizModel.load(new URLRequest(quizxml + _cacheString));
			quizModel.addEventListener(Model.MODEL_LOADED,quizXMLLoaded);*/
			
			/*glossaryModel = new GlossaryModel(_coursePreloader);
			var glossxml:String = settingsModel.paths.glossaryXML;
			//Make sure the XML isn't cached.
			_cacheString = _processData.getSkipCacheString(_playingLocally);
			if (_cacheString == null) _cacheString = "";
			glossaryModel.load(new URLRequest(glossxml + _cacheString));
			glossaryModel.addEventListener(Model.MODEL_LOADED,glossaryXMLLoaded);*/
		}
		
		//Loading the quiz.xml file is no longer required.
		private function quizXMLLoaded(e:Event):void
		{
			quizModel.removeEventListener(Model.MODEL_LOADED,quizXMLLoaded);
			trace("THE QUIZ.XML FILE HAS LOADED:");
			glossaryModel = new GlossaryModel(_coursePreloader);
			var glossxml:String = settingsModel.paths.glossaryXML;
			//Make sure the XML isn't cached.
			_cacheString = _processData.getSkipCacheString(_playingLocally);
			if (_cacheString == null) _cacheString = "";
			glossaryModel.load(new URLRequest(glossxml + _cacheString));
			glossaryModel.addEventListener(Model.MODEL_LOADED,glossaryXMLLoaded);
		}
		
		private function glossaryXMLLoaded(e:Event):void
		{
			glossaryModel.removeEventListener(Model.MODEL_LOADED,glossaryXMLLoaded);
			trace("THE GLOSSARY.XML FILE HAS LOADED:");
			
			var scoxml:String = settingsModel.paths.scoXML;
			_toc = settingsModel.paths.tocSWF;
			
			playerModel = new CourseModel(_coursePreloader,this,quizModel);
			playerModel.feedbackPanel = feedbackPanel;
			//Make sure the XML isn't cached
			_cacheString = _processData.getSkipCacheString(_playingLocally);
			if (_cacheString == null) _cacheString = "";
			playerModel.load(new URLRequest(scoxml + _cacheString));
			playerModel.addEventListener(Model.MODEL_LOADED,courseXMLLoaded);
			
			//startCourse();	
		}
		
		public function startCourse():void
		{
			feedbackPanel.updatePanel("Starting the Course.");
			//trace("USE INTERFACE COLORS: " + settingsModel.getSetting("useinterfacecolors"));
			//Show UI of Course
			this.gotoAndStop("course");
			trace("COURSE UI IS NOW VISABLE");
			//progress loader
			progressViewLoading(1,4);
			//Display Titles
			textView = new TextView(settingsModel.settings);
			textView.model = playerModel;
			textView.addTitleField(heading_txt);
			textView.addPageField(page_title_txt);
			textView.addPageCounter(pageNumber_txt);
			//Load Logo
			var logoPath:String = settingsModel.paths.courseLogo;
			if (playerModel.courseAttributes.courseLogo != null) logoPath = playerModel.courseAttributes.courseLogo;
			if (playerModel.courseAttributes.loadCourseLogo || logoPath != null)
			{
				_logoLoader = new Loader();
				_logoLoader.load(new URLRequest(logoPath));
				courselogo.addChild(_logoLoader);
			}
			
			//progress loader
			progressViewLoading(2,4);
			//Activate Controls
			navControl = new ButtonController(playerModel);
			buttonView = new ButtonView();
			buttonView.model = playerModel;
			buttonView.controller = navControl;
			buttonView.addNextButton(next_mc);
			buttonView.addPrevButton(back_mc);
			
			audio_onoff_mc.stateCode = playerModel.audioStatus;		//prefix to labels used in this button for the initial state.
			buttonView.addAudioButton(audio_onoff_mc);
			back_mc.enabled = false;
			index_read_mc.stateCode = playerModel.indexState;
			buttonView.addIndexButton(index_read_mc);
			buttonView.addExitButton(exit_btn);
			buttonView.addGlossaryButton(glossary_btn);
			tab_mc.stateCode = playerModel.indexVisibleState;
			buttonView.addIndexTabButton(tab_mc);
			//Not determine which buttons are visible
			//We set up buttons even if they are hidden in case calls still need to be made to those buttons
			buttonView.setVisibleButtons();
			//progress loader
			progressViewLoading(3,4);
			//Media Player
			mediaControlView = new MediaControllerView(controller_mc,settingsModel.paths,presentation,playerModel);//Pass in reference to controlle movie clip, paths, presentation movie clip where content is displayed, and model
			//progress loader
			progressViewLoading(4,4);
			
			//Activate View
			indexView = new IndexView(settingsModel.paths,_toc,indexName_mc,settingsModel.styles,settingsModel.settings,_coursePreloader,playerModel,tab_mc);//Pass in reference to toc.swf location, instance name of index, styles, settings, preloader and model.
			indexView.addEventListener(IndexView.INDEX_VIEW_LOADED,finishCourseLoading);
					
			//Add mask for index and content
			
			tocMask_mc.x = settingsModel.settings.maskLocationX;
			tocMask_mc.y = settingsModel.settings.maskLocationY;
			contentMask_mc.x = presentation.x;
			contentMask_mc.y = settingsModel.settings.maskLocationY;
			tocMask_mc.width = settingsModel.settings.presentSizeW;
			tocMask_mc.height = settingsModel.settings.presentSizeH;
			contentMask_mc.width = settingsModel.settings.presentSizeW;
			contentMask_mc.height = settingsModel.settings.presentSizeH;
			addChild(tocMask_mc);
			addChild(contentMask_mc);
			
			indexName_mc.mask = tocMask_mc;
			presentation.mask = contentMask_mc;
		}
		
		private function finishCourseLoading(e:Event):void
		{
			indexView.removeEventListener(IndexView.INDEX_VIEW_LOADED,finishCourseLoading);
			//Hide Mask
			cover_mc.alpha = 1;
			var courseTween:TweenLite = new TweenLite(cover_mc, .5, {alpha:0, ease:Strong.easeOut, onComplete:hideCover});
			//Content Page
			contentView = new ContentView(presentation,stage,playerModel,settingsModel);//Pass in reference to presentation movie clip where content is displayed, stage (not necessary), and model.
			//Glossary
			glossaryView = new GlossaryView(glossary_mc,settingsModel.paths,settingsModel.settings,settingsModel.styles,glossaryModel,playerModel); //Pass in glossary movie clip, paths data, glossary model and course model.
			//Load the FIRST PAGE.
			playerModel.changePage(0);
			//Remove the course preloader.
			if (_coursePreloader) _coursePreloader.parent.removeChild(_coursePreloader);
		}
		
		private function hideCover():void
		{
			//cover_mc._visible = false;
			this.removeChild(cover_mc);
		}
		
		private function progressViewLoading(cur:int,tot:int):void
		{
			var perc:Number = cur/tot;
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
		
		private function dataLoading(e:ProgressEvent):void
		{	
			
		}
		
		//Setter and Getter Methods
		public function set coursePreloader(p:MovieClip):void
		{
			_coursePreloader = p;
			//trace("preloader: " + _coursePreloader);
		}
		
		public function get coursePreloader():MovieClip
		{
			return _coursePreloader;
		}
	}
}
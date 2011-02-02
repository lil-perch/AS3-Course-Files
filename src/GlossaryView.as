package src
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	
	import src.AssetClasses.Glossary;
	import src.AssetClasses.Term;
	import src.classes.Path;
	import src.classes.Settings;
	import src.classes.Style;
	
	import fl.containers.ScrollPane;
	
	//import fl.containers.ScrollPane;

	public class GlossaryView extends View
	{
		private var _glossaryContainer:Sprite;
		private var _loader:Loader;
		private var _courseModel:CourseModel;
		private var _glossary:MovieClip;
		private var _settings:Settings;
		private var _styles:Style;
		private var _paths:Path;
		private var _cssFile:URLLoader;
		private var _css:StyleSheet;
		private var _scrollPos:Number =21;
		
		public function GlossaryView(g:Sprite,paths:Path,sett:Settings,glstyle:Style,gm:GlossaryModel,cm:CourseModel)
		{
			_glossaryContainer = g;
			_settings = sett;
			_styles = glstyle;
			_paths = paths;
			model = gm;
			courseModel = cm;
			_loader = new Loader();
			
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, glossaryLoaded);
			
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,glossaryLoading);
			
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadingError);
			
			_loader.load(new URLRequest(paths.glossarySWF));
		}
		
		override public function update(event:Event = null):void
		{
			trace("GLOSSARY DATA IS UPDATED");
			_glossary.term_txt.htmlText = "<span class=\"heading\">" + GlossaryModel(model).theTerm + "</span>";
			_glossary.description_txt.htmlText = "<span class=\"description\">" + GlossaryModel(model).definition + "</span>";
			_glossary.scrollPane.verticalScrollPosition = GlossaryModel(model).scrollPosition;
		}
		
		//Override for Button View because it needs to subscribe to another event
		override public function set model(m:Model):void
		{
			super.model = m;
			m.addEventListener(Model.GLOSSARY_CHANGE,update);
		}
		
		public function glossaryLoaded(e:Event):void
		{
			trace("GLOSSARY LOADED AND READY TO SHOW.");
			_glossary = Glossary(_loader.content);
			_glossary.model = model; 
			_glossary.courseModel = _courseModel;
			_glossary.setUpControls();
			_glossary.scrollPane.load(new URLRequest(_paths.glossaryTerm));
			_glossary.scrollPane.addEventListener(Event.COMPLETE, scrollPaneLoaded);
			_cssFile = new URLLoader();
			_cssFile.addEventListener(Event.COMPLETE,cssLoaded);
			_cssFile.addEventListener(IOErrorEvent.IO_ERROR,cssError);
			_cssFile.load(new URLRequest(_paths.glossaryCSS));
			//createLetterMenu();
		}
		
		private function createLetterMenu(letter:String,xPos:int,yPos:int,space:int,scrollPos:Number):void
		{
			
			if (letter == "W-Z")
				_glossary.createMenuLetter(letter,xPos,yPos,_styles.glossMenuColor,_styles.glossMenuOverColor,_styles.glossMenuUnderline,scrollPos,"LEFT");
			else
				_glossary.createMenuLetter(letter.toUpperCase(),xPos,yPos,_styles.glossMenuColor,_styles.glossMenuOverColor,_styles.glossMenuUnderline,scrollPos)
		}
		
		private function scrollPaneLoaded(e:Event):void
		{
			var glossTerms:MovieClip = e.target.content;
			glossTerms.model = model;
			//trace("SOURCE: " + glossTerms);
			glossTerms.createTermFormats(_styles.termColor,_styles.termOverColor,_styles.termMargin,_styles.termSize,_styles.termStyle);
			//Data for creating menu
			var xPos:int = _settings.glossaryMenuX;
			var yPos:int = _settings.glossaryMenuY;
			var space:int = _settings.glossaryMenuSpace;
			
			/* IMPORTANT: I banged my head a long time over this line of code.
			Because of the namespace in the glossary file I can't use the E4X syntax
			without first declaring a default namespace*/
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/glossary";
			
			var letters:XMLList = model.glossary;
			for each (var item in letters)
			{
				var letter:String = item.@text;
				glossTerms.createLetter(letter,_styles.letterColor,_styles.letterSize,_styles.letterStyle,_styles.letterMargin);
				if (letter!="*" && letter.toUpperCase()!="W" && letter.toUpperCase()!="X" && letter.toUpperCase()!="Y" && letter.toUpperCase()!="Z")
				{
					createLetterMenu(letter,xPos,yPos,space,_scrollPos);
					_scrollPos = glossTerms.currentPos;
					xPos += space;
				}
			
				var l:XML = item;
				createTheTerms(l,glossTerms); //Now create the terms inside that letter
			}
			createLetterMenu("W-Z",xPos,yPos,space,_scrollPos);
			ScrollPane(e.target).update();
		}
		
		private function createTheTerms(terms:XML,glossTerms:MovieClip):void
		{
			for each (var i:XML in terms.elements())//elements())
			{
				
				if (i.localName() == "term")
				{
					//trace(i.@text + " -- " + i.definition);
					glossTerms.createTerms(i.@text,i.definition,_scrollPos);
					_scrollPos = glossTerms.currentPos;
				}
			}
		}
		
		private function hideShowGlossary(e:Event):void
		{
			if (courseModel.glossaryState == "visible")
			{
				_glossaryContainer.addChild(_loader);
			} else if (courseModel.glossaryState == "hidden") {
				_glossaryContainer.removeChild(_loader);
			}
		}
		
		private function cssLoaded(e:Event):void
		{
			_css = new StyleSheet();
			_css.parseCSS(e.target.data);
			_glossary.term_txt.styleSheet = _css;
			_glossary.description_txt.textField.styleSheet = _css;
		}
		
		private function cssError(e:IOErrorEvent):void
		{
			trace("ERROR LOADING CSS FOR GLOSSARY FILES: " + e.text);
		}
		
		private function glossaryLoading(e:ProgressEvent):void
		{
			
		}
		
		private function loadingError(e:IOErrorEvent):void
		{
			trace("PROBLEM LOADING THE GLOSSARY: " + e.text);
		}
		
		public function set courseModel(m:CourseModel):void
		{
			_courseModel = m;
			_courseModel.addEventListener(Model.GLOSSARY_CHANGE,hideShowGlossary);
		}
		
		public function get courseModel():CourseModel
		{
			return _courseModel;
		}
	}
}
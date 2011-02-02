package src.pages
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.StyleSheet;
	import flash.xml.*;
	
	import src.CourseModel;
	import src.Model;
	import src.SettingsModel;
	

	public class DynamicPageAPI extends MovieClip
	{
		/*This class is the API for all page types.
		What types of methods does it need?
		What should this class do automatically?
		
		I'm going to have the ContentView pass in the model
		*/
		private var _model:Model;
		private var _courseModel:CourseModel;
		private var _currentPageTag:XML;
		private var _rootTag:XML;
		private var _useScoXML:Boolean;//Set to true if you need more of the sco.xml file then just the current page.
		private var _css:StyleSheet;
		private var _preloader:MovieClip;
		private var _settingsModel:SettingsModel;
		private var _controlContainer:MovieClip;
		
		public function DynamicPageAPI()
		{
			_useScoXML = false;
			_controlContainer = this;
		}
		
		//THIS FUNCTION SHOULD BE OVERIDDEN IN THE PAGE CLASS FILE
		//WHEN CALLED IT BEGINS LOADING THE PAGE TEMPLATE ELEMENTS
		public function loadPage():void
		{
			
		}
		
		public function set currentPageTag(n:XML):void
		{
			_currentPageTag = n;
			//trace("custom: " + _currentPageTag.toXMLString());
		}
		
		public function get currentPageTag():XML
		{
			return _currentPageTag;
		}
		
		public function set rootNode(n:XML):void
		{
			_rootTag = n;
			//trace("data: " + _rootTag)
		}
		
		public function get rootNode():XML
		{
			return _rootTag;
		}
		
		public function set useScoXML(n:Boolean):void
		{
			_useScoXML = n;
		}
		
		public function get useScoXML():Boolean
		{
			return _useScoXML;
		}
		
		public function set textCss(c:StyleSheet):void
		{
			_css = c;
			//trace("set the style sheet");
		}
		
		public function get textCss():StyleSheet
		{
			return _css;
		}
		
		public function set preloader(p:MovieClip):void
		{
			_preloader = p;
		}
		
		public function get preloader():MovieClip
		{
			return _preloader;
		}
		
		public function set settingsModel(m:SettingsModel):void
		{
			_settingsModel = m;
		}
		
		public function get settingsModel():SettingsModel
		{
			return _settingsModel;
		}
		
		public function get courseModel():CourseModel
		{
			return _courseModel;
		}
		
		public function set courseModel(m:CourseModel):void
		{
			_courseModel = m;
		}
		
		//public function loadImage():
		
		//THESE FUNCTIONS NEED TO BE OVERRIDEN BY THE PAGE CLASS IF FALSE IS NOT CORRECT. THEY ARE USED BY THE MEDIA CONTROLLER.
		public function get audioPage():Boolean
		{
			return false;
		}
		
		public function get videoPage():Boolean
		{
			return false;
		}
		
		public function get swfPage():Boolean
		{
			return false;
		}
		
		//IF THE PAGE IS AN AUDIO/VIDOE/SWF PAGE NEED TO OVERRIDE THIS FUNCTION TO RETURN THE INSTANCE NAME OF THE OBJECT PLAYING THE MEDIA THAT WILL BE CONTROLLED BY THE MEDIA PLAYER
		public function get mediaPlayer():*
		{
			return _controlContainer;
		}
	}
}
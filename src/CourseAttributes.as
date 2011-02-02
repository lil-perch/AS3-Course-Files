package src
{

	public class CourseAttributes
	{
		private var _pageComplete:Boolean = false;
		private var _completion:String = "none";
		private var _transition:String = "none";
		private var _tranDirection:String = "right";
		private var _transitionTime:Number = 1;
		private var _exitButton:Boolean = true;
		private var _audioButton:Boolean = true;
		private var _pageNumbering:Boolean = true;
		private var _saturationPercent:int = 50;
		private var _persIndex:Boolean = false;
		private var _loadCourseLogo:Boolean = true;
		private var _includeQuestionCnt:Boolean = false;
		private var _indexTooltip:Boolean = true;
		private var _autoNavigation:Boolean = false;
		private var _title:String;
		private var _narration:Boolean;
		private var _tracking:String = "NONE";
		private var _glossary:Boolean = true;
		private var _courseLogo:String;
		
		public function CourseAttributes()
		{
			
		}
		
		public function updateCourseAttributes(courseXML:XML):void
		{
			_pageComplete = (courseXML.@pageComplete.toString().toUpperCase() == "TRUE");
			_completion = courseXML.@completion;
			_transition = courseXML.@transition;
			_tranDirection = courseXML.@tranDirection.toString().toLowerCase();
			_transitionTime = Number(courseXML.@transitionTime);
			_exitButton = (courseXML.@exitButton.toString().toUpperCase() == "TRUE");
			_audioButton = (courseXML.@audioButton.toString().toUpperCase() == "TRUE");
			_pageNumbering = (courseXML.@pageNumbering.toString().toUpperCase() == "TRUE");
			if ("@saturationPercent" in courseXML) _saturationPercent = int(courseXML.@saturationPercent);
			if ("@persIndex" in courseXML) _persIndex = (courseXML.@persIndex.toString().toUpperCase() == "TRUE");
			if ("@loadCourseLogo" in courseXML) _loadCourseLogo = (courseXML.@loadCourseLogo.toString().toUpperCase() == "TRUE");
			_includeQuestionCnt = (courseXML.@include_question_cnt.toString().toUpperCase() == "TRUE");
			_indexTooltip = (courseXML.@indexTooltip.toString().toUpperCase() == "TRUE");
			_autoNavigation = (courseXML.@autoNavigation.toString().toUpperCase() == "TRUE");
			_title = courseXML.@title;
			_narration = (courseXML.@narration.toString().toUpperCase() == "TRUE");
			_tracking = courseXML.@tracking.toString().toUpperCase();
			_glossary = (courseXML.@glossary.toString().toUpperCase() == "TRUE");
			if ("@courseLogo" in courseXML) _courseLogo = courseXML.@courseLogo;
		}
		
		public function get pageComplete():Boolean
		{
			return _pageComplete;
		}
		
		public function get completion():String
		{
			return _completion;
		}
		
		public function get transition():String
		{
			return _transition;
		}
		
		public function get tranDirection():String
		{
			return _tranDirection;
		}
		
		public function get transitionTime():Number
		{
			return _transitionTime;
		}
		
		public function get exitButton():Boolean
		{
			return _exitButton;
		}
		
		public function get audioButton():Boolean
		{
			return _audioButton;
		}
		
		public function get pageNumbering():Boolean
		{
			return _pageNumbering;
		}
		
		public function get saturationPercent():int
		{
			return _saturationPercent;
		}
		
		public function get persIndex():Boolean
		{
			return _persIndex;
		}
		
		public function get loadCourseLogo():Boolean
		{
			return _loadCourseLogo;
		}
		
		public function get includeQuestionCnt():Boolean
		{
			return _includeQuestionCnt;
		}
		
		public function get indexTooltip():Boolean
		{
			return _indexTooltip;
		}
		
		public function get autoNavigation():Boolean
		{
			return _autoNavigation;
		}
		
		public function get title():String
		{
			return _title;
		}
		
		public function get narration():Boolean
		{
			return _narration;
		}
		
		public function get tracking():String
		{
			return _tracking;
		}
		
		public function get glossary():Boolean
		{
			return _glossary;
		}
		
		public function get courseLogo():String
		{
			return _courseLogo;
		}
	}
}
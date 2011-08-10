package src.classes
{
	public class Style
	{
		private var _xTColor:uint;
		private var _xPColor:uint;
		private var _xOColor:uint;
		private var _xDColor:uint;
		private var _highlightIndexColor:uint;
		private var _glossMenuColor:uint;
		private var _glossOverColor:uint;
		private var _glossMenuUnderline:Boolean;
		private var _termColor:uint;
		private var _termOverColor:uint;
		private var _termSize:int;
		private var _termStyle:String;
		private var _termMargin:int;
		private var _letterSize:int;
		private var _letterStyle:String;
		private var _letterColor:uint;
		private var _letterMargin:int;
		private var _distractorFont:String;					//Font used for styling the distractors in quiz questions
		private var _distractorFontSize:int;				//Size of font used for distractors in quiz questions
		private var _distractorFontColor:uint;				//Color of font used for distractors in quiz questions
		
		public function Style()
		{
			
		}
		
		//Setter and Getter Methods
		public function set xTopicColor(c:uint):void
		{
			_xTColor = c;
		}
		
		public function get xTopicColor():uint
		{
			return _xTColor;
		}
		
		public function set xPgColor(c:uint):void
		{
			_xPColor = c;
		}
		
		public function get xPgColor():uint
		{
			return _xPColor;
		}
		
		public function set xOvColor(c:uint):void
		{
			_xOColor = c;
		}
		
		public function get xOvColor():uint
		{
			return _xOColor;
		}
		
		public function set xDisColor(c:uint):void
		{
			_xDColor = c;
		}
		
		public function get xDisColor():uint
		{
			return _xDColor;
		}
		
		public function set highlightIndexColor(c:uint):void
		{
			_highlightIndexColor = c;
		}
		
		public function get highlightIndexColor():uint
		{
			return _highlightIndexColor;
		}
		
		public function set glossMenuColor(c:uint):void
		{
			_glossMenuColor = c;
		}
		
		public function get glossMenuColor():uint
		{
			return _glossMenuColor;
		}
		
		public function set glossMenuOverColor(c:uint):void
		{
			_glossOverColor = c;
		}
		
		public function get glossMenuOverColor():uint
		{
			return _glossOverColor;
		}
		
		public function set glossMenuUnderline(c:Boolean):void
		{
			_glossMenuUnderline = c;
		}
		
		public function get glossMenuUnderline():Boolean
		{
			return _glossMenuUnderline;
		}
		
		public function set termColor(c:uint):void
		{
			_termColor = c;
		}
		
		public function get termColor():uint
		{
			return _termColor;
		}
		
		public function set termOverColor(c:uint):void
		{
			_termOverColor = c;
		}
		
		public function get termOverColor():uint
		{
			return _termOverColor;
		}
		
		public function set termSize(c:int):void
		{
			_termSize = c;
		}
		
		public function get termSize():int
		{
			return _termSize;
		}
		
		public function set termStyle(c:String):void
		{
			_termStyle = c;
		}
		
		public function get termStyle():String
		{
			return _termStyle;
		}
		
		public function set letterSize(c:int):void
		{
			_letterSize = c;
		}
		
		public function get letterSize():int
		{
			return _letterSize;
		}
		
		public function set letterStyle(c:String):void
		{
			_letterStyle = c;
		}
		
		public function get letterStyle():String
		{
			return _letterStyle;
		}
		
		public function set letterColor(c:uint):void
		{
			_letterColor = c;
		}
		
		public function get letterColor():uint
		{
			return _letterColor;
		}
		
		public function set letterMargin(c:int):void
		{
			_letterMargin = c;
		}
		
		public function get letterMargin():int
		{
			return _letterMargin;
		}
		
		public function set termMargin(c:int):void
		{
			_termMargin = c;
		}
		
		public function get termMargin():int
		{
			return _termMargin;
		}
		
		public function set distractorFont(s:String):void
		{
			_distractorFont = s;
		}
		
		public function get distractorFont():String
		{
			return _distractorFont;
		}
		
		public function set distractorFontSize(c:int):void
		{
			_distractorFontSize = c;
		}
		
		public function get distractorFontSize():int
		{
			return _distractorFontSize;
		}
		
		public function set distractorFontColor(c:uint):void
		{
			_distractorFontColor = c;
		}
		
		public function get distractorFontColor():uint
		{
			return _distractorFontColor;
		}
	}
}
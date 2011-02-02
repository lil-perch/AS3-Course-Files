package src.AssetClasses
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class MenuLetter extends MovieClip
	{
		public var letter_txt:TextField;
		
		private var _upColor:uint;
		private var _overColor:uint;
		private var _underline:Boolean;
		private var _upFmt:TextFormat;
		private var _overFmt:TextFormat;
		private var _scrollPos:Number;
		
		public function MenuLetter()
		{
			//super();
			letter_txt.autoSize = TextFieldAutoSize.CENTER;
			_upFmt = new TextFormat();
			_overFmt = new TextFormat();
			_upFmt.color = this.letter_txt.textColor;
			_upFmt.underline = false;
			this.letter_txt.mouseEnabled = false;
			this.buttonMode = true;
			this.letter_txt.setTextFormat(_upFmt);
			this.addEventListener(MouseEvent.CLICK,clicked);
			this.addEventListener(MouseEvent.ROLL_OVER,over);
			this.addEventListener(MouseEvent.ROLL_OUT,out);
		}
		
		private function clicked(e:MouseEvent):void
		{
			Glossary(parent).scrollGlossary(scrollPos);
		}
		
		private function over(e:MouseEvent):void
		{
			this.letter_txt.setTextFormat(_overFmt);
		}
		
		private function out(e:MouseEvent):void
		{
			this.letter_txt.setTextFormat(_upFmt);
		}
		
		public function set upColor(c:uint):void
		{
			_upColor = c;
			_upFmt.color = c;
			this.letter_txt.setTextFormat(_upFmt);
		}
		
		public function get upColor():uint
		{
			return _upColor;
		}
		
		public function set overColor(c:uint):void
		{
			_overColor = c;
			_overFmt.color = c;
		}
		
		public function get overColor():uint
		{
			return _overColor;
		}
		
		public function set underline(c:Boolean):void
		{
			_underline = c;
			_overFmt.underline = c;
		}
		
		public function get underline():Boolean
		{
			return _underline;
		}
		
		public function set scrollPos(c:Number):void
		{
			_scrollPos = c;
		}
		
		public function get scrollPos():Number
		{
			return _scrollPos;
		}
	}
}
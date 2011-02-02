package src.AssetClasses
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent;
	
	import src.AssetClasses.GlossaryTerms;

	public class Term extends MovieClip
	{
		public var term_txt:TextField;
		
		private var _definition:String;
		private var _term:String;
		private var _scrollPos:Number;
		
		public function Term()
		{
			//super();
			this.term_txt.mouseEnabled = false;
			this.buttonMode = true;
			this.term_txt.autoSize = TextFieldAutoSize.LEFT;
			
			this.addEventListener(MouseEvent.ROLL_OVER,over);
			this.addEventListener(MouseEvent.ROLL_OUT,out);
			this.addEventListener(MouseEvent.CLICK,clicked);
		}
		
		private function clicked(e:MouseEvent):void
		{
			setDefinition();
		}
		
		private function over(e:MouseEvent):void
		{
			this.term_txt.setTextFormat(GlossaryTerms(parent).overTFmt);
		}
		
		private function out(e:MouseEvent):void
		{
			this.term_txt.setTextFormat(GlossaryTerms(parent).dftTFmt);
		}
		
		public function setDefinition():void
		{
			GlossaryTerms(parent).model.termSelected(this.theTerm,this.definition);
		}
		
		public function scrollToTerm():void
		{
			GlossaryTerms(parent).model.changeScrollPosition(this.scrollPos,true)
		}
		
		public function set definition(c:String):void
		{
			_definition = c;
		}
		
		public function get definition():String
		{
			return _definition;
		}
		
		public function set theTerm(c:String):void
		{
			_term = c;
			term_txt.text = c;
		}
		
		public function get theTerm():String
		{
			return _term;
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
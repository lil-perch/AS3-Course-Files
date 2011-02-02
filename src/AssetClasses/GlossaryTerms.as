package src.AssetClasses
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	import src.GlossaryModel;
	import src.classes.ProcessData;

	public class GlossaryTerms extends MovieClip
	{
		private var _currY:Number = 0;
		private var _currX:Number = 0;
		private var _dftTFmt:TextFormat;
		private var _overTFmt:TextFormat;
		private var _model:GlossaryModel;
		private var _data:ProcessData;
		
		public function GlossaryTerms()
		{
			//super();
			//trace("running");
			_data = new ProcessData();
		}
		
		public function createLetter(lett:String,lColor:uint,lSize:int,lStyle:String,lMarg:int):void
		{
			var aLetter:Letter = new Letter();
			aLetter.content_txt.autoSize = TextFieldAutoSize.LEFT;
			aLetter.content_txt.text = lett;
			var lFmt:TextFormat = new TextFormat;
			lFmt.color = lColor;
			lFmt.size = lSize;
			switch (lStyle) 
			{
				case "bold":
					lFmt.bold = true;
					break;
				case "underline":
					lFmt.underline = true;
					break;
				case "italic":
					lFmt.italic = true;
					break;
			}
			lFmt.leftMargin = lMarg;
			aLetter.content_txt.setTextFormat(lFmt);
			aLetter.x = _currX;
			aLetter.y = _currY;
			aLetter.name = _data.stripspaces(lett);
			//trace(lett, " - ", _currY);
			addChild(aLetter);
			_currY += aLetter.height;
		}
		
		public function createTerms(term:String,def:String,scrollPos:Number):void
		{
			var aTerm:MovieClip = new Term();
			aTerm.definition = def;
			aTerm.theTerm = term;
			aTerm.term_txt.setTextFormat(_dftTFmt);
			aTerm.x = _currX;
			aTerm.y = _currY;
			aTerm.name = _data.stripspaces(term).toLowerCase();
			aTerm.scrollPos = scrollPos;
			//aTerm.addEventListener(MouseEvent.ROLL_OVER,over);
			//aTerm.addEventListener(MouseEvent.ROLL_OUT,out);
			//aTerm.addEventListener(MouseEvent.CLICK,clicked);
			_currY += aTerm.height;
			addChild(aTerm);
		}
		
		public function createTermFormats(tColor:uint,tOColor:uint,tMargin:int,tSize:int,tStyle:String)
		{
			_dftTFmt = new TextFormat();
			_dftTFmt.color = tColor;
			_dftTFmt.leftMargin = tMargin;
			_dftTFmt.size = tSize;
			
			_overTFmt = new TextFormat();
			_overTFmt.color = tOColor;
			_overTFmt.leftMargin = tMargin;
			_overTFmt.size = tSize;
			
			switch (tStyle) 
			{
				case "bold":
					_dftTFmt.bold = true;
					_overTFmt.bold = true;
					break;
				case "underline":
					_dftTFmt.underline = true;
					_overTFmt.underline = true;
					break;
				case "italic":
					_dftTFmt.italic = true;
					_overTFmt.italic = true;
					break;
			}
		}
		
		/*private function clicked(e:MouseEvent):void
		{
			_model.termSelected(e.target.theTerm,e.target.definition);
		}
		
		private function over(e:MouseEvent):void
		{
			e.target.term_txt.setTextFormat(_overTFmt);
		}
		
		private function out(e:MouseEvent):void
		{
			e.target.term_txt.setTextFormat(_dftTFmt);
		}*/
		
		public function get model():GlossaryModel//This way the view class can be used with any model.
		{
			return _model;
		}
		
		public function set model(m:GlossaryModel):void
		{
			_model = m;
		}
		
		public function get currentPos():Number
		{
			return _currY;
		}
		
		public function get overTFmt():TextFormat
		{
			return _overTFmt;
		}	
		
		public function get dftTFmt():TextFormat
		{
			return _dftTFmt;
		}
	}
}
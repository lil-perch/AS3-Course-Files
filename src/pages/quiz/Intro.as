package src.pages.quiz
{
	//import fl.controls.TextArea;
	import fl.controls.UIScrollBar;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import src.pages.quiz.QuizQuestions;
	
	
	public class Intro extends QuizQuestions
	{
		
		//public var intro_ta:TextArea;
		public var intro_txt:TextField;
		public var heading_mc:MovieClip;
		public var scrollbar:UIScrollBar;
		
		private var _sizeH:Number;
		private var _sizeW:Number;
		private var _gutter:int = 50;
		
		public function Intro()
		{
			super();
		}
		
		override public function loadPage():void
		{
			_sizeH = settingsModel.settings.presentSizeH;
			_sizeW = settingsModel.settings.presentSizeW;
			//trace("SIZE: " + _sizeW + " - " + _sizeH);
			
			//Establish settings for page
			doSettings()
			//Size and position stage objects
			sizeIntroElements();
			positionElements();
			
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
			intro_txt.styleSheet = textCss;
			intro_txt.htmlText = "<span class='introtext'>" + currentPageTag.introText + "</span>";
			if (intro_txt.maxScrollV > 1)
			{
				scrollbar.visible = true;
				//intro_txt.border = true;
			}
			if (currentPageTag.@title.length() > 0) heading_mc.quiz_title_txt.text = currentPageTag.@title;
			
		}
		
		
		
		private function doSettings():void
		{
			establishQuizSettings();
		}
		
		private function sizeIntroElements():void
		{
			intro_txt.width = heading_mc.width;
			intro_txt.height = _sizeH - topMargin - bottomMargin - (_gutter*3) - heading_mc.height;
			scrollbar.height = intro_txt.height;
		}
		
		private function positionElements():void
		{
			heading_mc.y = topMargin + _gutter;
			heading_mc.x = (_sizeW - heading_mc.width)/2;
			intro_txt.x = heading_mc.x;
			intro_txt.y = topMargin + heading_mc.height + (_gutter*2);
			scrollbar.y = intro_txt.y;
			scrollbar.x = intro_txt.x + intro_txt.width;
		}
	}
}
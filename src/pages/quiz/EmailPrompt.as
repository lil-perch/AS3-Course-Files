package src.pages.quiz
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import src.com.AlertButton;
	import src.pages.quiz.Results;
	

	public class EmailPrompt extends MovieClip
	{
		public var exit_btn:SimpleButton;								//Exit Button
		public var review_txt:TextField;								// Title Text Field
		public var inputName_txt:TextField;								// Input field for name
		public var inputEmail_txt:TextField;							// Input field for email
		public var bg_mc:MovieClip;										// Background
		public var test_txt:TextField;
		
		private var _okBtn:AlertButton;									// OK/Send Button
		private var _result:Results;									// Reference to Results page
		
		
		public function EmailPrompt(result:Results)
		{
			
			_result = result;
			//trace("RESULT: " + _result);
			//Add button
			_okBtn = new AlertButton(70, 25, 10, 2, 0x00AEEF, 0x4092E1, "Send", 0xFFFFFF, 0xCCCCCC);
			_okBtn.x = this.width - _okBtn.width - 20;
			_okBtn.y = this.height - _okBtn.height - 10;
			_okBtn.addEventListener(MouseEvent.CLICK,sendButtonClick);
			exit_btn.addEventListener(MouseEvent.CLICK,closePrompt);
			
			inputName_txt.addEventListener(Event.ADDED_TO_STAGE,setFocus);
			
			this.addChild(_okBtn);
		}
		
		private function setFocus(e:Event)
		{
			
			inputName_txt.removeEventListener(Event.ADDED_TO_STAGE,setFocus);
			e.target.stage.focus = inputName_txt;
			inputName_txt.setSelection(inputName_txt.text.length,inputName_txt.text.length);
		}
		
		private function sendButtonClick(e:MouseEvent):void
		{
			//trace("button clicked");
			//trace(inputName_txt.text + " - " + inputEmail_txt.text);
			closePrompt();
			_result.prepareEmail(inputName_txt.text,inputEmail_txt.text);
		}
		
		private function closePrompt(e:MouseEvent = null):void
		{
			//trace("RESULT: " + _result + " - ");
			exit_btn.removeEventListener(MouseEvent.CLICK,closePrompt);
			_okBtn.removeEventListener(MouseEvent.CLICK,sendButtonClick);
			_result.removeChild(_result.email_prompt);
		}
	}
}
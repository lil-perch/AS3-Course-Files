package src.pages.quiz
{
	import fl.controls.Button;
	import fl.controls.RadioButton;
	import fl.controls.UIScrollBar;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import src.pages.quiz.QuizQuestions;
	
	
	public class TrueFalse extends QuizQuestions
	{
		
		public var true_rb:RadioButton;
		public var false_rb:RadioButton;
		public var question_txt:TextField;
		public var feedback_txt:TextField;
		public var question_cnt_txt:TextField;						//Question counter text field.
		public var submit_btn:Button;
		public var scrollbarQ:UIScrollBar;
		public var scrollbarF:UIScrollBar;
		
		public var correct_resp:Boolean;
		public var learner_resp:Boolean;
		
		private var lr_str:String;									//String value of learner response.
		private var _questionH:int = 100;							//Height of question field.
		private var _feedbackH:int = 70;							//Height of feedback field.
		private var _correct_resp:Boolean;
		
		public function TrueFalse()
		{
			super();
		}
		
		override public function loadPage():void
		{
			//trace("SIZE: " + _sizeW + " - " + _sizeH);
			
			//Establish settings for question
			doSettings()
			//Size and position stage objects
			sizeElements(question_txt,feedback_txt,question_cnt_txt,scrollbarQ,scrollbarF,submit_btn,_questionH,_feedbackH); //Pass in question text field, feedback text field, counter text field, question scroll bar, feedback scroll bar, submit button, height of question text field, height of feedback text field
			//Number quiz questions
			numberQuizQuestions(question_cnt_txt);
			//Check for previous answer
			checkPreviousAnswer();
			var question:String = getQuestionText();
			setTextfieldText(question_txt,question,scrollbarQ,"question")
			//question_txt.htmlText = question;
			questionDescription = question_txt.text;
			var feedback:String = getFeedback("init");
			setTextfieldText(feedback_txt,feedback,scrollbarF,"feedback")
			addControlButton(submit_btn);
			submit_btn.enabled = false;
			setupButtonListener(true_rb);
			setupButtonListener(false_rb);
			
			var tf:TextFormat = new TextFormat(); 
			tf.color = settingsModel.styles.distractorFontColor;
			tf.font = settingsModel.styles.distractorFont;
			tf.size = settingsModel.styles.distractorFontSize;
			true_rb.setStyle("textFormat", tf);
			false_rb.setStyle("textFormat", tf);
		}
		
		override public function recordQuestion()
		{
			trace("Question Submitted TF");
			
			correct_resp = currentPageTag.@correctResp.toLowerCase() == "true";
			if (true_rb.selected)
			{
				learner_resp = true;
				lr_str = "true";
			} else if (false_rb.selected) {
				learner_resp = false;
				lr_str = "false";
			} else { //If nothing is selected, it is still false.
				//learner_resp = null;
				lr_str = null;
			}
			evalTF();
			//Store data in quizObject
			quizObject.addQuestionData(interactionID,questionType + "~" + lr_str + "~" + result + "~" + correct_resp + "~" + questionDescription + "~" + weighting + "~" + latency + "~" + objectiveID);
		}
		
		override public function sendSCORMData()
		{
			trace("sending data from the TRUE FALSE question.");
			trace(questionType  + " - " + questionDescription + " - " + interactionID + " - " +  correct_resp + " - " +  learner_resp + " - " +  result  + " - " + latency  + " - " + weighting  + " - " + objectiveID);
			//Send data to SCORM method
			var errmsg:String = lmsLink.apiSendTrueFalseData(interactionID,learner_resp,result,correct_resp,questionDescription,weighting,latency,objectiveID);
		}
		
		override public function populateQuizQuestionObject(q:QuestionsAnswered)
		{
			trace("Populating Qustion data from Object in TrueFalse");
			var ans:String = q.learnerResp;
			//trace(ans);
			if (ans.toLowerCase() == "true")
			{
				true_rb.selected = true;
				submit_btn.enabled = true;
			} else if (ans.toLowerCase() == "false") {
				false_rb.selected = true;
				submit_btn.enabled = true;
			}
		}
		
		override public function populateQuizQuestionLMS(learnArray:Array)
		{
			trace("Populating Qustion data from LMS in TrueFalse");
			infoPanel.updatePanel("Populating Qustion data from LMS in TrueFalse - learnArray: " + learnArray[0]);
			if (learnArray != null)
			{
				infoPanel.addToPreviousUpdate("learnArray != Null");
				//trace("Learn Array: " + learnArray[0]);
				var result:Boolean = (learnArray[0] == "true");
				if (learnArray[0] != null && learnArray[0] != undefined && learnArray[0] != "")
				{
					infoPanel.addToPreviousUpdate("result != Null");
					if (result)
					{
						true_rb.selected = true;
						submit_btn.enabled = true;
					} else {
						false_rb.selected = true;
						submit_btn.enabled = true;
					}
				}
			}
		}
		
		override public function cleanUpListenersLocal()
		{
			//trace("Cleaning up Listeners in TrueFalse");
			true_rb.removeEventListener(MouseEvent.CLICK,answerQuestion);
			false_rb.removeEventListener(MouseEvent.CLICK,answerQuestion);
		}
		
		public function evalTF():void
		{
			if (lr_str != null)
			{
				var lr_bl:Boolean = lr_str == "true";
				result = (correct_resp == lr_bl);
			} else {
				result = false;
			}
	//trace("result: " + result);
			if (result)
			{
				var feedback:String = getFeedback("correct");
				disableQuestion();	// Disable objects
			} else {
				//Check number of tries
				if (numberTries > 1 && numberOfAttempts < numberTries)
				{
					numberOfAttempts++;
					var feedback:String = getFeedback("tries");
					
				} else {
					disableQuestion();	// Disable objects
					var feedback:String = getFeedback("wrong");
				}
			}
			setTextfieldText(feedback_txt,feedback,scrollbarF,"feedback");
		}
		
		private function disableQuestion():void
		{
			true_rb.enabled = false;
			false_rb.enabled = false;
			submit_btn.enabled = false;
		}
		
		private function doSettings():void
		{
			questionType = "true-false";
			establishSettings();
		}
		
		private function setupButtonListener(btn:DisplayObject):void
		{
			btn.addEventListener(MouseEvent.CLICK,answerQuestion);
		}
		
		private function answerQuestion(e:MouseEvent):void
		{
			var feedback:String = getFeedback("eval");
			setTextfieldText(feedback_txt,feedback,scrollbarF,"feedback");
			submit_btn.enabled = true;
			questionSubmitted = false;				//Property in QuizQuestion is true if the question has alredy been checked for correctness.
		}
	}
}
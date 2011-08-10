package src.pages.quiz
{
	import fl.controls.Button;
	import fl.controls.TextInput;
	import fl.controls.UIScrollBar;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import src.pages.quiz.QuizQuestions;
	
	
	public class FillInBlank extends QuizQuestions
	{
		public var input_ti:TextInput
		public var prompt_txt:TextField;
		public var question_txt:TextField;
		public var feedback_txt:TextField;
		public var question_cnt_txt:TextField;					//Question counter text field.
		public var submit_btn:Button;
		public var scrollbarQ:UIScrollBar;
		public var scrollbarF:UIScrollBar;
		
		private var _questionH:int = 100;
		private var _feedbackH:int = 70;
		private var _correct_entries:Array;						//An array of all the possible correct responses.
		private var _exactMatch:Boolean;						//true if question requires an exact match.
		private var _caseSensitive:Boolean;						//true if evaluating question evaluates case.
		private var _learnerResponse:String;					//Text that learner enters.
		private var _str_correct_entries:String;				//the correct entries array converted to string - separator = |
		
		public function FillInBlank()
		{
			super();
		}
		
		override public function loadPage():void
		{
			//Declare Arrays
			_correct_entries = new Array();
			//Establish settings for question
			doSettings()
			//Size and position stage objects
			sizeElements(question_txt,feedback_txt,question_cnt_txt,scrollbarQ,scrollbarF,submit_btn,_questionH,_feedbackH); //Pass in question text field, feedback text field, counter text field, question scroll bar, feedback scroll bar, submit button, height of question text field, height of feedback text field
			//Number quiz questions
			numberQuizQuestions(question_cnt_txt);
			//Position other elements
			positionInput();
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
			setupButtonListener(input_ti);
			
			//Get Correct Entries and Other Settings
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
			getCorrectEntries(currentPageTag.responses.*)
			_exactMatch = currentPageTag.@exactMatch.toLowerCase() == "true";
			_caseSensitive = currentPageTag.@caseSensitive.toLowerCase() == "true";
			
			input_ti.addEventListener(Event.ADDED_TO_STAGE,testingIt);
		}
		
		public function testingIt(e:Event)
		{
			input_ti.removeEventListener(Event.ADDED_TO_STAGE,testingIt);
			e.target.stage.focus = input_ti;
			input_ti.setSelection(input_ti.text.length,input_ti.text.length);
		}
		
		override public function recordQuestion()
		{
			trace("Question Submitted FB");
			
			_learnerResponse = input_ti.text; 
			
			evalFB();
			
			_learnerResponse = _learnerResponse.substr(0,255);
			_str_correct_entries = _correct_entries.join("|").substr(0,255);
			//Store data in quizObject
			quizObject.addQuestionData(interactionID,questionType + "~" + _learnerResponse + "~" + result + "~" + _str_correct_entries + "~" + questionDescription + "~" + weighting + "~" + latency + "~" + objectiveID);
		}
		
		override public function sendSCORMData()
		{
			trace("sending data from the FILL IN THE BLANK question.");
			trace(questionType  + " - " + questionDescription + " - " + interactionID + " - " +  _str_correct_entries + " - " +  _learnerResponse + " - " +  result  + " - " + latency  + " - " + weighting  + " - " + objectiveID);
			//Send data to SCORM method
			var errmsg:String = lmsLink.apiSendFillInBlankData(interactionID,_learnerResponse,result,_str_correct_entries,questionDescription,weighting,latency,objectiveID);
		}
		
		override public function populateQuizQuestionObject(q:QuestionsAnswered)
		{
			trace("Populating Qustion data from Object in FillInTheBlank");
			var ans:String = q.learnerResp;
			if (ans != null)
			{
				input_ti.text = ans;
				submit_btn.enabled = true;
			}
		}
		
		override public function populateQuizQuestionLMS(learnArray:Array)
		{
			trace("Populating Qustion data from LMS in FillInTheBlank");
			infoPanel.updatePanel("Populating Quiz Question LMS Fill in the Blank - learnArray: " + learnArray[0]);
			if (learnArray != null)
			{
				infoPanel.addToPreviousUpdate("learnArray != null");
				var result:String = learnArray[0];
				//trace("RESULT: " + result);
				if (result != null && result != undefined) 
				{
					input_ti.text = result;
					submit_btn.enabled = true;
				}
					
			}
		}
		
		override public function cleanUpListenersLocal()
		{
			trace("Cleaning up Listeners in FillInTheBlank");
			
			input_ti.removeEventListener(Event.CHANGE,answerQuestion);
		}
		
		public function evalFB():void
		{
			var match:Boolean = false;
			
			if (_exactMatch && _caseSensitive)
			{
				for (var i:uint = 0;i<_correct_entries.length;i++)
				{
					if (_learnerResponse == _correct_entries[i])
					{
						match = true;
						break;
					}
				}
			} else if (_exactMatch) {
				for (var i:uint = 0;i<_correct_entries.length;i++)
				{
					if (_learnerResponse.toLowerCase() == _correct_entries[i].toLowerCase())
					{
						match = true;
						break;
					}
				}
			} else if (_caseSensitive) {
				for (var i:uint = 0;i<_correct_entries.length;i++)
				{
					if (_learnerResponse.indexOf(_correct_entries[i]) > -1)
					{
						match = true;
						break;
					}
				}
			} else {
				for (var i:uint = 0;i<_correct_entries.length;i++)
				{
					if (_learnerResponse.toLowerCase().indexOf(_correct_entries[i].toLowerCase()) > -1)
					{
						match = true;
						break;
					}
				}
			}
			
			result = match;
			
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
		
		private function getCorrectEntries(res:XMLList):void
		{
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
			var cnt:uint = 0;
			for each (var item in res) 
			{
				if (item != "")
				{
					_correct_entries[cnt] = item;
					cnt++
				}
			}
		}
		
		private function disableQuestion():void
		{
			submit_btn.enabled = false;
			input_ti.enabled = false;
		}
		
		private function doSettings():void
		{
			questionType = "fill-in";
			establishSettings();
		}
		
		private function positionInput():void
		{
			input_ti.x = prompt_txt.x = Math.floor((widthSize - input_ti.width)/2);
			 
			prompt_txt.y = Math.floor((heightSize - input_ti.height - prompt_txt.height)/2);
			input_ti.y = prompt_txt.y + prompt_txt.height + 5;
		}
		
		private function setupButtonListener(fld:DisplayObject):void
		{
			fld.addEventListener(Event.CHANGE,answerQuestion);
		}
		
		private function answerQuestion(e:Event):void
		{
			if(e.target.text != "") {
				if (!submit_btn.enabled)
				{
					var feedback:String = getFeedback("eval");
					setTextfieldText(feedback_txt,feedback,scrollbarF,"feedback");
					submit_btn.enabled = true;
					questionSubmitted = false;				//Property in QuizQuestion is true if the question has alredy been checked for correctness.
				}
			} else {
				var feedback:String = getFeedback("init");
				setTextfieldText(feedback_txt,feedback,scrollbarF,"feedback");
				submit_btn.enabled = false;   
			}
			
		}
	}
}
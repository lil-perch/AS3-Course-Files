package src.pages.quiz
{
	import fl.controls.Button;
	import fl.controls.ButtonLabelPlacement;
	import fl.controls.CheckBox;
	import fl.controls.UIScrollBar;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import src.pages.quiz.QuizQuestions;
	
	
	public class MultipleCorrect extends QuizQuestions
	{
		public var choice1_cb:CheckBox;
		public var choice2_cb:CheckBox;
		public var choice3_cb:CheckBox;
		public var choice4_cb:CheckBox;
		public var choice5_cb:CheckBox;
		public var choice6_cb:CheckBox;
		public var choice7_cb:CheckBox;
		public var choice8_cb:CheckBox;
		public var question_txt:TextField;
		public var feedback_txt:TextField;
		public var question_cnt_txt:TextField;				//Question counter text field.
		public var submit_btn:Button;
		public var scrollbarQ:UIScrollBar;
		public var scrollbarF:UIScrollBar;
		
		public var learner_resp:Array;						//Stores the learner response: Letter ~ Long Answer in an array
		public var correct_resp:Array;						//Stores the correct response: Letter ~ Long answer in an array
		
		private var _questionH:int = 100;
		private var _feedbackH:int = 70;
		private var _correct_resp:Boolean;
		private var _xPos:uint = 90;
		private var _correctResp:Array;						//Stores the correct radio button.
		private var _learnerResp:Array;						//Stores the learner responded radio button.
		private var _choiceArray:Array = ["A","B","C","D","E","F","G","H"];	//Array for reporting short answer to  question.
		private var _visibleOptions:uint = 0;					//Number of Checkboxes being used in this question.
		
		public function MultipleCorrect()
		{
			super();
		}
		
		override public function loadPage():void
		{
			_correctResp = new Array();
			correct_resp = new Array();
			learner_resp = new Array();
			_learnerResp = new Array();
			//Establish settings for question
			doSettings();
			//Size and position stage objects
			sizeElements(question_txt,feedback_txt,question_cnt_txt,scrollbarQ,scrollbarF,submit_btn,_questionH,_feedbackH); //Pass in question text field, feedback text field, counter text field, question scroll bar, feedback scroll bar, submit button, height of question text field, height of feedback text field
			//Number quiz questions
			numberQuizQuestions(question_cnt_txt);
			//Position Radio Buttons
			positionRadioButtons();
			//Populate Radio Buttons with distractor text.
			populateRadioButtons();
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
			setupButtonListener();
		}
		
		override public function recordQuestion()
		{
			//trace("Question Submitted MC");
			var cnt:uint = 0;
			for (var d:uint = 1;d<=_visibleOptions;d++)
			{
				if (this["choice" + d + "_cb"].selected == true)
				{
					_learnerResp[_learnerResp.length] = this["choice" + d + "_cb"];
					var shortAns:String = _choiceArray[int(this["choice" + d + "_cb"].name.substr(6,1)) -1];
					var longAns:String = this["choice" + d + "_cb"].label.substr(0,255)
					learner_resp[cnt] = shortAns + "^" + longAns;
					cnt++;
				}
			}
			//trace("Short Answer: " + learner_resp);
			//trace("CORRECT: " + correct_resp);
			evalMC();
			
			//Store data in quizObject
			quizObject.addQuestionData(interactionID,questionType + "~" + learner_resp.join("$") + "~" + result + "~" + correct_resp.join("$") + "~" + questionDescription + "~" + weighting + "~" + latency + "~" + objectiveID);
		}
		
		override public function sendSCORMData()
		{
			trace("sending data from the MULTIPLE CORRECT question.");
			//trace(questionType  + " - " + questionDescription + " - " + interactionID + " - " +  correct_resp + " - " +  learner_resp + " - " +  result  + " - " + latency  + " - " + weighting  + " - " + objectiveID);
			//Send data to SCORM method
			var errmsg:String = lmsLink.apiSendMultipleCorrectData(interactionID,learner_resp,result,correct_resp,questionDescription,weighting,latency,objectiveID);
		}
		
		override public function populateQuizQuestionObject(q:QuestionsAnswered)
		{
			trace("Populating Qustion data from Object in MultipleCorrect");
			var answers:Array = q.learnerResp.split("$");
			for (var c:uint = 0;c<answers.length;c++)
			{
				var ans:String = answers[c];
				var tmp:Array = ans.split("^");

				//find the chosen response
				var responseFound:Boolean = false;
				for (var i:uint = 1;i<9;i++)
				{
					if (this["choice" + i + "_cb"].label.substr(0,255) == tmp[1])
					{
						this["choice" + i + "_cb"].selected = true;
						responseFound = true;
						break;
					}
					
				}
				
				//If the answer wasn't found and it is not randomized, use the short answer
				if (!responseFound)
				{
					if (currentPageTag.distractors.@randomize.length() > 0 && currentPageTag.distractors.@randomize.toLowerCase() == "true")
					{
						return;
					} else {
						//Use short answer to determine selected response
						for (var j:uint = 0;j<8;j++)
						{
							if (tmp[0] == _choiceArray[j])
							{
								this["choice" + (j+1) + "_cb"].selected = true;
								submit_btn.enabled = true;
								break;
							}
						}
					}
				} else {
					submit_btn.enabled = true;
				}
			}
		}
		
		override public function populateQuizQuestionLMS(learnArray:Array)
		{
			trace("Populating Qustion data from LMS in Multiple Correct");
			
			for (var k:uint = 0;k<learnArray.length;k++)
			{
				var ans:String = learnArray[k];
				//trace("ANS: " + ans);
				
				//Check to see if dual answer is returned
				if (ans.indexOf("^") > -1)
				{
					//After retrieving the data
					var tmp:Array = ans.split("^");
					
					//find the chosen response
					var responseFound:Boolean = false;
					for (var i:uint = 1;i<9;i++)
					{
						if (this["choice" + i + "_cb"].label.substr(0,255) == tmp[1])
						{
							this["choice" + i + "_cb"].selected = true;
							responseFound = true;
							break;
						}
						
					}
					//If the answer wasn't found and it is not randomeized, use the short answer
					if (!responseFound)
					{
						if (currentPageTag.distractors.@randomize.length() > 0 && currentPageTag.distractors.@randomize.toLowerCase() == "true")
						{
							return;
						} else {
							//Use short answer to determine selected response
							for (var j:uint = 0;j<8;j++)
							{
								if (tmp[0] == _choiceArray[j])
								{
									this["choice" + (j+1) + "_cb"].selected = true;
									submit_btn.enabled = true;
									break;
								}
							}
						}
						
					} else {
						submit_btn.enabled = true;
					}
				} else { //^ not used to separate answers
					/*if (ans.indexOf(" ") == -1)
					{
						var myPattern:RegExp = /\_/g;
						ans = ans.replace(myPattern," ");
						trace("ANS_CHANGE: " + ans);
					}*/
					for (var i:uint = 1;i<9;i++)
					{
						//trace("Label: " + this["choice" + i + "_cb"].label.substr(0,255));
						var str:String = this["choice" + i + "_cb"].label.substr(0,255).replace(/[^\w\-\(\)\+\.\:\=\@\;\$\_\!\*\'\%]/g, "_");
						//trace("STR: " + str);
						if (str == ans)
						{
							this["choice" + i + "_cb"].selected = true;
							break;
						}
						
					}
				}
			}
		}
		
		override public function cleanUpListenersLocal()
		{
			trace("Cleaning up Listeners in Multiple Correct");
			for (var i:uint = 1;i<9;i++)
			{
				this["choice" + i + "_cb"].removeEventListener(MouseEvent.CLICK,answerQuestion);
			}
		}
		
		public function evalMC():void
		{
			var poss:uint = 0;
			var match:uint = 0;
			//trace("Correct: " + _correctResp.toString());
			//trace("Learner: " + _learnerResp.toString());
			if (_learnerResp.length == _correctResp.length)
			{
				for (var d:uint = 0;d<_correctResp.length;d++)
				{
					poss++;
					for (var e:uint = 0;e<_learnerResp.length;e++)
					{
						//trace(":::::" + _correctResp[d].name + " - " + _learnerResp[e].name);
						if (_correctResp[d] == _learnerResp[e]) 
						{
							match++; 
							//trace("match");
						}
					}
				}
			
				result = (poss == match);
			} else {
				result = false;
			}
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
					_learnerResp = new Array();
					
				} else {
					disableQuestion();	// Disable objects
					var feedback:String = getFeedback("wrong");
				}
			}
			setTextfieldText(feedback_txt,feedback,scrollbarF,"feedback");
		}
		
		private function positionRadioButtons():void
		{
			//Get size of content area
			var totSpace:Number = feedback_txt.y - (question_txt.y + question_txt.height);
			var spacing:Number = Math.floor(totSpace/9);
			choice1_cb.x = choice2_cb.x = choice3_cb.x = choice4_cb.x = choice5_cb.x = choice6_cb.x = choice7_cb.x = choice8_cb.x = _xPos;
			choice1_cb.width = choice2_cb.width = choice3_cb.width = choice4_cb.width = choice5_cb.width = choice6_cb.width = choice7_cb.width = choice8_cb.width = widthSize - _xPos;
			//Size and position all the distractors
			for (var i:uint = 1;i<9;i++)
			{
				this["choice" + i + "_cb"].y = question_txt.y + question_txt.height + (spacing * i)
				this["choice" + i + "_cb"].visible = false;
			}
		}
		
		private function populateRadioButtons():void
		{
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
			var distract:XMLList = new XMLList();
			var radioArray:Array = [choice1_cb,choice2_cb,choice3_cb,choice4_cb,choice5_cb,choice6_cb,choice7_cb,choice8_cb];
			
			if (currentPageTag.distractors != undefined)
			{
				distract = currentPageTag.distractors.*;
				//var temp:XML = distract[2];
				//trace("DISTRACT: " + temp.toXMLString());
				var randomize:Boolean = false;
				if (currentPageTag.distractors.@randomize.length() > 0) randomize = currentPageTag.distractors.@randomize.toLowerCase() == "true";
				
				var tf:TextFormat = new TextFormat(); 
				tf.color = settingsModel.styles.distractorFontColor;
				tf.font = settingsModel.styles.distractorFont;
				tf.size = settingsModel.styles.distractorFontSize;
				
				if (randomize)
				{
					//trace("Number: " + distract.length());
					radioArray.length = distract.length();
					_visibleOptions = distract.length();
					for each (var item in distract) { 
						var new_num:Number = randomNumber(0,radioArray.length - 1)
						var tempArray:Array = radioArray.splice(new_num,1);
						var radioObj:CheckBox = tempArray[0];
						
						radioObj.setStyle("textFormat", tf); 
						
						radioObj.label = item;
						
						//Set the correct item
						if (item.@correct.length() > 0)
						{
							if (item.@correct.toLowerCase() == "true") 
							{
								_correctResp[_correctResp.length] = radioObj;
								
								var shortAns:String = _choiceArray[int(radioObj.name.substr(6,1)) -1];
								var longAns:String = radioObj.label.substr(0,255)
								correct_resp[correct_resp.length] = shortAns + "^" + longAns;
							}
						}
						
						radioObj.visible = true;
						
						//Deal with wrapping of text
						if (item.@wrap.length() > 0)
						{
							if (item.@wrap.toLowerCase() == "true")
							{
								radioObj.textField.width = radioObj.width;
								radioObj.textField.wordWrap = true;
							}
						}
					}
				} else {
					var radioCnt:uint = 1;
					for each (var item in distract) { 
						if (radioCnt < 9)
						{
							this["choice" + radioCnt + "_cb"].setStyle("textFormat", tf);
							this["choice" + radioCnt + "_cb"].label = item;
							this["choice" + radioCnt + "_cb"].visible = true;
							
							//Set the correct item
							if (item.@correct.length() > 0)
							{	
								if (item.@correct.toLowerCase() == "true") 
								{
									_correctResp[_correctResp.length] = this["choice" + radioCnt + "_cb"];
									
									var shortAns:String = _choiceArray[radioCnt-1];
									var longAns:String = this["choice" + radioCnt + "_cb"].label.substr(0,255)
									correct_resp[correct_resp.length] = shortAns + "^" + longAns;
								}
							}
							
							//Deal with wrapping of text in radio button
							if (item.@wrap.length() > 0)
							{
								if (item.@wrap.toLowerCase() == "true")
								{
									this["choice" + radioCnt + "_cb"].textField.width = this["choice" + radioCnt + "_cb"].width;
									this["choice" + radioCnt + "_cb"].textField.wordWrap = true;
								}
							}
							radioCnt++;
						}
					}
					_visibleOptions = radioCnt-1;
				}
			}
		}
		
		private function disableQuestion():void
		{
			for (var i:uint = 1;i<9;i++)
			{
				this["choice" + i + "_cb"].enabled = false;
			}
			submit_btn.enabled = false;
		}
		
		private function doSettings():void
		{
			questionType = "choiceM";
			establishSettings();
		}
		
		private function setupButtonListener():void
		{
			for (var i:uint = 1;i<9;i++)
			{
				this["choice" + i + "_cb"].addEventListener(MouseEvent.CLICK,answerQuestion);
			}
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
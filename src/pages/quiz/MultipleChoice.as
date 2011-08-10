package src.pages.quiz
{
	import fl.controls.Button;
	import fl.controls.ButtonLabelPlacement;
	import fl.controls.RadioButton;
	import fl.controls.RadioButtonGroup;
	import fl.controls.UIScrollBar;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import src.pages.quiz.QuizQuestions;
	
	
	public class MultipleChoice extends QuizQuestions
	{
		public var choice1_rb:RadioButton;
		public var choice2_rb:RadioButton;
		public var choice3_rb:RadioButton;
		public var choice4_rb:RadioButton;
		public var choice5_rb:RadioButton;
		public var choice6_rb:RadioButton;
		public var choice7_rb:RadioButton;
		public var choice8_rb:RadioButton;
		public var question_txt:TextField;
		public var feedback_txt:TextField;
		public var question_cnt_txt:TextField;				//Question counter text field.
		public var submit_btn:Button;
		public var scrollbarQ:UIScrollBar;
		public var scrollbarF:UIScrollBar;
		
		public var learner_resp:String;						//Stores the learner response: Letter ~ Long Answer
		public var correct_resp:String;						//Stores the correct response: Letter ~ Long answer
		
		private var _questionH:int = 100;
		private var _feedbackH:int = 70;
		private var _correct_resp:Boolean;
		private var _xPos:uint = 90;
		private var _specificFeedback:Object;				//Stores the item specific feedback
		private var _mchgroup:RadioButtonGroup;				//Contains the name for the group the radio buttons belong to.
		private var _correctResp:RadioButton;				//Stores the correct radio button.
		private var _learnerResp:RadioButton;				//Stores the learner responded radio button.
		private var _choiceArray:Array = ["A","B","C","D","E","F","G","H"];	//Array for reporting short answer to  question.
		
		public function MultipleChoice()
		{
			super();
		}
		
		override public function loadPage():void
		{
			_specificFeedback = new Object();
			_mchgroup = new RadioButtonGroup("Multiple Choice Group");
			//Establish settings for question
			doSettings();
			//Size and position stage objects
			sizeElements(question_txt,feedback_txt,question_cnt_txt,scrollbarQ,scrollbarF,submit_btn,_questionH,_feedbackH); //Pass in question text field, feedback text field, counter textfield, question scroll bar, feedback scroll bar, submit button, height of question text field, height of feedback text field
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
			//trace(_mchgroup.selection.name);
			_learnerResp = _mchgroup.selection;
			
			if (_learnerResp != null) 
			{
				var shortAns:String = _choiceArray[int(_learnerResp.name.substr(6,1)) -1];
				var longAns:String = _learnerResp.label.substr(0,255)
				learner_resp = shortAns + "^" + longAns;
				//trace("Short Answer: " + learner_resp);
				//trace("CORRECT: " + correct_resp);
				
			}
			evalMCH();
			//Store data in quizObject
			quizObject.addQuestionData(interactionID,questionType + "~" + learner_resp + "~" + result + "~" + correct_resp + "~" + questionDescription + "~" + weighting + "~" + latency + "~" + objectiveID);
		}
		
		override public function sendSCORMData()
		{
			trace("sending data from the MULTIPLE CHOICE question.");
			//trace(questionType  + " - " + questionDescription + " - " + interactionID + " - " +  correct_resp + " - " +  learner_resp + " - " +  result  + " - " + latency  + " - " + weighting  + " - " + objectiveID);
			//Send data to SCORM method
			var errmsg:String = lmsLink.apiSendMultipleChoiceData(interactionID,learner_resp,result,correct_resp,questionDescription,weighting,latency,objectiveID);
		}
		
		override public function populateQuizQuestionObject(q:QuestionsAnswered)
		{
			trace("Populating Qustion data from Object in MultipleChoice");
			var ans:String = q.learnerResp;
			var tmp:Array = ans.split("^");
			
			//find the chosen response
			var responseFound:Boolean = false;
			for (var i:uint = 1;i<9;i++)
			{
				if (this["choice" + i + "_rb"].label.substr(0,255) == tmp[1])
				{
					this["choice" + i + "_rb"].selected = true;
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
							this["choice" + (j+1) + "_rb"].selected = true;
							break;
						}
					}
				}
			} else {
				submit_btn.enabled = true;
			}
		}
		
		override public function populateQuizQuestionLMS(learnArray:Array)
		{
			trace("Populating Qustion data from LMS in Multiple Choice");
			infoPanel.updatePanel("Populating question from LMS - learnArray: " + learnArray);
			//trace("Learn Array: " + learnArray[0]);
			for (var k:uint = 0;k<learnArray.length;k++)
			{
				var ans:String = learnArray[k];
				infoPanel.addToPreviousUpdate("ans: " + ans);
				//trace("ans: " + ans);
				//After retrieving the data
				/*var tmp:Array = ans.split("^");*/
				
				//find the chosen response
				var responseFound:Boolean = false;
				//infoPanel.addToPreviousUpdate("tmp[1]: " + tmp[1]);
				for (var i:uint = 1;i<9;i++)
				{
					var str:String = this["choice" + i + "_rb"].label.substr(0,255).replace(/[^\w\-\(\)\+\.\:\=\@\;\$\_\!\*\'\%]/g, "_");
					if (str == ans)
					{
						infoPanel.addToPreviousUpdate("Selected: " + "choice" + i + "_rb");
						this["choice" + i + "_rb"].selected = true;
						responseFound = true;
						break;
					}
					
				}
				
				if (responseFound) 
				{
					submit_btn.enabled = true;
					break;
				}
				
				//If the answer wasn't found and it is not randomeized, use the short answer
				/*if (!responseFound)
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
								this["choice" + (j+1) + "_rb"].selected = true;
								submit_btn.enabled = true;
								break;
							}
						}
					}
					
				} else {
					submit_btn.enabled = true;
				}*/
			}
		}
		
		override public function cleanUpListenersLocal()
		{
			trace("Cleaning up Listeners in Multiple Choice");
			for (var i:uint = 1;i<9;i++)
			{
				this["choice" + i + "_rb"].removeEventListener(MouseEvent.CLICK,answerQuestion);
			}
		}
		
		override public function checkPreviousAnswer():void
		{
			infoPanel.updatePanel("in checkPreviousAnswer for Multiple Choice...");
			var feedback:String = "hasQuizObject= " + hasQuizObject;
			//infoPanel.addToPreviousUpdate(feedback);
			if (hasQuizObject)
			{
				//Find out if question has been answered before and is recorded in the quizObject.
				if (currentPageTag.@id.length() > 0)
				{
					if (quizObject.isQuestionAnswered(interactionID))	//See if the data is in the quiz object
					{
						populateQuizQuestionObject(quizObject.getQuestionObject(interactionID));
						feedback += " -populating MC Quiz Question from Object "
					} else if (courseModel.courseAttributes.tracking.toLowerCase() != "none") {	//See if the data is in the LMS.
						feedback += " -question is being tracked= " + courseModel.courseAttributes.tracking.toLowerCase();
						//infoPanel.addToPreviousUpdate(feedback);
						var learnResp:Array = lmsLink.apiGetLearnerResponseChoice(interactionID);
						feedback += " -learnResp= " + learnResp;
						//infoPanel.addToPreviousUpdate(feedback);
						if (learnResp != null)
						{
							populateQuizQuestionLMS(learnResp);
						}
					}
				}
			}
			infoPanel.updatePanel("checkPreviousAnswer in MultipleChoice.as - " + feedback);
		}
		
		public function evalMCH():void
		{
			result = (_correctResp == _learnerResp);
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
		
		private function positionRadioButtons():void
		{
			//Get size of content area
			var totSpace:Number = feedback_txt.y - (question_txt.y + question_txt.height);
			var spacing:Number = Math.floor(totSpace/9);
			choice1_rb.x = choice2_rb.x = choice3_rb.x = choice4_rb.x = choice5_rb.x = choice6_rb.x = choice7_rb.x = choice8_rb.x = _xPos;
			choice1_rb.width = choice2_rb.width = choice3_rb.width = choice4_rb.width = choice5_rb.width = choice6_rb.width = choice7_rb.width = choice8_rb.width = widthSize - _xPos;
			//Size and position all the distractors
			for (var i:uint = 1;i<9;i++)
			{
				this["choice" + i + "_rb"].y = question_txt.y + question_txt.height + (spacing * i)
				this["choice" + i + "_rb"].visible = false;
				this["choice" + i + "_rb"].group = _mchgroup;
			}
		}
		
		private function populateRadioButtons():void
		{
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
			var distract:XMLList = new XMLList();
			var radioArray:Array = [choice1_rb,choice2_rb,choice3_rb,choice4_rb,choice5_rb,choice6_rb,choice7_rb,choice8_rb];
			
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
					for each (var item in distract) { 
						var new_num:Number = randomNumber(0,radioArray.length - 1)
						var tempArray:Array = radioArray.splice(new_num,1);
						var radioObj:RadioButton = tempArray[0];
						
						radioObj.setStyle("textFormat", tf); 
						
						radioObj.label = item;
						//Store item specific feedback
						if (item.@iFeedback.length() > 0) 
							_specificFeedback[radioObj.name] = item.@iFeedback;
						else
							_specificFeedback[radioObj.name] = null;
						
						//Set the correct item
						if (item.@correct.length() > 0)
						{
							if (item.@correct.toLowerCase() == "true") 
							{
								_correctResp = radioObj;
								
								var shortAns:String = _choiceArray[int(radioObj.name.substr(6,1)) -1];
								var longAns:String = radioObj.label.substr(0,255)
								correct_resp = shortAns + "^" + longAns;
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
							this["choice" + radioCnt + "_rb"].setStyle("textFormat", tf);
							this["choice" + radioCnt + "_rb"].label = item;
							this["choice" + radioCnt + "_rb"].visible = true;
							
							//Store item specific feedback
							if (item.@iFeedback.length() > 0) 
								_specificFeedback["choice" + radioCnt + "_rb"] = item.@iFeedback;
							else
								_specificFeedback["choice" + radioCnt + "_rb"] = null;
							
							//Set the correct item
							if (item.@correct.length() > 0)
							{	
								if (item.@correct.toLowerCase() == "true") 
								{
									_correctResp = this["choice" + radioCnt + "_rb"];
									
									var shortAns:String = _choiceArray[radioCnt-1];
									var longAns:String = this["choice" + radioCnt + "_rb"].label.substr(0,255)
									correct_resp = shortAns + "^" + longAns;
								}
							}
							
							//Deal with wrapping of text in radio button
							if (item.@wrap.length() > 0)
							{
								if (item.@wrap.toLowerCase() == "true")
								{
									this["choice" + radioCnt + "_rb"].textField.width = this["choice" + radioCnt + "_rb"].width;
									this["choice" + radioCnt + "_rb"].textField.wordWrap = true;
								}
							}
							radioCnt++;
						}
					}
				}
			}
		}
		
		private function disableQuestion():void
		{
			for (var i:uint = 1;i<9;i++)
			{
				this["choice" + i + "_rb"].enabled = false;
			}
			submit_btn.enabled = false;
		}
		
		private function doSettings():void
		{
			questionType = "choice";
			establishSettings();
		}
		
		private function setupButtonListener():void
		{
			for (var i:uint = 1;i<9;i++)
			{
				this["choice" + i + "_rb"].addEventListener(MouseEvent.CLICK,answerQuestion);
			}
		}
		
		private function answerQuestion(e:MouseEvent):void
		{
			//trace(_specificFeedback[e.target.name]);
			if (_specificFeedback[e.target.name] != null) wrongFeedback = _specificFeedback[e.target.name];
				
			var feedback:String = getFeedback("eval");
			setTextfieldText(feedback_txt,feedback,scrollbarF,"feedback");
			submit_btn.enabled = true;
			questionSubmitted = false;				//Property in QuizQuestion is true if the question has alredy been checked for correctness.
		}
	}
}
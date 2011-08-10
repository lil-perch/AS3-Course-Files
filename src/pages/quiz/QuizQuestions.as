
package src.pages.quiz
{
	import fl.controls.Button;
	import fl.controls.UIScrollBar;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import src.Model;
	import src.classes.Settings;
	import src.pages.DynamicPageAPI;
	import src.pages.quiz.QuizObjects;

	public class QuizQuestions extends DynamicPageAPI
	{
		
		//Question Settings
		public var provideFeedback:Boolean = true;
		public var overrideFeedback:Boolean;
		public var numberTries:int = 1;
		public var initPrompt:String = "";
		public var evalPrompt:String = "";
		public var correctFeedback:String = "";
		public var wrongFeedback:String = "";
		public var triesFeedback:String = "";
		public var numberOfAttempts:int;				//Attempts at the question
		
		public var result:Boolean;						//Result is question right or wrong
		public var questionType:String;					//Type of question
		public var interactionID:String;				//Unique ID for question
		public var latency:uint;						//Time spent on question
		public var questionDescription:String;			//The question text
		public var weighting:int;						//weight of question
		public var objectiveID:String;					//objective ID this question is associated with.
		public var hasQuizObject:Boolean	=	false;	//True if this question is associated with a quiz object.
		public var quizObject:QuizObjects;				//Reference to quiz object this question belongs to. 
		public var questionSubmitted:Boolean=	false;	//True if the question answer has been submitted. Must be set to false by question type every time learner chooses and answer. Default is false because we want to count the question even if they skip it.
		
		private var submit_btn:DisplayObject;
		private var _startTimer:uint;
		private var _sizeH:Number;						//Height of content area
		private var _sizeW:Number;						//Width of content area
		
		private var _leftMargin:int 		=	10;		//Margins for quiz pages
		private var _rightMargin:int		=	20;
		private var _topMargin:int			=	10;
		private var _bottomMargin:int		=	10;
		private var _spaceBetweenElms:int	=	30;
		
		public function QuizQuestions()
		{
			super();
		}
		
		//loadPage from the Question page should call this to set up all the quiz settings
		public function establishSettings()
		{
			_sizeH = settingsModel.settings.presentSizeH;
			_sizeW = settingsModel.settings.presentSizeW;
			
			establishQuizSettings();
			
			//Set Attempts
			numberOfAttempts = 1;
			
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
			if (currentPageTag.@overrideFeedback.length() > 0)
			{
				overrideFeedback = currentPageTag.@overrideFeedback.toLowerCase() == "true";
			} else {
				overrideFeedback = false;
			}
			
			//trace("OV: " + overrideFeedback);
			if (overrideFeedback) //Do local feedback
			{
				if (currentPageTag.feedback != undefined)
				{
					provideFeedback = currentPageTag.feedback.@provide.toLowerCase() == "true";
					if (provideFeedback)
					{
						//trace("PROVIDE: " + provideFeedback);
						numberTries = Number(currentPageTag.feedback.@tries);
						//trace("TRIES: " + numberTries);
						if (currentPageTag.feedback.initPrompt != undefined) initPrompt = currentPageTag.feedback.initPrompt;
						//trace("PROMPT: " + initPrompt);
						if (currentPageTag.feedback.evalPrompt != undefined) evalPrompt = currentPageTag.feedback.evalPrompt;
						if (currentPageTag.feedback.correctFeedback != undefined) correctFeedback = currentPageTag.feedback.correctFeedback;
						if (currentPageTag.feedback.incorrectFeedback != undefined) wrongFeedback = currentPageTag.feedback.incorrectFeedback;
						if (currentPageTag.feedback.triesFeedback != undefined) triesFeedback = currentPageTag.feedback.triesFeedback;
					}
				}
				
			} else { //Do global feedback
				if (hasQuizObject) //Global feedback would only be available is this is part of a quiz object
				{
					provideFeedback  = quizObject.provideFeedback;
					if (provideFeedback)
					{
						numberTries = quizObject.numberTries;
						initPrompt = quizObject.initPrompt;
						evalPrompt = quizObject.evalPrompt;
						correctFeedback = quizObject.correctFeedback;
						wrongFeedback = quizObject.wrongFeedback;
						triesFeedback = quizObject.triesFeedback;
					}
				}
			}
			
			//Start timing session
			sessionStart();
			//Weight of question
			if (currentPageTag.@weight.length() > 0)
			{
				weighting = int(currentPageTag.@weight);
			} else {
				weighting = 1;
			}
			//Objective ID assigned to question
			if (currentPageTag.@objectiveID.length() > 0)
			{
				objectiveID = currentPageTag.@objectiveID;
			}
				
		} //End establishSettings
		
		public function establishQuizSettings():void //Establishes settings that has to do with all quiz pages.
		{
			//Interaction ID
			interactionID = escape(currentPageTag.@id);
			
			if (currentPageTag.@quizid.length() > 0)
			{
				var id:String = currentPageTag.@quizid;
				if (courseModel.quizObjs.isQuizCreated(id))
				{
					hasQuizObject = true;
					quizObject = courseModel.quizObjs.getQuizObject(id);
				}
			}
		}
		
		public function numberQuizQuestions(ctxt:TextField):void
		{
			//Update and display question counter
			if (quizObject.number_questions)
			{
				ctxt.visible = true;
				ctxt.text = quizObject.numberQuestions();
			} else {
				ctxt.visible = false;
			}
		}
		
		//Some question types may need to override this so they retrieve the correct data from the LMS.
		public function checkPreviousAnswer():void
		{
			//infoPanel.updatePanel("in checkPreviousAnswer...");
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
						feedback += " -populating Quiz Question from Object "
					} else if (courseModel.courseAttributes.tracking.toLowerCase() != "none") {	//See if the data is in the LMS.
						feedback += " -question is being tracked= " + courseModel.courseAttributes.tracking.toLowerCase();
						//infoPanel.addToPreviousUpdate(feedback);
						var learnResp:Array = lmsLink.apiGetLearnerResponse(interactionID);
						feedback += " -learnResp= " + learnResp;
						//infoPanel.addToPreviousUpdate(feedback);
						if (learnResp != null)
						{
							populateQuizQuestionLMS(learnResp);
						}
					}
				}
			}
			infoPanel.updatePanel("checkPreviousAnswer in QuizQuestions - " + feedback);
		}
		
		public function sizeElements(qtxt:TextField,ftxt:TextField,ctxt:TextField,qScroll:UIScrollBar,fScroll:UIScrollBar,sbtn:Button,qh:int,fh:int):void
		{
			//_sizeH = settingsModel.settings.presentSizeH;
			//_sizeW = settingsModel.settings.presentSizeW;
			qtxt.height = qh;
			qtxt.width = _sizeW - leftMargin - rightMargin;
			ftxt.height = fh;
			ftxt.width = _sizeW - leftMargin - rightMargin - spaceBetween - sbtn.width;
			qScroll.height = qh;
			fScroll.height = fh;
			qtxt.x = leftMargin;
			qtxt.y = topMargin;
			ftxt.x = leftMargin;
			ftxt.y = _sizeH - topMargin - fh;
			sbtn.x = _sizeW - rightMargin - sbtn.width;
			sbtn.y = _sizeH - bottomMargin - sbtn.height;
			ctxt.width = sbtn.width + 20;
			ctxt.x = sbtn.x - 10;
			ctxt.y = sbtn.y - ctxt.height - _topMargin;
			qScroll.y = topMargin;
			qScroll.x = leftMargin + qtxt.width;
			fScroll.y = ftxt.y;
			fScroll.x = leftMargin + ftxt.width;
		}
		
		public function getQuestionText():String
		{
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
			return currentPageTag.questionText;
		}
		
		public function getFeedback(type:String):String
		{
			switch (type)
			{
				case "init":
					return initPrompt;
					break;
				case "eval":
					return evalPrompt;
					break;
				case "correct":
					return correctFeedback;
					break;
				case "wrong":
					return wrongFeedback;
					break;
				case "tries":
					return triesFeedback;
					break;
				default:
					return "";
					break;
			}
		}
		
		public function setTextfieldText(txt:TextField,htmlText:String,sb:UIScrollBar,type:String)
		{
			txt.styleSheet = textCss;
			if (type == "question")
				txt.htmlText = "<span class='question'>" + htmlText + "</span>";
			else if (type == "feedback")
				txt.htmlText = "<span class='feedback'>" + htmlText + "</span>";
			
			if (txt.maxScrollV > 1)
			{
				sb.visible = true;
			} else {
				sb.visible = false;
			}
		}
		
		public function addControlButton(btn:DisplayObject):void
		{
			btn.addEventListener(MouseEvent.CLICK,submitQuestion);
			submit_btn = btn;
		}
		
		public function submitQuestion(e:MouseEvent = null)
		{
			//trace("Question Submitted");
			//Stop the session time
			sessionStop();
			
			recordQuestion()
			
			if (courseModel.courseAttributes.tracking.toLowerCase() != "none")
			{
				var tracking:Boolean = false;
				if (currentPageTag.@tracking.length() > 0)
				{
					tracking = currentPageTag.@tracking.toLowerCase() == "true";
				}
			
				if (tracking)
					sendSCORMData();
				else
					trace("tracking not set to true for this question");
			} else {
				trace("Tracking not set to SCORM");
				infoPanel.updatePanel("Tracking attribute not set to record SCORM data.");
			}
			questionSubmitted = true;				//Property in QuizQuestion is true if the question has alredy been checked for correctness.
		}
		
		override public function changingPage(e:Event):void
		{
			//trace("Changing page fired from QuizQuestion");
			courseModel.removeEventListener(Model.MODEL_CHANGE, changingPage);
			//Has question correctness already been determined?
			if (!questionSubmitted) submitQuestion();
			if (quizObject)
			{
				//trace("in quizObject: " + quizObject.quizIsComplete);
				if (quizObject.quizIsComplete)
				{
					if (!quizObject.scoreRecorded) quizObject.recordTheScore();
					if (!quizObject.statusRecorded) quizObject.recordLessonStatus();
				}
			}
			cleanUpListeners();
		}
		
		public function randomNumber(low:Number=0, high:Number=1):Number	//Generates random number for those questions that must radomize responses.
		{
			return Math.floor(Math.random() * (1+high-low)) + low;
		}
		
		//THIS SHOULD BE OVERRIDDEN AT THE QUESTION LEVEL
		public function recordQuestion()
		{
			trace("recording question in QuizQuestion.as");
		}
		
		//THIS SHOULD BE OVERRIDDEN AT THE QUESTION LEVEL
		public function sendSCORMData()
		{
			trace("sending SCORM data in QuizQuestion.as");
		}
		
		//THIS SHOULD BE OVERRIDDEN AT THE QUESTION LEVEL
		public function populateQuizQuestionObject(qobj:QuestionsAnswered)
		{
			trace("Populating Qustion data from Object in QuizQuestion.as");
		}
		
		//THIS SHOULD BE OVERRIDDEN AT THE QUESTION LEVEL
		public function populateQuizQuestionLMS(learnArray:Array)
		{
			trace("Populating Qustion data from LMS in QuizQuestion.as");
		}
		
		//THIS SHOULD BE OVERRIDDEN AT THE QUESTION LEVEL
		public function cleanUpListenersLocal()
		{
			trace("Cleaning up Listeners in QuizQuestion.as");
		}
		
		public function cleanUpListeners():void
		{
			trace("Cleaning up Listeners in QuizQuestion.as");
			if (submit_btn != null)
			{
				if(submit_btn.hasEventListener(MouseEvent.CLICK)) submit_btn.removeEventListener(MouseEvent.CLICK,submitQuestion);
			}
			cleanUpListenersLocal();
		}
		
		public function sessionStart():void
		{
			_startTimer = getTimer();
		}
		
		public function sessionStop():void
		{
			latency = getTimer() - _startTimer;
		}
		
		public function submitScore():void
		{
			
		}
		
		
		//Getter and Setters
		public function get leftMargin():int
		{
			return _leftMargin;
		}
		
		public function get rightMargin():int
		{
			return _rightMargin;
		}
		
		public function get topMargin():int
		{
			return _topMargin;
		}
		
		public function get bottomMargin():int
		{
			return _bottomMargin;
		}
		
		public function get spaceBetween():int
		{
			return _spaceBetweenElms;
		}
		
		public function get widthSize():Number		//Size (width) available in content area. 
		{
			return _sizeW;
		}
		
		public function get heightSize():Number		//Size (height) available in content area.
		{
			return _sizeH
		}
	}
}
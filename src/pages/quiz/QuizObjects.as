package src.pages.quiz
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import src.CourseModel;
	import src.classes.InfoPanel;
	import src.pages.quiz.QuestionsAnswered;
	
	public class QuizObjects extends EventDispatcher
	{
		//Feedback Settings
		public var provideFeedback:Boolean = true;
		public var numberTries:int = 1;
		public var initPrompt:String = "";
		public var evalPrompt:String = "";
		public var correctFeedback:String = "";
		public var wrongFeedback:String = "";
		public var triesFeedback:String = "";
		//Other Settings
		public var quizmode:String = "review";		//Whether the quiz is a test or a quiz 
		public var randomize:Boolean = false;		//Are the questions in a test to be randomized 
		public var reportScore:Boolean = true;		//Should the score be reported 
		public var number_questions:Boolean = false;//Should the questions be numbered 
		public var numquestions:uint = 1;			//Number of questions to display in the quiz 
		public var recordStatus:String = "none";	//How status should be recorded with this quiz. 
		public var minscore:Number = 0;				//Minimum score possible on the quiz  
		public var maxscore:Number = 100;			//Maximum score possible on the quiz 
		public var passComplete:Boolean = false;	//In SCORM 2004 whether to mark course complete for a passing status 
		public var failIncomplete:Boolean = false;	//In SCORM 2004 whether to mark course incomplete for a failing status
		public var quizIsComplete:Boolean			//Set to true after the learner has gone through the entire quiz. Set to false when the quiz is first accessed.
		public var passingScore:Number;				//Score to achieve in order to pass the quiz
		public var showresults:Boolean = true;		//Will the quiz display results.
		public var incRetakeButton:Boolean = false;	//Will the learner be able to retake the quiz
		public var includeIntro:Boolean = false;	//Will an intro page be include for the quiz.
		public var scoreRecorded:Boolean = false;	//False if the score has not been computed and recorded for this quiz
		public var statusRecorded:Boolean = false;	//False if the lesson status has not been recorded for the quiz.
		public var restrictBackwardNav:Boolean = false; //If set to true the learner will not be able to navigate backwards.
		
		public static const SCORE_COMPUTED:String = "scoreComputed";
		
		private var _questions:XMLList;				//Questions assigned to this quiz.
		private var _numPages:int;					//Number of pages in this quiz.
		private var _questionData:Object;			//Contains question data after question has been answered. There may be more than one entry per question.
		private var _numQuestions:uint;				//Total number of actual questions in the quiz -- excluding intro page, review and results and any other pages that may be inserted.
		private var _courseModel:CourseModel;		//Reference to courseModel.
		private var _percent:Number;				//The narmalized score received on the quiz.
		private var _totalCorrect:Number;			//Total questions correct.
		private var _totalIncorrect:Number;			//Total questions incorrect.
		private var _rawScore:Number;				//Raw score achieved.
		private var _rawScorePoss:Number;			//Raw score possible.
		private var _totalQuestionAnswered:uint = 0;//Total number of Questions answered
		private var _passedQuiz:Boolean = false; 	//Whether or not they passed.
		private var _currentQuestion:uint = 0;		//Number of current question.
		
		public function QuizObjects(cm:CourseModel)
		{
			_questionData = new Object();
			_courseModel = cm;
		}
		
		public function addQuestionData(id:String,data:String):void	//data contains all interaction data concatenated with a ~ in this order learner_resp~result~correct_resp~questionDescription~weighting~latency~objectiveID
		{
//trace("Quiz Object Add: " + data);
			if (isQuestionAnswered(id))
			{
				var questObj:QuestionsAnswered = _questionData[id];
				questObj.addQuestion(id,data);
			} else {
				var questObj1:QuestionsAnswered = new QuestionsAnswered();
				questObj1.addQuestion(id,data);
				_questionData[id] = questObj1;
				_totalQuestionAnswered++;
			}
			scoreRecorded = false;
			//trace("number of questions: " + questObj.numAnswers);
		}
		
		public function isQuestionAnswered(id:String):Boolean	//Returns whether or not question has been answered.
		{
			var exists:Boolean = false;
			for (var item in _questionData)
			{
				//trace("ITEM: " + item + " - " + n);
				if (item == id)
				{
					exists = true;
					break;
				}
			}
			return exists;
		}
		
		public function getQuestionObject(id:String):QuestionsAnswered
		{
			return _questionData[id];
		}
		
		public function getQuestionCollection():Object
		{
			return _questionData;
		}
		
		public function getGlobalFeedback(curPage:XML):void
		{
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
			
			if (curPage.feedback != undefined)
			{
				provideFeedback = curPage.feedback.@provide.toLowerCase() == "true";
				if (provideFeedback)
				{
					//trace("PROVIDE: " + provideFeedback);
					numberTries = Number(curPage.feedback.@tries);
					//trace("TRIES: " + numberTries);
					if (curPage.feedback.initPrompt != undefined) initPrompt = curPage.feedback.initPrompt;
					//trace("PROMPT: " + initPrompt);
					if (curPage.feedback.evalPrompt != undefined) evalPrompt = curPage.feedback.evalPrompt;
					if (curPage.feedback.correctFeedback != undefined) correctFeedback = curPage.feedback.correctFeedback;
					if (curPage.feedback.incorrectFeedback != undefined) wrongFeedback = curPage.feedback.incorrectFeedback;
					if (curPage.feedback.triesFeedback != undefined) triesFeedback = curPage.feedback.triesFeedback;
				}
			}
		}
		
		public function getQuizSettings(curPage:XML):void
		{
			if (curPage.@quizmode.length() > 0)	quizmode = curPage.@quizmode.toLowerCase();
			if (curPage.@randomize.length() > 0)	randomize = (curPage.@randomize.toLowerCase() == "true"); 
			if (curPage.@reportScore.length() > 0)	reportScore = (curPage.@reportScore.toLowerCase() == "true"); 
			if (curPage.@number_questions.length() > 0)	number_questions = (curPage.@number_questions.toLowerCase() == "true"); 
			if (curPage.@numquestions.length() > 0)	numquestions = Number(curPage.@numquestions); 
			if (curPage.@recordStatus.length() > 0)	recordStatus = curPage.@recordStatus.toLowerCase(); 
			if (curPage.@minscore.length() > 0)	minscore = Number(curPage.@minscore); 
			if (curPage.@maxscore.length() > 0)	maxscore = Number(curPage.@maxscore); 
			if (curPage.@passComplete.length() > 0)	passComplete = (curPage.@passComplete.toLowerCase() == "true"); 
			if (curPage.@failIncomplete.length() > 0)	failIncomplete = (curPage.@failIncomplete.toLowerCase() == "true");
			
			if (curPage.@passingScore.length() > 0)	passingScore = Number(curPage.@passingScore);
			if (curPage.@showresults.length() > 0)	showresults = (curPage.@showresults.toLowerCase() == "true");
			if (curPage.@restrictBack.length() > 0) restrictBackwardNav = (curPage.@restrictBack.toLowerCase() == "true");
			
			//The following may be included on the results page now.
			
			if (curPage.@includeIntro.length() > 0)	includeIntro = (curPage.@includeIntro.toLowerCase() == "true");
			
			
			quizIsComplete = false;
		}
		
		public function recordTheScore():void
		{
//trace("Recording SCORM for the QUIZ");
			var correct:uint = 0;
			var incorrect:uint = 0;
			var score:uint = 0;
			var possible:uint = 0;
			var possScore:uint = 0;
			
			scoreRecorded = true;
			//Cycle through each QuestionsAnswered object and add up the score. 
			for (var item in _questionData)
			{
				var question:QuestionsAnswered = _questionData[item];
				//trace(question.result + " - " + question.weight);
				
				if (question.result)
				{
					correct++;
					possible++;
					score = score + question.weight;
					possScore = possScore + question.weight;
				} else {
					incorrect++;
					possible++;
					possScore = possScore + question.weight;
				}
			}
	
			if (score > 0)
				_percent = 100*(score/possScore);
			else
				_percent = 0;
			_totalCorrect = correct;
			_totalIncorrect = incorrect;
			_rawScore = score;
			_rawScorePoss = possScore;

			//Record Data
			if (_courseModel.courseAttributes.tracking.toLowerCase() != "none")
			{
				if (reportScore) var errmsg:String = _courseModel.lmsLink.apiSendScoreData(_percent,maxscore,minscore);
			} else {
				trace("Unable to Track SCORE for Quiz. Tracking not set.");
				_courseModel.feedbackPanel.updatePanel("Unable to Track SCORE for Quiz. Tracking not set.");
			}
			dispatchEvent(new Event(QuizObjects.SCORE_COMPUTED));
		}
		
		public function recordLessonStatus()
		{
			trace("In record lesson status: " + recordStatus);
			statusRecorded = true;
			var errmsg:Boolean;
			if (recordStatus == "passfail" || recordStatus == "apipassfail"  || recordStatus == "passincomplete") {//Yes record pass/fail
				
				if (_percent >= passingScore){//did they pass?
					if (recordStatus == "apipassfail") {
						//Take care of page complete
						_courseModel.markPageComplete();
					} else {
						errmsg = _courseModel.lmsLink.apiSetCompletion(true,"passed");
					}
					_passedQuiz = true; //Used so Results page can find out if the quiz was passed.
					
				}else{
					_passedQuiz = false; //Used so Results page can find out if the quiz was passed.
					if (recordStatus == "passfail"){
						errmsg = _courseModel.lmsLink.apiSetCompletion(true,"failed");
					}
					
					
					if (recordStatus == "passincomplete" && _courseModel.lmsLink.tracking == "SCORM1.2"){
						errmsg = _courseModel.lmsLink.apiSetCompletion(true,"incomplete");
					}
				}
			} else if (recordStatus == "completed") {//Yes, record completed recordStatus
				//trace("sent completion");
				errmsg = _courseModel.lmsLink.apiSetCompletion(true,"completed");
			} else if (recordStatus == "apicompleted") {
				_courseModel.markPageComplete();
			}
		}
		
		public function numberQuestions():String
		{
			return "Question " + this.currentQuestionNum + " of " + _numQuestions;
		}
		
		//Getter and Setters
		public function set questions(s:XMLList):void	//Original XMLList of questions for this quiz.
		{
			_questions = s;
			_numPages = s.length();
			//trace("NUMBER OF PAGES in QUIZ: " + _numPages);
		}
		
		public function get questions():XMLList
		{
			return _questions;
		}
		
		public function get numPages():int
		{
			return _numPages;
		}
		
		public function set numOfQuestions(n:uint):void
		{
			_numQuestions = n;
		}
		
		public function get numOfQuestions():uint
		{
			return _numQuestions;
		}
		
		public function get percent():Number
		{
			return _percent;
		}
		
		public function get totalCorrect():Number
		{
			return _totalCorrect;
		}
		
		public function get totalIncorrect():Number
		{
			return _totalIncorrect;
		}
		
		public function get rawScore():Number
		{
			return _rawScore;
		}
		
		public function get possibleRawScore():Number
		{
			return _rawScorePoss;
		}
		
		public function get questionsAnswered():uint
		{
			return _totalQuestionAnswered;
		}
		
		public function get passedQuiz():Boolean
		{
			return _passedQuiz;
		}
		
		public function set currentQuestionNum(n:uint):void
		{
			_currentQuestion = n;
		}
		
		public function get currentQuestionNum():uint
		{
			return _currentQuestion;
		}
	}
}
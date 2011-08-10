package src.pages.quiz
{
	
	public class QuestionsAnswered
	{
		private var _qID:String;							//Id for question.
		private var _data:String							// Data for answered question
		private var _answerCnt:uint							// Number of times answered
		private var _questionData:Array;					//Contains question data after each time it has been answered. The most recent answer is in the top position.
		private var _strLearnerResp:String					// Contains learner's response.
		private var _weight:uint;							// Contains the amount this question is worth.
		private var _correct:Boolean;						// True if correct false if wrong.
		private var _qType:String;							// Question type.
		private var _question:String;						// Question string
		private var _strCorrectResp:String;					// Contains correct response
		
		public function QuestionsAnswered()
		{
			_questionData = new Array();
		}
		
		public function addQuestion(id:String,data:String):void
		{
//trace("question added: " + data);
			_answerCnt = _questionData.push(data);
			_qID = id;
			_data = data;
			setDataElements();
		}
		
		private function setDataElements():void
		{
			var tmpArray:Array = _data.split("~");		//data contains all interaction data concatenated with a ~ in this order questionType~learner_resp~result~correct_resp~questionDescription~weighting~latency~objectiveID
			_strLearnerResp = tmpArray[1];
			_weight = tmpArray[5];
			_correct = (tmpArray[2] == "true");
			_qType = tmpArray[0];
			_question = tmpArray[4];
			_strCorrectResp = tmpArray[3];
			//trace("W: " + _weight + " - " + _correct);
		}
		
		//GETTER and SETTER
		public function get id():String
		{
			return _qID;
		}
		
		public function get learnerResp():*
		{
			return _strLearnerResp;
		}
		
		public function get numAnswers():uint
		{
			return _answerCnt;
		}
		
		public function get weight():uint
		{
			return _weight;
		}
		
		public function get result():Boolean
		{
			return _correct;
		}
		
		public function get questionType():String
		{
			return _qType;
		}
		
		public function get question():String
		{
			return _question;
		}
		
		public function get correctResp():*
		{
			return _strCorrectResp;
		}
	}
}
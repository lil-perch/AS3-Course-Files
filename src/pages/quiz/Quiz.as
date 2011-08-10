package src.pages.quiz
{
	import flash.events.EventDispatcher;
	
	import src.CourseModel;
	import src.pages.quiz.QuizObjects;
	
	public class Quiz extends EventDispatcher
	{
		private var _quizzes:Object;
		private var _courseModel:CourseModel;
		
		
		public function Quiz(cm:CourseModel)
		{
			_quizzes = new Object();
			_courseModel = cm;
		}
		
		public function addQuizObject(n:String)
		{
			var q:QuizObjects = new QuizObjects(_courseModel);
			_quizzes[n] = q;
		}
		
		public function getQuizObject(n:String):QuizObjects
		{
			return _quizzes[n];
		}
		
		public function isQuizCreated(n:String):Boolean
		{
			var exists:Boolean = false;
			for (var item in _quizzes)
			{
				//trace("ITEM: " + item + " - " + n);
				if (item == n)
				{
					exists = true;
					break;
				}
			}
			return exists;
		}
		
		public function get quizObject():Object
		{
			return _quizzes;
		}
	}
}
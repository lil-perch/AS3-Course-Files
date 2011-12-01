package src.classes
{
	public class LoadingPercentages
	{
		private var _coureFlaEndPoint:Number 	= 	.3;
		private var _settingsModel:Number 		= 	.02;
		private var _courseModel:Number 		= 	.08;
		private var _loadingScorm:Number 		= 	.32;
		private var _quizModel:Number 			= 	.05;	//No longer loads a quiz model.
		private var _glossaryModel:Number 		= 	.02;
		private var _views:Number 				=	.01;
		private var _narrationView:Number		=	.08
		private var _indexView:Number			=	.10;
		private var _contentView:Number 		=	.01;
		private var _previousPerc:Number		= 	0;
		
		public function LoadingPercentages()
		{
			
		}
		
		public function get settingsModelPerc():Number
		{
			_previousPerc = _coureFlaEndPoint;
			return _coureFlaEndPoint + _settingsModel;
		}
		
		public function get courseModelPerc():Number
		{
			_previousPerc = settingsModelPerc;
			return _coureFlaEndPoint + _settingsModel + _courseModel;
		}
		
		public function get scormPerc():Number
		{
			_previousPerc = courseModelPerc;
			return _coureFlaEndPoint + _settingsModel + _courseModel + _loadingScorm;
		}
		
		public function get quizModelPerc():Number
		{
			_previousPerc = scormPerc;
			return _coureFlaEndPoint + _settingsModel + _courseModel + _loadingScorm + _quizModel;
		}
		
		public function get glossaryModelPerc():Number
		{
			_previousPerc = quizModelPerc;
			return _coureFlaEndPoint + _settingsModel + _courseModel + _loadingScorm + _quizModel + _glossaryModel;
		}
		
		public function get viewPerc():Number
		{
			_previousPerc = glossaryModelPerc;
			return _coureFlaEndPoint + _settingsModel + _courseModel + _loadingScorm + _quizModel + _glossaryModel + _views;
		}
		
		public function get narrationViewPerc():Number
		{
			_previousPerc = viewPerc;
			return _coureFlaEndPoint + _settingsModel + _courseModel + _loadingScorm + _quizModel + _glossaryModel + _views + _narrationView;
		}
		
		public function get indexViewPerc():Number
		{
			_previousPerc = narrationViewPerc;
			return _coureFlaEndPoint + _settingsModel + _courseModel + _loadingScorm + _quizModel + _glossaryModel + _views + _narrationView + _indexView;
		}
		
		public function get contentViewPerc():Number
		{
			_previousPerc = indexViewPerc;
			return _coureFlaEndPoint + _settingsModel + _courseModel + _loadingScorm + _quizModel + _glossaryModel + _views + _narrationView + _indexView + _contentView;
		}
		
		public function get previousPercent():Number
		{
			return _previousPerc;
		}
	}
}
package src.pages.quiz
{
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import fl.controls.Button;
	import fl.controls.UIScrollBar;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import src.pages.quiz.QuestionsAnswered;
	import src.pages.quiz.QuizQuestions;
	import src.pages.quiz.Review;
	
	public class Results extends QuizQuestions
	{
		//Declare objects on Stage
		public var heading_mc:MovieClip;
		public var correct_lable:TextField;
		public var correct_txt:TextField;
		public var incorrect_lable:TextField;
		public var incorrect_txt:TextField;
		public var score_lable:TextField;
		public var score_txt:TextField;
		public var possible_lable:TextField;
		public var possible_txt:TextField;
		public var percent_lable:TextField;
		public var percent_txt:TextField;
		public var line1_mc:MovieClip;
		public var line2_mc:MovieClip;
		public var line3_mc:MovieClip;
		public var line4_mc:MovieClip;
		public var fade_mc:MovieClip;					//The fading of the background.
		public var review_btn:Button;					//Button to show Review
		public var print_btn:Button;					//Button to print results
		public var email_btn:Button;					//Button to email results
		public var print_results:Boolean = false;		//Should the learner be able to print the results.
		public var email_results:Boolean = false;		//Should the learner be able to email the results.
		public var incReview:Boolean = false;			//Should this quiz include a review 
		public var review:Review;						//Review object that contains review data.
		public var status_txt:TextField;				//Displays congratulations or failure messages.
		
		private var _sizeH:Number;						//Height of content area
		private var _sizeW:Number;						//Width of content area
		private var _gutter:int = 50;					//space from top
		private var _spacing:int = 15;					//horizontal space between elements
		private var _horizSpace:int = 20;				//space between fields 
		private var _origX:Number;						//Original location of Review
		private var _origY:Number;						//Original location of Reivew
		private var _qAns:Object;						//Stores all the questions that have been answered and needs to be reviewed.
		
		public function Results()
		{
			super();
		}
		
		override public function loadPage():void
		{
			_sizeH = settingsModel.settings.presentSizeH;
			_sizeW = settingsModel.settings.presentSizeW;
			//trace("SIZE: " + _sizeW + " - " + _sizeH);
			
			//Establish settings for page
			doSettings()
			//Size and position stage objects
			sizeResultsElements();
			positionElements();
			
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
			//Force computing the score and lesson status
			if (!quizObject.scoreRecorded) quizObject.recordTheScore();
			trace("record the score done");
			if (!quizObject.statusRecorded) quizObject.recordLessonStatus();
			//trace("VALUE: " + quizObject.totalCorrect);
			if (currentPageTag.@title.length() > 0) heading_mc.heading_txt.text = currentPageTag.@title;
			var sTag:String = "<span class='resultvalue'>";
			var cTag:String = "</span>";
			correct_txt.styleSheet = incorrect_txt.styleSheet = score_txt.styleSheet = possible_txt.styleSheet = percent_txt.styleSheet = status_txt.styleSheet = textCss;
			//trace("object: " + quizObject);
			correct_txt.htmlText = sTag + quizObject.totalCorrect + cTag;
			incorrect_txt.htmlText = sTag + quizObject.totalIncorrect + cTag;
			score_txt.htmlText = sTag + quizObject.rawScore + cTag;
			possible_txt.htmlText = sTag + quizObject.possibleRawScore + cTag;
			percent_txt.htmlText = sTag + quizObject.percent + cTag;
			
			//Set message text
			if (quizObject.recordStatus == "passfail" || quizObject.recordStatus == "apipassfail"  || quizObject.recordStatus == "passincomplete") 
			{
				if (quizObject.passedQuiz)
				{
					trace("In Results page quiz is passed.");
					
					status_txt.htmlText = "<p class = 'success'>" + "Congratulations! That is a passing score." + "</p>";
				} else {
					trace("Results page - Quiz failed");
					
					status_txt.htmlText = "<p class = 'failure'>" + "Sorry, that is not a passing score." + "</p>";
				}
			}
			
			if (incReview)
			{
				review_btn = new Button();
				review_btn.label = "Show Review";
				review_btn.width = 150;
				review_btn.height = 30;
				
				review_btn.y = status_txt.y + status_txt.height + _spacing; //percent_lable.y + percent_lable.height + _spacing;
				review_btn.x = (_sizeW - review_btn.width)/2;
				this.addChild(review_btn);
				review_btn.addEventListener(MouseEvent.CLICK,showReview);
			}
			
			if (print_results)
			{
				print_btn = new Button();
				print_btn.label = "Print Results";
				print_btn.width = 150;
				print_btn.height = 30;
				
				print_btn.y = status_txt.y + status_txt.height + _spacing + 30 + _spacing; //percent_lable.y + percent_lable.height + _spacing + 30 + _spacing;
				print_btn.x = (_sizeW - print_btn.width)/2;
				this.addChild(print_btn);
			}
			
			if (email_results)
			{
				email_btn = new Button();
				email_btn.label = "Email Results";
				email_btn.width = 150;
				email_btn.height = 30;
				
				email_btn.y = status_txt.y + status_txt.height + _spacing + 30 + _spacing; //percent_lable.y + percent_lable.height + _spacing + 30 + _spacing;
				email_btn.x = (_sizeW - email_btn.width)/2;
				this.addChild(email_btn);
			}
			
			if (email_results && print_results)
			{
				print_btn.x = print_btn.x - print_btn.width/2 - _spacing;
				email_btn.x = email_btn.x + email_btn.width/2 + _spacing;
			}
		}
		
		override public function cleanUpListenersLocal()
		{
			//trace("Cleaning up Listeners in Results Page");
			if (review)
			{
				review.cleanUp();
				this.removeChild(review);
			}
			
			review_btn.removeEventListener(MouseEvent.CLICK,showReview);
		}
		
		public function closeReview(e:MouseEvent = null):void
		{
			//trace("CLOSE REVIEW");
			review.cleanUp();
			var reviewTween:TweenLite = new TweenLite(review,1,{x:_origX,y:_origY,ease:Strong.easeOut,onComplete:finishTween});
			var fadeTween:TweenLite = new TweenLite(fade_mc,0.5,{alpha:0});
			fade_mc.x = -1000;
		}
		
		private function showReview(e:MouseEvent):void
		{
			var margin:uint = settingsModel.settings.reviewMargin;
			review = new Review(margin,_sizeW,_sizeH,textCss,this);
			review.y = _origY = margin;
			review.x = _sizeW;//widthSize + 200;
			_origX = review.x + 100;
			
			fade_mc.y = fade_mc.x = 0;
			fade_mc.width = _sizeW;
			fade_mc.height = _sizeH;
			this.addChild(review);
			
			var fadeTween:TweenLite = new TweenLite(fade_mc,1,{alpha:0.2});
			var reviewTween:TweenLite = new TweenLite(review,2,{x:margin,y:margin,ease:Strong.easeOut});
			
			_qAns = quizObject.getQuestionCollection();
			
			review.populateReview(_qAns,quizObject.questionsAnswered,quizObject.questions);
			//Here is another example of how to do this
			
			
			
			/*review.x = 724.50;
			popup_mc._y = (presentSizeH - popup_mc._height) / 2;
			TweenMax.to(fade_mc,1,{_alpha:100, onComplete:slide_in});
			
			var indexTween:TweenLite = new TweenLite(dialog, 0.5, {alpha:1, ease:Strong.easeOut});
			
			function slide_in()
			{
				
				
				var __x = (presentSizeW - popup_mc._width) / 2;
				var __y = (presentSizeH - popup_mc._height) / 2;
				
				TweenMax.to(popup_mc,1,{_x:__x, _y:__y, onComplete:enable_buttos});
			}*/
			
			
			/*
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
			*/
		}
		
		private function finishTween():void
		{
			//trace("FINISHED");
			this.removeChild(review);
		}
		
		private function doSettings():void
		{
			establishQuizSettings();
			if (currentPageTag.@print_results.length() > 0)	print_results = (currentPageTag.@print_results.toLowerCase() == "true");
			if (currentPageTag.@email_results.length() > 0)	email_results = (currentPageTag.@email_results.toLowerCase() == "true");
			if (currentPageTag.@incReview.length() > 0)	incReview = (currentPageTag.@incReview.toLowerCase() == "true"); 
		}
		
		private function sizeResultsElements():void
		{
			status_txt.width = heading_mc.width + 40;
		}
		
		private function positionElements():void
		{
			heading_mc.y = topMargin + _gutter;
			heading_mc.x = (_sizeW - heading_mc.width)/2;
			correct_lable.y = correct_txt.y = heading_mc.y + heading_mc.height + _spacing;
			correct_lable.x = Math.floor(heading_mc.x + (heading_mc.width/2) - _horizSpace/2 - correct_lable.width);
			correct_txt.x = Math.floor(correct_lable.x + correct_lable.width + _horizSpace);
			line1_mc.x = line2_mc.x = line3_mc.x = line4_mc.x = Math.floor(heading_mc.x + (heading_mc.width/2) - (line1_mc.width/2));
			line1_mc.y = correct_txt.y + correct_txt.height + _spacing/2;
			
			incorrect_lable.y = incorrect_txt.y = correct_txt.y + correct_txt.height + _spacing;
			incorrect_lable.x = Math.floor(heading_mc.x + (heading_mc.width/2) - _horizSpace/2 - incorrect_lable.width);
			incorrect_txt.x = Math.floor(incorrect_lable.x + incorrect_lable.width + _horizSpace);
			line2_mc.y = incorrect_txt.y + incorrect_txt.height + _spacing/2;
			score_lable.y = score_txt.y = incorrect_txt.y + incorrect_txt.height + _spacing;
			score_lable.x = Math.floor(heading_mc.x + (heading_mc.width/2) - _horizSpace/2 - score_lable.width);
			score_txt.x = Math.floor(score_lable.x + score_lable.width + _horizSpace);
			line3_mc.y = score_txt.y + score_txt.height + _spacing/2;
			possible_lable.y = possible_txt.y = score_txt.y + score_txt.height + _spacing;
			possible_lable.x = Math.floor(heading_mc.x + (heading_mc.width/2) - _horizSpace/2 - possible_lable.width);
			possible_txt.x = Math.floor(possible_lable.x + possible_lable.width + _horizSpace);
			line4_mc.y = possible_txt.y + possible_txt.height + _spacing/2;
			percent_lable.y = percent_txt.y = possible_txt.y + possible_txt.height + _spacing;
			percent_lable.x = Math.floor(heading_mc.x + (heading_mc.width/2) - _horizSpace/2 - percent_lable.width);
			percent_txt.x = Math.floor(percent_lable.x + percent_lable.width + _horizSpace);
			
			status_txt.x = heading_mc.x - 20;
			status_txt.y = percent_txt.y + percent_txt.height + _spacing;
		}
	}
}
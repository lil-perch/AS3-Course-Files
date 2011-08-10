package src.pages.quiz
{
	import fl.controls.UIScrollBar;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	
	public class Review extends MovieClip
	{
		public var review_txt:TextField;								//Text field for showing the review information.
		public var title_txt:TextField;									//Text field for title of dialog box
		public var review_scroll:UIScrollBar;							//Scroll bar for review text field
		public var bg_mc:MovieClip;										//background for dialog box.
		public var exit_btn:SimpleButton;								//Exit Button
		public var sReviewFeedback:String;								//String of feedback text.
		
		private var _margin:uint;
		private var _width:Number;											//Size of content area
		private var _height:Number;											//Size of content area
		private var _exit:DisplayObject;
		private var _textMargin:uint					= 10;				//Margins for text fields.
		private var _spacing:uint						= 5;				//Spacing between exit button and field.
		private var _vertSpace:uint						= 55;				//Spacing around text field
		private var _results:Results;										//Reference to results
		private var _total:uint;											//Total questions answered.
		private var _css:StyleSheet;										//Stylesheet for text.
		private var _questions:XMLList;										//XMLList of questions in quiz.
		
		public function Review(margin:uint,x:Number,y:Number,textCss:StyleSheet,r:Results)
		{
			super();
			
			_margin = margin;
			_width = x;
			_height = y;
			_css = textCss;
			_results = r;
			var newW:Number = _width - (_margin*2);
			var newH:Number = _height - (_margin*2);
			
			title_txt.text = "Question Review";
			//review_txt.text = "test";
			bg_mc.width = newW;
			bg_mc.height = newH;
			
			//Position text fields
			review_txt.width = bg_mc.width - (_textMargin*2) - review_scroll.width;
			review_txt.x = _textMargin;
			review_txt.height = newH - _vertSpace;
			review_scroll.x = _textMargin + review_txt.width;
			review_scroll.y = review_txt.y;
			review_scroll.height = review_txt.height;
			review_scroll.visible = false;
			title_txt.x = _textMargin*2;
			title_txt.width = bg_mc.width - _textMargin*3 - exit_btn.width - _spacing;
			exit_btn.x = _textMargin*2 + title_txt.width + _spacing;
			//
			//review_txt.styleSheet = textCss;
			
			addExitButton(exit_btn);
		}
		
		public function addExitButton(btn:DisplayObject):void
		{
			_exit = btn;
			_exit.addEventListener(MouseEvent.CLICK,Results(_results).closeReview);
		}
		
		public function cleanUp():void
		{
			_exit.removeEventListener(MouseEvent.CLICK,Results(_results).closeReview);
		}
		
		public function populateReview(qAns:Object,total:uint,questions:XMLList):void
		{
			var questionCnt:uint = 1;
			_total = total;
			sReviewFeedback = "";
			_questions = questions;
			
			for each (var item in _questions)
			{
				if (item.@id.length() > 0)
				{
					var id:String = item.@id;
					var question:QuestionsAnswered = qAns[id];
					var questionXML:XML = item;
					
					//trace("ID: " + question.id + " ---- " + questionXML);
					if (question != null)
					{
						var sCorrect:String = (question.result) ?  '<span class="correctmark">Correct</span>' : '<span class="incorrectmark">Incorrect</span>' ; 
						sReviewFeedback += '<p class="questionnum">Question ' + questionCnt + ' of ' + _total + '   -    ' + sCorrect + '</p>';
						sReviewFeedback += '<p class="questionreview">' + question.question + '</p>';
						
						sReviewFeedback += buildFoilsAndStudentResponse(question,questionXML);
						
						sReviewFeedback += '<br>';
						
						if (!question.result) sReviewFeedback += getCorrectAnswerStatement(question,questionXML);
						
						sReviewFeedback += '--------------------------------------------------------------------------------------------<br><br><br>';
						
						/*if (question.result)
						{
						correct++;
						possible++;
						score = score + question.weight;
						possScore = possScore + question.weight;
						} else {
						incorrect++;
						possible++;
						possScore = possScore + question.weight;
						}*/
						
						questionCnt++;
					}
				}
			}
			
			
			
			/*for (var item in qAns)
			{
				var question:QuestionsAnswered = qAns[item];
				//trace("ID: " + question.id + " -Result: " + question.result);
				//trace("question TYPE: " + question.questionType);
				var questionXML:XML = findQuestion(question.id);
				
				trace("ID: " + question.id + " ---- " + questionXML);
				
				var sCorrect:String = (question.result) ?  '<span class="correctmark">Correct</span>' : '<span class="incorrectmark">Incorrect</span>' ; 
				sReviewFeedback += '<p class="questionnum">Question ' + questionCnt + ' of ' + _total + '   -    ' + sCorrect + '</p>';
				sReviewFeedback += '<p class="questionreview">' + question.question + '</p>';
				
				sReviewFeedback += buildFoilsAndStudentResponse(question,questionXML);
				
				sReviewFeedback += '<br>';
				
				/*if ((( SessionArray[i].result == 'C' ) && ( this.currentQuiz_xmlnode.attributes.showCorrect == 'true' )) || ( SessionArray[i].result == 'W' ) || ( SessionArray[i].result == undefined ) )
				{
					sReviewFeedback += getCorrectAnswerStatement( i );
				}*/
	//			sReviewFeedback += '--------------------------------------------------------------------------------------------<br><br><br>';
				
				/*if (question.result)
				{
				correct++;
				possible++;
				score = score + question.weight;
				possScore = possScore + question.weight;
				} else {
				incorrect++;
				possible++;
				possScore = possScore + question.weight;
				}*/
				
	//			questionCnt++;
	//		}
			//review_txt.styleSheet = cssBlock;
			review_txt.styleSheet = _css
			review_txt.htmlText = sReviewFeedback;
			if (review_txt.maxScrollV > 1)
			{
				review_scroll.visible = true;
			} else {
				review_scroll.visible = false;
			}
		}
		
		private function buildFoilsAndStudentResponse(question:QuestionsAnswered,questionXML:XML):String
		{
			var sFoils = '<p>&nbsp;</p><p>Your answer was:</p>';
			var cFdbkMark:String = '<span class="correctmark">C</span>';
			var xFdbkMark:String =   '<span class="incorrectmark">X</span>' ;
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
			switch (question.questionType)
			{
				case "true-false":
					
					if (question.learnerResp == null || question.learnerResp == "null")
					{
						sFoils += '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You did not provide an answer for this question.</p>';
					} else if (question.correctResp.toLowerCase() == "true") {
						if (question.result)
						{
							sFoils += '<p>' + cFdbkMark + ' ' +  '&nbsp;&nbsp;True</p>';
							sFoils += '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;False</p>';
						} else {
							sFoils += '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;True</p>';
							sFoils += '<p>' + xFdbkMark + ' ' +  '&nbsp;&nbsp;False</p>';
						}
					} else {
						if (question.result)
						{
							sFoils += '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;True</p>';
							sFoils += '<p>' + cFdbkMark + ' ' +  '&nbsp;&nbsp;False</p>';
						} else {
							sFoils += '<p>' + xFdbkMark + ' ' +  '&nbsp;&nbsp;True</p>';
							sFoils += '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;False</p>';
						}
					}
					return sFoils;
					break;
				case "fill-in":
					if (question.learnerResp == null || question.learnerResp == "null" || question.learnerResp == "")
					{
						sFoils += '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You did not provide an answer for this question.</p>';
					} else {
						if (question.result) {
							sFoils += '<p>&nbsp;' + cFdbkMark + '&nbsp;&nbsp;' + question.learnerResp +  '</p>';
						} else {
							sFoils += '<p>&nbsp;' + xFdbkMark + '&nbsp;&nbsp;' + question.learnerResp +  '</p>';
						}
					}
					return sFoils;
					break;
				case "choice":
		
					if (question.learnerResp == null || question.learnerResp == "null")
					{
						sFoils += '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You did not provide an answer for this question.</p>';
					} else {
						var distract:XMLList = new XMLList();
						distract = questionXML.distractors.*;
						var ans:String = question.learnerResp;
						var tmp:Array = ans.split("^");
						var tempFoils:String = "";
						if (question.result)
						{
							tempFoils = '<p>&nbsp;' + cFdbkMark + '&nbsp;&nbsp;';
						} else {
							tempFoils = '<p>&nbsp;' + xFdbkMark + '&nbsp;&nbsp;';
						}
						
						for each (var item in distract) { 
							
							//find the chosen response
							var responseFound:Boolean = false;
							
							if (item.substr(0,255) == tmp[1])
							{
								responseFound = true;
							}
							
							if (responseFound)
							{
								sFoils += tempFoils + item + '</p>';
							} else {
								sFoils += '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + item + '</p>';
							}
						}
					}
					
					return sFoils;
					break;
				case "choiceM":
					sFoils = '<p>&nbsp;</p><p>Your answers were:</p>';
					
				trace("::: " + question.learnerResp);	
					if (question.learnerResp == null || question.learnerResp == "null" || question.learnerResp == "")
					{
						sFoils += '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You did not provide an answer for this question.</p>';
					} else {
						var distractM:XMLList = new XMLList();
						distractM = questionXML.distractors.*;
						//var ansM:String = question.learnerResp;
						var answers:Array = question.learnerResp.split("$");
						//var tmpM:Array = ans.split("^");
						var tempFoilsM:String = "";
						
						for each (var itemM in distractM) { 
							
							//find the chosen response
							var responseFoundM:Boolean = false;
							var correctResp:Boolean = false;
							
							for (var c:uint = 0;c<answers.length;c++)
							{
								var ansM:String = answers[c];
								var tmpM:Array = ansM.split("^");
								
								//find the chosen response
								if (itemM.substr(0,255) == tmpM[1])
								{
									responseFoundM = true;
									break;
								}
							}
							if (itemM.@correct.length() > 0)
							{
								if (itemM.@correct.toLowerCase() == "true") correctResp = true;
							}
							
							if (responseFoundM)
							{
								if (correctResp)
								{
									tempFoilsM = '<p>&nbsp;' + cFdbkMark + '&nbsp;&nbsp;';
								} else {
									tempFoilsM = '<p>&nbsp;' + xFdbkMark + '&nbsp;&nbsp;';
								}
								sFoils += tempFoilsM + itemM + '</p>';
							} else {
								sFoils += '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + itemM + '</p>';
							}
						}
					}
					
					return sFoils;
					break;
				default:
					return "Question type was not found in buildFoilsAndStudentResponse.";
			}
			
			
			return "Foils for Question Type Couldn't be Built.";
		}
		
		private function getCorrectAnswerStatement(question:QuestionsAnswered,questionXML:XML):String
		{
			var cAnswer = '<p>&nbsp;</p><p>Correct Answer: </p>';
			
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
			
			switch (question.questionType)
			{
				case "true-false":
					cAnswer += '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + question.correctResp + '</p>';
					return cAnswer;
					break;
				case "fill-in":
					cAnswer += '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + question.correctResp + '</p>';
					return cAnswer;
					break;
				case "choice":
					var tmpA:Array = question.correctResp.split("^");
					cAnswer += '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + tmpA[1] + '</p>';
					return cAnswer;
					break;
				case "choiceM":
				trace("** " + question.correctResp);
					var theAnswers:Array = question.correctResp.split("$");
					
					for (var c:uint = 0;c<theAnswers.length;c++)
					{
						var ansMC:String = theAnswers[c];
						var tmpMC:Array = ansMC.split("^");
						cAnswer += '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + tmpMC[1] + '</p>';
					}
					
					return cAnswer;
					break;
				default:
					return "Question type was not found in getCorrectAnswerStatement.";
			}
		}
	}
}
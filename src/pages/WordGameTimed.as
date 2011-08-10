package src.pages
{
	import src.pages.DynamicPageAPI;
	import flash.ui.*;
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.utils.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	import src.pages.utils.*;
	import flash.external.ExternalInterface;
	import flash.display.Loader;
	import flash.media.SoundChannel;

	public class WordGameTimed extends DynamicPageAPI
	{

		private var loader:URLLoader;
		//private var settingsModel;
		//private var currentPageTag;
		

		private var countdownInterval:Timer;
		private var timer;
		private var total = 0;
		private var count = 0;
		private var score = 0;
		private var step = 1000;
		private var indexQ = 0;// Load the question number
		private var presentSizeH:Number;
		private var presentSizeW:Number;
		private var objGame:Array;


		private var req:URLRequest;

		// SCORM
		private var intCnt;
		private var intStr:String;
		private var intID:Timer;  //setInterval for recording data.
		private var objCnt:Number = 0;



		// AS2 conversion
		private var snd:Sound = new Sound();// Sound manager variable
		private var sndChannel:SoundChannel = new SoundChannel();// Sound manager variable

		private var FeedSound:Sound = new Sound();
		private var FeedSoundChannel:SoundChannel = new SoundChannel();

		private var SpinSound:Sound = new Sound();
		private var SpinSoundChannel:SoundChannel = new SoundChannel();


		public function WordGameTimed()
		{
			super();
			//loadPage();
			

		}





		override public function loadPage():void
		{
			trace("LOAD PAGE WOIRD")
			
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";

			addFrameScript(0, addFrame1);
			addFrameScript(1, addFrame2);
			addFrameScript(2, addFrame3);
			addFrameScript(3, addFrame4);
			
			//runLocal();
			
			
		
		}





		private function shuffleXML(xml)
		{
			for (var i:Number=0; i<xml.length(); i++)
			{
				var rand:Number = Math.floor(Math.random() * xml.length());
				var xml1:XML = new XML(xml[i]);
				var xml2:XML = new XML(xml[rand]);
				xml[i] = null;
				xml[rand] = null;
				xml[i] = xml2;
				xml[rand] = xml1;
			}
		}

		private function shuffle(_arr)
		{
			var len = _arr.length;
			for (var i = 0; i < len; i++)
			{
				var rand = Math.floor(Math.random() * len);
				//swap current index with a random one  
				var temp = _arr[i];
				_arr[i] = _arr[rand];
				_arr[rand] = temp;
			}
		}


		//Testing outside ProForm
		private function runLocal()
		{
			loader = new URLLoader(new URLRequest("sco.xml"));
			loader.addEventListener(Event.COMPLETE,xmlLoaded);
		}
		private function xmlLoaded(e:Event)
		{
			currentPageTag = new XML(e.target.data);

			presentSizeH = 500;
			presentSizeW = 700;
			doTrace("XML LOADED");
			play();
		}




		private function runServer()
		{
			presentSizeH = settingsModel.settings.presentSizeH;
			presentSizeW = settingsModel.settings.presentSizeW;
			
			trace("GO TO FRAME2")
			play();
		}

		function addFrame1()
		{
			stop();
			doTrace(":: FRAME1");
			runServer();
			
		}
		function addFrame2()
		{
			
			stop();
			doTrace(":: FRAME2");
			trace("INIT")			
			init();
			lock_mc.visible = false;
			lock_mc.width = presentSizeW;
			lock_mc.height= presentSizeH;
			lock_mc.addEventListener(MouseEvent.CLICK,function(e:MouseEvent){doTrace("LOCKED");});

		}




		//////////////////////////// FRAME2

		function init()
		{

			var colors;
			// COLORS
			if (("@bg_color1" in currentPageTag.color[0]) && ("@bg_color2" in currentPageTag.color[0]))
			{
				colors = [Number(currentPageTag.color[0]. @ bg_color1),Number(currentPageTag.color[0]. @ bg_color2)];
				Colorize.FillRadial(bg_mc,colors);
			}


			Colorize.doColor(title_bar_mc,currentPageTag.color[0].@title_bar);
			Colorize.doColor(score_bar_mc.base_mc,currentPageTag.color[0].@title_bar);
			Colorize.doColor(popup_mc.bg_mc.bg_mc,currentPageTag.color[0].@title_bar);
			Colorize.doColor(popup_mc.start_btn.base_mc,currentPageTag.color[0].@button);
			Colorize.doColor(submit_btn.base_mc,currentPageTag.color[0].@button);
			Colorize.doColor(hint_btn.base_mc,currentPageTag.color[0].@button1);





			// POSITIONS AND DIMENSION

			fade_mc.width = presentSizeW;
			fade_mc.height = presentSizeH;
			bg_mc.width = presentSizeW;
			bg_mc.height = presentSizeH;

			title_bar_mc.width = presentSizeW;
			title_txt.width = presentSizeW - 10;
			score_bar_mc.x = title_bar_mc.width - score_bar_mc.width - 20;
			score_bar_mc.y = title_bar_mc.height - 4;

			word_txt.width = presentSizeW - 50;

			progress_mc.x = 12;
			progress_mc.y = presentSizeH - 26;

			input_mc.x = presentSizeW / 2 - input_mc.width / 2;
			word_txt.x = presentSizeW / 2 - word_txt.width / 2;



			hint_btn.x = presentSizeW / 2 - (submit_btn.width + hint_btn.width) / 2;
			submit_btn.x = hint_btn.x + hint_btn.width + 10;



			//EVENTS 
			Events.setColor(currentPageTag.color[0].@button_over,currentPageTag.color[0].@button);



			// DIFFERENT COLORS ON OVER.OUT
			hint_btn.color_over = Number(currentPageTag.color[0]. @ button1_over);
			hint_btn.color_out = Number(currentPageTag.color[0]. @ button1);

			Events.doEvents(hint_btn,doHint);
			Events.doEvents(submit_btn,doSubmit);



			submit_btn.mouseEnabled = false;
			hint_btn.mouseEnabled = false;

			popup_mc.title_txt.htmlText = "<b>" + currentPageTag.popInstruct[0]. @ titleInst + "</b>";
			popup_mc.instruction_txt.htmlText = currentPageTag.popInstruct[0];

			popup_mc.start_btn.title_txt.htmlText = "<b>" + currentPageTag.popInstruct[0]. @ startBTNTitle + "</b>";

			title_txt.htmlText = "<b>"+currentPageTag.@title+"</b>"
			
			;
			hint_btn.title_txt.htmlText = "<b>" + currentPageTag.btn[0]. @ hint_btn + "</b>";
			submit_btn.title_txt.htmlText = "<b>" + currentPageTag.btn[0]. @ submit_btn + "</b>";
			score_bar_mc.timer_txt.htmlText = "<b>" + Format.doFormat(0) + "</b>";
			score_bar_mc.score_title_txt.htmlText = "<b>" + currentPageTag.text[0]. @ score_txt + "</b>";

			fade_mc.alpha = 0;
			popup_mc.x = 2 * presentSizeW;
			popup_mc.y = (presentSizeH - popup_mc.height) / 2;
			TweenMax.to(fade_mc,1,{alpha:1, onComplete:slide_in});


			prepareGame();
		}


		function slide_in()
		{
			var _x = (presentSizeW - popup_mc.width) / 2;
			var _y = (presentSizeH - popup_mc.height) / 2;
			TweenMax.to(popup_mc,1,{x:_x, y:_y, onComplete:enable_buttos});
		}

		function slide_out(_ref:MovieClip)
		{
			trace("SLIDE OUT "+" this "+this);
			
			// STOP SOUND HERE
			sndChannel.stop();
			TweenMax.to(fade_mc,1,{alpha:0});
			TweenMax.to(popup_mc,1,{x:2*presentSizeW, onComplete:doPlay});
		}


		function enable_buttos()
		{

			sndChannel = doSound(currentPageTag. @ audioPath,snd);
			popup_mc.start_btn.useHandCursor = true;			
			Events.doEvents(popup_mc.start_btn,slide_out);

		}

		function doPlay()
		{
			
			
			play();
			stage.focus = input_mc.input_txt;			
		}



		function prepareGame()
		{
			
			
			var i:Number;
			objGame = new Array();



			if (currentPageTag.configuration[0]. @ shuffle == "true")
			{
				shuffleXML(currentPageTag.game[0].question);
			}


			for (i = 0; i < currentPageTag.game[0].question.length(); i++)
			{
				trace("Q "+currentPageTag.game[0].question[i]);
				if (currentPageTag.game[0].question[i] != "" && currentPageTag.game[0].question[i]. @ active != "true")
				{

					trace("P "+currentPageTag.game[0].question[i]);
					var obj:Object = new Object();
					obj.feedback = currentPageTag.game[0].question[i]. @ feedback;
					obj.hint = currentPageTag.game[0].question[i]. @ hint;
					obj.correctanswer = currentPageTag.game[0].question[i]. @ answer;
					obj.point = currentPageTag.game[0].question[i]. @ point;
					obj.time = currentPageTag.game[0].question[i]. @ time;
					obj.question = currentPageTag.game[0].question[i];
					obj.useranswer = "";
					objGame.push(obj);
				}
			}

			total = objGame.length;
			progress_mc.title_txt.text = "Question [current] out of [total]";
			progress_mc.title_txt.text = progress_mc.title_txt.text.split("[total]").join(total);
			progress_mc.title_txt.htmlText = progress_mc.title_txt.text.split("[current]").join((indexQ+1));
			score_bar_mc.score_txt.htmlText = "<b>0 of " + total + "</b>";
			
			
			trace(" LLEVAR A "+Number(total))
			progress_mc.gotoAndStop(Number(total));
			for (i=0; i<=indexQ; i++)
			{
				trace("step" + i);
				progress_mc["step" + i].gotoAndStop("on");
			}



			loadQuestion();
		}


		function loadQuestion()
		{
			
				lock_mc.visible = true;
				lock_mc.width = presentSizeW;
				lock_mc.height = presentSizeH;
				TweenMax.to(lock_mc,0.3,{alpha:1, onComplete:doUnlock});			
		}

		function doUnlock()
		{

			if (objGame[indexQ].hint != undefined && objGame[indexQ].hint != "")
			{
				hint_btn.x = presentSizeW / 2 - (submit_btn.width + hint_btn.width) / 2;
				submit_btn.x = hint_btn.x + hint_btn.width + 10;
				hint_btn.visible = true;
			}
			else
			{
				submit_btn.x = presentSizeW / 2 - (submit_btn.width) / 2;
				hint_btn.visible = false;
			}

			trace("TEXTO "+objGame[indexQ].question)
			word_txt.htmlText = objGame[indexQ].question;
			input_mc.input_txt.text = "";									
			objGame[indexQ].descript = word_txt.text;
			
			TweenMax.to(lock_mc,0.3,{alpha:0, onComplete:doLoadText});							
		}

		function doLoadText()
		{
			
			lock_mc.visible = false;	
			stage.focus = input_mc.input_txt;

		}
		function doCount(_time)
		{
			submit_btn.mouseEnabled = true;
			timer = Number(_time);
			count = 0;
			score_bar_mc.timer_txt.htmlText = "<b>" + Format.doFormat(timer) + "</b>";
		}

		function doSubmit(_ref:MovieClip)
		{

			// SCORM
			objGame[indexQ].timeStamp = getTimeStamp();
			objGame[indexQ].dateStamp = getDateStamp();
			var str = input_mc.input_txt.text;
			var answer = objGame[indexQ].correctanswer;
			objGame[indexQ].useranswer = str;



			if (currentPageTag.configuration[0]. @ caseSensitive != "true")
			{
				str = str.toLowerCase();
				answer = answer.toLowerCase();
			}


			if (answer == str)
			{
				objGame[indexQ].guess = true;
				score +=  Number(objGame[indexQ].point);
				score_bar_mc.score_txt.htmlText = "<b>" + score + " of " + total + "</b>";
			}
			else
			{
				objGame[indexQ].guess = false;
			}

			indexQ++;

			//progress_mc.title_txt.htmlText = "<b>"+currentPageTag.text[0].progress_txt+"</b>";
			progress_mc.title_txt.text = "Question [current] out of [total]";
			progress_mc.title_txt.text = progress_mc.title_txt.text.split("[total]").join(total);
			progress_mc.title_txt.htmlText = progress_mc.title_txt.text.split("[current]").join((indexQ+1));
			
			
			
			trace("indexQ "+indexQ+" OBJgAME "+objGame.length)

			if (indexQ < objGame.length)
			{
				trace("ENTRA ")
				
				for (var i=0; i<=indexQ; i++)
				{				
					progress_mc["step" + i].gotoAndStop("on");
				}
				loadQuestion();
				doCount(objGame[indexQ].time);
				countdownInterval.stop();
				countdownInterval.start();				
			}
			else
			{
				// it's over
				countdownInterval.stop();
				gotoAndStop("answers");
			}


		}

		private function timerHandler(e:TimerEvent):void
		{
			countdown();
		}

		private function completeHandler(e:TimerEvent):void
		{
			doTrace("TIME IS OVER");
		}

		function doHint(_ref:MovieClip)
		{

			popup_mc.visible = true;
			lock_mc.alpha = 1;
			lock_mc.visible = true;
						
			popup_mc.x = 2 * presentSizeW;
			popup_mc.y = (presentSizeH - popup_mc.height) / 2;

			Colorize.doColor(popup_mc.bg_mc.bg_mc,currentPageTag.color[0].@title_bar);
			Colorize.doColor(popup_mc.start_btn.base_mc,currentPageTag.color[0].@button);

			popup_mc.title_txt.htmlText = "<b>" + currentPageTag.btn[0]. @ hint_btn + "</b>";
			popup_mc.instruction_txt.htmlText = objGame[indexQ].hint;
			popup_mc.start_btn.title_txt.htmlText = "<b>" + currentPageTag.btn[0]. @ continue_btn + "</b>";
			Events.doEvents(popup_mc.start_btn,slide_out_hint);
			slide_in_hint();
		}

		function slide_in_hint()
		{
			var _x = (presentSizeW - popup_mc.width) / 2;
			var _y = (presentSizeH - popup_mc.height) / 2;
			TweenMax.to(popup_mc,1,{x:_x, y:_y});


		}

		function slide_out_hint(_ref:MovieClip)
		{
			// STOP SOUND HERE
			lock_mc.alpha = 0;
			lock_mc.visible = false;
			TweenMax.to(popup_mc,1,{x:2*presentSizeW});
			
						

		}

		private function doTrace(_msg)
		{
			//debug_txt.appendText(_msg+"\n");
			trace(_msg);
		}










		///////////////// FRAME 3


		private function addFrame3()
		{

			doTrace(":: FRAME3");

			stop();


			

			submit_btn.mouseEnabled = true;
			hint_btn.mouseEnabled = true;

			doCount(objGame[indexQ].time);			
			countdownInterval = new Timer(step);
			countdownInterval.start();
			countdownInterval.addEventListener(TimerEvent.TIMER, timerHandler);
			countdownInterval.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);								
			stage.addEventListener(KeyboardEvent.KEY_UP, DoKeyDown);
			
		}

		function DoKeyDown(evt:KeyboardEvent):void
		{

			if (evt.keyCode == Keyboard.ENTER)
			{
				// TESTEAR HERE

				if (String(stage.focus) == String(input_mc.input_txt))
				{					
					doSubmit(undefined);
				}
			}

		}



		private function countdown()
		{
			count++;
			objGame[indexQ].latency = count;//For SCORM tracking
			//trace("timer: " + count);
			if (timer == count)
			{
				score_bar_mc.timer_txt.htmlText = "<b>" + Format.doFormat(0) + "</b>";
				slide_out_hint(undefined);
				doSubmit(undefined);
			}
			else
			{
				var rest = timer - count;

				score_bar_mc.timer_txt.htmlText = "<b>" + Format.doFormat(rest) + "</b>";
			}
		}


		//////////   FRAME 4

		private function addFrame4()
		{
			doTrace(":: FRAME4");

			stop();




			var max_question = 8;
			var i:Number;
			
			
			
			
			//SCORM
			var intCnt;
			var intStr:String;
			var intID:Number;//setInterval for recording data.
			// COLOR
			Colorize.doColor(score_bar_mc.base_mc,currentPageTag.color[0].@title_bar);
			Colorize.doColor(feedback_mc.bg_mc.bg_mc,currentPageTag.color[0].@title_bar);
			Colorize.doColor(score_bar_mc.base_mc,currentPageTag.color[0].@title_bar);


			// POSITIONS AND DIMENSION

			separator_mc.width = presentSizeW;
			score_bar_mc.x = title_bar_mc.width - score_bar_mc.width - 20;
			score_bar_mc.y = title_bar_mc.height - 4;
			score_bar_mc.score_txt.htmlText = "<b>" + score + " of " + total + "</b>";
			score_bar_mc.timer_txt.htmlText = "<b>" + Format.doFormat(0) + "</b>";
			your_responsetitle_txt.htmlText = "<b>" + currentPageTag.text[0]. @ your_responsetitle_txt + "</b>";
			correct_responsetitle_txt.htmlText = "<b>" + currentPageTag.text[0]. @ correct_responsetitle_txt + "</b>";

			score_bar_mc.final_score_txt.htmlText = "<b>" + currentPageTag.text[0]. @ final_score_txt + "</b>";
			final_feedbacktitle_txt.htmlText = "<b>" + currentPageTag.text[0]. @ final_feedbacktitle_txt + "</b>";


			// POSITION  IS MISSING
			feedback_mc.visible = false;

			for ( i = 0; i < max_question; i++)
			{
				this["question" + i].visible = false;
			}


			for (i = 0; i < objGame.length; i++)
			{
				this["question" + i].visible = true;
				this["question" + i].index = i;
				Events.doEvents(this["question" + i].show_btn,showFeedBack);
				this["question" + i].show_btn.title_txt.htmlText = "<b>" + currentPageTag.btn[0]. @ show_btn + "</b>";
				this["question" + i].your_txt.text = objGame[i].useranswer;
				this["question" + i].correct_txt.text = objGame[i].correctanswer;

				if (objGame[i].guess == true)
				{
					this["question" + i].icono_mc.gotoAndStop("correct");
				}
				else
				{
					this["question" + i].icono_mc.gotoAndStop("incorrect");
				}
			}

			// SCORM
			recordInteraction();

		}

		function showFeedBack(_ref:MovieClip)
		{
			trace("Show Feedback "+lock_mc)
			lock_mc.visible = true;
			lock_mc.alpha = 0;			
			
			feedback_mc.visible = true;
			feedback_mc.feedpopupsubtitle_txt.htmlText = "<b>" + currentPageTag.text[0]. @ feedpopupsubtitle_txt + "</b>";
			feedback_mc.correct_responsetitle_txt.htmlText = "<b>" + currentPageTag.text[0]. @ correct_responsetitle_txt + "</b>";
			feedback_mc.your_responsetitle_txt.htmlText = "<b>" + currentPageTag.text[0]. @ your_responsetitle_txt + "</b>";

			feedback_mc.feedareatitle_txt.htmlText = "<b>" + currentPageTag.text[0]. @ feedpopuptitle_txt + "</b>";
			feedback_mc.feedpopuptitle_txt.htmlText = "<b>" + currentPageTag.text[0]. @ feedpopuptitle_txt + "</b>";
							
			feedback_mc.question_txt.text = objGame[MovieClip(_ref.parent).index].question;
			feedback_mc.your_response_txt.text = objGame[MovieClip(_ref.parent).index].useranswer;
			feedback_mc.correct_response_txt.text = objGame[MovieClip(_ref.parent).index].correctanswer;
			feedback_mc.feedback_txt.text = objGame[MovieClip(_ref.parent).index].feedback;
			
			
			
			feedback_mc.close_btn.title_txt.htmlText = "<b>" + currentPageTag.btn[0]. @ close_btn + "</b>";
			Events.doEvents(feedback_mc.close_btn,closeFeedBack);


			feedback_mc.x = 2 * presentSizeW;
			feedback_mc.y = (presentSizeH - feedback_mc.height) / 2;			
			
			TweenMax.to(lock_mc,0.2,{alpha:1, onComplete:slide_in_feed});

		}
		
		
		
		

		function slide_in_feed()
		{
			var _x = (presentSizeW - feedback_mc.width) / 2;
			var _y = (presentSizeH - feedback_mc.height) / 2;
			TweenMax.to(feedback_mc,0.5,{x:_x, y:_y});
		}


		function closeFeedBack(_ref:MovieClip)
		{

			TweenMax.to(lock_mc,0.5,{alpha:0});
			// STOP SOUND HERE			
			TweenMax.to(feedback_mc,0.5,{x:2*presentSizeW, onComplete:doActivate});


		}

		function doActivate()
		{			
			lock_mc.visible = false;
			feedback_mc.visible = false;
		}




		private function doSound(audio_path, _snd)
		{
			if (audio_path != null && audio_path != "")
			{
				_snd = new Sound();
				req = new URLRequest(audio_path);
				_snd.load(req);
				return _snd.play();
			}

		}



		//Rapid Intake
		//Functions used for SCORM recording
		
		
		//SCORM functions
		
		private function getTimeStamp():String
		{
			var timeObj:Date = new Date();		
			var hours:String = formatNum(timeObj.getHours());
			var minutes:String = formatNum(timeObj.getMinutes());
			var seconds:String = formatNum(timeObj.getSeconds());		
			var timeString:String = String(hours)+":"+String(minutes)+":"+String(seconds);
			return timeString;
		}		
		
		private function getDateStamp():String
		{
			var dateObj:Date = new Date();			
			var year:String = String(dateObj.getFullYear());
			var month:String = String(formatNum(dateObj.getMonth()+1));
			var day:String = String(formatNum(dateObj.getDate()));			
			var dateString = year+"/"+month+"/"+day;
			return dateString;
		}
		
		private function formatNum(num:Number):String {	
			var str:String;
			if (num <= 9) {
				str = "0"+String(num);
			}
			else
			{
				str = String(num);
			}
			return str;
		}
				
		
		
		
		
		
		
		
		private function timerHandlerData(e:TimerEvent):void
		{
			sendData();
		}

		private function completeHandlerData(e:TimerEvent):void
		{
			doTrace("TIME IS OVER");
		}
		
		
		//******NEED TO SET UP THIS FUNCTION FOR THE MATCHING STILL*************
		
		function sendData()
		{
			var description;
			var sData;
			if (objCnt < objGame.length)
			{
				if (objCnt > 0)
				{
					if (courseModel.courseAttributes.tracking == "SCORM1.3")
					{
						description = objGame[objCnt - 1].descript;
						if (description !== undefined && description != "" && description != " ")
						{
							sData = intStr + "description";
							trace("Desc: " + sData + " - " + description);							
							courseModel.lmsLink.apiSetValue(sData,description);
						}
						intCnt++;
						intStr = "cmi.interactions." + intCnt + ".";
					}
				}
																														
				if (objGame[objCnt].latency == undefined)
				{
					objGame[objCnt].latency = 0;
				}
				var sTime:String = getLatency(objGame[objCnt].latency);
				//trace(sTime);
				var sId:String = currentPageTag.@interactionID + objCnt;
				var sWeight:Number = objGame[objCnt].point;
				
				var sResult;
				if (objGame[objCnt].guess)
				{
					sResult = "C";
				}
				else
				{
					sResult = "W";
				}
				var sType:String = "fill-in";
				var sResponse:String = escape(objGame[objCnt].useranswer);
				//trace("sResponse " + sResponse);
				var sCorrect:String = escape(objGame[objCnt].correctanswer);
		
				var timeStamp:String = objGame[objCnt].timeStamp;
		
				var dateStamp:String = objGame[objCnt].dateStamp;		
		
				//trace (timeStamp + "-" + dateStamp);
				//trace("sCorrect " + sCorrect);
				//playerMain_mc.apiSetInteraction(sId,sType,sResponse,sCorrect,sResult,sWeight,sTime);
		
				var intData = dateStamp + ";" + timeStamp + ";" + sId + ";" + "" + ";" + sType + ";" + sCorrect + ";" + sResponse + ";" + sResult + ";" + sWeight + ";" + sTime;
				trace(intData);				
				var errmsg = ExternalInterface.call("MM_cmiSendInteractionInfo", intData);		
				objCnt++;		
			}
			else
			{							
				intID.stop();
				if (courseModel.courseAttributes.tracking == "SCORM1.3")
				{
					description = objGame[objCnt - 1].descript;
					if (description !== undefined && description != "" && description != " ")
					{
						sData = intStr + "description";
						trace("Desc: " + sData + " - " + description);												
						courseModel.lmsLink.apiSetValue(sData,description);
					}
					intCnt++;
					intStr = "cmi.interactions." + intCnt + ".";
				}				
				courseModel.lmsLink.apiSendCommit();
				
			}
		}
		
					
		
		function getLatency(timeInSec)
		{
			var l_seconds, l_minutes, l_hours, timeInHours;
		
			if (timeInSec <= 9)
			{
				l_seconds = "0" + timeInSec;
				l_minutes = "00";
				l_hours = "00";
			}
			else
			{
				l_seconds = timeInSec;
				l_minutes = "00";
				l_hours = "00";
			}
			if (l_seconds > 59)
			{
				l_minutes = int(l_seconds / 60);
				l_minutes = formatNum(l_minutes);
				l_seconds = l_seconds - (l_minutes * 60);
				l_seconds = formatNum(l_seconds);
				l_hours = "00";
			}
			if (l_minutes > 59)
			{
				l_hours = int(l_minutes / 60);
				l_hours = formatNum(l_hours);
				l_minutes = l_minutes - (l_hours * 60);
				l_minutes = formatNum(l_minutes);
			}
			timeInHours = l_hours + ":" + l_minutes + ":" + l_seconds;
			return timeInHours;
		}

		function recordInteraction()
		{
			
			if("@trackInteraction" in currentPageTag != false)
			{
				if (currentPageTag.@trackInteraction.toLowerCase() == "true")
				{
					var isAvailable:Boolean = ExternalInterface.available;
				
					if (isAvailable)
					{
						intCnt = ExternalInterface.call("SCOGetValue","cmi.interactions._count");
						intStr = "cmi.interactions." + intCnt + ".";
					}
					
					intID = new Timer(250);
					intID.start();
					intID.addEventListener(TimerEvent.TIMER, timerHandlerData);
					intID.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandlerData);												
				}
			}
		
		
			if("@recordScore" in currentPageTag != false)
			{
				if (currentPageTag.@recordScore.toLowerCase() == "true")
				{
					var sResult:Number = (Math.round((score/total * 10000000)))/10000000;
					trace(0 + " - " + total + " - " + score + " - " + sResult);																
					courseModel.lmsLink.apiSetScore(0,total,score,String(sResult));
				}
			}
		}
		
		
	}

}
package src.pages
{
	import src.pages.DynamicPageAPI;
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



	public class SpinWheel extends DynamicPageAPI
	{


		private var loader:URLLoader;
		private var loaderImg:Loader;
		//private var currentPageTag:XML;




		// AS2 conversion
		private var snd:Sound = new Sound();// Sound manager variable
		private var sndChannel:SoundChannel = new SoundChannel();// Sound manager variable
		
		private var FeedSound:Sound = new Sound();		
		private var FeedSoundChannel:SoundChannel = new SoundChannel();
		
		private var SpinSound:Sound = new Sound();
		private var SpinSoundChannel:SoundChannel = new SoundChannel();
		
		
		
		
		private var req:URLRequest;
		private var timer:Number;
		private var total:Number = 0;
		private var count:Number = 0;
		private var score:Number = 0;
		private var posScore:Number;// Max number of points possible.
		private var step:Number = 1000;
		private var points:Number;
		private var indexQ:Number = 0;
		private var played:Array = new Array();// Questions played during the game
		private var currentQuestion:Object = new Object();
		private var currentSector:Number = NaN;
		private var defaultQuestion:Number = 6;
		private var presentSizeH:Number;
		private var presentSizeW:Number;


		private var margin = 15;
		private var currentIndex = -1;

		private var progress = "Question [current] out of [total]";

		//SCORM
		private var intCnt;
		private var intStr:String;
		private var intID:Timer;//setInterval for recording data.
		private var objCnt:Number = 0;		

		private var countdownInterval:Timer;


		private var objGame:Object;

		public function SpinWheel()
		{
			super();
			
		}
		
		
		override public function loadPage():void
		{
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";						
			addFrameScript(0, addFrame1);
			addFrameScript(1, addFrame2);
			addFrameScript(2, addFrame3);
			addFrameScript(3, addFrame4);
			
			//runLocal();
			runServer();
		}
		
		

		private function doTrace(_msg)
		{
			//debug_txt.appendText(_msg+"\n");
			trace(_msg);
		}


		private function runServer()
		{
			presentSizeH = settingsModel.settings.presentSizeH;
			presentSizeW = settingsModel.settings.presentSizeW;
			play();
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


		function shuffleXML(_xml)
		{
			for (var i:Number=0; i<_xml.length(); i++)
			{
				var rand:Number = Math.floor(Math.random() * _xml.length());
				var xml1:XML = new XML(_xml[i]);
				var xml2:XML = new XML(_xml[rand]);
				_xml[i] = null;
				_xml[rand] = null;
				_xml[i] = xml2;
				_xml[rand] = xml1;
			}
		}

		function shuffle(_arr)
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


		//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		// CODE FOR FRAME1
		//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		private function addFrame1()
		{
			stop();
			doTrace(":: FRAME1");								
		}


		//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		// CODE FOR FRAME2
		//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		private function addFrame2()
		{
			stop();
			doTrace(":: FRAME2");
			posScore = Number(currentPageTag.configuration[0]. @ points) * Number(currentPageTag.configuration[0]. @ questions);
			alert_mc.visible = false;
			init();

		}

		private function init()
		{
			// COLORIZE OBJECTS

			

			if (("@bg_color1" in currentPageTag.color[0]) && ("@bg_color2" in currentPageTag.color[0]))
			{				
				var colors:Array = [Number(currentPageTag.color[0]. @ bg_color1),Number(currentPageTag.color[0]. @ bg_color2)];
				Colorize.FillRadial(bg_mc,colors);
			}

			Colorize.doColor(title_bar_mc,currentPageTag.color[0].@title_bar);
			Colorize.doColor(alert_mc.bg_mc.bg_mc,currentPageTag.color[0].@title_bar);
			Colorize.doColor(score_bar_mc.base_mc,currentPageTag.color[0].@title_bar);
			Colorize.doColor(popup_mc.bg_mc.bg_mc,currentPageTag.color[0].@title_bar);
			Colorize.doColor(popup_mc.start_btn.base_mc,currentPageTag.color[0].@button);
			Colorize.doColor(submit_btn.base_mc,currentPageTag.color[0].@button);
			Colorize.doColor(give_btn.base_mc,currentPageTag.color[0].@button1);
			Colorize.doColor(spin_mc.spin_btn.base_mc,currentPageTag.color[0].@button2);



			fade_mc.addEventListener(MouseEvent.CLICK,function(e:MouseEvent){doTrace("LOCKED");});


			// POSITIONS AND DIMENSION
			var margin:Number = 15;
			fade_mc.width = presentSizeW;
			fade_mc.height = presentSizeH;
			bg_mc.width = presentSizeW;
			bg_mc.height = presentSizeH;
			title_bar_mc.width = presentSizeW;
			title_txt.width = presentSizeW - 10;
			score_bar_mc.x = title_bar_mc.width - score_bar_mc.width - 20;
			score_bar_mc.y = title_bar_mc.height - 4;
			spin_mc.x = presentSizeW - spin_mc.width - margin;
			spin_mc.y = presentSizeH - spin_mc.height - margin;
			question_mc.x = margin;
			question_mc.title_txt.width = presentSizeW - (presentSizeW - spin_mc.x) - 2 * margin;
			var __x = (question_mc.title_txt.width-question_mc.option0_txt.width)/2;
			question_mc.option0_txt.x = __x;
			question_mc.option0.x = __x - 20;
			question_mc.option1_txt.x = __x;
			question_mc.option1.x = __x - 20;
			question_mc.option2_txt.x = __x;
			question_mc.option2.x = __x - 20;
			question_mc.option3_txt.x = __x;
			question_mc.option3.x = __x - 20;





			give_btn.x = question_mc.width / 2 - give_btn.width / 2 + question_mc.x;
			submit_btn.x = question_mc.width / 2 - submit_btn.width / 2 + question_mc.x;


			// ASSIGN DEFAULT COLOR   TO OVER,OUT
			Events.setColor(currentPageTag.color[0].@button_over,currentPageTag.color[0].@button);




			// DIFFERENT COLORS ON OVER.OUT
			give_btn.color_over = currentPageTag.color[0].@button1_over;
			give_btn.color_out = currentPageTag.color[0].@button1;
			spin_mc.spin_btn.color_over = currentPageTag.color[0]. @ button2_over;
			spin_mc.spin_btn.color_out = currentPageTag.color[0]. @ button2;


			// ASSIGN EVENTS TO BUTTONS
			Events.doEvents(submit_btn,doSubmit);
			Events.doEvents(give_btn,doGive);
			Events.doEvents(spin_mc.spin_btn,doSpin);
			
			


			// LOAD TEXTS											
			
			alert_mc.title_txt.text = "@alert" in currentPageTag.btn[0]?currentPageTag.btn[0]. @ alert:"Spin the wheel to answer another question";															
			popup_mc.title_txt.htmlText = "<b>" + currentPageTag.popInstruct[0]. @ titleInst + "</b>";
			popup_mc.instruction_txt.htmlText = currentPageTag.popInstruct[0];
			popup_mc.start_btn.title_txt.htmlText = "<b>" + currentPageTag.btn[0]. @ continue_btn + "</b>";
			title_txt.htmlText = currentPageTag.instruction[0];
			give_btn.title_txt.htmlText = "<b>" + currentPageTag.btn[0]. @ give_btn + "</b>";
			spin_mc.spin_btn.title_txt.htmlText = "<b>" + currentPageTag.btn[0]. @ spin_btn + "</b>";
			submit_btn.title_txt.htmlText = "<b>" + currentPageTag.btn[0]. @ submit_btn + "</b>";
			score_bar_mc.timer_txt.htmlText = "<b>" + Format.doFormat(0) + "</b>";
			score_bar_mc.score_txt.htmlText = "<b>0 of " + posScore + "</b>";
			score_bar_mc.score_title_txt.htmlText = "<b>" + currentPageTag.text[0]. @ score + "</b>";



			if (popup_mc.instruction_txt.maxScrollV > 1)
			{
				popup_mc.scroll_mc.alpha = 1;
			}
			else
			{
				popup_mc.scroll_mc.alpha = 0;
			}



			if (currentPageTag.configuration[0]. @ points == "" ||  ("@points" in currentPageTag.configuration[0])==false)
			{
				points = 1;
			}
			else
			{
				points = Number(currentPageTag.configuration[0]. @ points);
			}


			fade_mc.alpha = 0;
			popup_mc.x = presentSizeW * 3 / 2;
			popup_mc.y = (presentSizeH - popup_mc.height) / 2;
			TweenMax.to(fade_mc,1,{alpha:1, onComplete:slide_in});


			prepareGame();


		}


		function resize_init()
		{
		
			resize(feedback_mc.img_mc,feedback_mc.ref_mc,false);			
			center(feedback_mc.img_mc,feedback_mc.ref_mc,false);
			

			feedback_mc.border_mc.width = feedback_mc.img_mc.width;
			feedback_mc.border_mc.height = feedback_mc.img_mc.height;
			feedback_mc.maskimg_mc.width = feedback_mc.img_mc.width - 5;
			feedback_mc.maskimg_mc.height = feedback_mc.img_mc.height - 5;			
			center(feedback_mc.border_mc,feedback_mc.ref_mc,false);
			center(feedback_mc.maskimg_mc,feedback_mc.ref_mc,false);


			feedback_mc.img_mc. mask = feedback_mc.maskimg_mc;
			feedback_mc.img_mc.forceSmoothing = true;
			
		}


		function resize(_img, _ref, tween)
		{

			var rate:Number;
			var h_rate = _ref.height / _img.height;
			var w_rate = _ref.width / _img.width;
			if (Math.abs(h_rate) < Math.abs(w_rate))
			{
				/// limit h
				rate = h_rate;
			}
			else
			{
				//limt w
				rate = w_rate;
			}

			var h = rate * _img.height;
			var w = rate * _img.width;
			if (tween)
			{
				TweenMax.to(_img,0.5,{width:w, height:h});
			}
			else
			{
				_img.width = w;
				_img.height = h;
			}
		}

		function center(_img, _ref, tween)
		{
			if (tween)
			{
				var x = Position.getCenterH(_img, _ref, "center");
				var y = Position.getCenterV(_img, _ref, "center");
				TweenMax.to(_img,1,{x:x, y:y});
			}
			else
			{
				_img.x = Position.getCenterH(_img, _ref, "center");
				_img.y = Position.getCenterV(_img, _ref, "center");
			}
		}




		function doSpin(_ref:MovieClip)
		{

			alert_mc.visible = false;
			spin_mc.spin_btn.mouseEnabled = false;
			spin_mc.spin_btn.alpha = 0.5;

			// get a question from objGame, which has not been seen yet.
			var order_category:Array = new Array();
			var order_question:Array = new Array();
			for (var i=0; i<objGame.category.length; i++)
			{								
				order_category.push(i);
				for (var j=0; j<objGame.category[i].question.length; j++)
				{					
					order_question.push(j);
				}
			}

			var m = 500;// avoid a infinite loop
			var out = false;
			while (out==false|| m>0)
			{
				shuffle(order_category);
				shuffle(order_question);
				
				i = order_category[0];
				j = order_question[0];				
				var ob = objGame.category[i].question[j];
				trazar();
				if (ob.seen == false)
				{
					out = true;
					ob.seen = true;
					currentQuestion = ob;
					played.push(ob);
					break;
				}
				m--;
			}


			doTurn(currentQuestion);



		}


		function populateQuestion()
		{

			currentSector = NaN;
			question_mc.visible = true;
			give_btn.visible = true
			;
			submit_btn.visible = true;

			TweenMax.to(question_mc,0.5,{alpha:1});
			TweenMax.to(give_btn,0.5,{alpha:1});
			TweenMax.to(submit_btn,0.5,{alpha:1});
			give_btn.mouseEnabled = true;
			submit_btn.mouseEnabled = true;


			question_mc.title_txt.htmlText = "<b>"+currentPageTag.text[0].@question+" "+(played.length)+"</b><br/>"+currentQuestion.question;

			var i:Number,j:Number;
			for (i=0; i<4; i++)
			{
				question_mc["option" + i].selected = false;
				question_mc["option" + i].visible = false;
				question_mc["option" + i + "_txt"].visible = false;
			}
			for (i=0,j=0; i<currentQuestion.option.length; i++)
			{
				
				
				if (currentQuestion.option[i].text != undefined && currentQuestion.option[i].text !="")
				{					
					question_mc["option" + j].selected = false;					
					question_mc["option" + j].visible = true;
					question_mc["option" + j + "_txt"].visible = true;
					question_mc["option" + j + "_txt"].htmlText = "<b>" + currentQuestion.option[i].text + "</b>";
					j++;
				}
			}

			//SCORM
			currentQuestion.timeStamp = getTimeStamp();
			currentQuestion.dateStamp = getDateStamp();

			doCount(currentQuestion.time_limit);
			countdownInterval = new Timer(step);
			countdownInterval.start();
			countdownInterval.addEventListener(TimerEvent.TIMER, timerHandler);
			countdownInterval.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);

		}


		private function timerHandler(e:TimerEvent):void
		{
			countdown();
		}

		private function completeHandler(e:TimerEvent):void
		{
			doTrace("TIME IS OVER");
		}
		
		function countdown()
		{
			count++;			
			
			if (timer == count)
			{
				score_bar_mc.timer_txt.htmlText = "<b>" + Format.doFormat(0) + "</b>";
				
				


				currentQuestion.seen = false;

				var obj = played.splice(played.length - 1,1);
				obj.seen = false;				
				countdownInterval.stop();
				

				slide_out_give(undefined);
				loadQuestion();
			}
			else
			{
				var rest = timer - count;				
				score_bar_mc.timer_txt.htmlText = "<b>" + Format.doFormat(rest) + "</b>";				
			}
		}



		function trazar()
		{
			return;
		}

		private function doGive(_ref:MovieClip)
		{			
			var limit:Number;

			if ( ("@beforeGiveUp" in currentPageTag.configuration[0]) != false && currentPageTag.configuration[0]. @ beforeGiveUp != "")
			{
				limit = Number(currentPageTag.configuration[0]. @ beforeGiveUp);
			}
			else
			{
				limit = 1;
			}

			if (played.length <= limit)
			{
				// popup Alert
				slide_in_give();
			}
			else
			{				
				countdownInterval.stop();
				var obj = played.splice(played.length - 1,1);				
				obj.seen = false;
				gotoAndStop("answers");
			}

		}


		private function slide_in()
		{
			doTrace("SLIDE IN");

			var __x:Number = (presentSizeW - popup_mc.width) / 2;
			var __y:Number = (presentSizeH - popup_mc.height) / 2;

			TweenMax.to(popup_mc,1,{x:__x, y:__y, onComplete:enable_buttons});
		}
		private function slide_out(_ref:MovieClip)
		{

			// STOP SOUND HERE				
			sndChannel.stop();

			TweenMax.to(fade_mc,1,{alpha:0});
			TweenMax.to(popup_mc,1,{x:presentSizeW*3/2, onComplete:doPlay});
		}


		function enable_buttons()
		{			
			sndChannel = doSound(currentPageTag.@audioPath,snd);						
			popup_mc.start_btn.useHandCursor = true;
			Events.doEvents(popup_mc.start_btn,slide_out);
		}

		function doPlay()
		{			
			fade_mc.visible = false;
			play();
		}


		function slide_in_give()
		{
			feedback_mc.x = presentSizeW * 3 / 2;
			feedback_mc.y = (presentSizeH - feedback_mc.height) / 2;
			feedback_mc.gotoAndStop("no_image");

			Colorize.doColor(feedback_mc.bg_mc.bg_mc,currentPageTag.color[0].@title_bar);
			Colorize.doColor(feedback_mc.continue_btn.base_mc,currentPageTag.color[0].@button);

			feedback_mc.title_txt.htmlText = "<b>" + currentPageTag.givePopup[0]. @ titleInst + "</b>";
			feedback_mc.data_txt.htmlText = currentPageTag.givePopup[0];						

			if (feedback_mc.data_txt.maxScrollV > 1)
			{
				feedback_mc.scroll_mc.alpha = 1;
			}
			else
			{
				feedback_mc.scroll_mc.alpha = 0;
			}

			feedback_mc.continue_btn.title_txt.htmlText = "<b>" + currentPageTag.btn[0]. @ continue_btn + "</b>";
			Events.doEvents(feedback_mc.continue_btn,slide_out_give);

			feedback_mc.visible = true;
			fade_mc.visible = true;
			fade_mc.alpha = 1;
			var __x = (presentSizeW - feedback_mc.width) / 2;
			var __y = (presentSizeH - feedback_mc.height) / 2;
			TweenMax.to(MovieClip(feedback_mc),1,{x:__x, y:__y});


		}

		function slide_out_give(_ref:MovieClip)
		{
			// STOP SOUND HERE			
			FeedSoundChannel.stop();
			TweenMax.to(feedback_mc,1,{x:presentSizeW*3/2, onComplete:doUnlock});
			TweenMax.to(fade_mc,1,{alpha:0});
		}

		function slide_in_feedback()
		{
			fade_mc.visible = true;
			fade_mc.alpha = 1;
			var __x = (presentSizeW - feedback_mc.width) / 2;
			var __y = (presentSizeH - feedback_mc.height) / 2;
			TweenMax.to(feedback_mc,1,{x:__x, y:__y});
		}

		function doUnlock()
		{
			fade_mc.visible = false;
		}


		function slide_out_feedback(_ref:MovieClip)
		{

			trace("SLIDE OUT FEEDBACK");
			// STOP SOUND HERE

			FeedSoundChannel.stop();
			TweenMax.to(feedback_mc,1,{x:presentSizeW*3/2, onComplete:loadQuestion});
			TweenMax.to(fade_mc,1,{alpha:0});
		}


		function doTurn(_obj)
		{
			var angle:Number;
			if (_obj.angle1 == 330)
			{
				angle = getRandom(330,359);
			}
			else
			{
				angle = getRandom(_obj.angle1 + 59,_obj.angle1);
			}

			var turn = [2,3,4];
			shuffle(turn);
			var time_turn = 1;
			var rot = spin_mc.arrow_mc.rotation;
			TweenMax.to(spin_mc.arrow_mc,time_turn*turn[0],{rotation:360*turn[0]+angle,ease:Sine.easeInOut,  onComplete:populateQuestion, onUpdate:paintCircle, onUpdateParams:[this]});
			spin_mc.spin_btn.mouseEnabled = false;
			spin_mc.spin_btn.alpha = 0.5;		
		}

		function getRandom(High,Low)
		{
			var number = Math.floor(Math.random()*(1+High-Low))+Low;			
			return number;
		}

		function paintCircle(_mc)
		{
			var _rot;
			if (_mc.spin_mc.arrow_mc.rotation < 0)
			{
				_rot = 360 + _mc.spin_mc.arrow_mc.rotation;
			}
			else
			{
				_rot = _mc.spin_mc.arrow_mc.rotation;
			}

			var angles = [{init:270},{init:330},{init:30},{init:90},{init:150},{init:210}];
			if (_rot >= 0 && _rot < 30)
			{
				doSector(1);
			}
			if (_rot >= 30 && _rot <= 89)
			{
				doSector(2);
			}
			if (_rot >= 90 && _rot <= 149)
			{
				doSector(3);
			}
			if (_rot >= 150 && _rot <= 209)
			{
				doSector(4);
			}
			if (_rot >= 210 && _rot <= 269)
			{
				doSector(5);
			}
			if (_rot >= 270 && _rot <= 329)
			{
				doSector(0);
			}
			if (_rot >= 330 && _rot <= 359)
			{
				doSector(1);
			}
		}

		function doSector(number)
		{
			if (number != currentSector && number != -1)
			{								
				SpinSoundChannel = doSound(currentPageTag.configuration[0].@spin,SpinSound);								
				currentSector = number;												
			}
			
			


			for (var i=0; i<6; i++)
			{
				if (i == number)
				{
					spin_mc.circle_mc["p" + i].gotoAndStop(2);
				}
				else
				{
					spin_mc.circle_mc["p" + i].gotoAndStop(1);
				}
			}
		}

			
		
		

		//SCORM functions
		//Rapid Intake
		//Functions used for SCORM recording
		
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
				


		function prepareGame()
		{

			doTrace("PREPARE GAME");

			var i:Number,j:Number;
			objGame = new Object();
			objGame.category = new Array();


			doSector(-1);
			
			if (currentPageTag.configuration[0]. @ shuffle_category == "true")
			{
				shuffleXML(currentPageTag.category);
			}
			if (currentPageTag.configuration[0]. @ shuffle_option == "true")
			{
				for (i = 0; i < currentPageTag.category.length(); i++)
				{
					for (j = 0; j < currentPageTag.category[i].question.length(); j++)
					{
						shuffleXML(currentPageTag.category[i].question[j].option);

					}
				}
			}

			

			var numberQuestion = 0;

			var angles = [{init:270},{init:330},{init:30},{init:90},{init:150},{init:210}];

			var categories:Object = new Object();
			categories.question = new Array();
			for (i = 0; i < currentPageTag.category.length(); i++)
			{

				var objectTemp = new Object();
				objectTemp.question = new Array();
				spin_mc.circle_mc["category" + i].htmlText = "<b>" + currentPageTag.category[i]. @ catTitle + "</b>";
				


				var count:Number = 0;
				for (j = 0; j < currentPageTag.category[i].question.length(); j++)
				{


					if (currentPageTag.category[i].question[j].@active != "true" && currentPageTag.category[i].question[j].text[0] != "" && currentPageTag.category[i].question[j].text[0] != undefined && hasOptions(currentPageTag.category[i].question[j]) != false)
					{
						count++;
						numberQuestion++;
						var obj:Object = new Object();
						obj.category = currentPageTag.category[i].@id;

						obj.angle1 = angles[i].init;



						spin_mc.circle_mc["category" + i].htmlText = "<b>" + currentPageTag.category[i]. @ catTitle + "</b>";
						
						obj.question = currentPageTag.category[i].question[j].text[0];
						obj.option = new Array();
						obj.seen = false;
						obj.image = currentPageTag.category[i].question[j].@image;
						obj.audio = currentPageTag.category[i].question[j].@audio;
						obj.position = currentPageTag.category[i].question[j].@position;

						for (var k = 0; k < currentPageTag.category[i].question[j].option.length(); k++)
						{
							var opt:Object = new Object();
							opt.text = currentPageTag.category[i].question[j].option[k];
							opt.selected = false;
							opt.correct = currentPageTag.category[i].question[j].option[k].@correct == "true" ? true:false;
							obj.option.push(opt);
						}

						obj.feedback_text = currentPageTag.category[i].question[j].feedback_text[0];
						obj.time_spent = 0;

						if (currentPageTag.category[i].question[j].@time != "" && ("@time" in currentPageTag.category[i].question[j]) != false)
						{
							obj.time_limit = Number(currentPageTag.category[i].question[j].@time);
						}
						else
						{
							obj.time_limit = -1;
						}
						
						objectTemp.question.push(obj);

					}

				}
				
				
				// The category at least have a question active
				if(count != 0)
				{					
					objGame.category.push(objectTemp)
				}
								

			}



			if (currentPageTag.configuration[0]. @ questions != "" && ("@questions" in currentPageTag.configuration[0]) != false)
			{
				if (numberQuestion < Number(currentPageTag.configuration[0]. @ questions))
				{
					total = numberQuestion;
				}
				else
				{
					total = Number(currentPageTag.configuration[0]. @ questions);
				}
			}
			else
			{
				if (numberQuestion < defaultQuestion)
				{
					total = numberQuestion;
				}
				else
				{
					total = defaultQuestion;
				}
			}



			question_mc.visible = false;
			give_btn.visible = false;
			submit_btn.visible = false;
			question_mc.alpha = 0;
			give_btn.alpha = 0;
			submit_btn.alpha = 0;


		}



		function hasOptions(_question)
		{
			var has = false;
			for (var k = 0; k < _question.option.length(); k++)
			{
				if (_question.option[k] != undefined)
				{
					has = true;
					break;
				}
			}

			return has;
		}


		function loadQuestion()
		{

			trace("LOAD QUESTION");
			fade_mc.visible = false;

			if (played.length >= total)
			{
				gotoAndStop("answers");
			}
			else
			{
				// doSpin
				alert_mc.visible = true;
				alert_mc.alpha = 0;
				alert_mc.x = spin_mc.x;
				alert_mc.y = spin_mc.y;

				TweenMax.to(alert_mc,0.5,{alpha:1, ease:Sine.easeIn});
				spin_mc.spin_btn.mouseEnabled = true;
				spin_mc.spin_btn.alpha = 1;
				fade_mc.visible = false;

				TweenMax.to(question_mc,0.5,{alpha:0, onComplete:lockQuestion});
				TweenMax.to(give_btn,0.5,{alpha:0});
				TweenMax.to(submit_btn,0.5,{alpha:0});
				give_btn.mouseEnabled = false;
				submit_btn.mouseEnabled = false;
			}
		}

		function lockQuestion()
		{
			question_mc.visible = false;
			give_btn.visible = false;
			submit_btn.visible = false;
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

			countdownInterval.stop();
			for (var i=0; i<currentQuestion.option.length; i++)
			{
				if (question_mc["option" + i].selected == true)
				{
										
					
					currentQuestion.option[i].selected = true;
					if (currentQuestion.option[i].correct == true)
					{
						score +=  points;
						score_bar_mc.score_txt.htmlText = "<b>" + score + " of " + posScore + "</b>";
						currentQuestion.correct = true;
					}
				}
			}

			currentQuestion.time_spent = count;

			feedback_mc.visible = true;
					
			if ((currentQuestion.image[0] == "" || currentQuestion.image[0] == undefined))
			{
				feedback_mc.gotoAndStop("no_image");
			}
			else
			{								
							
				feedback_mc.gotoAndStop(currentQuestion.position[0]);

				
				

				feedback_mc.ref_mc.visible = false;
				loaderImg = new Loader();
				loaderImg.load(new URLRequest(currentQuestion.image[0]));				
				loaderImg.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);				
				
				
				
				feedback_mc.img_mc.visible = true;
				feedback_mc.border_mc.visible = true;
				feedback_mc.maskimg_mc.visible = true;
			}

		
			if (currentQuestion.audio[0] != "" && currentQuestion.audio[0] != undefined)
			{								
				FeedSoundChannel.stop();			
				FeedSoundChannel = doSound(currentQuestion.audio[0],FeedSound);
			}
			
	

			
			feedback_mc.x = presentSizeW * 3 / 2;
			feedback_mc.y = (presentSizeH - feedback_mc.height) / 2;

			Colorize.doColor(feedback_mc.bg_mc.bg_mc,currentPageTag.color[0].@title_bar);
			Colorize.doColor(feedback_mc.continue_btn.base_mc,currentPageTag.color[0].@button);

			feedback_mc.title_txt.htmlText = "<b>" + currentPageTag.text[0]. @ feedback_title + "</b>";
			feedback_mc.data_txt.htmlText = currentQuestion.feedback_text;

			if (feedback_mc.data_txt.maxScrollV > 1)
			{
				feedback_mc.scroll_mc.alpha = 1;
			}
			else
			{
				feedback_mc.scroll_mc.alpha = 0;
			}

			feedback_mc.continue_btn.title_txt.htmlText = "<b>" + currentPageTag.btn[0]. @ continue_btn + "</b>";
			Events.doEvents(feedback_mc.continue_btn,slide_out_feedback);

			slide_in_feedback();
		}


		private function imageLoaded(e:Event)
		{			
			if(feedback_mc.img_mc.numChildren>0)
				feedback_mc.img_mc.removeChildAt(0);
				
			feedback_mc.img_mc.addChild(loaderImg);			
			resize_init();
		}



		//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		// CODE FOR FRAME3
		//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		private function addFrame3()
		{
			stop();
			trace(":: FRAME 3");
			feedback_mc.visible = false;
		}



		//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		// CODE FOR FRAME4
		//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		private function addFrame4()
		{
			stop();
			trace(":: FRAME 4");
			currentIndex = -1;


			// COLOR
			Colorize.doColor(title_bar_mc,currentPageTag.color[0].@title_bar);			
			Colorize.doColor(score_bar_mc.base_mc,currentPageTag.color[0].@title_bar);


			// POSITIONS AND DIMENSION
			margin = 15;

			title_bar_mc.width = presentSizeW;
			score_bar_mc.x = presentSizeW-score_bar_mc.width*2;			
			your_answer_mc.x = ((presentSizeW/2)-your_answer_mc.width)/2;
			correct_answer_mc.x = ((presentSizeW/2)-your_answer_mc.width)/2+presentSizeW/2;
			separator_mc.base_mc.width = presentSizeW;

			separator_mc.time_title.x = presentSizeW - separator_mc.time_title.width - margin;
			separator_mc.bar_mc.x = separator_mc.time_title.x - margin;
			separator_mc.time_txt.x = separator_mc.time_title.width / 2 - separator_mc.time_txt.width / 2 + separator_mc.time_title.x;
			separator_mc.title_txt.width = (presentSizeW-(presentSizeW-separator_mc.bar_mc.x))-2.5*margin;
			separator_mc.title_txt.x = margin;
			review_btn.x = presentSizeW - review_btn.width - margin;
			review_btn.y = presentSizeH - review_btn.height - margin;
			question_txt.width = presentSizeW - 30;

			score_bar_mc.x = title_bar_mc.width - score_bar_mc.width - 20;
			score_bar_mc.y = title_bar_mc.height - 4;
			score_bar_mc.score_txt.htmlText = "<b>" + score + " of " + posScore + "</b>";
			score_bar_mc.score_title_txt.htmlText = "<b>"+currentPageTag.text[0].@final_score+"</b>"						
			title_txt.text = currentPageTag.text[0]. @ feedback_title;			
			


			Colorize.doColor(review_btn.base_mc,currentPageTag.color[0].@button);
			Events.doEvents(review_btn,showAnswer);
			review_btn.title_txt.htmlText = currentPageTag.btn[0]. @ review_btn;
			showAnswer(undefined);



			// API
			recordInteraction();


		}

		function showAnswer(_ref:MovieClip)
		{

			var i:Number, j:Number;
			currentIndex++;
			if (currentIndex >= played.length)
			{
				currentIndex = 0;
			}

			progress_txt.text = progress.split("[total]").join(played.length);
			progress_txt.htmlText= "<b>"+progress_txt.text.split("[current]").join((currentIndex+1))+"</b>";
		

			for (i=0; i<4; i++)
			{
				your_answer_mc["option" + i].mouseEnabled = false;
				correct_answer_mc["option" + i].mouseEnabled = false;

				your_answer_mc["option" + i].visible = false;
				correct_answer_mc["option" + i].visible = false;
				your_answer_mc["option" + i + "_txt"].visible = false;
				correct_answer_mc["option" + i + "_txt"].visible = false;
			}

			your_answer_mc.title_txt.text = currentPageTag.text[0]. @ your_answer;
			correct_answer_mc.title_txt.text = currentPageTag.text[0]. @ correct_answer;
			separator_mc.title_txt.htmlText = played[currentIndex].feedback_text;
			separator_mc.time_title.htmlText = currentPageTag.text[0]. @ time_spent;
			separator_mc.time_txt.htmlText = Format.doFormat(played[currentIndex].time_spent);



			if (separator_mc.title_txt.maxScrollV > 1)
			{
				separator_mc.scroll_mc.alpha = 1;
			}
			else
			{
				separator_mc.scroll_mc.alpha = 0;
			}

			separator_mc.scroll_mc.x = separator_mc.title_txt.x + separator_mc.title_txt.width;

			question_txt.htmlText = played[currentIndex].question;
			for (i=0, j=0; i<played[currentIndex].option.length; i++)
			{

				if (played[currentIndex].option[i].text != undefined)
				{
					your_answer_mc["option" + j + "_txt"].visible = true;
					correct_answer_mc["option" + j + "_txt"].visible = true;

					your_answer_mc["option" + j].visible = true;					
					your_answer_mc["option" + j + "_txt"].text = played[currentIndex].option[i].text;

					correct_answer_mc["option" + j].visible = true;					
					correct_answer_mc["option" + j + "_txt"].text = played[currentIndex].option[i].text;


					if (played[currentIndex].option[i].selected == true)
					{						
						your_answer_mc["option" + j].selected = true;																								
					}
					else
					{
						your_answer_mc["option" + j].selected = false;
					}


					if (played[currentIndex].option[i].correct == true)
					{
						correct_answer_mc["option" + j].selected = true;
					}
					else
					{
						correct_answer_mc["option" + j].selected = false;
					}
					j++;
				}
			}
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
		
		
		
		private function recordInteraction()
		{
			
			trace("A")
			if("@trackInteraction" in currentPageTag != false)
			{
				if (currentPageTag.@trackInteraction.toLowerCase() == "true")
				{
					trace("A2")
					var isAvailable:Boolean = ExternalInterface.available;
				
					if (isAvailable)
					{
						trace("A3")
						intCnt = ExternalInterface.call("SCOGetValue","cmi.interactions._count");
						intStr = "cmi.interactions." + intCnt + ".";
					}
					trace("B")
					intID = new Timer(250);
					intID.start();
					intID.addEventListener(TimerEvent.TIMER, timerHandlerData);
					intID.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandlerData);												
				}
			}
			trace("C")
		
			if("@recordScore" in currentPageTag != false)
			{
				if (currentPageTag.@recordScore.toLowerCase() == "true")
				{
					trace("D")
					var sResult:Number = (Math.round((score/posScore * 10000000)))/10000000;
					trace(0 + " - " + posScore + " - " + score + " - " + sResult);																
					trace("E")
					courseModel.lmsLink.apiSetScore(0,posScore,score,String(sResult));
				}
			}
		}
		
		private function timerHandlerData(e:TimerEvent):void
		{
			sendData();
		}

		private function completeHandlerData(e:TimerEvent):void
		{
			doTrace("TIME IS OVER");
		}
		
		
		function sendData()
		{
			var description;
			var sData;
			if (objCnt < played.length)
			{
				if (objCnt > 0)
				{
					if (courseModel.courseAttributes.tracking == "SCORM1.3")
					{
						description = played[objCnt-1].question;
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
				
				if (played[objCnt].time_spent == undefined)
					played[objCnt].time_spent = 0;
				
				var sTime:String = getLatency(played[objCnt].time_spent);												
				//trace(sTime);
				var sId:String = currentPageTag.@interactionID + objCnt;
				var sWeight:Number = currentPageTag.configuration[0].@points;												
				var sResult;
				
				if (played[objCnt].correct)
				{
					sResult = "C";
				}
				else
				{
					sResult = "W";
				}						
				var sType:String = "choice";
				
				var sResponse:String = escape(getLearnerResponse());
				//trace("sResponse " + sResponse);
				var sCorrect:String = escape(getCorrectResponse());
				
				var timeStamp:String = played[objCnt].timeStamp;
				
				var dateStamp:String = played[objCnt].dateStamp;

		
				//trace (timeStamp + "-" + dateStamp);
				//trace("sCorrect " + sCorrect);
				//playerMain_mc.apiSetInteraction(sId,sType,sResponse,sCorrect,sResult,sWeight,sTime);
		
						
				var intData = dateStamp+";"+timeStamp+";"+sId+";"+""+";"+sType+";"+sCorrect+";"+sResponse+";"+sResult+";"+sWeight+";"+sTime;				
				trace(intData);	
				var errmsg = ExternalInterface.call("MM_cmiSendInteractionInfo", intData);
		
				objCnt++;
		
			}
			else
			{										
				intID.stop();
				if (courseModel.courseAttributes.tracking == "SCORM1.3")
				{
					description = played[objCnt-1].question;
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
		
		function getLearnerResponse()
		{
			trace("DEBUG:: Length "+played[objCnt].option.length)
			for(var i=0;i<played[objCnt].option.length;i++)
			{
				if( played[objCnt].option[i].selected == true)
				{
					trace("DEBUG:: Option: "+played[objCnt].option[i].text)
					return played[objCnt].option[i].text;
				}
			}
			return "";
		}
		
		function getCorrectResponse()
		{
			for(var i=0;i<played[objCnt].option.length;i++)
			{
				if( played[objCnt].option[i].correct == true)
				{
					return 	played[objCnt].option[i].text;						
				}
			}
			
			return "";
		}


	}

}
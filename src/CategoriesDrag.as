package src.pages
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.*;
	
	import src.pages.DynamicPageAPI;
	import src.pages.utils.*;
	import src.pages.utils.drag_drop.*;




	public class CategoriesDrag extends DynamicPageAPI
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
		
		
		
		// MovieClip
		private var hasTimer:Boolean;
		private var timerVal:Number;
		
		
		
		
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




		////////////// Categories Game
		
		private var tot_poss_cat:Number = 4;
		private var max_by_cat:Number = 8;
		private var active_cat:Array;
	
		private var item:Array = new Array(); // Save the duplicate clips (drags in screen)		
		private var drag_item;// item being dragged				
		private var terms:Array = new Array(); // Object with all 24 terms, and its id (intercation battery questions)


		public function CategoriesDrag()
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
			init();

		}
		
		

		//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		// CODE FOR FRAME3
		//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		private function addFrame3()
		{
			stop();
			trace(":: FRAME 3");			
		}
		
		
		
		//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		// CODE FOR FRAME4
		//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		private function addFrame4()
		{
			stop();
			trace(":: FRAME 4");			
		}
		
		

		private function init()
		{
			// COLORS
	
			if (("@bg_color1" in currentPageTag.color[0]) && ("@bg_color2" in currentPageTag.color[0]))
			{				
				var colors:Array = [Number(currentPageTag.color[0]. @ bg_color1),Number(currentPageTag.color[0]. @ bg_color2)];
				Colorize.FillRadial(bg_mc,colors);
			}
		
			if (("@drag_color1" in currentPageTag.color[0]) && ("@drag_color2" in currentPageTag.color[0]))
			{				
				var colors:Array = [Number(currentPageTag.color[0]. @ drag_color1),Number(currentPageTag.color[0]. @ drag_color2)];
				Colorize.FillLinear(item_btn.bg_mc,colors);
			}
		
			Colorize.doColor(title_bar_mc,currentPageTag.color[0].@title_bar);
			Colorize.doColor(timer_mc.base_mc,currentPageTag.color[0].@title_bar);
			Colorize.doColor(popup_mc.bg_mc.bg_mc,currentPageTag.color[0].@title_bar);
			Colorize.doColor(popup_mc.start_btn.base_mc,currentPageTag.color[0].@button);
			Colorize.doColor(restart_btn.base_mc,currentPageTag.color[0].@button);
			Colorize.doColor(showAnswers_btn.base_mc,currentPageTag.color[0].@ShowAnswerButton);

		
		
		
			// POSITIONS AND DIMENSION
		
			fade_mc.width = presentSizeW;
			fade_mc.height = presentSizeH;
			bg_mc.width = presentSizeW;
			bg_mc.height = presentSizeH;			
			title_bar_mc.width = presentSizeW;
			title_txt.width = presentSizeW - 10;
			timer_mc.x = title_bar_mc.width - timer_mc.width - 20;
			timer_mc.y = title_bar_mc.height - 4;
			instructions_txt.width = presentSizeW - timer_mc.width - 40;		
			item_btn.x = presentSizeW / 2 - item_btn.width / 2;
			
			
		
			popup_mc.title_txt.text = currentPageTag.popInstruct[0].@titleInst;
			popup_mc.instruction_txt.htmlText = currentPageTag.popInstruct[0].text();
			popup_mc.start_btn.title_txt.text = currentPageTag.popInstruct[0].@startBTNTitle;
			title_txt.htmlText = currentPageTag.@title;
			instructions_txt.text = currentPageTag.gameInstruct[0].text();
		
			showAnswers_btn.title_txt.text = currentPageTag.@showAnswers_btn;
			restart_btn.title_txt.text = currentPageTag.@restart_btn;
		
		
			hasTimer = (currentPageTag.@hasTimer.toLowerCase() == "true");
			timerVal = Number(currentPageTag.@valueTime);
			
			if(hasTimer==true && timerVal<=0)
				hasTimer = false;
						
		
			active_cat = getActiveCat();
		
			if (hasTimer)
			{				
				timer_mc.timer_txt.text = Format.doFormat(timerVal);
			}
			else
			{
				timer_mc.visible = false;
			}
		
			for (var i = 0; i < tot_poss_cat; i++)
			{
				this["category" + i].visible = false;				
				Colorize.doColor(this["category" + i].base_mc,currentPageTag.color[0]["category" + (i + 1)]);
			}
		
			// RESET on RESTART
			DropList.getInstance().clear();
		
				
			
			var width = 0;			
			for (var i = 0; i < active_cat.length; i++)
			{
				width += this["category" + i].width; 
				this["category" + i].id = currentPageTag.game[0].category[active_cat[i]].@id;
				var drop = new DropItem(this["category" + i], max_by_cat);
				DropList.getInstance().addItem(drop);				
				this["category" + i].visible = true;
				this["category" + i].title_txt.text = currentPageTag.game[0].category[active_cat[i]].@text;
								
			}
								
			var center_w = presentSizeW / 2 - width / 2;
					
			var distance = (Math.abs(presentSizeW - width)) / (active_cat.length + 1);
			var pos = distance;
			var w_col = 0;			
			for (var i = 0; i < active_cat.length; i++)
			{
				this["category" + i].x = pos;
				pos += this["category" + i].width + distance;
				w_col = this["category" + i].width;
			}				
		
		
			// MORE POSITION BASED ON COLUMNS
		
			restart_btn.x = presentSizeW - restart_btn.width - distance;
			showAnswers_btn.x = restart_btn.x - showAnswers_btn.width - 20;
		
		
			doTrace(" centwr_w" + center_w + " w " + width + " PW " + presentSizeW + " PH " + presentSizeH + "  -- " + pos + " " + w_col + " " + restart_btn.width);			
		
			fade_mc.alpha = 0;
			popup_mc.x = presentSizeW*2;
			popup_mc.y = (presentSizeH - popup_mc.height) / 2;
			TweenMax.to(fade_mc,1,{alpha:1, onComplete:slide_in});
		}


	
		private function getActiveCat()
		{
			var arr = new Array();
			var count = 0;
			for (var i = 0; i < currentPageTag.game[0].category.length(); i++)
			{								
				if(hasQuestion(currentPageTag.game[0].category[i])&&currentPageTag.game[0].category[i].@active != "true")
				{
					trace("PUSH "+i)
					arr.push(i);
					
				}
			}
			return arr;
		}
		
		private function hasQuestion(_cat)
		{
			var has = false;
			for(var i=0;i<_cat.term.length();i++)
			{
				
					trace(" --> "+_cat.term[i].text());
					trace(" ***** [DEUBG ] _cat.term[i].text : "+_cat.term[i].text)
					if(_cat.term[i].text()!="" &&_cat.term[i].text()!=undefined )
					{
						return true;
					}
				
			}
				return false;
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
		
		
		
		
		
		

///////////////////// END




		
/*

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
		
		
		
		
		
		
		
		private function recordInteraction()
		{
						
			if("@trackInteraction" in currentPageTag != false)
			{
				if (currentPageTag.@trackInteraction.toLowerCase() == "true")
				{					
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
					//var sResult:Number = (Math.round((score/total * 10000000)))/10000000;
					trace(0 + " - " + total + " - " + score);																
					//courseModel.lmsLink.apiSetScore(0,total,score,String(sResult));
					courseModel.lmsLink.apiSendScoreData(score,total,0)
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
			var description:String;
			var sData;
			if (objCnt < played.length)
			{
				trace("objCnt "+objCnt)
				if (objCnt > 0)
				{
					description = played[objCnt-1].question;
				}
				
				if (played[objCnt].time_spent == undefined)
				{
					played[objCnt].time_spent = 0;
				}
										
				var sTime:uint = played[objCnt].time_spent;				
				//trace(sTime);
				var sId:String = currentPageTag.@interactionID + objCnt;				
				var sWeight:Number = currentPageTag.configuration[0].@points;												
								
				var sResult:String;
				var correct:Boolean;				
				if (played[objCnt].correct)
				{
					sResult = "C";
					correct = true;
				}
				else
				{
					sResult = "W";
					correct = false;
				}						
				var sType:String = "choice";
				
				var sResponse:String = getLearnerResponse();
				//trace("sResponse " + sResponse);
				var sCorrect:String = getCorrectResponse();
				
				var timeStamp:String = played[objCnt].timeStamp;
				
				var dateStamp:String = played[objCnt].dateStamp;
				
				//trace (timeStamp + "-" + dateStamp);
				//trace("sCorrect " + sCorrect);
				//playerMain_mc.apiSetInteraction(sId,sType,sResponse,sCorrect,sResult,sWeight,sTime);
								
				var intData = dateStamp+";"+timeStamp+";"+sId+";"+""+";"+sType+";"+sCorrect+";"+sResponse+";"+sResult+";"+sWeight+";"+sTime;				
				//trace("INT DATA: " + intData);		
				//No need to arrange content before submitting, so call the simple method
				var emsg:String = courseModel.lmsLink.apiSendMultipleChoiceData(sId,sResponse,correct,sCorrect,description,sWeight,sTime,"");		
				
				objCnt++;
			}
			else
			{										
				intID.stop();				
				courseModel.lmsLink.apiSendCommit();
				
			}
		}
		
		
		function getLearnerResponse()
		{
			trace("DEBUG:: Length "+played[objCnt].option.length)
			for(var i=0;i<played[objCnt].option.length;i++)
			{
				if( played[objCnt].option[i].selected == true)
				{
					trace("DEBUG:: Option: "+played[objCnt].option[i].text)
					return i + "^" + played[objCnt].option[i].text;
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
					return 	i + "^" + played[objCnt].option[i].text;						
				}
			}
			
			return "";
		}
		*/


	}

}
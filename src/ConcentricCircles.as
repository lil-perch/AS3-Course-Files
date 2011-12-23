package src.pages
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import com.greensock.events.*;
	import com.greensock.loading.*;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.ui.*;
	import flash.utils.*;
	
	import rapid.circles.*;
	
	
	import src.pages.DynamicPageAPI;
	import src.pages.utils.*;

	public class ConcentricCircles extends DynamicPageAPI
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




		//  Concentric Circles
		
		private var _initArray :Array = new Array();		
		private var scaleTo:Number = 1.07;
		private var _curCircle:Number = -1;
		var imgLoader:LoaderMax;


		public function ConcentricCircles()
		{
			super();
			TweenPlugin.activate([TintPlugin]);
			
			//loadPage();
			

		}





		override public function loadPage():void
		{
			trace("LOAD PAGE WOIRD")
			
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";

			// for loading pictures
			imgLoader = new LoaderMax( {name:"loader", onComplete:onImageLoad, onError:imageError} );

			addFrameScript(0, addFrame1);
			addFrameScript(1, addFrame2);
			//addFrameScript(2, addFrame3);
			//addFrameScript(3, addFrame4);

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
			
															
			//Interaction Title			
			//var introTitle :String = currentPageTag.intro.@introTitle;			
			//Intro Text Content		
			//var introText :String = currentPageTag.intro.text()						
			
			
			/* 
			//Resizing background
			main_mc.bg_mc._width = playerMain_mc.presentSizeW;
			main_mc.bg_mc._height = playerMain_mc.presentSizeH;
			//Resizing the fader
			main_mc.black_mc._width = playerMain_mc.presentSizeW;
			main_mc.black_mc._height = playerMain_mc.presentSizeH;
			//Resizing stage2
			*/
			
			///////Variables for the array to use///////////												
			runServer();
			
		}

		function addFrame2()
		{
				stop();
				
				var colors;
				
				intro_mc.x = presentSizeW / 2 - intro_mc.width / 2;
				intro_mc.y = presentSizeH / 2 - intro_mc.height / 2;
				black_mc.width = presentSizeW;
				black_mc.height = presentSizeH;
				
				bg_mc.width = presentSizeW;
				bg_mc.height = presentSizeH;
				bg_mc2.width = presentSizeW;
				bg_mc2.height = presentSizeH;

								
				var cir1title :String = currentPageTag.cir1.@label;								
				var cir1Msg :String = currentPageTag.cir1.text();								
				var cir1Img :String = currentPageTag.cir1.@img;
				
				var cir2title :String = currentPageTag.cir2.@label;								
				var cir2Msg :String = currentPageTag.cir2.text();								
				var cir2Img :String = currentPageTag.cir2.@img;
				
				var cir3title :String = currentPageTag.cir3.@label;								
				var cir3Msg :String = currentPageTag.cir3.text();								
				var cir3Img :String = currentPageTag.cir3.@img;
				
				var cir4title :String = currentPageTag.cir4.@label;								
				var cir4Msg :String = currentPageTag.cir4.text();								
				var cir4Img :String = currentPageTag.cir4.@img;
				
				var cir5title :String = currentPageTag.cir5.@label;								
				var cir5Msg :String = currentPageTag.cir5.text();								
				var cir5Img :String = currentPageTag.cir5.@img;				

				_initArray = [
					{title: cir1title, msg: cir1Msg, img: cir1Img},
					{title: cir2title, msg: cir2Msg, img: cir2Img},
					{title: cir3title, msg: cir3Msg, img: cir3Img},
					{title: cir4title, msg: cir4Msg, img: cir4Img},
					{title: cir5title, msg: cir5Msg, img: cir5Img}
					];



				// COLORS
				if (("@bg_color1" in currentPageTag.color[0]) && ("@bg_color2" in currentPageTag.color[0]))
				{
					colors = [Number(currentPageTag.color[0]. @ bg_color1),Number(currentPageTag.color[0]. @ bg_color2)];
					Colorize.FillRadial(bg_mc,colors);
				}
												
				intro_mc.alpha = 0;
				intro_mc.visible = true;
				TweenMax.to(intro_mc,2,{alpha:1, ease:Strong.easeOut});	
				black_mc.visible = false;																
				
				
				intro_mc["header_txt"].text = currentPageTag.intro.@introTitle;
				intro_mc["message_txt"].message_txt.htmlText = currentPageTag.intro.text();
				
	
				intro_mc.start_btn.title_txt.text = currentPageTag.start_btn.text();						
				Colorize.doColor(intro_mc.bg_mc.bg_mc,currentPageTag.color[0].@title_bar);
				Events.setColor(currentPageTag.color[0].@button_over,currentPageTag.color[0].@button);
				Events.doEvents(intro_mc.start_btn,closeIntro);
				
		}
		
		
		private function closeIntro(_ref:MovieClip)
		{
			
			TweenMax.to(intro_mc,1,{autoAlpha:0, ease:Strong.easeOut, onComplete:goStage2});			
			trace("NEXT")
		}
		
		private function goStage2()
		{
			gotoAndStop("stage2");
			
			
			stage2_mc.lock_mc.width = presentSizeW;
			stage2_mc.lock_mc.height = presentSizeH;
			stage2_mc.frame_mc.x = presentSizeW - stage2_mc.frame_mc.width - 10;		
			stage2_mc.lock_mc.visible = false;			 
			stage2_mc.lock_mc.addEventListener(MouseEvent.CLICK,locked);						
			stage2_mc.frame_mc.visible = false;				
			initCircles();
		}
		
		private function locked(event:MouseEvent)
		{
			trace("LOCKED");
		}
		
		private function initCircles()
		{			
			
	
			for (var num:Number = 0; num < 5; num++)
			{
				var circle = stage2_mc["circle_" + String(num)];
	
				if( (_initArray[num].title == "" || _initArray[num].title == undefined )&&( _initArray[num].img == "" || _initArray[num].img == undefined))
				{
					circle.visible = false;
					continue;
				}				
				
				var append = "@circle" + (num + 1);
				Colorize.doColor(circle.bg_mc,currentPageTag.color[0][append]);
				Colorize.doColor(circle.bg_mc2,currentPageTag.color[0][append]);								
	
				circle.title_txt.text = _initArray[num].title;
					
				circle.addEventListener(MouseEvent.ROLL_OVER,circleOver);
				circle.addEventListener(MouseEvent.ROLL_OUT,circleOut);
				circle.addEventListener(MouseEvent.CLICK,circleClick);
				
			}
		}
		
		private function circleOver(event:MouseEvent)
		{
			TweenMax.to(event.currentTarget,0.2,{scaleX:scaleTo, scaleY:scaleTo, ease:Strong.easeIn});
		}
		
		private function circleOut(event:MouseEvent)
		{
			TweenMax.to(event.currentTarget,0.2,{scaleX:1, scaleY:1, ease:Strong.easeIn});
		}
		
		private function circleClick(event:MouseEvent)
		{
			initCircleClick(event.currentTarget as MovieClip)
		}
		
		
		private function initCircleClick(circle:MovieClip)
		{
			var circleNum:Number = 0;
	
			for (var num:Number = 0; num < 5; num++)
			{
				if (stage2_mc["circle_" + String(num)] == circle)
				{
					circleNum = num;
					break;
				}
			}
	
			if (_curCircle == circleNum)
			{
				return;
			}
						
			
			_curCircle = circleNum;
				
			stage2_mc.frame_mc.message_txt.message_txt.htmlText = _initArray[circleNum].msg;
			stage2_mc.frame_mc.arrow_mc.gotoAndStop(circleNum + 1);
						
			loadImage(_initArray[circleNum].img);				
	
			stage2_mc.frame_mc.visible = true;
	
			//if there is no image - make text bigger									
			if (_initArray[circleNum].img == "" || _initArray[circleNum].img == undefined )
			{																
				stage2_mc.frame_mc.picture_mask_mc.visible = false;				
				var val = stage2_mc.frame_mc.picture_mask_mc.y + stage2_mc.frame_mc.picture_mask_mc.height - 5
				stage2_mc.frame_mc.message_txt.scroll_mc.height = val;
				stage2_mc.frame_mc.message_txt.message_txt.height = val;				
				stage2_mc.frame_mc.message_txt.scroll_mc.invalidate();			
			
			}
			else
			{				
				stage2_mc.frame_mc.picture_mask_mc.visible = true;								
				val = stage2_mc.frame_mc.picture_mask_mc.y - 10
				stage2_mc.frame_mc.message_txt.scroll_mc.height = val;
				stage2_mc.frame_mc.message_txt.message_txt.height = val;				
				stage2_mc.frame_mc.message_txt.scroll_mc.invalidate();	
			}
			

			if (stage2_mc.frame_mc.message_txt.message_txt.textHeight >stage2_mc.frame_mc.message_txt.message_txt.height)
			{
				stage2_mc.frame_mc.message_txt.scroll_mc.alpha = 1;			
			}
			else
			{
				stage2_mc.frame_mc.message_txt.scroll_mc.alpha  = 0;			
			}			
			
			stage2_mc.frame_mc.message_txt.scroll_mc.invalidate();
		}		
		
		
		private function loadImage(url:String)
		{					
			var w_max = stage2_mc.frame_mc.picture_mask_mc.back_mc.width;
			var h_max = stage2_mc.frame_mc.picture_mask_mc.back_mc.height;
									
			if(imgLoader.getLoader("photo1"))
			{				
				imgLoader.empty(true,true);
			}
			
			trace("URL:: "+url)
			if(url!= "" && url != null)
			{
				var myloader  = new ImageLoader(url, {name:"photo1", container:stage2_mc.frame_mc.picture_mask_mc.holder_mc, width:w_max, height:h_max, scaleMode:"proportionalInside"});						
				imgLoader.append(myloader);
				
				//begin loading
				imgLoader.load();
				
				
				
			}
			
			
			
			
			
		}
	
		private function imageError(event:LoaderEvent)
		{
			
			stage2_mc.frame_mc.picture_mask_mc.visible = false;
			var val = stage2_mc.frame_mc.picture_mask_mc.y + stage2_mc.frame_mc.picture_mask_mc.height - 5			
			stage2_mc.frame_mc.message_txt.scroll_mc.height = val;
			stage2_mc.frame_mc.message_txt.message_txt.height = val;						
			stage2_mc.frame_mc.message_txt.scroll_mc.invalidate();			
			
			trace("ERRROE IMAGE "+val);			
		}
		
		private function onImageLoad(event:LoaderEvent)		
		{
				trace("IMAGE LOADED "+stage2_mc.frame_mc.picture_mask_mc.holder_mc.x)									
				
				stage2_mc.frame_mc.picture_mask_mc._imgObj.x = stage2_mc.frame_mc.picture_mask_mc.holder_mc.x;
				stage2_mc.frame_mc.picture_mask_mc._imgObj.y = stage2_mc.frame_mc.picture_mask_mc.holder_mc.y;
				stage2_mc.frame_mc.picture_mask_mc._imgObj.width = stage2_mc.frame_mc.picture_mask_mc.holder_mc.width;
				stage2_mc.frame_mc.picture_mask_mc._imgObj.height = stage2_mc.frame_mc.picture_mask_mc.holder_mc.height;				
				
				stage2_mc.frame_mc.picture_mask_mc.init(presentSizeW,presentSizeH,-stage2_mc.frame_mc.picture_mask_mc.x - stage2_mc.frame_mc.x,-stage2_mc.frame_mc.picture_mask_mc.y - stage2_mc.frame_mc.y);
		}
		
		
		
		
	
		function doTrace(_str:String)
		{
			
			trace("Str: "+_str);
			
		}



/*


MovieClip.prototype.FillRadial = function(colors)
{
	
	
	fillType = "radial" ;

	alphas = [100, 100];
	ratios = [0, 255];
	w = this._width+100;
	h = this._height+100;
	matrix = {matrixType:"box", x:-w / 2, y:-h / 2, w:w * 2, h:h * 2, r:0 / 180 * Math.PI};
	this.lineStyle(0,0x000000,0);
	this.beginGradientFill(fillType,colors,alphas,ratios,matrix);
	this.moveTo(0,0);
	this.lineTo(w,0);
	this.lineTo(w,h);
	this.lineTo(0,h);
	this.lineTo(0,0);
	this.endFill();
};


MovieClip.prototype.FillLinear = function(colors, _rot)
{
	if (_rot == undefined)
	{
		_rot = 0;
	}

	fillType = "linear";

	alphas = [100, 100];
	ratios = [0, 255];
	w = this._width;
	h = this._height;
	matrix = {matrixType:"box", x:-w / 2, y:-h / 2, w:w * 2, h:h * 2, r:_rot / 180 * Math.PI};
	this.lineStyle(0,0x000000,0);
	this.beginGradientFill(fillType,colors,alphas,ratios,matrix);
	this.moveTo(0,0);
	this.lineTo(w,0);
	this.lineTo(w,h);
	this.lineTo(0,h);
	this.lineTo(0,0);
	this.endFill();
};


*/
























  		/* CODE FROM THE OWRDGAME WORKING*/
/*
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
			stage.focus = input_mc.input_txt;						
			play();
			
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
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
			

		}
		
		function onAdded(e:Event)
		{			
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
			var description:String;
			var sData;
			if (objCnt < objGame.length)
			{
				/*if (objCnt > 0)
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
				// -----> FIN * /
				
								
				if (objCnt > 0)
				{
					description = objGame[objCnt - 1].descript;
				}
																														
				if (objGame[objCnt].latency == undefined)
				{
					objGame[objCnt].latency = 0;
				}
				var sTime:uint = objGame[objCnt].latency;
				//trace(sTime);
				var sId:String = currentPageTag.@interactionID + objCnt;
				var sWeight:Number = objGame[objCnt].point;
				
				var sResult:String;
				var correct:Boolean;
				if (objGame[objCnt].guess)
				{
					sResult = "C";
					correct = true;
				}
				else
				{
					sResult = "W";
					correct = false;
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
				var emsg:String = courseModel.lmsLink.apiSendFillInBlankData(sId,sResponse,correct,sCorrect,description,sWeight,sTime,"");
					
					//ExternalInterface.call("MM_cmiSendInteractionInfo", intData);		
				objCnt++;		
			}
			else
			{							
				intID.stop();
				/*if (courseModel.courseAttributes.tracking == "SCORM1.3")
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
				
				
				---> FIN * /			
				courseModel.lmsLink.apiSendCommit();
				
			}
		}
		
					
		function recordInteraction()
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
		*/
		
	}

}
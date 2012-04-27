package src.pages
{
	// GREENSOCK CLASSES
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import com.greensock.events.*;
	import com.greensock.loading.*;
	
	
	// FLASH CLASSES
	import flash.display.*;
	import flash.events.*;	
	import flash.ui.*;
	import flash.utils.*;
	import flash.external.ExternalInterface;	
					
	
	// CUSTOM CLASSES
	import src.pages.DynamicPageAPI;
	import src.pages.utils.*;

	public class Survey extends DynamicPageAPI
	{

		// SCORM
		private var intCnt;
		private var intStr:String;
		private var intID:Timer;  //setInterval for recording data.
		private var objCnt:Number = 0;

		
		// Size
		public  var presentSizeH:Number;
		public  var presentSizeW:Number;				
	

		public function Survey()
		{
			super();
			TweenPlugin.activate([TintPlugin]);
		}

		override public function loadPage():void
		{						
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
			addFrameScript(0, addFrame1);
			addFrameScript(1, addFrame2);
		}

		private function runServer()
		{
			presentSizeH = settingsModel.settings.presentSizeH;
			presentSizeW = settingsModel.settings.presentSizeW;						
			play();
		}

		//================================================
		//  Add the code for frame1
		// ===============================================		
		function addFrame1()
		{
			stop();									
			runServer();
		}


		//================================================
		//  Add the code for frame2
		// ===============================================		
		function addFrame2()
		{
			stop();					
			initStage1();								
		}

				
		//================================================
		//  Hide All the Elements from the Stage
		// ===============================================		
		public function hideAll() 
		{
			intro_mc.visible = false;
			black_mc.visible = false;
			stage2_mc.visible = false;
			alert_mc.visible = false;
		}	
		
		
		//================================================
		//  Configure and prepare the elements for Stage1
		// ===============================================		
		private function initStage1()
		{
			// COLORS
			var colors;								
						
			Events.setColor(currentPageTag.color[0].@button_over,currentPageTag.color[0].@button);				
			if (("@bg_color1" in currentPageTag.color[0]) && ("@bg_color2" in currentPageTag.color[0]))
			{
				colors = [Number(currentPageTag.color[0]. @ bg_color1),Number(currentPageTag.color[0]. @ bg_color2)];
				Colorize.FillRadial(bg_mc,colors);
			}
							
			hideAll();				
			black_mc.visible = true;
						
			
			// Init the Stages
			intro_mc.init(currentPageTag.intro.@introTitle,currentPageTag.intro.text(),currentPageTag.@audioPath);			
			
			var asks :Array = new Array();			
			for(var i=0;i<5;i++)
			{
				var ask :Object = new Object();
				ask.question = currentPageTag.ask[i].@question;
				ask.type = currentPageTag.ask[i].@type;			
				if(currentPageTag.ask[i].@active!="true"&&currentPageTag.ask[i].@question!="" && ("@question" in currentPageTag.ask[i]) )
				{									
					asks.push(ask);
				}
			}						
			var numbers :Array = [currentPageTag.col.@c1, currentPageTag.col.@c2, currentPageTag.col.@c3, currentPageTag.col.@c4, currentPageTag.col.@c5]												
			stage2_mc.init(currentPageTag.course.@introTitle, currentPageTag.course.text(), asks, numbers, currentPageTag.configuration.@url, currentPageTag.configuration.@email);									

			// Shows the Instructions Popup
			intro_mc.showWindow();			
			
			//Center Instructions
			intro_mc.x = presentSizeW / 2 - intro_mc.bg_mc.width / 2;
			intro_mc.y = presentSizeH / 2 - intro_mc.bg_mc.height / 2;
			
			// Set Size of background elements
			black_mc.width = presentSizeW;
			black_mc.height = presentSizeH;							
			bg_mc.width = presentSizeW;
			bg_mc.height = presentSizeH;
			bg_mc2.width = presentSizeW;
			bg_mc2.height = presentSizeH;
		}
		
		//================================================
		//  COnfigure and prepare the elements for Stage2
		// ===============================================		
		public function initStage2()
		{						
			intro_mc.visible = false;
			black_mc.visible = false;
			stage2_mc.visible = true;							
			stage2_mc.showWindow();
		}
		
		
		
		
		
		
		//======================================================================================
		//Rapid Intake
		//Functions used for SCORM recording				
		//SCORM functions
		//======================================================================================
		
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
				
		

		private function timerHandler(e:TimerEvent):void
		{
			sendData();
		}

		private function completeHandler(e:TimerEvent):void
		{
			
		}
		
		
		//******NEED TO SET UP THIS FUNCTION FOR THE MATCHING STILL*************
		
		function sendData()
		{
			var description:String;
			var sData;
			
			var objGame:Array = new Array();
			
			if (objCnt < objGame.length)
			{
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
				var sWeight:Number = 1;
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

				courseModel.lmsLink.apiSendCommit();
				
			}
		}
		
			
		public function recordInteraction()
		{						
			if("@trackInteraction" in currentPageTag != false)
			{
				if (currentPageTag.@trackInteraction.toLowerCase() == "true")
				{					
					intID = new Timer(250);
					intID.start();
					intID.addEventListener(TimerEvent.TIMER, timerHandler);
					intID.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);												
				}
			}
		
		
			if("@recordScore" in currentPageTag != false)
			{
				if (currentPageTag.@recordScore.toLowerCase() == "true")
				{					
					var total = 0;
					var score = 0;
				
					trace(0 + " - " + total + " - " + score);						
					courseModel.lmsLink.apiSendScoreData(score,total,0)
				}
			}
		}
		
		
	}

}
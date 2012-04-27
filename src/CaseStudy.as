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

	public class CaseStudy extends DynamicPageAPI
	{

		// SCORM
		private var intCnt;
		private var intStr:String;
		private var intID:Timer;  //setInterval for recording data.
		private var objCnt:Number = 0;

		
		// Size
		public  var presentSizeH:Number;
		public  var presentSizeW:Number;				
	

		public function CaseStudy()
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
			
			var introTitle :String = currentPageTag.popInstruct[0].@titleInst;
			var introText :String = currentPageTag.popInstruct[0].text();			
			var stage2Title :String = currentPageTag.@title;
			var stage2Text :String = currentPageTag.instruction[0].text();			
			var feedbackTitle :String = currentPageTag.feedback[0].@feedbackTitle;
			var feedbackText :String = currentPageTag.feedback[0].text();
			
			
			main_mc.initApplication(introTitle,
									introText,
									currentPageTag.@audioPath,
									stage2Title,
									stage2Text,
									currentPageTag.image1[0].@path,
									currentPageTag.image1[0].@position,
									currentPageTag.image1[0].@audio,
									feedbackTitle,
									feedbackText,
									currentPageTag.image2[0].@path,
									currentPageTag.image2[0].@position,
									currentPageTag.image2[0].@audio,
									currentPageTag.configuration[0].@link);
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
			trace("Record Interaction");
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
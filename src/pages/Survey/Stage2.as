package
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	
	import flash.display.MovieClip;

	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.events.*;
	import src.pages.utils.*;
	
	public class Stage2 extends MovieClip
	{
	
		private var presentSizeW;
		private var presentSizeH;
			
	
			
		private var my_name;
		private var email;
		private var optionData;
	
		private var nameRequired;
		private var emailRequired;
		private var optionRequired;
		private var nameFromLMS;
		private var optionText:String;
		private var LMSName:String;
	
	
		private var _emailUrl:String = "";
		private var _fromEmail:String = "";
		private var _askEmail:Boolean = true;
		private var _subject:String = "";
		private var _toEmail:String;
	
		private var _asks:Array = null;
		private var _numbers:Array;
	
		// UIScrollBar needs 2 frames before it calculates if scrolling is needed
		// wait 2 frames before checking for scrollThumb_mc
		private var framesElapsed:Number = 0;
		private var framesToWait:Number = 2;
	
	
		//private var MP3_URL :String = ""; 
		public function init(course:String, description:String, asks:Array, numbers:Array, emailUrl:String, toEmail:String)
		{
	
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
	
			presentSizeW = MovieClip(this.parent).presentSizeW;
			presentSizeH = MovieClip(this.parent).presentSizeH;
	
			title_mc.width = presentSizeW;
			course_txt.width = presentSizeW - 20;
			description_txt.width = presentSizeW - 30-description_txt.x;
			scroll_mc.x = description_txt.width+description_txt.x;
	
			submit_btn.x = presentSizeW - 25 - submit_btn.width;
			submit_btn.y = presentSizeH - 25 - submit_btn.height;
	
			numbers_box.x = presentSizeW - numbers_box.base_mc.width;
	
			_numbers = numbers;
			
			// POPUP AND LOCK
			popup_mc._toX = (presentSizeW - popup_mc.bg_mc.width) / 2;
			popup_mc._toY = (presentSizeH - popup_mc.bg_mc.height) / 2;
			popup_mc._outX = 3 * presentSizeW / 2;
			popup_mc._outY = (presentSizeH - popup_mc.bg_mc.height) / 2;
	
			
			
			popup_mc.x = 3 * presentSizeW / 2;
			popup_mc.y = (presentSizeH - popup_mc.height) / 2;
	
			lock_mc.width = presentSizeW;
			lock_mc.height = presentSizeH;
			lock_mc.addEventListener(MouseEvent.CLICK, function(){	trace("LOCKED");});
			lock_mc.useHandCursor = false;
			lock_mc.alpha = 0;
			lock_mc.visible = false;
	
			nameRequired = MovieClip(this.parent).currentPageTag.popup.@namerequired=="true"?true:false;
			emailRequired = MovieClip(this.parent).currentPageTag.popup.@emailrequired=="true"?true:false;
			_askEmail = MovieClip(this.parent).currentPageTag.popup.@requirepersonalinfo.toLowerCase()=="true"?true:false;
			optionRequired = MovieClip(this.parent).currentPageTag.popup.@optionfieldrequired.toLowerCase()=="true"?true:false;
			nameFromLMS = MovieClip(this.parent).currentPageTag.popup.@retrieveLMSname.toLowerCase()=="true"?true:false;
					
			//LMSName = MovieClip(root).scormValue_array[8];
			trace("LMSName "+LMSName)
			
			_subject = MovieClip(this.parent).currentPageTag.configuration[0].@emailSubject;
			_toEmail = toEmail;
			_asks = asks;
			_emailUrl = emailUrl;				
	
			var twidth = numbers_box.x-30;
			this["ask_0"].width = twidth;
			this["ask_1"].width = twidth;
			this["ask_2"].width = twidth;
			this["ask_3"].width = twidth;
			this["ask_4"].width = twidth;
			
			this["scroll_mc0"].x = this["ask_0"].width+this["ask_0"].x;
			this["scroll_mc1"].x = this["ask_1"].width+this["ask_1"].x;
			this["scroll_mc2"].x = this["ask_2"].width+this["ask_2"].x;
			this["scroll_mc3"].x = this["ask_3"].width+this["ask_3"].x;
			this["scroll_mc4"].x = this["ask_4"].width+this["ask_4"].x;
			
	
			this["base_mc"].width = presentSizeW;
			this["base_mc"].height = numbers_box.height;
			this["base_mc"].y = numbers_box.y;
			this["base_mc"].x = 0;
	
	
			course_txt.text = course;
			description_txt.text = description;
	
			
			initAsks(asks);
			initNumbers(numbers);
	
	
			framesElapsed = 0			
			addEventListener(Event.ENTER_FRAME,showOrHideScrollbars);
	
			var me = this;

			this["submit_btn"].title_txt.text = MovieClip(this.parent).currentPageTag.btn[0].@submit;
			doColor(this["title_mc"],MovieClip(this.parent).currentPageTag.color[0].@title_bar);
			doColor(this["base_mc"],MovieClip(this.parent).currentPageTag.color[0].@back);
			doColor(this["popup_mc"].bg_mc.bg_mc,MovieClip(this.parent).currentPageTag.color[0].@title_bar);
			
			popup_mc.header_txt.text = MovieClip(this.parent).currentPageTag.course[0].@introTitle;
			popup_mc.name_txt.text = MovieClip(this.parent).currentPageTag.popup[0].@name;
			popup_mc.inputname_txt.tabEnabled = true;
			popup_mc.inputname_txt.tabIndex = 12;
			popup_mc.email_txt.text = MovieClip(this.parent).currentPageTag.popup[0].@email;
			popup_mc.inputemail_txt.tabEnabled = true;
			popup_mc.inputemail_txt.tabIndex = 13;
			popup_mc.submit_btn.title_txt.text = MovieClip(this.parent).currentPageTag.btn[0].@submit;
			popup_mc.message_txt.text = MovieClip(this.parent).currentPageTag.popup[0].text();
			optionText = MovieClip(this.parent).currentPageTag.popup[0].@optionfieldlabel;
			if ( ("@optionfieldlabel" in MovieClip(this.parent).currentPageTag.popup[0]) && optionText != "" && optionText != " ")
			{
				popup_mc.optional_txt.text = optionText;
				popup_mc.inputOptional_mc.visible = true;
				popup_mc.inputOptional_txt.visible = true;
				popup_mc.optional_txt.visible = true;
				popup_mc.inputOptional_txt.tabEnabled = true;
				popup_mc.inputOptional_txt.tabIndex = 14;
			} else {
				popup_mc.inputOptional_mc.visible = false;
				popup_mc.inputOptional_txt.visible = false;
				popup_mc.optional_txt.visible = false;
			}
			
			if (nameFromLMS && LMSName != null) popup_mc.inputname_txt.text = LMSName;
			
			Events.doEvents(submit_btn,finishForm);
			
			
						
			
			
			
			
		}
		
		//=======================================================================	
		function showOrHideScrollbars(event:Event):void {
			trace(framesElapsed+" showOrHideScrollbars() "+this);
			framesElapsed++;
			if (framesElapsed == framesToWait) {
				removeEventListener(Event.ENTER_FRAME,showOrHideScrollbars);				
				for(var i=0;i<5;i++)
				{
					var myScrollbar = this["scroll_mc"+i];			
					myScrollbar.visible = (this["ask_"+i].textHeight > this["ask_"+i].height) ? true : false;									
				}
				
				myScrollbar = this["scroll_mc"];		
				myScrollbar.visible = (this.description_txt.textHeight > this.description_txt.height) ? true : false;
							
				
			}
		}
		//
		//=========================================================================
	
		
		public function showWindow()
		{
			this.alpha = 0;
			TweenMax.to(this,2,{alpha:1, ease:Strong.easeOut});				
		}
	
		public function hideWindow()
		{
			TweenMax.to(this,2,{alpha:0, ease:Strong.easeOut});			
			for (var num:Number = 0; num < _asks.length; num++)
			{
				if (_asks[num].type == "text")
				{
					numbers_box["text_" + String(num)].text = ""
				}
			}
		}
	
		private function initAsks(asks:Array)
		{
			var tab=1000;
			var firstElement;
			for (var num:Number = 0; num < 5; num++)
			{
	
				if ((asks[num] == undefined) || (asks[num] == null))
				{
					for (var cbNum:Number = 0; cbNum < 5; cbNum++)
					{
						numbers_box["a" + String(num) + "_" + String(cbNum)].visible = false;
						
					}
	
					numbers_box["border_" + String(num)].visible = false;
					numbers_box["text_" + String(num)].visible = false;
					this["ask_" + String(num)].visible = false;
	
					continue;
				}
	
				this["ask_" + String(num)].text = asks[num].question;
				if (asks[num].type == "text")
				{				
					if(firstElement == undefined)
					{
						firstElement = numbers_box["text_" + String(num)];
					}
					
					numbers_box["text_" + String(num)].tabIndex = tab++;
					for (cbNum = 0; cbNum < 5; cbNum++)
					{
						numbers_box["a" + String(num) + "_" + String(cbNum)].visible = false;
					}
				}
				else
				{				
					if(firstElement == undefined)
					{
						firstElement = numbers_box["a" + String(num) + "_" + String(cbNum)];
					}
				
					numbers_box["border_" + String(num)].visible = false;
					numbers_box["text_" + String(num)].visible = false;
					
					for (cbNum = 0; cbNum < 5; cbNum++)
					{
						numbers_box["a" + String(num) + "_" + String(cbNum)].useHandCursor = true;
						numbers_box["a" + String(num) + "_" + String(cbNum)].tabIndex = tab++;
					}
				}
				
				
				//_root.focusManager.setFocus(firstElement);
				
			}
		}
	
		private function initNumbers(numbers:Array)
		{
			for (var num:Number = 0; num < numbers.length; num++)
			{
				numbers_box["num_" + String(num)].text = numbers[num];
			}
		}
	
	
		private function askEmail()
		{
			lock_mc.visible = true;
	
			TweenMax.to(popup_mc,1,{x:popup_mc._toX, y:popup_mc._toY, onComplete:activateSubmit, onCompleteParams:[this]});
			TweenMax.to(lock_mc,1,{alpha:1});

		}
		
		
		private function activateSubmit(ref)
		{	
			ref.popup_mc.submit_btn.mouseChildren = false;
			ref.popup_mc.submit_btn.buttonMode = true;
			ref.popup_mc.submit_btn.ref = ref;
			Events.doEvents(ref.popup_mc.submit_btn,ref.validateFields);
		}
	
		
		private function validateFields(_ref:MovieClip)
		{
			var all = true;
			if (popup_mc.inputname_txt.text == "" && nameRequired == true)
			{
				all = false;
				TweenMax.to(popup_mc.inputname_mc.line_mc,1,{tint:0xFF0000});
				popup_mc.inputname_txt.addEventListener(Event.CHANGE,function(evt:Event)
						{										
							TweenMax.to(evt.target.parent.inputname_mc.line_mc,1,{removeTint:true});
						}
				);
			};
	
			if ( (popup_mc.inputemail_txt.text == "" || popup_mc.inputemail_txt.text.indexOf("@")==-1 ) && emailRequired == true)
			{
				all = false;
				TweenMax.to(popup_mc.inputemail_mc.line_mc,1,{tint:0xFF0000});				
				popup_mc.inputemail_txt.addEventListener(Event.CHANGE,function(evt:Event)
						{
							TweenMax.to(evt.target.parent.inputemail_mc.line_mc,1,{removeTint:true});
						}
				);
			}
			if (optionText != "" && optionText != " ")
			{
				if ( popup_mc.inputOptional_txt.text == "" && optionRequired == true)
				{
					all = false;
					TweenMax.to(popup_mc.inputOptional_mc.line_mc,1,{tint:0xFF0000});
					popup_mc.inputOptional_txt.addEventListener(Event.CHANGE,function(evt:Event)
							{
								TweenMax.to(evt.target.parent.inputOptional_mc.line_mc,1,{removeTint:true});
							}
					)
				}
			}
						
			if(all==true)
			{
				my_name = popup_mc.inputname_txt.text;
				email = popup_mc.inputemail_txt.text;
				optionData = popup_mc.inputOptional_txt.text;
			
				TweenMax.to(popup_mc,1,{x:popup_mc._outX, y:popup_mc._outY, onComplete:doFinish, onCompleteParams:[this]});				
				
			}
	
		}
		
		private function doFinish(ref)
		{						
			var me = ref;
			
			var alertClickHandle:Function = function ()
			{								
				me.hideWindow();
			};						
						
			ref.sendMail();			
			MovieClip(ref.parent).recordInteraction();
			
			//Alert.show("Thank you. Your response has been received.","Thanks",Alert.OK,null,alertClickHandle);
			MovieClip(this.parent).alert_mc.showWindow("Thank you. Your response has been received.",alertClickHandle);
			
			
		}
		
		private function finishForm(_ref:MovieClip)
		{
									
			
			var me = this;		
	
			if (!isFormFill())
			{
				//Alert.show("Please answer all questions!","Warning");
				MovieClip(this.parent).alert_mc.showWindow("Please answer all questions!");				
			}
			else
			{
				if (_askEmail)
					askEmail();
				else
					doFinish(me)
					//sendMail();
				
			}
		}
	
		private function isFormFill():Boolean
		{
			for (var num:Number = 0; num < 5; num++)
			{
				if ((_asks[num] == undefined) || (_asks[num] == null))
				{
					continue;
				}
	
	
				if (_asks[num].type == "text")
				{
					if (numbers_box["text_" + String(num)].text == "")
					{
						return false;
					}
				}
				else
				{
					var isSel:Boolean = false;
					for (var cbNum:Number = 0; cbNum < 5; cbNum++)
					{
						if (numbers_box["a" + String(num) + "_" + String(cbNum)].selected)
						{
							isSel = true;
						}
					}
	
					if (!isSel)
					{
						return false;
					}
				}
			}
	
			return true;
		}
	
		private function sendMail()
		{
			
			// name, email: holds the input text values
					
			
			
			
			var answers:Array = new Array();
	
			for (var num:Number = 0; num < _asks.length; num++)
			{
				var obj:Object = new Object();
				trace(num+"+< i")
				
				if (_asks[num].type == "text")
				{
					obj.question = _asks[num].question;
					obj.type = "text";
					obj.answer = numbers_box["text_" + String(num)].text;
										
					
				}
				else
				{
					obj.question = _asks[num].question;
					obj.type = "cb";
					var isSel :Boolean = false;
					for (var cbNum :Number = 0; cbNum < 5; cbNum ++)
					{
						if (numbers_box["a" + String(num) + "_" + String(cbNum)].selected) 
						{
							trace(" Sel Answer: ["+num+"]  ["+cbNum+"]"+isSel);
							isSel = true;
							obj.answer = _numbers[cbNum];
						}
					}
					//obj.answer = isSel;
				}
				trace("PUSH "+obj)
				answers.push(obj);
			}
			
			trace("1*** ");
			
			//Put together data for  email
			var theBody:String = "";
			var cr:String = "%0d";
			
			if (_askEmail)
			{
				theBody += "Survey data submitted by:" + cr + cr;
				theBody += my_name + cr + email + cr + optionData + cr + cr + cr;
			}
			
			trace("2*** ");
			for (var j=0;j<answers.length;j++)
			{
				obj = answers[j];
				if (obj.answer !== undefined)
				{
					theBody += "QUESTION " + (j+1) + ": " + cr;
					theBody += escape(obj.question) + cr + cr;
					theBody += "ANSWER: " + cr;
					theBody += escape(obj.answer) + cr + cr + "--------------------------------------" + cr;
				}
			}
			trace("3*** ");
			
			trace(theBody)
			var aDate:Date = new Date();
			var theDate:String = (aDate.getMonth()+1) + "/" + aDate.getDate() + "/" + aDate.getFullYear();
			trace("Date: " + theDate);
			var idag = "4/5/20106-7-0910/10/2011" + theDate + "3/4/0911/12/20091-1-12";
			/*trace("DEBUG: " + _root.debug)
			trace("ARRAY: " + answers.toString())
			trace("Numbers: " + _numbers)*/
			if (email !== undefined && email != "" && email != " " && email.indexOf("@")>-1)
			{
				var fromEmail = email;
			} else {
				fromEmail = "survey@rapidintake.com";
			}
			
			navigateToURL(new URLRequest(_emailUrl + "?From=" + fromEmail + "&To=" + _toEmail + "&Subject=" + _subject + "&Body=" + theBody + "&idag=" + idag),"_blank");
		}
	
	
		private function doColor(_btn, _color)
		{
			if (_color != "" && _color != undefined)
			{
					
				TweenMax.to(_btn,0,{tint:_color});
			}
	
		}
		
			
	
	}

}
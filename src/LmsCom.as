package src
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.net.SharedObject;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
	
	import src.classes.InfoPanel;
	import src.classes.LoadingPercentages;
	import src.com.AlertButton;
	import src.com.Alerts;

	public class LmsCom extends EventDispatcher
	{
		public static const LMS_DATA_LOADED:String = "lmsDataLoaded";
		public static const NO_API_FOUND:String = "noApiFound";
		public var scormData_array:Array;
		public var scormValue_array:Array;
		public var lmsInitialized:Boolean = false;
		
		public var testTxt:TextField;
		
		private var _coursePreloader:MovieClip;
		private var _model:CourseModel;
		private var _courseAttributes:CourseAttributes;
		private var _track:String;
		private var _timer:Timer;							//Used for loading SCORM data. Use a timer so we can update the pre-loader.
		private var _dataCount:int = 0;						//Used for loading SCORM data with the timer.
		private var _dataTimer:Timer;
		private var _feedback:InfoPanel;
		private var _noAPIAlert:Alerts;
		private var _bookMarkAlert:Alerts;
		private var _state_array:Array = new Array();  		// an array to hold the state information
		private var _sSep:String = '`';
		private var _bookmarkPage:int;
		private var _courseBookMarked:Boolean = false;
		private var _data_cookie_so:SharedObject;			//Cookie object for local tracking.
		//Loading percentage variables
		private var _percentObj:LoadingPercentages;
		private var _perc:Number;
		
		
		public function LmsCom(cp:MovieClip,m:CourseModel)
		{
			_coursePreloader = cp;
			_model = m;
			_feedback = _model.feedbackPanel;
			_courseAttributes = _model.courseAttributes;
			_track = _courseAttributes.tracking;
			_percentObj = new LoadingPercentages();
			_perc = _percentObj.scormPerc;
			//Build Data Array
			createDataArray();
			_timer = new Timer(1000,3);
			_timer.addEventListener(TimerEvent.TIMER,checkAPIStatus);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE,noAPIFound);
			
			// initialize the alert window
			_noAPIAlert = new Alerts();
			_bookMarkAlert = new Alerts();
			
			// add listeners
			_noAPIAlert.addEventListener(Alerts.RIGHT_BUTTON_CLICK, onAPIConfirm);
			_noAPIAlert.addEventListener(Alerts.LEFT_BUTTON_CLICK, onAPIReject);
			_bookMarkAlert.addEventListener(Alerts.RIGHT_BUTTON_CLICK, bookmarkConfirm);
			_bookMarkAlert.addEventListener(Alerts.LEFT_BUTTON_CLICK, bookmarkReject);
			
			// add the alert window to the display list
			if (_coursePreloader != null) //Check to see if the course is playing inside of the course.swf file.
			{
				_coursePreloader.parent.addChild(_noAPIAlert);
				_coursePreloader.parent.addChild(_bookMarkAlert);
			} else {
				_model.mainPlayer.addChild(_noAPIAlert);
				_model.mainPlayer.addChild(_bookMarkAlert);
			}
		}
		
		//Called from CourseModel once the XML data is loaded.
		public function beginLoading():void
		{
			if (_track == "SCORM1.2" || _track == "SCORM1.3")
			{
				try {
					_coursePreloader.status_txt.text = "Loading SCORM Data...";
				} catch (error:Error) {
					trace("The player file is not running inside the course file: ");
				}
				if (ExternalInterface.available) lmsInitialized = ExternalInterface.call("isSCOInitialized");
				if (lmsInitialized)
				{
					startTheCourse()
				}
				else
					_timer.start();
			} else if (_track == "COOKIE") { 
				try {
					_coursePreloader.status_txt.text = "Loading Bookmark Data...";
				} catch (error:Error) {
					trace("The player file is not running inside the course file: ");
				}
				
				loadCookieData();
			} else {
				scormLoaded();
			}
		}
		
		private function loadCookieData():void
		{
			_data_cookie_so = SharedObject.getLocal("fc_suspend_data");
			//Retrieve data from cookie
			var COOKIE_bookmark:String = _data_cookie_so.data.bookmark;
			var COOKIE_state:String = _data_cookie_so.data.suspend;
			
			if (COOKIE_bookmark != null)
			{
				scormValue_array[0] = COOKIE_bookmark;
				scormValue_array[1] = COOKIE_state;
				continueTheCourse();
			} else {
				scormLoaded();
			}
			
			//Now do loading
		}
		
		private function loadingSCORM(curElement:Number):void
		{
			var perc:Number = (curElement+1)/scormData_array.length;
			var newPerc:Number;
			var prevPerc:Number = _percentObj.previousPercent;
			newPerc = perc*(_perc - prevPerc) + prevPerc;
		_feedback.updatePanel("Percentage: " + newPerc);
			try {
			    _coursePreloader.percent_txt.text = Math.ceil(newPerc*100).toString() + "%";
				_coursePreloader.status_txt.text = "Loading SCORM Data...";
				_coursePreloader.bar_mc.scaleX = newPerc;
			} catch (error:Error) {
			     trace("The player file is not running inside the course file: ");
			}
		}
		
		private function scormLoaded():void
		{
			trace("SCORM DATA HAS BEEN LOADED.");
			dispatchEvent(new Event(LmsCom.LMS_DATA_LOADED));
		}
		
		private function startTheCourse():void
		{
			readData();
		}
		
		private function continueTheCourse():void
		{
			loadState();
			_bookmarkPage = checkForBookmark();
			_feedback.updatePanel("Course Was Bookmarked?: " + _courseBookMarked);
			if (_courseBookMarked) 
			{
				//Display Alert
				_bookMarkAlert.headerText = "Bookmark Found!";
				_bookMarkAlert.alertText = "This course has been bookmarked. Would you like to return to where you left off?";
				_bookMarkAlert.rightButtonText = "Yes";
				_bookMarkAlert.leftButtonText = "No";
				
				// show the alert window when you need it
				_bookMarkAlert.showAlert();
			} else {
				scormLoaded();
			}
		}
		
		private function readData():void
		{
			/*for (var i:Number=0; i<scormData_array.length; i++){
				loadingSCORM(i)
				scormValue_array[i] = ExternalInterface.call("SCOGetValue",scormData_array[i]);
			}*/
			_dataTimer = new Timer(50);
			_dataTimer.addEventListener(TimerEvent.TIMER,readDataTimer);
			scormValue_array[_dataCount] = "--";
			_dataTimer.start();
		}
		
		private function readDataTimer(e:TimerEvent):void
		{
			loadingSCORM(_dataCount);
			if (ExternalInterface.available) scormValue_array[_dataCount] = ExternalInterface.call("SCOGetValue",scormData_array[_dataCount]);
			if (scormValue_array[_dataCount] != "--")
			{
				_dataCount++;
				scormValue_array[_dataCount] == "--"
			}
			//Are we finished
			if (_dataCount >= scormData_array.length)
			{
				_dataTimer.stop();
				_dataTimer.removeEventListener(TimerEvent.TIMER,readDataTimer);
				continueTheCourse();
			}
		}
		
		private function checkForBookmark():int
		{
			var sMovie:String = String(apiGetBookmark());
			if (apiGetLastError() == 0 && int(sMovie) != 0) 
			{
				_courseBookMarked = true;
				return int(sMovie);
			} else {
				return 0;
			}
		}
		
		private function bookmarkConfirm(e:Event):void
		{
			_model.changePage(_bookmarkPage);
			scormLoaded();
		}
		
		private function bookmarkReject(e:Event):void
		{
			scormLoaded();
		}
		
		/*
		- Find out if the API has been discovered by the HTML page.
		- After 3 seconds display a message.
		*/
		private function checkAPIStatus(e:TimerEvent):void
		{
			if (ExternalInterface.available) lmsInitialized = ExternalInterface.call("isSCOInitialized");
			if (lmsInitialized)
			{
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER,checkAPIStatus);
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE,noAPIFound);
				startTheCourse()
			}
			_feedback.updatePanel("LMSInitialized: " + lmsInitialized);
		}
		
		/*
		- This function will fire after 3 seconds of not finding the SCORM API.
		*/
		private function noAPIFound(e:TimerEvent):void
		{
			trace("SCORM API WAS NOT FOUND.");
			dispatchEvent(new Event(LmsCom.NO_API_FOUND));
			_timer.removeEventListener(TimerEvent.TIMER,checkAPIStatus);
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE,noAPIFound);
			//Display Alert
			_noAPIAlert.headerText = "LMS Warning";
			_noAPIAlert.alertText = "The SCORM API could not be found. Therefore communication with the LMS will not occur. Do you want to continue anyway?";
			_noAPIAlert.rightButtonText = "Yes";
			_noAPIAlert.leftButtonText = "No";
			
			// show the alert window when you need it
			_noAPIAlert.showAlert();
		}
		
		private function onAPIConfirm(e:Event):void
		{
			scormLoaded();
		}
		
		private function onAPIReject(e:Event):void
		{
			//Close the course???
		}
		
		private function createDataArray():void
		{
			// intialize the array to hold the SCORM names
			if (_track == "SCORM1.3") {
				scormData_array = new Array(
				'cmi.location',//*
				'cmi.suspend_data',//*
				'cmi.interactions._count',//*
				
				/* ONLY LOAD THE DATA WE NEED TO SAVE LOADING TIME */	
				'cmi.mode',//*
				'cmi.completion_status',//*
				'cmi.credit',//*
				'cmi.entry',//*
				'cmi.learner_id',//*
				'cmi.learner_name',//*
				'cmi.objectives._count',//*
				'cmi.launch_data',//*
				'cmi.scaled_passing_score',//*
				'cmi.max_time_allowed',//*
				'cmi.time_limit_action',//*
				
				/* LEAST IMPORTANT DATA BELOW */
				'cmi.score.max',//*
				'cmi.score.min',//*
				'cmi.score.raw',//*
				'cmi.total_time',//*
				'cmi.learner_preference.audio_level',//*
				'cmi.learner_preference.language',//*
				'cmi.learner_preference.delivery_speed',//*
				'cmi.learner_preference.audio_captioning',//*
				'cmi.comments_from_learner._children',//*
				'cmi.comments_from_lms._children',//*
				'cmi.score._children',//*
				'cmi.interactions._children',//*
				'cmi.objectives._children',//*
				'cmi.learner_preference._children',//*
				
				/*SCORM RTE 1.3 Specific*/
				'cmi.completion_threshold',
				'cmi.progress_measure',
				'cmi.score.scaled',
				'cmi.success_status');
			} else {
				scormData_array = new Array(
				'cmi.core.lesson_location',
				'cmi.suspend_data',
				'cmi.interactions._count',
				
				/* ONLY LOAD THE DATA WE NEED TO SAVE LOADING TIME */	
				'cmi.core.lesson_mode',
				'cmi.core.lesson_status',
				'cmi.core.credit',
				'cmi.core.entry',
				'cmi.core.student_id',
				'cmi.core.student_name',
				'cmi.objectives._count',
				'cmi.launch_data',
				'cmi.student_data.mastery_score',
				'cmi.student_data.max_time_allowed',
				'cmi.student_data.time_limit_action',
				
				/* LEAST IMPORTANT DATA BELOW */
				'cmi.core.score.max',
				'cmi.core.score.min',
				'cmi.core.score.raw',
				'cmi.core.total_time',
				'cmi.student_preference.audio',
				'cmi.student_preference.language',
				'cmi.student_preference.speed',
				'cmi.student_preference.text',
				'cmi.comments',
				'cmi.comments_from_lms',
				'cmi.core._children',
				'cmi.core.score._children',
				'cmi.interactions._children',
				'cmi.objectives._children',
				'cmi.student_data._children',
				'cmi.student_preference._children');
			}
			//Value array initialize to blank
			scormValue_array = new Array();
			for (var i:Number=0; i<scormData_array.length; i++){
				scormValue_array[i] = "";
			}
		}
		
		/*
		* Load the suspend data into our state array
		*/
		private function loadState():void
		{
			/* get the suspend_data */
			var sSuspend:String = apiGetSuspendData();
			
			/* load the data into a temp array */
			var aParts:Array = sSuspend.split(_sSep);
			
			/* loop through the array */
			for (var i:Number=0; i<aParts.length; i=i+2)
			{
				/* see if we have an id */
				if (aParts[i] != "")
				{
					/* we do, copy the data to the state array */
					_state_array[ aParts[i] ] = aParts[i+1];
				}
			}
		}
		
		/*
		* Set the state in suspend data 
		* we do this by flattening the data stored in the state array
		*/
		private function saveState():void
		{
			/* buffer for the state arrray */
			var sSuspend:String = "";
			
			/* loop through the array */
			for (var i:* in _state_array)
			{
				sSuspend += i + _sSep + _state_array[i] + _sSep;
			}
			/* see if there is any data to set */
			if (sSuspend != "")
			{	
				/* there is, store this with SCORM */
				var success:Boolean = apiSetSuspendData(sSuspend);
			}
			_feedback.updatePanel("saveState success: " + success);
		}
		
		/*
		* Remember a state value associated with this id
		* The state information is held in a javascript array
		*/
		public function apiSetState(sId:String,sValue:String):void
		{
			_feedback.updatePanel("apiSetState: " + sId + " - " + sValue);
			/* set the state in our state arrat */
			_state_array[sId] = sValue;
			
			/* write out the data to LMS */
			saveState();
			
			/*Check completion status*/
			checkComplete(sValue);
		}
		
		/*
		* Get the state value of this id
		*/
		public function apiGetState(sId:String):String
		{
			/* see if there is an ID in the state array */
			if (_state_array[sId])
			{
				/* there is, return it */
				return _state_array[sId];
			}
			else
			{
				/* there is no ID, return an empty string */
				return "";
			}
		}
		
		/*
		Passed a string that represents either visited pages
		or pages marked complete using apiPageComplete()
		Checks for completion and sends message to LMS.
		*/
		private function checkComplete(sValue:String):void 
		{
			if (sValue != null){
				// Check to see if all pages are visited. If so submit completed status.
				if (sValue != ""){
					var usePageComplete:Boolean = _courseAttributes.pageComplete;
					var completion:String = _courseAttributes.completion;
					//Check to see if using PageComplete method or simply visit page method
					if (!usePageComplete){
						if (completion != null && completion != "" && completion.toLowerCase() != "none"){
							//Check the completion
							doCompletion(sValue,completion);
						}
					} else {
						if (completion != null && completion != "" && completion.toLowerCase() != "none"){//for this method set completion if not already set.
							completion = "completed"
						}
						//Check the completion
						doCompletion(sValue,completion);
					}
				}
			}
		}
		
		//Cycles through visited array to chec completion
		private function doCompletion(sValue:String,completion:String){
			// break it apart (visited array)
			var suspend_array:Array = sValue.split(":");
			var visit_array:Array = suspend_array[0].split(",");
			var course_complete:Boolean;
			if (visit_array.length > 0) {
				course_complete = true;
				for (var i:Number = 0;i < visit_array.length;i++){
					//Has the page been visited?
					if (visit_array[i] != "1"){
						course_complete = false;
					}
				}
			} else {
				course_complete = false;//default to not complete if array doesn't exist;
			}
			//trace(visit_array);
			//trace(course_complete);
			if (course_complete){//Every page visited?
				apiSetCompletion(true,completion);//record it
			}
		}
		
		/*
							SCORM API Functions
		*/
		
		// set the completion status
		//	bComplete - true is SCO is complete - a normal exit is needed
		//	            false if SCO is incomplete - a suspended exit is needed
		//	sStatus - the completion status - "completed", "incomplete", "passed", or "failed"
		//
		//	Returns true if successful false if not. If not successful query the error code for status and/or exit
		//	AICC is handled differently.
		public function apiSetCompletion(bComplete:Boolean,sStatus:String):Boolean
		{
			var errStatus:String = "";
			var errExit:String = "";
			if (_track == "SCORM1.2") {
				/* see if the SCO is complete */
				if (bComplete)
				{
					if (ExternalInterface.available) 
					{
						/* it is, set the completion status to normal */
						errStatus = String(ExternalInterface.call("SCOSetValue","cmi.core.lesson_status",sStatus));
						errExit = String(ExternalInterface.call("SCOSetValue","cmi.core.exit,"+""));
					}
				}
				else
				{
					if (ExternalInterface.available) 
					{
						/* not complete, set the status  and the exit to suspend */
						errStatus = String(ExternalInterface.call("SCOSetValue","cmi.core.lesson_status",sStatus));
						errExit = String(ExternalInterface.call("SCOSetValue","cmi.core.exit","suspend"));
					}
				}
				scormValue_array[4] = sStatus;
			} else if (_track == "SCORM1.3"){
				if (bComplete)
				{
					if (ExternalInterface.available) 
					{
						/* it is, set the completion status to normal */
						errStatus = String(ExternalInterface.call("SCOSetValue","cmi.completion_status",sStatus));
						errExit = String(ExternalInterface.call("SCOSetValue","cmi.exit","normal"));
					}
				}
				else
				{
					if (ExternalInterface.available) 
					{
						/* not complete, set the status  and the exit to suspend */
						errStatus = String(ExternalInterface.call("SCOSetValue","cmi.completion_status",sStatus));
						errExit = String(ExternalInterface.call("SCOSetValue","cmi.exit","suspend"));
					}
				}
				scormValue_array[4] = sStatus;
			} else if (_track == "AICC"){
				//fscommand("MM_cmiSetLessonStatus", sStatus);
				//scormValue_array[4] = sStatus;
			}
			apiSendCommit()
			if ((errStatus == "true" || errStatus == "") && (errExit == "true" || errExit == "")) return true;
			else return false;
		}
		
		//Get the completion status
		public function apiGetCompletion():String 
		{
			return scormValue_array[4];
		}
		
		//Set the bookmark
		public function apiSetBookmark(n:int):Boolean
		{
			_feedback.updatePanel("Trying to bookmark - n: " + n + " -track: " + _track);
			scormValue_array[0] = n;
			var errmsg:String = "";
			if (_track == "SCORM1.2") {
				if (ExternalInterface.available) errmsg = ExternalInterface.call("SCOSetValue","cmi.core.lesson_location",n);
				_feedback.updatePanel("Bookmark SCORM 1.2: " + errmsg);
			} else if (_track == "SCORM1.3") {
				if (ExternalInterface.available) errmsg = ExternalInterface.call("SCOSetValue","cmi.location",n);
			} else if (_track == "AICC"){
				//fscommand("CMISetLocation", book_mark_data);
			}  else if (_track.toUpperCase() == "COOKIE") {
					_data_cookie_so.data.bookmark = n;
					_data_cookie_so.flush();
			}
			apiSendCommit()
			
			if (errmsg == "true" || errmsg == "") return true;
			else return false;
		}
		
		//Get the bookmark
		public function apiGetBookmark():String
		{
			return scormValue_array[0];
		}
		
		//Set success status
		//sStatus - the success status - "passed", "failed", or "unknown"
		//Only used for SCORM RTE 1.3
		//	Returns true if successfule, false if unsuccessful.
		public function apiSetSuccess(sStatus):Boolean
		{
			if (_track == "SCORM1.3") 
			{
				var errmsg:String = "";
				if (ExternalInterface.available) errmsg = String(ExternalInterface.call("SCOSetValue","cmi.success_status",sStatus));
				scormValue_array[31] = sStatus;
			}
			if (errmsg == "true" || errmsg == "") return true;
			else return false;
		}
		
		//Get the completion status
		public function apiGetSuccess():String 
		{
			return scormValue_array[31];
		}
		
		//Commit data
		public function apiSendCommit():Boolean
		{
			if (_track == "SCORM1.2" || _track == "SCORM1.3") {
				var errmsg:String = "";
				if (ExternalInterface.available) errmsg = String(ExternalInterface.call("SCOCommit"));
			}
			if (errmsg == "true" || errmsg == "") return true;
			else return false;
		}
		
		//Finish SCO
		public function apiSendFinish():Boolean
		{
			var errmsg:String = "";
			if (_track == "SCORM1.2" || _track == "SCORM1.3") {
				if (ExternalInterface.available) errmsg = String(ExternalInterface.call("SCOFinish"));
			} else if (_track == "AICC"){
				//fscommand("CMIExitAU")
			}
			if (errmsg == "true" || errmsg == "") return true;
			else return false;
		}
		
		// Generic Set Value funciton for SCORM data item
		public function apiSetValue(sData:String, sValue:String):Boolean
		{
			var errmsg:String = "";
			if (ExternalInterface.available) errmsg = String(ExternalInterface.call("SCOSetValue",sData,sValue));
			
			//Place the value in the array
			for (var i:Number=0; i<scormValue_array.length; i++)
			{
				// see if we found it
				if (scormData_array[i] == sData)
				{
					// we did, return the value
					scormValue_array[i] = sValue;
				}
			}
			
			if (errmsg == "true" || errmsg == "") return true;
			else return false;
		}
		
		// Generic function to get a SCORM data item
		public function apiGetValue(sData):String
		{
			// look through the array of data items until we find the name
			for (var i:Number=0; i<scormValue_array.length; i++)
			{
				// see if we found it
				if (scormData_array[i] == sData)
				{
					// we did, return the value
					return scormValue_array[i];
				}
			}
			if (ExternalInterface.available) 
			{
				// we did not find it, so call the API.
				return String(ExternalInterface.call("SCOGetValue",sData));
			} else {
				return "";
			}
		}
		
		// get the suspend data
		public function apiGetSuspendData():String
		{
			return scormValue_array[1];
		}
		
		// set the suspend data
		public function apiSetSuspendData(suspend_str:String):Boolean
		{
			scormValue_array[1] = suspend_str;
			var errmsg:String = "";
			if (_track == "SCORM1.2" || _track == "SCORM1.3") {
				if (ExternalInterface.available) errmsg = ExternalInterface.call("SCOSetValue","cmi.suspend_data",suspend_str);
			} else if (_track == "AICC"){
				//fscommand("CMISetData", suspend_str);
			} else if (_track.toUpperCase() == "COOKIE") {
				_data_cookie_so.data.suspend = suspend_str;
				_data_cookie_so.flush();
			}
			
			if (errmsg == "true" || errmsg == "") return true;
			else return false;
		}
		
		// get the count of interactions
		public function apiGetIntCount():int
		{
			if (_track == "SCORM1.2" || _track == "SCORM1.3") {
				if (ExternalInterface.available) 
				{
					var data:int = int(ExternalInterface.call("SCOGetValue","cmi.interactions._count"));
					scormValue_array[2] = data;
				}
			}
			return int(scormValue_array[2]);
		}
		
		/*
		* return the current hours:minutes:seconds given a data object
		*/
		private function getHMS(dateNow:Date):String
		{
			var hh = dateNow.getHours();
			var mm = dateNow.getMinutes();
			var ss = dateNow.getSeconds();
			if (hh < 10) hh = "0" + hh;
			if (mm < 10) mm = "0" + mm;
			if (ss < 10) ss = "0" + ss;
			return hh + ":" + mm + ":" + ss;
		}
		
		//Returns the date for AICC and SCORM1.3
		private function getYMD(dateNow:Date,SCORM:Boolean):String
		{
			var yy = dateNow.getFullYear();
			var mm = dateNow.getMonth() + 1;
			var dd = dateNow.getDate();
			if (mm < 10) mm = "0" + mm;
			if (dd < 10) dd = "0" + dd;
			if (SCORM){
				return yy + "-" + mm + "-" + dd;
			}else{
				return yy + "/" + mm + "/" + dd;
			}
		}
		
		///Returns the date in Date type format (SCORM 1.3)
		private function getDateType(dateNow:Date):String
		{
			return getYMD(dateNow,true) + "T" + getHMS(dateNow);
		}
		
		/*
		* set the interaction data for a question - SCORM 1.2 & SCORM 1.3
		* This function will set:
		* cmi.interactions.n.id
		* cmi.interactions.n.type
		* cmi.interactions.n.student_response
		* cmi.interactions.n.correct_responses.0.pattern
		* cmi.interactions.n.result
		* cmi.interactions.n.time
		* cmi.interactions.n.weighting
		* cmi.interactions.n.latency
		*/
		public function apiSetInteraction(sId:String,sType:String,sResponse:String,sCorrect:String,sResult:String,sWeight:Number = NaN,sTime:String = null):Boolean
		{
			if (_track == "SCORM1.2" || _track == "SCORM1.3") {
				if (ExternalInterface.available) 
				{
					/* get the count of interactions from the LMS */
					var sNum:int = apiGetIntCount();
				
					/* tell the LMS about the interaction */
					var sInt:String = "cmi.interactions." + sNum + ".";
					var errmsg1:String = String(ExternalInterface.call("SCOSetValue",sInt + "id",sId));
					var errmsg2:String = String(ExternalInterface.call("SCOSetValue",sInt + "type",sType));
					var errmsg3:String = "";
					if (_track == "SCORM1.2") {
						errmsg3 = String(ExternalInterface.call("SCOSetValue",sInt + "student_response",sResponse));
					} else if (_track == "SCORM1.3") {
						errmsg3 = String(ExternalInterface.call("SCOSetValue",sInt + "learner_response",sResponse));
					}
					var errmsg4:String = String(ExternalInterface.call("SCOSetValue",sInt + "correct_responses.0.pattern",sCorrect));
					var errmsg5:String = String(ExternalInterface.call("SCOSetValue",sInt + "result",sResult));
					var dateNow:Date = new Date();
					var errmsg6:String = "";
					if (_track == "SCORM1.2") {
						errmsg6 = String(ExternalInterface.call("SCOSetValue",sInt + "time",getHMS(dateNow)));
					} else if (_track == "SCORM1.3") {
						errmsg6 = String(ExternalInterface.call("SCOSetValue",sInt + "timestamp",getDateType(dateNow)));
					}
					if (!isNaN(sWeight)) var errmsg7:String = String(ExternalInterface.call("SCOSetValue",sInt + "weighting",sWeight));
					if (sTime != null)   var errmsg8:String = String(ExternalInterface.call("SCOSetValue",sInt + "latency",sTime));
					
					if (errmsg1 == "true" && errmsg2 == "true" && errmsg3 == "true" && errmsg4 == "true" && errmsg5 == "true" && errmsg6 == "true") return true;
					else return false;
				}
			} else if (_track == "AICC"){
				/*var sep:String = ";"
				var dateNow:Date = new Date();
				var aicc_data:String = getYMD(dateNow) + sep + getHMS(dateNow) + sep + sId + sep + objId + sep + sType + sep + sCorrect + sep + sResponse + sep + sResult + sep + sWeight + sep + sTime;
				fscommand("MM_cmiSendInteractionInfo",aicc_data);*/
				return true;
			}
			return false;
		}
		
		// set the  score
		//	nMin - the minimum score (normalized between 0-100)
		//	nMax - the maximum score (normalized between 0-100)
		//	nRaw - the learner's score (normalized between 0-100)
		public function apiSetScore(nMin:Number,nMax:Number,nRaw:Number,sResult:String = null)
		{
			var errmsg1:String;
			var errmsg2:String;
			var errmsg3:String;
			var errmsg4:String;
			
			errmsg1 = errmsg2 = errmsg3 = errmsg4 = "";
			if (_track == "SCORM1.2") {
				if (ExternalInterface.available) 
				{
					errmsg1 = String(ExternalInterface.call("SCOSetValue","cmi.core.score.min",nMin));
					errmsg2 = String(ExternalInterface.call("SCOSetValue","cmi.core.score.max",nMax));
					errmsg3 = String(ExternalInterface.call("SCOSetValue","cmi.core.score.raw",nRaw));
				}
			} else if (_track == "SCORM1.3") {
				if (ExternalInterface.available) 
				{
					errmsg1 = String(ExternalInterface.call("SCOSetValue","cmi.score.min",nMin));
					errmsg2 = String(ExternalInterface.call("SCOSetValue","cmi.score.max",nMax));
					errmsg3 = String(ExternalInterface.call("SCOSetValue","cmi.score.raw",nRaw));
					errmsg4 = String(ExternalInterface.call("SCOSetValue", "cmi.score.scaled",sResult));
				}
			} else if (_track == "AICC"){
				//fscommand("CMISetScore", nRaw);
			}
			apiSendCommit();
			
			if ((errmsg1 == "true" || errmsg1 == "") && (errmsg2 == "true" || errmsg2 == "") && (errmsg3 == "true" || errmsg3 == "") && (errmsg4 == "true" || errmsg4 == "")) return true;
			else return false;
		}
		
		//Get the last error
		public function apiGetLastError():int
		{
			if (ExternalInterface.available) 
			{
				var error:int = int(ExternalInterface.call("SCOGetLastError"));
				return error;
			} else {
				return 0;
			}
		}
		
		
		/*
			Getter and Setter Methods
		*/
		
		public function get stateArray():Array
		{
			return _state_array;
		}
	}
}
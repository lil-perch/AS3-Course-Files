//Find the SCORM 1.2 API.
//Ideas for this code come initially from the ADL and improved upon by Mike Rustici, Rustici Software, LLC as well as from Adobe.
// Modified and implemented for Rapid Intake by Steven Hancock, Rapid Intake, Inc.

var MAX_PARENTS_TO_SEARCH = 500; //Number of parent windows to search.
var MAX_TIME_INTERVAL = 10; //Used to determine how long to wait until it should stop searching for API.
var g_objAPI = null; //Contains the API object.
var g_initAPIcnt = 0; //Counter for timed attempts to find API.
var g_strAPIInitialized = false; //Used to determine if SCO is initialized.
var g_varInterval = "";			// global interval for timed checking 
var g_dtmInitialized = new Date(); // Used for reporting session time.
var g_bFinishDone = false;

/*
ScanParentsForApi
-Searches all the parents of a given window until
 it finds an object named "API". If an
 object of that name is found, a reference to it
 is returned. Otherwise, this function returns null.
*/
function ScanParentsForApi(win)
{
/*
      Establish an outrageously high maximum number of
      parent windows that we are will to search as a
      safe guard against an infinite loop. This is
      probably not strictly necessary, but different
      browsers can do funny things with undefined objects.
      */
      var nParentsSearched = 0;
	
	var api = null;

	api = findTheAPI(win);

      /*
      Search each parent window until we either:
             -find the API,
             -encounter a window with no parent (parent is null
                        or the same as the current window)
             -or, have reached our maximum nesting threshold
      */
      while ( (api == null) &&
                  (win.parent != null) && (win.parent != win) &&
                  (nParentsSearched <= MAX_PARENTS_TO_SEARCH)
              )
      {
            
			nParentsSearched++;
            win = win.parent;
			api = findTheAPI(win);
      }
      /*
      If the API doesn't exist in the window we stopped looping on,
      then this will return null.
      */
      return api;
}

/*
GetAPI
-Searches all parent and opener windows relative to the
 current window for the SCORM 2004 API Adapter.
 Returns a reference to the API Adapter if found or null
 otherwise.
*/
function GetApi()
{
      var theApi = null;
	//Search child frames first
	theApi = findTheAPI(window);
      //Search all the parents of the current window if there are any
      if ((theApi == null) && (window.parent != null) && (window.parent != window))
      {
            theApi = ScanParentsForApi(window.parent);
      }

      /*
      If we didn't find the API in this window's chain of parents,
      then search all the parents of the opener window if there is one
      */
      if ((theApi == null) && (window.top.opener != null))
      {
            theApi = ScanParentsForApi(window.top.opener);
      }

      return theApi;
}

/*findTheAPI
 - Searches through the window and the child frames
   for the API obj.
*/


function findTheAPI(win)
{
	// Search the window hierarchy for an object named "API" for SCORM 1.2
	// Look in the current window (win) and recursively look in any child frames
	if(win.API_1484_11 != null){
		return win.API_1484_11;
	}
	if (win.length > 0)  // check frames
	{
		for (var i=0;i<win.length;i++)
		{
			var objAPI = findTheAPI(win.frames[i]);
			if (objAPI != null)
			{
				return objAPI;
			}
		}
	}
	return null;
}

/*
initAPI 
- Called at intervals from main page to check and see
  if the API object has been found.
  This accounts for situations when things may not load as quickly as we think.
*/
function initAPI() {
	//window.alert("start")
	if (g_initAPIcnt < MAX_TIME_INTERVAL && !g_strAPIInitialized) {
		if(APIOK()) {
			clearInterval(g_varInterval);
			var err = initializeSCO();
			//alert(err)
		} else {
			g_objAPI = GetApi();
		}
	} else {
		g_objAPI = null;
		clearInterval(g_varInterval);
	}
	g_initAPIcnt++;
}

/*
APIOK
- checks to see if the api object has been found and exists.
*/
function APIOK() {
	return (g_objAPI != null)
}

/*
isSCOInitialized
 - Used by Flash course to find out if the sco has been initialized.
*/
function isSCOInitialized() {
	return g_strAPIInitialized;
}

/*
initializeSco
 - Initializes SCO with teh LMS and sets the global variable.
*/
function initializeSCO() {
	var err = true;
	if (!g_strAPIInitialized) {
		g_strAPIInitialized = g_objAPI.Initialize("");
		g_dtmInitialized = new Date();
	}
	if (g_strAPIInitialized) {
		//Set status and exit.
		
		if ( SCOGetValue("cmi.mode") != "review"){
			var lesson_status = SCOGetValue("cmi.completion_status");
			if (lesson_status != "completed"){
				SCOSetValue("cmi.completion_status","incomplete");
			}
		}
		SCOSetValue("cmi.exit","suspend");
		return ("true");
	} else {
		return ("false");
	}
}

/*
SCOFinish
 - Used to complete the SCO.
*/
function SCOFinish() {
	if ((APIOK()) && g_strAPIInitialized && (g_bFinishDone == false)) {
		SCOReportSessionTime()
		var err = g_objAPI.Terminate("");
		if (err == true || err == "true") g_bFinishDone = true;
	}
	return (g_bFinishDone + "" ) // Force type to string
}

/*
MillisecondsToCMIDuration
 - Convert duration from milliseconds to 0000:00:00.00 format
*/
function MillisecondsToCMIDuration(n) {
//Convert duration from milliseconds to 0000:00:00.00 format
	var hms = "";
	var dtm = new Date();	dtm.setTime(n);
	var h = "000" + Math.floor(n / 3600000);
	var m = "0" + dtm.getMinutes();
	var s = "0" + dtm.getSeconds();
	var cs = "0" + Math.round(dtm.getMilliseconds() / 10);
	hms = "PT" + h.substr(h.length-4)+"H"+m.substr(m.length-2)+"M";
	hms += s.substr(s.length-2)+"S";
	return hms
}

/*
SCOReportSessionTime
 - Used to report session time when SCO is closed.
*/
function SCOReportSessionTime() {
	var dtm = new Date();
	var n = dtm.getTime() - g_dtmInitialized.getTime();
	return SCOSetValue("cmi.session_time",MillisecondsToCMIDuration(n))
}

//**********************************************
//SCORM Communication functions

/*
SCOSetValue
 - Set value in LMS.
   Pass in element name and value.
*/
function SCOSetValue(nam,val){
	var err = "";
	if (APIOK()){
			err = g_objAPI.SetValue(nam,val.toString() + "");
			if (err != "true") {
				return err
			} else {
				// Check to see if suspend was passed that this is committed immediately.
				if (nam == "cmi.exit" && val.toString() == "suspend")
					SCOCommit();
			}
	}
	return err.toString();
}
/*
SCOGetValue
 - Retrieves a value for the element passed in.
*/
function SCOGetValue(nam)		{
	return ((APIOK())?g_objAPI.GetValue(nam.toString()):"")
}
/*
- All other SCORM communcation functions.
*/
function SCOCommit()			{return ((APIOK())?g_objAPI.Commit(""):"false")}
function SCOGetLastError()		{return ((APIOK())?g_objAPI.GetLastError():"-1")}
function SCOGetErrorString(n)	{return ((APIOK())?g_objAPI.GetErrorString(n):"No API")}
function SCOGetDiagnostic(p)	{return ((APIOK())?g_objAPI.GetDiagnostic(p):"No API")}

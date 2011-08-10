//Javascript Document

/*
	Additional SCORM Javascript functions to enhance the ability of Flash
	to work with the Rustici Code.
	
	Developed By: Steven Hancock/Rapid Intake
	
	Date: 3/31/2011

*/
//Records Multiple Choice interaction. Converts learner Response and correct response to object.
function PreRecordMultipleChoiceInteraction(strID,lResponse,blnCorrect,cResponse,description,weight,latency,objectiveID)
{
	var tmp:Array = lResponse.split("^");
	var lObj = CreateResponseIdentifier(tmp[0],tmp[1]);
	var tmp2:Array = cResponse.split("^");
	var cObj = CreateResponseIdentifier(tmp2[0],tmp2[1])
	
	RecordMultipleChoiceInteraction(strID,lObj,blnCorrect,cObj,description,weight,latency,objectiveID);
}

//Retrieves learner response for multiple choice. Converts object to string and returns in an array.
function PreGetInteractionLearnerResponsesChoice(strID)
{
	var tmp:Array = GetInteractionLearnerResponses(strID);
	var newArray;
	
	for (var i = 0;i<tmp.length();i++)
	{
		if (typeof(tmp[i] == "object")
		{
			newArray[i] = tmp[i].Short + "^" + tmp[i].Long;
		} else {
			newArray[i] = tmp[i];
		}
	}
	return newArray;
}

//Records Multiple Correct interaction. Converts learner Response and correct response to object and places in an array.
function PreRecordMultipleCorrectInteraction(strID,lResponse,blnCorrect,cResponse,description,weight,latency,objectiveID)
{
	var newLResp = new Array();
	var newCResp = new Array();
	
	for (var i = 0;i<lResponse.length();i++)
	{
		var tmp:Array = lResponse[i].split("^");
		var lObj = CreateResponseIdentifier(tmp[0],tmp[1]);
		newLResp[i] = lObj;
	}
	
	for (var j = 0;j<cResponse.length();j++)
	{
		var tmp2:Array = cResponse[j].split("^");
		var cObj = CreateResponseIdentifier(tmp2[0],tmp2[1])
		newCResp[j] = cObj;
	}
	
	
	RecordMultipleChoiceInteraction(strID,newLResp,blnCorrect,newCResp,description,weight,latency,objectiveID);
}

function GetCommunicationStandard()
{
	return objLMS.Standard;
}
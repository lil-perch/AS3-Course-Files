package src
{
	import flash.events.Event;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.external.ExternalInterface;
	import flash.system.fscommand;
	
	public class Controller
	{
		public var model:CourseModel;
		
		public function Controller(m:CourseModel)
		{
			model = m;
		}
		
		public function nextPage(e:Event = null):void //Set the event to Null so this function can be called without an event.
		{
			if (e)
			{
				if (e.target.enabled) model.changePage(1);
			} else {
				model.changePage(1);
			}
		}
		
		public function prevPage(e:Event = null):void
		{
			if (e)
			{
				if (e.target.enabled) model.changePage(-1);
			} else {
				model.changePage(-1);
			}
		}
		
		public function setAudioTransform(v:SoundTransform):void //Pan or Volume globally can be set here.
		{
			SoundMixer.soundTransform = v;
		}
		
		public function showGlossary(e:Event = null):void
		{
			//trace("glossary clicked: " + model.glossaryState);
			if (model.glossaryState == "visible")
			{
				model.glossaryState = "hidden";
			} else if (model.glossaryState == "hidden") {
				model.glossaryState = "visible";
			}
		}
		
		public function exitCourse(e:Event = null):void
		{
			trace("EXIT COURSE" + e.target.root.loaderInfo.loaderURL);
			if (e.target.root.loaderInfo.loaderURL.indexOf(".exe") > -1 || e.target.root.loaderInfo.loaderURL.indexOf(".hqx") > -1){
				fscommand("quit")
			} else {
				if (ExternalInterface.available) ExternalInterface.call('window.close');
			}
		}
		
		public function slideIndex(e:Event = null):void
		{	
			if (model.indexVisibleState == "visible")
			{
				model.indexVisibleState = "hidden";
			} else if (model.indexVisibleState == "hidden") {
				model.indexVisibleState = "visible";
			}
		}
	}
}
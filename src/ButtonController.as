package src
{
	import flash.events.Event;
	import flash.media.SoundTransform;
	
	public class ButtonController extends Controller
	{
		public function ButtonController(m:CourseModel) //the parent class reads in the model so we must do it here.
		{
			super(m);
		} 
		
		public function adjustAudio(e:Event = null):void
		{
			var vol:SoundTransform = new SoundTransform();
			if (model.audioStatus == "on")
			{
				model.audioStatus = "off";
				vol.volume = 0;
			} else if (model.audioStatus == "off"){
				model.audioStatus = "on";
				vol.volume = model.audioVolume;
			}
			setAudioTransform(vol);
		}
		
		public function onIndexClick(e:Event = null):void
		{
			if (model.indexState == "index")
			{
				model.indexState = "read";
			} else if (model.indexState == "read") {
				model.indexState = "index";
			}
			//Call either handle Narration or handleIndex
			//Or maybe the model calls something in the view.
		}
	}
}
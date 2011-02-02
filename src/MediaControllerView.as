package src
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import src.AssetClasses.MediaControl;
	import src.classes.Path;
	import src.com.Presentation;

	public class MediaControllerView extends View
	{
		private var _mediaControl:MovieClip;
		private var _loader:Loader;
		private var _mediaPlayer:MediaControl;
		private var _presentation:Presentation;
		
		public function MediaControllerView(m:MovieClip,paths:Path,p:Presentation,cm:CourseModel)
		{
			_mediaControl = m;
			_presentation = p;
			model = cm;
			_loader = new Loader();
			_mediaControl.addChild(_loader);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, controlLoaded);
			
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,controlLoading);
			
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadingError);
			
			_loader.load(new URLRequest(paths.controlSWF));
		}
		
		override public function update(event:Event = null):void
		{
			//Find out if media controller should be visible.
			var cm:CourseModel = CourseModel(model);
			if (cm.pageAttributes.loadPercentage == 0)
			{
				cm.mediaControlVisible = false;
			} else {
				cm.mediaControlVisible = true;
			}
		}
		
		//Override for Button View because it needs to subscribe to another event
		override public function set model(m:Model):void
		{
			super.model = m;
			model.addEventListener(CourseModel.MEDIA_CHANGED, updatePlayPauseButton);
			model.addEventListener(CourseModel.MEDIACONTROL_STATE, hideShowControl);
		}
		
		private function hideShowControl(e:Event):void
		{
			_mediaControl.visible = CourseModel(model).mediaControlVisible;
		}
		
		public function contentLoaded(e:Event):void
		{
			trace("CONTENT LOADED in MEDIA CONTROL VIEW");
		}
		
		private function updatePlayPauseButton(e:Event = null):void//Event = null allows us to call this directly.
		{
			try {
				_mediaPlayer.updatePlayPauseButton();
			} catch(error:Error) {
				trace("MEDIA PLAYER NOT INSTANTIATED WHEN TRYING TO UPDATE PLAY BUTTON.");
			}
		}
		
		private function controlLoading(e:ProgressEvent):void
		{
			
		}
		
		private function controlLoaded(e:Event):void
		{
			trace("MEDIA CONTROLLER LOADED.");
			_mediaPlayer = MediaControl(_loader.content);
			_mediaPlayer.model = model;
			_mediaPlayer.presentation = _presentation;
			_mediaPlayer.setUpButtons();
			_mediaPlayer.setUpLocalConnection();
		}
		
		private function loadingError(e:IOErrorEvent):void
		{
			trace("PROBLEM LOADING THE MEDIA CONTROLLER: " + e);
		}
	}
}
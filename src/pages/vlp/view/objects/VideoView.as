package src.pages.vlp.view.objects {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.AsyncErrorEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.media.Video;
	import fl.controls.Button;
	import flash.events.MouseEvent;
	import src.pages.vlp.view.assets.MediaControllerAssets;
	
	public class VideoView extends ObjectView{
			
		
		private var MediaAsset:MediaControllerAssets = new MediaControllerAssets();
			
		public function VideoView(){
			//this.width = 200;
			//this.height = 100;
			
		}
		
		override public function get viewType():String
		{
			return _viewType;
		}
		
		public var _viewType:String = 'Video';
		
		[Bindable]
		private var _bgAlpha:Number = 1;
		
		private var outputText:TextField;
		
		private var videoMc:MovieClip;
		private var video:Video;
		
		private var videoURL:String = "";
        private var connection:NetConnection;
        private var stream:NetStream;
		
		private var oh:Number;
		private var ow:Number;
		private var _maintainAspectRatio:Boolean = true;
		
		private var _widthDirty:Boolean = false;
		private var _heightDirty:Boolean = false;
		
		
		private var backBtn:Button;
		private var playBtn:Button;
		
		private var _autoPlay:Boolean = false;
		
		private var okToPlay:Boolean = false;
		
		private var isPlaying:Boolean = false;
		private var streamStarted:Boolean = false;
		
		
		override public function setDimentions(w:Number,h:Number):void{
		}
		
		
		override public function setObjectData(value:XML, isNew:Boolean=false):void
		{
			super.setObjectData(value);
			if(value)
			{
				_bgAlpha = parseFloat(value.@alpha)/100;
				
				// Add Black Background
				videoMc = new MovieClip();
				videoMc.graphics.beginFill(0x000000);
				videoMc.graphics.drawRect(0, 0, 100, 80);
				videoMc.graphics.endFill();
            	addChild(videoMc);
				
				_autoPlay = (value.@autoPlayMedia+""=='true')?true:false;
				trace("~~~~AUTOPLAY VIDEO","("+value.@autoPlayMedia+")","("+_autoPlay+")");
				
				videoURL = value.@mediaPath+"";
				connection = new NetConnection();
            	connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
           		connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            	connection.connect(null);
				
				backBtn = new Button();
				backBtn.move(0,0);
				backBtn.label = '';
				backBtn.width = 40;
				backBtn.height = 22;
				backBtn.addEventListener(MouseEvent.CLICK,rewind);
				backBtn.setStyle('upSkin',MediaAsset.BackUp);
				backBtn.setStyle('downSkin',MediaAsset.BackDown);
				backBtn.setStyle('overSkin',MediaAsset.BackOver);
				
				//backBtn.x = 0;
				addChild(backBtn);
				
				playBtn = new Button();
				playBtn.move(0,40);
				playBtn.label = '';
				playBtn.width = 40;
				playBtn.height = 22;
				playBtn.addEventListener(MouseEvent.CLICK,play_pause);
				if(_autoPlay){
					playBtn.setStyle('upSkin',MediaAsset.PauseUp);
					playBtn.setStyle('downSkin',MediaAsset.PauseDown);
					playBtn.setStyle('overSkin',MediaAsset.PauseOver);
				}
				else{
					playBtn.setStyle('upSkin',MediaAsset.PlayUp);
					playBtn.setStyle('downSkin',MediaAsset.PlayDown);
					playBtn.setStyle('overSkin',MediaAsset.PlayOver);
				}
				
				
				
				//playBtn.x = 41;
				addChild(playBtn);
				
			}
		}
		private function buttonClick(event:MouseEvent):void{
			
		}
		
		private function netStatusHandler(event:NetStatusEvent):void {
            switch (event.info.code) {
                case "NetConnection.Connect.Success":
                    okToPlay = true;
					connectStream();
                    break;
                case "NetStream.Play.StreamNotFound":
                    trace("Unable to locate video: " + videoURL);
                    break;
            }
        }

        private function connectStream():void {
            stream = new NetStream(connection);
            stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
            video = new Video();
            video.attachNetStream(stream);
			
			if(_autoPlay){
				stream.play(videoURL);
				streamStarted = true;
				isPlaying = true;
			}
			
            addChild(video);
			ow = video.width/video.height;
			oh = video.height/video.width;
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event);
        }
        
        private function asyncErrorHandler(event:AsyncErrorEvent):void {
            // ignore AsyncErrorEvent events.
        }
		
		
		protected function rewind(event:MouseEvent=null):void{
			
			if(isPlaying){
				stream.play(videoURL);
				playBtn.setStyle('upSkin',MediaAsset.PauseUp);
				playBtn.setStyle('downSkin',MediaAsset.PauseDown);
				playBtn.setStyle('overSkin',MediaAsset.PauseOver);
				//playBtn.toolTip = "Pause";
				isPlaying = true;
			}
			else{
				stream.play(videoURL);
				stream.pause();
				playBtn.setStyle('upSkin',MediaAsset.PlayUp);
				playBtn.setStyle('downSkin',MediaAsset.PlayDown);
				playBtn.setStyle('overSkin',MediaAsset.PlayOver);
				//playBtn.toolTip = "Play";
				isPlaying = false;
			}
		}
		
		protected function play_pause(event:MouseEvent=null):void{
			if(isPlaying){
				stream.pause();
				playBtn.setStyle('upSkin',MediaAsset.PlayUp);
				playBtn.setStyle('downSkin',MediaAsset.PlayDown);
				playBtn.setStyle('overSkin',MediaAsset.PlayOver);
				//playBtn.toolTip = "Play";
			}
			else{
				if(streamStarted)
					stream.resume();
				else{
					stream.play(videoURL);
					resizeVideo();
				}
				playBtn.setStyle('upSkin',MediaAsset.PauseUp);
				playBtn.setStyle('downSkin',MediaAsset.PauseDown);
				playBtn.setStyle('overSkin',MediaAsset.PauseOver);
				//playBtn.toolTip = "Pause";
			}
			isPlaying = !isPlaying;
		}
		
		override public function set width(value:Number):void{
			super.width = value;
			if(videoMc){
				videoMc.width = value;
				if(_heightDirty){
					resizeVideo();
				}
				else{
					_widthDirty = true;
				}
			}
		}
		
		override public function set height(value:Number):void{
			super.height = value;
			if(videoMc){
				videoMc.height = value;
				if(_widthDirty){
					resizeVideo();
				}
				else{
					_heightDirty = true;
				}
				// Reposition control buttons
				backBtn.move(0,value-22);
				playBtn.move(40,value-22);
			}
		}
		
		public function resizeVideo():void{
			_heightDirty = false;
			_widthDirty = false;			
			// Proportional size
			if ((videoMc.height / videoMc.width) > oh) {
				video.width = videoMc.width;
				video.height = oh * video.width;
			} else {
				video.height = videoMc.height;
				video.width = ow * video.height;
			}
			// Center
			video.x = Math.abs((videoMc.width-video.width)/2);
			video.y = Math.abs((videoMc.height-video.height)/2);
		}
	
	}
	
}
package src.pages.vlp.view.objects {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import src.pages.vlp.manager.Audio;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.greensock.*;

	public class AudioView extends ObjectView{
		
		private var playAudioBtn:MovieClip;
		private var pauseAudioBtn:MovieClip;
		
		override public function get viewType():String
		{
			return _viewType;
		}
		
		public var _viewType:String = 'Audio';
		
		private var _bgAlpha:Number = 1;
		
		private var outputText:TextField;
		
		private var _audioData:XML;
		
		private var _imageW:Number;
		private var _imageH:Number;
		
		private var _audio:Audio;
		private var _audioSource:String;
		
		private var _image:MovieClip;
		private var loader:Loader;
		private var _audioIconSource:String;
		
		private var _autoPlay:Boolean = false;
		
		
		public function AudioView(){
			this.width = 200;
			this.height = 100;
			
			this.addEventListener(MouseEvent.ROLL_OVER, showTools);
			this.addEventListener(MouseEvent.ROLL_OUT, hideTools);
			
			playAudioBtn = new MovieClip();
			loader = new Loader();
			playAudioBtn.addEventListener(MouseEvent.CLICK, playAudio);
			loader.load(new URLRequest('src/pages/vlp/assets/media/media_playback_start.png'));
			playAudioBtn.addChild(loader);
			
			pauseAudioBtn = new MovieClip();
			pauseAudioBtn.visible = false;
			loader = new Loader();
			loader.load(new URLRequest('src/pages/vlp/assets/media/media_playback_pause.png'));
			pauseAudioBtn.addChild(loader);
			
		}
		
		override public function setObjectData(value:XML, isNew:Boolean=false):void
		{
			super.setObjectData(value);
			_audioData = value;
			if(_audioData)
			{
				_bgAlpha = parseFloat(value.@alpha)/100;
				
				_audio = new Audio();
				
				_autoPlay = (_audioData.@autoPlay+""=='true')?true:false;
				
				if(_audioData.@mediaPath != _audioData.@nonExsistanceAttribute)
				{
					_audioSource = _audioData.@mediaPath.toString();
				}
				else
				{
					_audioSource = "src/pages/vlp/assets/sample_audio.mp3";
				}
				_audio.autoPlay = false;
				_audio.source = _audioSource;
				
				
				// Set image source
				if(_audioData.@audioIcon != _audioData.@nonExsistanceAttribute)
				{
					_audioIconSource = _audioData.@audioIcon.toString();
				}
				else
				{
					_audioIconSource = 'src/pages/vlp/assets/img/autojonas-rask-itunes-icon.png';
				}
				
				// Load Image
				loader = new Loader();
				_image = new MovieClip();
				_image.visible = false;
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, displayImage);		 	
				loader.load(new URLRequest(_audioIconSource));
				_image.addChild(loader);
				this.addChild(_image);
			}
		}
		
		private function displayImage(evt:Event):void{
			// set image
			_image.width = _imageW;
			_image.height = _imageH;
			_image.visible = true;
			
			// Add play/pause buttons on top
			this.addChild(playAudioBtn);
			this.addChild(pauseAudioBtn);
			hideTools();
			if(_autoPlay){
				playAudio();
			}
		}
		
		public function playAudio(evt:Event=null):void{
			playAudioBtn.visible = false;
			playAudioBtn.removeEventListener(MouseEvent.CLICK,playAudio);
			
			pauseAudioBtn.visible = true;
			pauseAudioBtn.addEventListener(MouseEvent.CLICK, pauseAudio);
			
			_audio.play();
		}
		
		public function pauseAudio(evt:Event=null):void{
			pauseAudioBtn.visible = false;
			pauseAudioBtn.removeEventListener(MouseEvent.CLICK,pauseAudio);
			
			playAudioBtn.visible = true;
			playAudioBtn.addEventListener(MouseEvent.CLICK, playAudio);
			
			_audio.pause();
		}
		public function showTools(evt:Event=null):void{
			TweenLite.to(playAudioBtn, .25, {alpha:.7});
			TweenLite.to(pauseAudioBtn, .25, {alpha:.7});
		}
		public function hideTools(evt:Event=null):void{
			TweenLite.to(playAudioBtn, .25, {alpha:0});
			TweenLite.to(pauseAudioBtn, .25, {alpha:0});
		}
		
		
		override public function set width(value:Number):void{
			super.width = value;
			_imageW = value;
			if(_image){
				_image.width = value;
				playAudioBtn.x = (value-48)/2;
				pauseAudioBtn.x = (value-48)/2;
			}
		}
		
		override public function set height(value:Number):void{
			super.height = value;
			_imageH = value;
			if(_image){
				_image.height = value;
				playAudioBtn.y = (value-48)/2;
				pauseAudioBtn.y = (value-48)/2;
			}
		}

	}
	
}
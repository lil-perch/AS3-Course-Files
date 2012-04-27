package {

	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import com.greensock.events.*;
	import com.greensock.loading.*;
	
	import flash.display.*;		
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import src.pages.utils.*;
	
	public class Intro extends MovieClip
	{		
		public var HEADER_TEXT :String = "";
		public var MESSAGE_TEXT :String = "";
		private var MP3_URL :String = "";		
		
		// Sounds
		private var snd:Sound = new Sound();// Sound manager variable
		private var sndChannel:SoundChannel = new SoundChannel();// Sound manager variable				
		private var req:URLRequest;
		
		private var currentPageTag;
		
		public function init(header :String, msg :String, mp3URL :String)
		{			
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
			TweenPlugin.activate([TintPlugin]);
			
			currentPageTag = MovieClip(this.parent).currentPageTag
			
			this["message_txt"].text = msg;	
			this["header_txt"].text = header;			
			MP3_URL = mp3URL;									
						
			
			start_btn.title_txt.text = currentPageTag.btn.@start;																		
			start_btn.useHandCursor = true;										
			Events.doEvents(start_btn,hideWindow);																										
			doColor(this["bg_mc"].bg_mc,currentPageTag.color.@title_bar);						
		}		
		
		// Changes the color of a MovieClip
		private function doColor(_btn, _color)
		{
			if (_color != "" && _color != undefined)
			{					
				TweenMax.to(_btn,0,{tint:_color});
			}
		}
			
		// Load a  Sound
		private function doSound(audio_path, _snd)
		{
			if (audio_path != null && audio_path != "")
			{
				var _snd = new Sound();
				req = new URLRequest(audio_path);
				_snd.load(req);
				return _snd.play();
			}
		}
		
		public function showWindow()
		{			
			this.visible = true;
			this.alpha = 0;
			TweenMax.killTweensOf(this);
			TweenMax.to(this, 1, {alpha: 1, ease:Strong.easeIn, onComplete:loadSound});			
		}
		
		private function loadSound()
		{
			if (MP3_URL != "")
			{
				sndChannel = doSound(MP3_URL,snd);
			}
		}
								
		public function hideWindow(_ref:MovieClip)
		{
			TweenMax.to(this, 1, {autoAlpha: 0, ease:Strong.easeOut});
			sndChannel.stop();						
			
			// Init Stage2
			MovieClip(this.parent).initStage2();
		}
		
	}
	
	
}
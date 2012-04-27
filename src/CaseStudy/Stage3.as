package {
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
		
	import flash.display.*;			
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	
	import src.pages.utils.*;
	
	public class Stage3 extends MovieClip
	{
	
		private var presentSizeW;
		private var presentSizeH;
	
		private var HEADER_TEXT:String = "";
		private var MESSAGE_TEXT:String = "";
		private var IMG_URL:String = "";
		private var IMG_PLACE:String = "right";
		private var MP3_URL:String = "";
	
	
		// NEW
		private var LINK:String = "";			
		//initial image params
		private var _imgObj:Object = new Object();
	
		private var _isZoom:Boolean = false;
	
		//Sounds
		private var snd:Sound = new Sound();// Sound manager variable
		private var sndChannel:SoundChannel = new SoundChannel();// Sound manager variable				
		private var req:URLRequest;
	
	
		public function init(header:String, msg:String, url:String, place:String, mp3URL:String, link)
		{
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
			
						
			
			TweenPlugin.activate([TintPlugin]);
			presentSizeW = MovieClip(this.parent).presentSizeW;
			presentSizeH = MovieClip(this.parent).presentSizeH;
	
	
			HEADER_TEXT = header;
			MESSAGE_TEXT = msg;
			IMG_URL = url;
			IMG_PLACE = place;
			MP3_URL = mp3URL;
			LINK = link;
	
			
			initInterface();
	
			header_txt.text = HEADER_TEXT;			
			message_txt.text = MESSAGE_TEXT;
	
			var me = this;
			
	
			this["continue_btn"].visible = (LINK == "Type in name of page you want to link to"|| LINK == null || LINK == "")?false:true;
			this["continue_btn"].title_txt.text = MovieClip(this.parent).currentPageTag.btn[0].@continue_btn;
			doColor(this["bg_mc"].bg_mc,MovieClip(this.parent).currentPageTag.color[0].@title_bar);
			
			//doEventsColor(this["continue_btn"],undefined,MovieClip(this.parent).currentPageTag.color[0].@button,MovieClip(this.parent).currentPageTag.color[0].@button_over);
												
				
			Events.doEvents(this["continue_btn"],function()
				{
						trace("[MISSING IN AS3] GoToPage____ "+LINK);
						//MovieClip(this.parent.parent.parent).goToPage(LINK);
					
				}
			);							
				
			
			
			if (IMG_URL != "")
			{
				loadImage();
			}						
			
			//This is where it was Jeff
		}
	
		public function initInterface()
		{
			var tX:Number = 26;
	
			if (IMG_URL == "" || IMG_URL == null)
			{
				picture_mask_mc.visible = false;
				picture_mask_mc.zoom_btn.visible = false;
				picture_mask_mc.zoom_btn.visible = false;
				message_txt.message_txt.width = bg_mc.width - message_txt.scroll_mc.width - tX;
				message_txt.x = tX / 2;
				message_txt.scroll_mc.x = message_txt.message_txt.width + message_txt.message_txt.x;			
				continue_btn.x = message_txt.x + (message_txt.width / 2 - continue_btn.width / 2);
			}
			else
			{
				if (IMG_PLACE == "right")
				{
					picture_mask_mc.x = bg_mc.width - picture_mask_mc.width - tX / 2;
					message_txt.x = tX / 2;
	
	
					message_txt.message_txt.width = bg_mc.width - picture_mask_mc.width - message_txt.scroll_mc.width - tX / 2 - tX;
					message_txt.scroll_mc.x = message_txt.message_txt.width;
					message_txt.x = tX / 2;
					continue_btn.x = message_txt.x + (message_txt.width / 2 - continue_btn.width / 2);
	
	
	
					//picture_mask_mc.zoom_btn.y = picture_mask_mc._height - picture_mask_mc.zoom_btn._height-200;
					//picture_mask_mc.zoom_btn.y = 0;
				}
				else
				{
					picture_mask_mc.x = tX / 2;
					message_txt.x = picture_mask_mc.x + picture_mask_mc.width + tX / 2;
					message_txt.message_txt.width = bg_mc.width - picture_mask_mc.width - message_txt.scroll_mc.width - tX / 2 - tX;
					message_txt.scroll_mc.x = message_txt.message_txt.width;
					//picture_mask_mc.zoom_btn.x =  picture_mask_mc.width - picture_mask_mc.zoom_btn.width;
					//picture_mask_mc.zoom_btn.y = picture_mask_mc._height - picture_mask_mc.zoom_btn._height;
	
				}
							
				
				//picture_mask_mc.zoom_btn.x = 0 //picture_mask_mc.x + zoom_btn.x - tX;
				//picture_mask_mc.zoom_btn.y =  picture_mask_mc.border.y + picture_mask_mc.border._height // - picture_mask_mc.zoom_btn._height - 5;			
				
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
			this.alpha = 0;
			TweenLite.to(this,3,{alpha:1, ease:Strong.easeOut});
	
			if (MP3_URL != "")
			{
				sndChannel = doSound(MP3_URL,snd);
			}			
		}
	
		public function hideWindow()
		{
			TweenLite.to(this,3,{alpha:0, ease:Strong.easeOut});
			sndChannel.stop();
		}
	
		private function loadImage()
		{					
			picture_mask_mc.loadImage(IMG_URL,presentSizeW,presentSizeH, -(picture_mask_mc.x+this.x), -(picture_mask_mc.y+this.y));		
		}
	
		private function doColor(_btn, _color)
		{
			if (_color != "" && _color != undefined)
			{
				TweenMax.to(_btn,0,{tint:_color});
			}
		}
	
	
	
		private function doEventsColor(_mc, _fx, _over, _out)
		{
			_mc.fx = _fx;
				
			doColor(_mc.base_mc,_out);
			_mc._outColor = _out;
			_mc._overColor = _over;
			_mc.ref = this;
			_mc.onRollOver = function()
			{
					
				this.base_mc.gotoAndStop("over");
	
				this.ref.doColor(this.base_mc,this._overColor);
			};
			_mc.onRollOut = _mc.onReleaseOutside = function ()
			{
				this.base_mc.gotoAndStop("out");
				this.ref.doColor(this.base_mc,this._outColor);
			};
			_mc.onRelease = function()
			{
				this.base_mc.gotoAndStop("out");
				this.ref.doColor(this.base_mc,this._outColor);
				this.fx.apply(this._parent);
			};
		}
	}	
}
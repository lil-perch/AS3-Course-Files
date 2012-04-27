package
{
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	
	import flash.display.*;			
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import flash.events.*;
	import src.pages.utils.*;
	
	
	public class Stage2 extends MovieClip
	{
	
		private var presentSizeW;
		private var presentSizeH;
	
		private var HEADER_TEXT:String = "";
		private var MESSAGE_TEXT:String = "";
		private var IMG_URL:String = "";
		private var IMG_PLACE:String = "right";
		private var MP3_URL:String = "";
	
		//initial image params
		private var _imgObj:Object = new Object();
	
		private var _isZoom:Boolean = false;
			
		// Sounds
		private var snd:Sound = new Sound();// Sound manager variable
		private var sndChannel:SoundChannel = new SoundChannel();// Sound manager variable				
		private var req:URLRequest;
	
	
		public function init(header:String, msg:String, url:String, place:String, mp3URL:String)
		{
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
			
			presentSizeW = MovieClip(this.parent).presentSizeW;
			presentSizeH = MovieClip(this.parent).presentSizeH;
	
	
			title_mc.width = presentSizeW;
			header_txt.width = presentSizeW - 20;
			submit_btn.x = presentSizeW - 25 - submit_btn.width;
			submit_btn.y = presentSizeH - 25 - submit_btn.height;
			input_txt.width = presentSizeW - 50;
			input_txt.x = presentSizeW / 2 - input_txt.width / 2;
			input_txt.y = message_txt.height + message_txt.y + 10;
	
			bg_text.height = input_txt.height;
			bg_text.width = input_txt.width;
			bg_text.x = input_txt.x;
			bg_text.y = input_txt.y;
			HEADER_TEXT = header;
			MESSAGE_TEXT = msg;
			IMG_URL = url;
			IMG_PLACE = place;
			MP3_URL = mp3URL;

	
			header_txt.text = HEADER_TEXT;			
			message_txt.text = MESSAGE_TEXT;
			
			initInterface();
	
			var me = this;
	
			this["submit_btn"].title_txt.text = MovieClip(this.parent).currentPageTag.btn[0].@submit_btn;
			doColor(this["title_mc"],MovieClip(this.parent).currentPageTag.color[0].@title_bar);
	
			doEventsColor(this["submit_btn"],undefined,MovieClip(this.parent).currentPageTag.color[0].@button,MovieClip(this.parent).currentPageTag.color[0].@button_over);	
	
			submit_btn.useHandCursor = true;										
			Events.doEvents(submit_btn,function()
				{
					if (me.input_txt.text == "")
					{
						//Alert.show("Please type something in text field","Attention!");						
						MovieClip(this.parent).alert_mc.showWindow("Please type something in text field");
					}
					else
					{
						MovieClip(this.parent.parent).recordInteraction();
						MovieClip(this.parent).initStage3();
					}
				}
			);																										
			
			
	
			if (IMG_URL != "")
			{
				loadImage();
			}
		}
	
		public function initInterface()
		{
			var tX:Number = 26;
			if (IMG_URL == "" || IMG_URL == null)
			{				
				picture_mask_mc.visible = false;
				picture_mask_mc.zoom_btn.visible = false;
				message_txt.message_txt.width = presentSizeW - message_txt.scroll_mc.width - tX * 2;
				message_txt.message_txt.x = 0;
				message_txt.x = tX;
				message_txt.scroll_mc.x = message_txt.message_txt.width + message_txt.message_txt.x;
			}
			else
			{
					
				if (IMG_PLACE == "right")
				{
	
					picture_mask_mc.x = presentSizeW - picture_mask_mc.width - tX;
					message_txt.x = tX;
					//picture_mask_mc.zoom_btn._x = picture_mask_mc._x + zoom_btn._x - tX;
					message_txt.message_txt.width = presentSizeW - message_txt.scroll_mc.width - (presentSizeW - picture_mask_mc.x) - 2 * tX;
					message_txt.scroll_mc.x = message_txt.message_txt.width;
										
					trace("W: "+message_txt.message_txt.width)
					trace("X: "+message_txt.scroll_mc.x)
					
				}
				else
				{				
					
					message_txt.message_txt.width = presentSizeW - picture_mask_mc.width - message_txt.scroll_mc.width - picture_mask_mc.x - 40;
					message_txt.scroll_mc.x = message_txt.message_txt.width;
				}
	
	
				//picture_mask_mc.zoom_btn._x = picture_mask_mc._x + zoom_btn._x - tX;
				//picture_mask_mc.zoom_btn._y =  picture_mask_mc.holder_mc._y + picture_mask_mc.holder_mc._height - picture_mask_mc.zoom_btn._height - 5;
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
			picture_mask_mc.loadImage(IMG_URL,presentSizeW,presentSizeH,-picture_mask_mc.x,-picture_mask_mc.y);
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
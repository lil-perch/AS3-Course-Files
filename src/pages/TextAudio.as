package src.pages
{
	import flash.events.*;
	import src.pages.DynamicPageAPI;
	import src.pages.vlp.manager.*;
	import flash.text.TextField;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import fl.controls.UIScrollBar;
	import src.Model;
	// LoaderMax
	
	import com.greensock.*;
 	import com.greensock.events.*;
 	import com.greensock.loading.*;
	import com.greensock.loading.display.*;
	import flash.media.Sound;
	
	
	

	public class TextAudio extends DynamicPageAPI
	{
		private var _sizeH:Number;
		private var _sizeW:Number;
		private var _noteType:String;
		private var _ldr:Loader;
		private var _iconIndent:Number = 10;
		private var _margin:Number = 10;
		private var _iconH:Number;
		private var _iconW:Number;
		private var _isNote:Boolean = false;
		
		private var txtFld:TextField 
		private var noteFld:TextField			
		private var _backgroundAudio:Audio = new Audio();
		
		
		
		
 
		public function TextAudio()
		{
			super();			
		}
		
		private function systemManagerHandler(event:Event):void { event.preventDefault(); }
		
		override public function loadPage():void
		{
			
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";						
			_sizeH = settingsModel.settings.presentSizeH;
			_sizeW = settingsModel.settings.presentSizeW;
			_noteType = String(currentPageTag.@nType).toLowerCase();
			if (_noteType != null && _noteType != "none")
			{
				_isNote = true;
				createNote();

			}  else {
				_isNote = false;
				
				//Create text field
				txtFld = createContentText();
				txtFld.htmlText = currentPageTag.pText;								
				addChild(txtFld);				
				loadMedia();
			}		
		}


		


		override public function get audioPage():Boolean
		{			
			return true;
		}
		
		override public function get mediaPlayer():*
		{			
			return _backgroundAudio;
		}
				
		override public function changingPage(e:Event):void
		{
			trace("Changing page fired from DynamicPageAPI");
			_backgroundAudio.stop();
			courseModel.removeEventListener(Model.MODEL_CHANGE, changingPage);
		}
		

		private function loadMedia() {					
						
			// MEDIA--> MP3 or FLV
			 switch(String(currentPageTag.@mediaFormat))
			 {			
			 	case "MP3":																											
						_backgroundAudio.autoPlay = String(currentPageTag.@autoPlayMedia)=="true"?true:false;						
						_backgroundAudio.source = currentPageTag.@mediaPath+"";												
						break;				
				default:
					trace("Does not have audio");
			 }
			 
			 addScrollBar(txtFld);
			 
		}
				 		
		 
				
		
		private function createNoteText():TextField
		{
			var txtFld:TextField = createTextField();
			txtFld.x = _margin + _iconW + _margin;
			txtFld.y = _sizeH - _margin - _iconH;
			txtFld.width = _sizeW - (_margin * 3) - _iconW;
			txtFld.height = _iconH;
			return txtFld;
		}
		
		private function createContentText():TextField
		{
			txtFld = createTextField();
			txtFld.x = txtFld.y = _margin;
			txtFld.width = _sizeW - _margin - _margin;
			if (_isNote)
			{
				txtFld.height = _sizeH - _margin - _margin - _iconH;
			} else {
				txtFld.height = _sizeH - _margin - _margin;
			}															
			return txtFld;
		}
		
		private function addScrollBar(txtFld)
		{
			if(txtFld.maxScrollV>1)
			{
				var scrollbar:UIScrollBar = new UIScrollBar();				
				addChild(scrollbar); 
				scrollbar.x = txtFld.width+txtFld.x+scrollbar.width; 
				scrollbar.y = txtFld.y;
				scrollbar.height = txtFld.height;
				scrollbar.scrollTarget = txtFld; 
				scrollbar.update();								
			}
		}
		
		private function createTextField():TextField
		{
			var txtFld:TextField = new TextField();
			txtFld.selectable = false;
			txtFld.multiline = true;
			txtFld.wordWrap = true;
			return txtFld;
		}
		
		private function createNote():void
		{
			//trace(settingsModel.paths.noteIcon);
			_ldr = new Loader();
			_ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,iconLoaded);
			var iconPath:URLRequest;
			switch (_noteType)
			{
				case "note":
					iconPath = new URLRequest(settingsModel.paths.noteIcon);
					break;
				case "tip":
					iconPath = new URLRequest(settingsModel.paths.tipIcon);
					break;
				case "warning":
					iconPath = new URLRequest(settingsModel.paths.warningIcon);
					break;
			}
			try
			{
				_ldr.load(iconPath);
			} catch (err:Error) {
				trace("UNABLE to LOAD PAGE ICON");
			}
		}
		
		private function iconLoaded(e:Event):void
		{
			_ldr.removeEventListener(Event.COMPLETE,iconLoaded);
			var icon_mc:MovieClip = MovieClip(e.target.content);
			_iconH = icon_mc.height;
			_iconW = icon_mc.width;
			//Create Note Text field
			//Create text field
			txtFld = createContentText();
			txtFld.htmlText = currentPageTag.pText;												
			noteFld = createNoteText();
			noteFld.htmlText = currentPageTag.note;
			
			icon_mc.x = _iconIndent;
			icon_mc.y = _sizeH - _margin - _iconH;
			//Add elements to the stage.
			addChild(txtFld);
			addChild(noteFld);
			addChild(icon_mc);
			
			
			// Load image, audio, video or swf
			loadMedia();
		}
		
			
		
	}
}
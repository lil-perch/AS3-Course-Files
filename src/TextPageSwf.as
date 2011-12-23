package src.pages
{
	import flash.events.*;
	import src.pages.DynamicPageAPI;
	import flash.text.TextField;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class TextPageSwf extends DynamicPageAPI
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
		
		private var _swf:MovieClip; // Container for loadd SWF
		private var _swfLoader:Loader;
		
		
		public function TextPageSwf()
		{
			super();
			//trace("textPage");
		}
		
		override public function loadPage():void
		{
			
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";			
			//trace("CURent Page: " + currentPageTag.pText);
			//trace("setting: " + settingsModel.settings.presentSizeW);
			_sizeH = settingsModel.settings.presentSizeH;
			_sizeW = settingsModel.settings.presentSizeW;
			_noteType = currentPageTag.@nType.toLowerCase();
			trace("noteType: " + _noteType);
			if (_noteType != null && _noteType != "none")
			{
				_isNote = true;
				createNote();
			}  else {
				_isNote = false;
				//Create text field
				var txtFld:TextField = createContentText();
				txtFld.htmlText = currentPageTag.pText;
				addChild(txtFld);
			}
			
					
			
			loadSWF(currentPageTag.@imageFile);
			
			
			
		}
		
		override public function get swfPage():Boolean
		{
			return true;
		}
		
		private function loadSWF(swf_path)
		{							
				_swfLoader= new Loader();
				var myRequest:URLRequest = new URLRequest(swf_path);
				_swfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);							
				_swfLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadError);
				_swfLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadError);				
				try
				{
					_swfLoader.load(myRequest);			
				} catch (err:Error) {
					trace("UNABLE to LOAD PAGE ICON");
				}								
		}
			
		function loadError(event:ErrorEvent):void {
			trace("Error loading file");
		}
		

		function onCompleteHandler(loadEvent:Event)
		{						
			loadEvent.currentTarget.content.stop();
			addChild(loadEvent.currentTarget.content);			
			
		}
		/*
		function onProgressHandler(mProgress:ProgressEvent)
		{
		var percent:Number = mProgress.bytesLoaded/mProgress.bytesTotal;
		trace(percent);
		}
		*/
		
		override public function get mediaPlayer():*
		{			
			trace(" EL MEDIA PLAYER")
			return (this._swfLoader.content as MovieClip).name;
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
			var txtFld:TextField = createTextField();
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
			var txtFld:TextField = createContentText();
			txtFld.htmlText = currentPageTag.pText;
			var noteFld:TextField = createNoteText();
			noteFld.htmlText = currentPageTag.note;
			
			icon_mc.x = _iconIndent;
			icon_mc.y = _sizeH - _margin - _iconH;
			//Add elements to the stage.
			addChild(txtFld);
			addChild(noteFld);
			addChild(icon_mc);
		}
	}
}
package src.pages
{
	import flash.events.*;
	import flash.utils.*;
	import src.pages.DynamicPageAPI;
	import src.pages.vlp.manager.*;
	import flash.text.TextField;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import fl.controls.UIScrollBar;	
	import flash.display.StageDisplayState;
	import src.Model;
	
	import fl.video.*;
	
	import com.greensock.*;
 	import com.greensock.events.*;
 	
	
	

	public class TextVideo extends DynamicPageAPI
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
		
		public  var caption_txt:TextField;
		public  var caption_back:MovieClip;								 						 								
   		public  var  displayFLV = new FLVPlayback();
		public  var fullscreen_btn;
		private var skin_mc;
		private var status = "normal";
 
		public function TextVideo()
		{
			super();
			
		}
		
		private function systemManagerHandler(event:Event):void { event.preventDefault(); }
		
		override public function loadPage():void
		{
						
			addChild(displayFLV);
			
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
		
		override public function get videoPage():Boolean
		{
			return true;
		}
				
		override public function get mediaPlayer():*
		{
			return displayFLV;
		}

		override public function changingPage(e:Event):void
		{
			trace("Changing page fired from DynamicPageAPI");
			displayFLV.stop();
			courseModel.removeEventListener(Model.MODEL_CHANGE, changingPage);
		}
		

		private function loadMedia() 
		{														
			displayFLV.autoPlay = String(currentPageTag.@autoPlayMedia)=="true"?true:false;
			displayFLV.source = currentPageTag.@mediaPath+"";				
			displayFLV.addEventListener(VideoEvent.READY, readyHandler);
				
		}


		function readyHandler(event:VideoEvent):void {
			trace("READY TO GO");
			// Pause until the video can play till the end			
			adjustSize();		  		  		  
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
		
		
		
		// Image 
		
		
		function adjustSize(){
			
			
			var pictW = displayFLV.width;
			var pictH = displayFLV.height;
			
			trace(pictW+" H: "+pictH)
			
			//Constants
			var rMargin:Number = 30; //Number of pixels
			var lMargin:Number = 30; //Number of pixels
			var gutter:Number = 10;  //Space between picture and text in pixels
			var caption_gutter:Number = 5; //Space between picture and caption in pixels
			var pictVertSpace:Number = _sizeH - 90; //Space vertically allowed for picture
			var pictHorizSpace:Number = _sizeW; //Space horizontally allowed for picture
			var tMargin:Number = 10; //Number of pixels
			var bMargin:Number = 20; //If you change this also change it in textpage.as
			var totW:Number = _sizeW; //the total size of the movie. If you change the movie size change this.
			var totH:Number = _sizeH; // The heighth of the movie. Change this is movie changes.
			
			var noteType:String = currentPageTag.@nType.toLowerCase(); //used to determine relative size of page text if img centered
			var caption_head:String = String(currentPageTag.@captionhead);
			var caption_text:String = String(currentPageTag.@captiontext);						
			
							
			var image_mc = displayFLV;
							
			var newX:Number = lMargin;
			image_mc.x = Math.round(newX);
			image_mc.y = tMargin;
			
			var mediaPos:String = currentPageTag.@mediaPos;
			var loadPercentage:Number = currentPageTag.@loadPercentage;
			
			//   Does it matter in AS3??  MediaPlayerNum?
			/*
			if (loadPercentage == 0) { //if the page loading the text doesn't include media
				totH = playerMain_mc.presentSizeH + playerMain_mc.mediaPlayerNum; //number of pixels
				pictVertSpace = playerMain_mc.presentSizeH + playerMain_mc.mediaPlayerNum;
			} else {
				totH = playerMain_mc.presentSizeH;
				pictVertSpace = playerMain_mc.presentSizeH;
			}
			*/
			
			var page_txt = txtFld; // Equivalent in AS3
			var note_txt = noteFld;
			
			var newSizeW:Number;
			var newSizeH:Number;
			var newHeight:Number;
			
			
			
			switch (mediaPos.toLowerCase()){
				case "center":
					image_mc.y = tMargin;
					image_mc.x = Math.round((pictHorizSpace - pictW)/2);
					page_txt.x = lMargin;
					page_txt.y = image_mc.y + pictH + caption_txt.height + gutter;
					newSizeW = (pictHorizSpace - lMargin - rMargin);
					newSizeH = (totH - image_mc.y - pictH - caption_txt.height - gutter - bMargin - tMargin);
					if (caption_head == "" || !("@captionhead" in currentPageTag)) {
						if (caption_text == "" || !("@caption_text" in currentPageTag)){
							page_txt.y = page_txt.y - caption_txt.height;
							newSizeH = (newSizeH + caption_txt.height - gutter);
						}
					}
					if (noteType != "none") {
						newSizeH = (newSizeH - note_txt.height);
					}
					if (newSizeH < 42)newSizeH = 42;
					
					page_txt.width = newSizeW;
					page_txt.height = newSizeH;
					
					break;
					
				case "bottom center":
					page_txt.x = lMargin;
					page_txt.y = tMargin;
					newSizeW = (pictHorizSpace - lMargin - rMargin);
					newSizeH = (totH - pictH - caption_txt.height - gutter - bMargin - tMargin);
					if (caption_head == "" || !("@captionhead" in currentPageTag)) {
						if (caption_text == "" || !("@caption_text" in currentPageTag)){							
							newSizeH = (newSizeH + caption_txt.height - gutter);
						}
					}
					if (noteType != "none") {
						newSizeH = (newSizeH - note_txt.height);
					}
					if (newSizeH < 42){
						newSizeH = 42;
						image_mc.y = page_txt.y + newSizeH + gutter;
					} else {
						image_mc.y = page_txt.y + newSizeH + gutter;
					}
					
					image_mc.x = Math.round((pictHorizSpace - pictW)/2);
					page_txt.width = newSizeW;
					page_txt.height = newSizeH;													
					break;
					
				case "left and center":
					page_txt.x = lMargin + gutter + pictW; //position page text to the right of the pic
					newHeight = totH - tMargin - bMargin;
					if (noteType != "none") {
						newHeight = (newHeight - note_txt.height - gutter);
						image_mc.y = Math.round((pictVertSpace - tMargin - bMargin - note_txt.height - pictH)/2);
					} else {
						image_mc.y = Math.round((pictVertSpace - tMargin - bMargin - pictH)/2);
					}					
					page_txt.width = totW - pictW - rMargin - lMargin - gutter;
					page_txt.height = newHeight;			
					break;
					
				case "left":									
					image_mc.x = Math.round(lMargin);					
					page_txt.x = lMargin + gutter + pictW;					
					newHeight = totH - tMargin - bMargin;					
					if (noteType != "none") {
						newHeight = (newHeight - note_txt.height - gutter);						
					}
					page_txt.width = totW - pictW - rMargin - lMargin - gutter					
					page_txt.height = newHeight;
					
					trace(" page_txt "+page_txt.x +" page_txt "+page_txt.y)
					
					break;
					
				case "right":
					image_mc.x = Math.round((totW - rMargin - pictW));
					page_txt.x = lMargin;
					newHeight = totH - tMargin - bMargin;
					if (noteType != "none") {
						newHeight = (newHeight - note_txt.height - gutter);
					}
					page_txt.width = totW - pictW - rMargin - lMargin - gutter;	
					page_txt.height = newHeight;																
					break;
					
				case "right and center":
					image_mc.x = Math.round((pictHorizSpace - rMargin - pictW));
					
					page_txt.x = lMargin;
					newHeight = totH - tMargin - bMargin;
					if (noteType != "none") {
						newHeight = (newHeight - note_txt.height - gutter);
						image_mc.y = Math.round((pictVertSpace - tMargin - bMargin - note_txt.height - pictH)/2);
					} else {
						image_mc.y = Math.round((pictVertSpace - tMargin - bMargin - pictH)/2);
					}					
					page_txt.width = totW - pictW - rMargin - lMargin - gutter;	
					page_txt.height = newHeight;				
					
					break;
					
				case "imageaudio":
					image_mc.y = Math.round(((pictVertSpace - tMargin - pictH - gutter)/2)/2);
					image_mc.x = Math.round((pictHorizSpace - pictW)/2);
					break;
					
			}
			
			addScrollBar(page_txt);
			
			
			//Adjust Caption
			caption_txt.width = pictW;
			caption_txt.x = image_mc.x //make caption line up with wherever the image is
			//trace(image_mc._x + "   " + image_mc._y + "   " + caption_gutter + "   " + pictH);
			caption_txt.y = image_mc.y + caption_gutter + pictH;
		
			if (caption_text != "")
			{
				//Adjust Caption background
				caption_back.visible = true;
				caption_back.width = pictW + 10;
				caption_back.x = image_mc.x - 5;
				caption_back.y = image_mc.y + caption_gutter + pictH;
			} else {
				caption_back.visible = false;
			}
			
			
			//Load and position caption
			if (caption_head != "" && caption_head != null) {
				var captionText = "<b>" + String(currentPageTag.@captionhead) + "</b> ";
			}
			if (caption_text != "" && caption_text != null) {
				captionText = captionText + caption_text;
			}				
			caption_txt.htmlText = captionText;
			
			
			// Full Screen
			fullscreen_btn = new FullScreenButton();
			addChild(fullscreen_btn);
			fullscreen_btn.x = displayFLV.x+((pictW));
			fullscreen_btn.y = displayFLV.y+((pictH));
			fullscreen_btn.buttonMode = true;
			displayFLV.fullScreenTakeOver = true;
			fullscreen_btn.addEventListener(MouseEvent.CLICK,goFullScreen);			
			displayFLV.skin= "SkinPlayer.swf";			
			displayFLV.addEventListener(VideoEvent.SKIN_LOADED, onFlvPlayback_SKIN_LOADED);
			
			
			
		}
				
		function onFlvPlayback_SKIN_LOADED(event:VideoEvent):void {

				
				for (var i:uint = 0; i < displayFLV.numChildren; i++){			
				if(Class(getDefinitionByName(getQualifiedClassName(displayFLV.getChildAt(i)))) == Sprite)
				{
					skin_mc = displayFLV.getChildAt(i);					
				}
				}								
				addEventListener(Event.ENTER_FRAME,goCheck);
				//addEventListener(FullScreenEvent.FULL_SCREEN, onFullScreen); 
		}

 
		private function goFullScreen(e:MouseEvent)
		{			
			if (stage.displayState == StageDisplayState.FULL_SCREEN)
			{				
				//skin.visible = false;								
			    stage.displayState=StageDisplayState.NORMAL;
			}
		  	else
		  	{				
				//skin.visible = true;								
				stage.displayState=StageDisplayState.FULL_SCREEN;
		  	}
		}		


		private function goCheck(e:Event)
		{							
			    if (stage.displayState == StageDisplayState.FULL_SCREEN)
			    {				  
					fullscreen_btn.visible = false;															
					skin_mc.visible =true;
			  	}
			  	else
				{
				    fullscreen_btn.visible = true;								  						
					skin_mc.visible =false;			  			 			
			  	}					  
		}
		
	}
}
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
	
	
	

	public class ImageAudio extends DynamicPageAPI
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
		
		private var _swf:MovieClip; // Container for loadd SWF
		private var _swfLoader:Loader;
		
		private var loader:ImageLoader;
 		
		private var image_mc:Sprite;
		private var video_mc:Sprite;
 		private var swfFile:Boolean;
 
 
 		// Audio LoaderMax
		var audio:MP3Loader;		
		
		private var _backgroundAudio:Audio = new Audio();
		
		// Video LoaderMax
		var video:VideoLoader;
		
		// LoaderMAX
		var queue:LoaderMax;
 
		public function ImageAudio()
		{
			super();
			
		}
		
		private function systemManagerHandler(event:Event):void { event.preventDefault(); }
		
		override public function loadPage():void
		{
			
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";						
			_sizeH = settingsModel.settings.presentSizeH;
			_sizeW = settingsModel.settings.presentSizeW;
							
			loadMedia();			
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
		
			queue = new LoaderMax({name:"mainQueue", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});
		
			// MEDIA--> MP3 or FLV
			 switch(String(currentPageTag.@mediaFormat))
			 {			
			 	case "MP3":																											
						_backgroundAudio.autoPlay = false;
						_backgroundAudio.source = currentPageTag.@mediaPath+"";												
						
						break;
				case "FLV":								
						video_mc = new Sprite();
						addChild(video_mc);
						queue.append(new VideoLoader(String(currentPageTag.@mediaPath), {autoPlay:false, name:"media", container:video_mc}));						
					break;
				default:
					trace("Does not have audio nor video");
			 }									 
			 
			 //Get Image node
			var imgLoc:String = String(currentPageTag.@imageFile);
			swfFile = false;
			
			if (imgLoc !== null){				
				image_mc = new Sprite();				
				addChild(image_mc);										
				if (imgLoc.toLowerCase().indexOf(".swf") > 0){
					//Get SWF File
					swfFile = true;								
					queue.append(new SWFLoader(String(currentPageTag.@imageFile), {name:"image", container:image_mc}));
				}else{
					//Get JPEG file					
					queue.append(new ImageLoader(String(currentPageTag.@imageFile), {name:"image", container:image_mc}));
				}																
			}

			queue.load();
		
		}


		function progressHandler(event:LoaderEvent):void {
			trace("progress: " + event.target.progress+" >>>> "+event.target.rawProgress);
		}
		
		function completeHandler(event:LoaderEvent):void {		  
		  		  		  		   		  
		  
		  var image:ContentDisplay = LoaderMax.getContent("image");		  
		  if(image)
		  {
			  	  var w,h;
				  w = image.width;
				  h = image.height
				  if(swfFile)
				  {
					if(("@swfHeight" in currentPageTag) && String(currentPageTag.@swfHeight) != "" && ("@swfWidth" in currentPageTag) && String(currentPageTag.@swfWidth) != "")
					{
						w = String(currentPageTag.@swfWidth);
						h = String(currentPageTag.@swfHeight);
					}
				  }				  
				  adjustSize(w, h);
		  }
		  
		  var media = LoaderMax.getContent("media");
		  var autoPlay = String(currentPageTag.@autoPlayMedia)=="true"?true:false;		  
		  
		  
		  if(media)
		  {		 		  		  
		  	 switch(String(currentPageTag.@mediaFormat))
			 {			
			 	case "MP3":									
						if(autoPlay)
						{														
							_backgroundAudio.playheadTime = 0;
							_backgroundAudio.play();
						}
						break;
				case "FLV":								
						if(autoPlay)
						{
							trace("Play Video")
							LoaderMax.getLoader("media").playVideo()
							
						}
					break;
				default:
					trace("Does not have audio nor video");
			 }					
		  }
		}
		 
		function errorHandler(event:LoaderEvent):void {
			trace("error occured with " + event.target + ": " + event.text);
		}
	
		
		
		// Image 
		
		
		function adjustSize(pictW:Number,pictH:Number){
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
						
			var caption_head:String = String(currentPageTag.@captionhead);
			var caption_text:String = String(currentPageTag.@captiontext);						
			
							
			var newX:Number = lMargin;
			image_mc.x = Math.round(newX);
			image_mc.y = tMargin;
			
			var imgPos:String = currentPageTag.@imgPos;
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
						
			
			var newSizeW:Number;
			var newSizeH:Number;
			var newHeight:Number;

			if (currentPageTag.@pType.toLowerCase() == "image and audio" || currentPageTag.@pType.toLowerCase() == "image link and audio"){
				imgPos = "imageaudio"
			}
			
			switch (imgPos.toLowerCase()){									
				case "imageaudio":
					image_mc.y = Math.round(((pictVertSpace - tMargin - pictH - gutter)/2)/2);
					image_mc.x = Math.round((pictHorizSpace - pictW)/2);
					break;
					
			}						
			
			
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
		}
				
		
		
		
	}
}
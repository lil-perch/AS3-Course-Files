package src.pages.vlp.view.objects {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import fl.controls.UIScrollBar;
	import flash.text.TextFormat;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	public class TextView extends ObjectView{
			
		public var _viewType:String = 'Text';
		private var _bgAlpha:Number = 1;
		private var outputText:TextField;
		private var scrollBar:UIScrollBar;
		private var _ldr:Loader;
		private var _textWidth:Number;
		private var _textHeight:Number;
		
		private var bg_mc:MovieClip;
		private var bg_color:Number = 0xFFFFFF;
		
		public function TextView(){
			this.width = 200;
			this.height = 100;
		}
		
		override public function get viewType():String{
			return _viewType;
		}

		override public function setObjectData(value:XML, isNew:Boolean=false):void{
			super.setObjectData(value);
			if(value)
			{
				_bgAlpha = parseFloat(value.@alpha)/100;
				//textarea1.setStyle("backgroundAlpha", parseFloat(value.@alpha)/100);	
				outputText = new TextField();
				outputText.wordWrap = true;
				outputText.multiline = true;
				
				var myFormat:TextFormat = new TextFormat();
				//myFormat.font = "Arial";
				myFormat.font = "Verdana";
				myFormat.size = 10;
				myFormat.color  = 0x0B333C;
				myFormat.leading = 2;
				
				outputText.defaultTextFormat = myFormat;
				outputText.htmlText = value.pText+'';
            	outputText.width = 200;
            	outputText.height = 200;
				
				scrollBar = new UIScrollBar(); 
				scrollBar.direction = "vertical";
								
				scrollBar.scrollTarget = outputText;
				
            	addChild(outputText);
				addChild(scrollBar);
				
				_ldr = new Loader();
				_ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,iconLoaded);
				var iconPath:URLRequest = new URLRequest(this._settingsModel.paths.noteIcon);
				
				try{
					_ldr.load(iconPath);
				} catch (err:Error) {
					trace("UNABLE to LOAD PAGE ICON");
				}
				
			}
		}
		
		override public function set width(value:Number):void{
			super.width = value;
			_textWidth = value;
			if(outputText){
				outputText.width = value;
			}
		}
		
		override public function set height(value:Number):void{
			super.height = value;
			_textHeight = value;
			
		}
		
		public function resizeComp():void{
			if(outputText){
				outputText.height = _textHeight;
				scrollBar.visible = false;
				//outputText.content
				//trace(outputText.textHeight+" > "+outputText.height);
				if(outputText.textHeight > outputText.height){
					outputText.width = _textWidth - 16;
					// Size it to match the text field. 
					scrollBar.setSize(outputText.width, outputText.height);
					// Move it immediately below the text field. 
					scrollBar.move(outputText.width+outputText.x, outputText.y);
					scrollBar.visible = true;
					scrollBar.update();
					/*if(scrollBar.maxScrollPosition<=scrollBar.pageScrollSize){
						scrollBar.visible = false;
						outputText.width = _textWidth;
					} */
				}
				
				// Add background
				bg_mc = new MovieClip();
				bg_mc.graphics.beginFill(bg_color);
				bg_mc.graphics.drawRect(0, 0, _textWidth, _textHeight);
				bg_mc.graphics.endFill();
				bg_mc.x = 0;
				bg_mc.y = 0;
				bg_mc.alpha = _bgAlpha;
				addChildAt(bg_mc,0);
			}
		}
		
		
		private function iconLoaded(e:Event):void{
			/*_ldr.removeEventListener(Event.COMPLETE,iconLoaded);
			icon_mc = MovieClip(e.target.content);
			_iconH = icon_mc.height + 10; //Add 10 for a buffer
			_iconW = icon_mc.width + 10;
			icon_mc.x = _iconX = _iconIndent;
			
			icon_mc.y = _iconY = (_sizeH - _iconH)/2;
			addChild(icon_mc);*/
			
			resizeComp();
		}
		
	}
}
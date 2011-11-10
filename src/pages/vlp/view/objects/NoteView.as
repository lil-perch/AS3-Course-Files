package src.pages.vlp.view.objects {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.Event;
	import fl.controls.UIScrollBar;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import src.Model;
	import flash.text.TextFormat;
	
	public class NoteView extends ObjectView{
			
		public var _viewType:String = 'Note';
		private var _noteTextField:TextField;
		private var _scrollBar:UIScrollBar;
		private var _ldr:Loader;
		private var _noteData:XML;
		private var _noteType:String;
		private var _m:Model;
		
		private var bg_mc:MovieClip;
		private var bg_color:Number = 0xFFFFFF;
		private var _bgAlpha:Number = 1;
		
		private var _iconH:Number;
		private var _iconW:Number;
		private var _iconX:Number;
		private var _iconY:Number;
		private var icon_mc:MovieClip;
		private var _iconIndent:Number = 10;
		private var _margin:Number = 10;
		private var _sizeH:Number;
		private var _sizeW:Number;
		private var _iconPadding:Number = 87;
		
		public function NoteView(){
			this.width = 300;
			this.height = 72;
		}
		
		override public function get viewType():String{
			return _viewType;
		}
		
		override public function setObjectData(value:XML, isNew:Boolean=false):void
		{
			super.setObjectData(value);
			_noteData = value;
			if(_noteData){
				
				_bgAlpha = parseFloat(_noteData.@alpha)/100;
				
				_noteTextField = new TextField();
				_noteTextField.wordWrap = true;
				_noteTextField.multiline = true;
				var myFormat:TextFormat = new TextFormat();
				myFormat.font = "Verdana";
				myFormat.size = 10;
				myFormat.color  = 0x0B333C;
				myFormat.leading = 2;
				//myFormat.
				_noteTextField.defaultTextFormat = myFormat;
				//_noteTextField.htmlText = '<TEXTFORMAT LEADING="2"><FONT FACE="Verdana" SIZE="10" COLOR="#FF0033" LETTERSPACING="0" KERNING="0">'+_noteData.note+'</FONT></TEXTFORMAT>';
				_noteTextField.htmlText = ''+_noteData.note+'';
            	_noteTextField.width = 200;
            	_noteTextField.height = 200;
				
				_scrollBar = new UIScrollBar(); 
				_scrollBar.direction = "vertical";
				_scrollBar.scrollTarget = _noteTextField;
				
            	addChild(_noteTextField);
				addChild(_scrollBar);
				
				_noteType = _noteData.@nType+'';
				
				_ldr = new Loader();
				_ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,iconLoaded);
				var iconPath:URLRequest;
				switch (_noteType)
				{
					case "note":
						iconPath = new URLRequest(this._settingsModel.paths.noteIcon);
						break;
					case "tip":
						iconPath = new URLRequest(this._settingsModel.paths.tipIcon);
						break;
					case "warning":
						iconPath = new URLRequest(this._settingsModel.paths.warningIcon);
						break;
					case "none":
						
						break;
				}
				try
				{
					_ldr.load(iconPath);
				} catch (err:Error) {
					trace("UNABLE to LOAD PAGE ICON");
				}
			}
		}
		
		override public function set width(value:Number):void{
			super.width = value;
			_sizeW = value;
			if(_noteTextField){
				_noteTextField.x = _iconPadding;
				_noteTextField.width = value - _iconPadding;
			}
		}
		
		override public function set height(value:Number):void{
			super.height = value;
			_sizeH = value;
			//resizeComp();
		}
		
		public function resizeComp():void{
			if(_noteTextField){
				_noteTextField.height = _sizeH;
				_scrollBar.visible = false;
				//_noteTextField.content
				if(_noteTextField.textHeight > _noteTextField.height){
					if(icon_mc){
						_noteTextField.width = _sizeW - 16 - _iconPadding;
					}
					else{
						_noteTextField.width = _sizeW;
					}
					
					// Size it to match the text field. 
					_scrollBar.setSize(_noteTextField.width, _noteTextField.height);
					// Move it immediately below the text field. 
					_scrollBar.move(_noteTextField.width+_noteTextField.x, _noteTextField.y);
					_scrollBar.visible = true;
					_scrollBar.update();
					
				}
				
				// Add background
				bg_mc = new MovieClip();
				bg_mc.graphics.beginFill(bg_color);
				bg_mc.graphics.drawRect(0, 0, _sizeW, _sizeH);
				bg_mc.graphics.endFill();
				bg_mc.x = 0;
				bg_mc.y = 0;
				bg_mc.alpha = _bgAlpha;
				addChildAt(bg_mc,0);
				
				/*var mc:MovieClip = new MovieClip();
				mc.graphics.lineStyle(2, 0x434B54);
				mc.graphics.drawRect(0, 0, _sizeW, _sizeH);
				mc.graphics.endFill();
				.addChildAt(mc,0);*/
				
				
				if(icon_mc){
					icon_mc.y = _iconIndent;
					icon_mc.x = _iconIndent;

				}
			}
		}
		
		
		private function iconLoaded(e:Event):void{
			_ldr.removeEventListener(Event.COMPLETE,iconLoaded);
			icon_mc = MovieClip(e.target.content);
			trace(icon_mc.height,icon_mc.width);
			_iconH = icon_mc.height + 10; //Add 10 for a buffer
			_iconW = icon_mc.width + 10;
			icon_mc.x = _iconX = _iconIndent;
			icon_mc.y = _iconY = _iconIndent;
			addChild(icon_mc);
			
			resizeComp();
		}

	}
}
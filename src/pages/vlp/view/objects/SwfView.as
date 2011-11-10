package src.pages.vlp.view.objects {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Bitmap;
	import flash.geom.Transform;
	import flash.display.AVM1Movie;
	import flash.utils.getQualifiedClassName;
	import com.greensock.*;
 	import com.greensock.loading.*;
 	import flash.events.MouseEvent;
 	import com.greensock.events.LoaderEvent;
 	import com.greensock.loading.display.ContentDisplay;
	
	public class SwfView extends ObjectView{
		
		public var _viewType:String = 'Swf';
		private var _imageAlpha:Number = 1;
		private var _imageW:Number;
		private var _imageH:Number;
		private var _image:MovieClip;
		public var loader:SWFLoader;
		private var _imageSource:String;
		private var _swfData:XML;
		private var _autoPlay:Boolean = false;
		private var _swfObject:MovieClip;
		private var _playing:Boolean = false;
		private var _swfName:String = '';
			
		public function SwfView(){
			this.width = 400;
			this.height = 300;
			this.buttonMode = true;
			this.useHandCursor = true;
			this.addEventListener(MouseEvent.CLICK, toggleSwf);
		}
		
		override public function get viewType():String{
			return _viewType;
		}
		
		override public function setObjectData(value:XML, isNew:Boolean=false):void{
			super.setObjectData(value);
			_swfData = value;
			if(_swfData){
				_imageAlpha = parseFloat(value.@alpha)/100;
				
				if(_swfData.@imageFile != _swfData.@nonExsistanceAttribute){
					_imageSource = _swfData.@imageFile.toString();
				}
				else{
					_imageSource = "src/pages/vlp/assets/imageIcon.png";
				}
				_autoPlay = (_swfData.@autoPlay+'' == 'true');
			}
			_swfName = _swfData.@name+"";
		}
		
		public function loadSWF():void{
			loader = new SWFLoader(_imageSource, {name:_swfName, 
									   container:this, 
									   x:0, y:0, 
									   width: _imageW,
									   height: _imageH,
									   onComplete :initHandler, 
									   onScriptAccessDenied: onErrorEvent,
									   onChildFail : onErrorEvent,
									   onUncaughtError : onErrorEvent,
									   onError : onErrorEvent,
									   onFail : onErrorEvent,
									   onIOError : onErrorEvent,
									   onSecurityError : onErrorEvent,
									   onChildCancel : onErrorEvent,
									   estimatedBytes:9500, 
									   scaleMode:'stretch',
									   centerRegistration:false,
									   autoPlay:false,
									   crop:true});
 				loader.load();
		}
		private function onErrorEvent(evt:LoaderEvent):void{
			trace("ERROR:::",evt.type);
		}
		private function initHandler(event:LoaderEvent):void {
			if(loader){
				_swfObject = loader.rawContent as MovieClip;
			
				if(_autoPlay && _swfObject){
					_playing = true;
					_swfObject.play();
				}
			}
			
		}
		
		public function toggleSwf(evt:Event):void{
			if(!_swfObject)
				return;
			if(_playing){
				_playing = false;
				_swfObject.stop()
			}
			else{
				_playing = true;
				_swfObject.play();
			}
		}
		
		protected function displayImage(event:Event):void{
			
		}
		
		override public function set width(value:Number):void{
			super.width = value;
			_imageW = value;
			if(_image){
				_image.width = value;
			}
		}
		
		override public function set height(value:Number):void{
			super.height = value;
			_imageH = value;
			if(_image){
				_image.height = value;
			}
		}
	
	}
	

}
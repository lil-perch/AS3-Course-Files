package src.pages.vlp.view.objects {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Transform;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;
	import flash.net.navigateToURL;
	
	public class ImageView extends ObjectView{
		public var _viewType:String = 'Image';
		private var _imageAlpha:Number = 1;
		private var _imageData:XML;
		private var _imageW:Number;
		private var _imageH:Number;
		private var _image:MovieClip;
		public var loader:Loader;
		private var _imageSource:String;
		private var _imageUrl:String;
		private var _useImageLink:Boolean = false;
		
		public function ImageView(){
			this.width = 300;
			this.height = 300;
		}
		
		override public function get viewType():String{
			return _viewType;
		}
		
		override public function setObjectData(value:XML, isNew:Boolean=false):void{
			super.setObjectData(value);
			_imageData = value;
			if(_imageData){
				_imageAlpha = parseFloat(value.@alpha)/100;
				
				if(_imageData.@imageFile != _imageData.@nonExsistanceAttribute){
					_imageSource = _imageData.@imageFile.toString();
				}
				else{
					_imageSource = "src/pages/vlp/assets/imageIcon.png";
				}
				
				if(_imageData.@imageURL != _imageData.@nonExsistanceAttribute && _imageData.@imageURL+"" != ""){
					_imageUrl = _imageData.@imageURL+"";
					_useImageLink = true;
				}

				// Load Image
				loader = new Loader();
				_image = new MovieClip();
				if(_useImageLink){
					_image.buttonMode = true;
					_image.useHandCursor = true;
					_image.addEventListener(MouseEvent.CLICK, goToLink);
				}
				
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, displayImage);
				loader.load(new URLRequest(_imageSource));
				_image.addChild(loader);
				this.addChild(_image);
			}
		}
		
		private function displayImage(evt:Event):void{
			_image.alpha = _imageAlpha;
			_image.width = _imageW;
			_image.height = _imageH;
			_image.visible = true;
		}
		
		public function goToLink(evt:Event=null):void{
			var url:String = "http://site";
			var request:URLRequest = new URLRequest(_imageUrl);
			try {
				navigateToURL(request, '_blank'); // second argument is target
			} catch (e:Error) {
				trace("Error occurred!",_imageUrl,e);
			}
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
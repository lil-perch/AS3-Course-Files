package src.pages.vlp.view.objects {
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import src.SettingsModel;
	
	public class ObjectView extends MovieClip{
		
		public function ObjectView(){
			//this.graphics.beginFill(0xFF0000);
			//this.graphics.drawRect(0, 0, 100, 80);
			//this.graphics.endFill();
		}
		
		
		public function get viewType():String
		{
			return '';
		}
		
		[Bindable]
		public var preview:Boolean = false;
		
		[Bindable]
		public var _objectData:XML;
		
		[Bindable]
		public var _settingsModel:SettingsModel;
		
		[Bindable]
		private var showCaption:Boolean = false;
		
		public function get objectData():XML
		{
			return _objectData;
		}
		public function set objectData(value:XML):void
		{
			//_objectData = value;// <data imageFile="Source" captionhead="Cap" captiontext="Captext"/>
			setObjectData(value);
		}
		
		public function setObjectData(value:XML, isNew:Boolean=false):void
		{
			_objectData = value;
		}
		
		public function setDimentions(width:Number,height:Number):void{
		}
		
		public function set settingsModel(value:SettingsModel):void{
			_settingsModel = value;
		}
		public function get settingsModel():SettingsModel{
			return _settingsModel;
		}
	
	}
	
}
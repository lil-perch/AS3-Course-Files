package src.pages
{
	import src.pages.DynamicPageAPI;
	import src.pages.vlp.manager.*;
	import src.pages.vlp.view.objects.*;
	import flash.utils.getDefinitionByName;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.MovieClip;

	//import mx.*;

	public class VLPage extends DynamicPageAPI
	{
		
		private static var _THE_PATH:String = "swfs/pagetemplates/OmniPage.swf";
		
		private var _manager:VLPManager;
		
		private var _tv:TextView;
		private var _iv:ImageView;
		private var _sv:SwfView;
		private var _vv:VideoView;
		private var _nv:NoteView;
		private var _av:AudioView;
		private var _backgroundAudio:Audio = new Audio();
		
		private var debugging:Boolean = false;
		
		public function VLPage()
		{
			super();
			
			//_manager = new VLPManager();
		}
		
		private function systemManagerHandler(event:Event):void { event.preventDefault(); }
		
		override public function loadPage():void
		{
			default xml namespace = "www.rapidintake.com/xmlgrammars/fc/sco";
			
			var tXML:XML = new XML('<transformManager></transformManager>');
			tXML.setChildren(currentPageTag.children());
				
			this.applyFullXML(tXML);
		}
		
		private function applyFullXML(xml:XML):void{			
			var node:XML
			var pattern:RegExp = new RegExp("[A-z]+", "g");
			var itemsList:Array = new Array()
			
			var xmlItems:XMLList = xml.items.item;
			if(xmlItems.length()>0){
				var list:XMLList = xml.items[0].item;
				for each (node in list) {
					var objType:String = node.@oType+'View';//
					if(objType == 'View'){
						objType = (node.@name).match(pattern);
					}
					var xmlData:XML = node.data[0] as XML;
					if(objType != 'BackgroundAudioView'){
						//var obj:ObjectView;
						var obj:*;
						try{
							obj = new (getDefinitionByName("src.pages.vlp.view.objects." + objType))();
						}catch(e:Error){
							trace("Type:"+"src.pages.vlp.view.objects." + objType);
							trace("ERROR:",e.message);
							obj = new ObjectView();
						}
						
						obj.settingsModel = settingsModel;
						obj.objectData = xmlData;
						obj.name = node.@name;
						itemsList.push(obj);
						this.addChild(obj);
					}
					else{
						trace("~~~BACKGROUND AUDIO~~~");
						trace("Source:",xmlData.@mediaPath+"");
						_backgroundAudio.autoPlay = false;
						_backgroundAudio.source = xmlData.@mediaPath+"";
						courseModel.mediaControlVisible = true;
					}
				}
			}
			
			_manager = new VLPManager({targetObjects:itemsList});
			if(itemsList.length>0){
				var misssing:Array =  _manager.applyFullXML(xml, this);
			}
			
		}
		
		override public function get audioPage():Boolean
		{
			trace("GET AUDIO");
			return true;
		}
		
		override public function get mediaPlayer():*
		{
			trace("GET MEDIA PLAYER");
			return _backgroundAudio;
		}
		
	}
}